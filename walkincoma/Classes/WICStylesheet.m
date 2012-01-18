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

- (TTStyle*)tabBar {
    return [TTLinearGradientFillStyle styleWithColor1:[UIColor lightGrayColor]
                                               color2:[UIColor darkGrayColor] next:
            [TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.5) blur:6 offset:CGSizeMake(1, 1) next:nil]];
}

- (UIColor*)tabTintColor {
    return [UIColor darkGrayColor];
}

- (TTStyle*)tab:(UIControlState)state {
    if (state == UIControlStateSelected) {
        return
        [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithTopLeft:4.5 topRight:4.5
                                                                   bottomRight:0 bottomLeft:0] next:
         [TTInsetStyle styleWithInset:UIEdgeInsetsMake(5, 1, 0, 1) next:
          [TTShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.5) blur:2 offset:CGSizeMake(1, -1) next:
          [TTSolidFillStyle styleWithColor:RGBCOLOR(78,78,78) next:
           [TTInsetStyle styleWithInset:UIEdgeInsetsMake(-1, -1, 0, -1) next:
            //[TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.5) blur:6 offset:CGSizeMake(1, 0) next:
            [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(6, 12, 2, 12) next:
              [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:12]  color:[UIColor whiteColor]
                         minimumFontSize:8 shadowColor:[UIColor darkGrayColor]
                            shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
        
    } else {
        return
        [TTInsetStyle styleWithInset:UIEdgeInsetsMake(5, 1, 1, 1) next:
         [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(6, 12, 2, 12) next:
          [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:12]  color:[UIColor whiteColor]
                     minimumFontSize:8 shadowColor:[UIColor colorWithWhite:0 alpha:0.6]
                        shadowOffset:CGSizeMake(0, -1) next:nil]]];
    }
}

/*- (TTStyle*)tabRound:(UIControlState)state {
    if (state == UIControlStateSelected) {
        return
        [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
         [TTInsetStyle styleWithInset:UIEdgeInsetsMake(9, 1, 8, 1) next:
          [TTShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.5) blur:6 offset:CGSizeMake(1, 1) next:
           [TTReflectiveFillStyle styleWithColor:TTSTYLEVAR(tabBarTintColor) next:
             [TTInsetStyle styleWithInset:UIEdgeInsetsMake(-1, -1, -1, -1) next:
               [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:13]  color:[UIColor whiteColor]
                          minimumFontSize:8 shadowColor:[UIColor colorWithWhite:0 alpha:0.5]
                             shadowOffset:CGSizeMake(0, -1) next:nil]]]]]];
        
    } else {
        return
        [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, 10, 0, 10) next:
         [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:13]  color:[UIColor whiteColor]
                    minimumFontSize:8 shadowColor:[UIColor blackColor]
                       shadowOffset:CGSizeMake(0, -1) next:nil]];
    }
}*/
- (UIColor*)tableHeaderShadowColor {
    return [UIColor darkGrayColor];
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
