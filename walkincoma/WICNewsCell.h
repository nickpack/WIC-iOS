//
//  WICNewsCell.h
//  WalkInComa
//
//  Created by Nick Pack on 31/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WICNewsArticle;

@interface WICNewsCell : UITableViewCell

@property (nonatomic, strong) WICNewsArticle *article;
@property (nonatomic) UILabel *dateLabel;

+ (CGFloat)heightForCellWithArticle:(WICNewsArticle *)article;

@end
