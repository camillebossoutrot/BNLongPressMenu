//
//  MTPopAroundMenu.h
//  MyTest
//
//  Created by camille bossoutrot on 13-05-14.
//  Copyright (c) 2013 camille bossoutrot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNLongPressMenu : NSObject
{
    int radius;
}

@property (strong)UIButton* mainButton;
@property (strong)NSArray* buttonsArray;
@property (readonly, getter = isExpanded)BOOL expanded;
@property CGPoint origin;

- (id)initWithButtonsArray:(NSArray*)buttonsArray radius:(int)menuRadius;
- (void)handle:(UILongPressGestureRecognizer*)recognizer withView:(UIView*) view;


@end
