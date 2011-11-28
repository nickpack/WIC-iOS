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
                      @"wic://photos",
                      @"wic://news",
                      @"wic://news",
                      @"wic://news",
                      nil]];
    /*
     [map from:@"wic://news" toViewController:[NewsView class]];
     [map from:@"wic://videos" toViewController:[VideosView class]];
     [map from:@"wic://photos" toViewController:[PhotosView class]];
     [map from:@"wic://viewnews" toViewController:[NewsItemView class]];

     */
}

@end
