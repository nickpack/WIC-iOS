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
    self.customizableViewControllers = nil;

    [self setTabURLs:[NSArray arrayWithObjects:@"wic://news",
                      @"wic://videos",
                      @"wic://news",
                      @"wic://photos",
                      @"wic://news",
                      nil]];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"Play-off.png"] highlightImage:[UIImage imageNamed:@"Play.png"]];
}

-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(audioPlayer:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    [self.view addSubview:button];
}

-(void) audioPlayer:(id) sender {
    [[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:@"bl://quickboot"] applyAnimated:YES]];
}


@end
