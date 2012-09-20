//
//  WICNewsCell.m
//  WalkInComa
//
//  Created by Nick Pack on 31/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICNewsCell.h"
#import "WICNewsArticle.h"
#import "UIImageView+AFNetworking.h"

@implementation WICNewsCell{
@private
    __strong WICNewsArticle *_article;
    UILabel *_dateLabel;
}

@synthesize article = _article;
@synthesize dateLabel = _dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.font = [UIFont systemFontOfSize:11.0f];
    self.dateLabel.textColor = [UIColor darkTextColor];
    [self.contentView addSubview:self.dateLabel];
    
    self.textLabel.adjustsFontSizeToFitWidth = NO;
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return self;
}

- (void)setArticle:(WICNewsArticle *)article {
    _article = article;
    self.textLabel.text = _article.articleTitle;
    self.dateLabel.text = _article.articleDate;
    
    self.detailTextLabel.text = [NSString stringWithFormat:
                                 @"%@...",
                                 [_article.articleBody substringToIndex:
                                  MIN(200, [_article.articleBody length])]];
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithArticle:(WICNewsArticle *)article {
    NSString *shortBody = [article.articleBody substringToIndex:
                           MIN(203, [article.articleBody length])];
    CGSize sizeToFit = [shortBody sizeWithFont:[UIFont systemFontOfSize:12.0f]
                             constrainedToSize:CGSizeMake(1000.0f, CGFLOAT_MAX)
                                 lineBreakMode:UILineBreakModeWordWrap];
    
    return fmaxf(70.0f, sizeToFit.height + 45.0f);
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(20.0f, 10.0f, 200.0f, 20.0f);
    self.dateLabel.frame = CGRectOffset(self.textLabel.frame, 210.0f, 0.0f);
    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
    detailTextLabelFrame.size.width = self.textLabel.frame.size.width + 80.0f;
    detailTextLabelFrame.size.height = [[self class] heightForCellWithArticle:_article] - 45.0f;
    self.detailTextLabel.frame = detailTextLabelFrame;
}

@end