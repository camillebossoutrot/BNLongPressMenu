//
//  BNDemoViewController.h
//  BNLongPressMenuDemo
//
//  Created by camille bossoutrot on 13-05-16.
//  Copyright (c) 2013 camille bossoutrot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNLongPressMenu.h"

#define RADIUS                60

@interface BNDemoViewController : UIViewController
{
    BNLongPressMenu* longPressMenu;
    IBOutlet UILabel* label;
}
@end
