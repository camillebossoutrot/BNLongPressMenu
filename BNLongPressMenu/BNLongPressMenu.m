//
//  MTPopAroundMenu.m
//  MyTest
//
//  Created by camille bossoutrot on 13-05-14.
//  Copyright (c) 2013 camille bossoutrot. All rights reserved.
//

#import "BNLongPressMenu.h"

@implementation BNLongPressMenu

@synthesize expanded;


- (id)initWithButtonsArray:(NSArray*)buttonsArray radius:(int)menuRadius
{
    if (self = [super init]) {
        radius = menuRadius;
        self.buttonsArray = [[NSArray alloc] initWithArray:buttonsArray];
    }
    return self;
}

- (void)expandWithAnimation:(BOOL)isAnimated
{
    float delay = 0;
    if (isAnimated)
    {
        delay = 0.1 * [self.buttonsArray count];
    }
    float rad =  0;
    for (UIButton* button in self.buttonsArray) {
        
        CGAffineTransform rotation = CGAffineTransformMakeRotation(rad);
        float x = radius * rotation.a;
        float y = radius * rotation.c;
        if (self.mainButton)
        {
            button.center = self.mainButton.center;
        }
        else
        {
            button.center = self.origin;
        }
        button.hidden = NO;
        CGPoint center = CGPointMake(button.center.x + x, button.center.y + y);
        
        [UIView animateWithDuration:0.2 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^
         {
             button.center = center;
         }
                         completion:^(BOOL finished)
         {
             if (button == self.buttonsArray.lastObject) expanded = YES;
         }];
        if (isAnimated)
        {
            delay -= 0.1;
        }
        rad += (2 * M_PI) / [self.buttonsArray count] ;
    }
}

- (void)collapse
{
    float delay = 0;
    
    for (UIButton* button in self.buttonsArray) {
        
        [UIView animateWithDuration:0.2 delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^
         {
             if (self.mainButton)
             {
                 button.center = self.mainButton.center;
             }
             else
             {
                 button.center = self.origin;
             }
         }
                         completion:^(BOOL finished)
         {
             button.hidden = YES;
             if (button == self.buttonsArray.lastObject) expanded = NO;
         }];
        delay += 0.1;
        
    }
}

- (void)hide
{
    
    for (UIButton* button in self.buttonsArray) {
        
        [UIView animateWithDuration:0.2 animations:^
         {
             button.alpha = 0.0;
         }
                         completion:^(BOOL finished)
         {
             button.hidden = YES;
             button.alpha = 1.0;
             if (button == self.buttonsArray.lastObject) expanded = NO;
         }];
        
    }
}

- (void)changeButtonStateWithPoint:(CGPoint)position
{
    for (UIButton* button in self.buttonsArray) {
        
        if (CGRectContainsPoint(button.frame, position)) {
            [button setHighlighted:YES];
        }
        else
        {
            [button setHighlighted:NO];
        }
    }
}

- (void)selectButtonWithPoint:(CGPoint)position
{
    for (UIButton* button in self.buttonsArray) {
        [button setHighlighted:NO];
        if (CGRectContainsPoint(button.frame, position)) {
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
    }
}

- (void)handle:(UILongPressGestureRecognizer*)recognizer withView:(UIView*) view
{
    CGPoint touchPoint = [recognizer locationInView:view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        if (expanded)
        {
            [self selectButtonWithPoint:touchPoint];
            [self hide];
        }
    }
    else
    {
        
        if (!expanded)
        {
            [self setOrigin:touchPoint];
            [self expandWithAnimation:NO];
        }
        else
        {
            [self changeButtonStateWithPoint:touchPoint];
        }
        
    }
}

@end
