//
//  BNDemoViewController.m
//  BNLongPressMenuDemo
//
//  Created by camille bossoutrot on 13-05-16.
//  Copyright (c) 2013 camille bossoutrot. All rights reserved.
//

#import "BNDemoViewController.h"

@interface BNDemoViewController ()

@end

@implementation BNDemoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray* tmpArray = [[NSMutableArray alloc] init];
    
    for (int i= 0; i<7; i++) {
        
        UIButton* button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [button setBackgroundImage:[[UIImage alloc]
                                    initWithContentsOfFile:[[NSBundle mainBundle]
                                                            pathForResource:@"menu-item"
                                                            ofType:@"png"
                                                            ]
                                    ] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didPressMenuItem:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [self.view insertSubview:button atIndex:i];
        [tmpArray addObject:button];
        
    }
    
    longPressMenu = [[BNLongPressMenu alloc] initWithButtonsArray:[[NSArray alloc] initWithArray:tmpArray] radius:RADIUS];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture

- (IBAction)showGestureForLongPressRecognizer:(UILongPressGestureRecognizer *)recognizer
{
    [longPressMenu handle:recognizer withView:self.view];
}

#pragma mark - Instance Methods

- (IBAction)didPressMenuItem:(id)sender
{
    //add code to execute when a menu item is clicked
    label.text = [label.text stringByAppendingFormat:@"%@ ", ((UIButton*)sender).titleLabel.text];
}
@end
