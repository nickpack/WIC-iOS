//
//  UINavigationBar+StyleHaxx.m
//  Walk in Coma
//
//  Created by Nikki Pack on 04/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+StyleHaxx.h"

@implementation UINavigationBar (StyleHaxx)

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIColor *color = [UIColor blackColor];
    UIImage *img  = [UIImage imageNamed: @"navbar"];
    [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.tintColor = color;
}

@end
