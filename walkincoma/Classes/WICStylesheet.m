//
//  WICStylesheet.m
//  walkincoma
//
//  Created by Nikki Pack on 02/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WICStylesheet.h"

@implementation WICStylesheet

- (UIColor*)navigationBarTintColor {
    return RGBCOLOR(44, 44, 44);
}

-(UIColor*)tabBarTintColor {
	return RGBCOLOR(72,72,72);
}

- (UIColor*)tabTintColor {
    return [UIColor darkGrayColor];
}

- (TTStyle*)tabRound:(UIControlState)state {
    if (state == UIControlStateSelected) {
        return
        [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4.5] next:
         [TTInsetStyle styleWithInset:UIEdgeInsetsMake(9, 1, 8, 1) next:
          [TTShadowStyle styleWithColor:RGBACOLOR(0,10,10,0.8) blur:0 offset:CGSizeMake(0, 1) next:
           [TTReflectiveFillStyle styleWithColor:TTSTYLEVAR(tabBarTintColor) next:
            [TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.3) blur:1 offset:CGSizeMake(1, 1) next:
             [TTInsetStyle styleWithInset:UIEdgeInsetsMake(-1, -1, -1, -1) next:
              [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, 10, 0, 10) next:
               [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:13]  color:[UIColor whiteColor]
                          minimumFontSize:8 shadowColor:[UIColor colorWithWhite:0 alpha:0.5]
                             shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]]];
        
    } else {
        return
        [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, 10, 0, 10) next:
         [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:13]  color:[UIColor whiteColor]
                    minimumFontSize:8 shadowColor:[UIColor blackColor]
                       shadowOffset:CGSizeMake(0, -1) next:nil]];
    }
}

- (UIFont*)font {
	return [UIFont fontWithName:@"AmericanTypewriter" size:14];
}

- (UIColor*)toolbarTintColor {
	return RGBCOLOR(72,72,72);
}

- (UIColor*)tableHeaderTintColor {
	return RGBCOLOR(72,72,72);
}

- (UIColor*)tableHeaderTextColor {
	return [UIColor whiteColor];
}

- (UIColor*)tableSubTextColor {
	return [UIColor grayColor];
}

- (UITableViewCellSelectionStyle)tableSelectionStyle {
	return UITableViewCellSelectionStyleGray;
}

- (UIColor*)tablePlainBackgroundColor {
    UIImage *patternImage = [UIImage imageNamed:@"tile.png"];
    
    return [UIColor colorWithPatternImage:patternImage];
}


@end
