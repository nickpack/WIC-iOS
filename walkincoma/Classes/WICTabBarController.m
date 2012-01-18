//
//  WICTabBarController.m
//  walkincoma
//
//  Created by Nikki Pack on 01/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WICTabBarController.h"

@implementation WICTabBarController

- (void)viewDidLoad {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    self.customizableViewControllers = nil;

    [self setTabURLs:[NSArray arrayWithObjects:@"wic://news",
                      @"wic://audio",
                      @"wic://videos",
                      @"wic://photos",
                      nil]];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar.png"]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        [self.tabBar insertSubview:backgroundImageView atIndex:1];
    } else {
        [self.tabBar insertSubview:backgroundImageView atIndex:0];
    }
    
    [backgroundImageView release];
    
}


@end
