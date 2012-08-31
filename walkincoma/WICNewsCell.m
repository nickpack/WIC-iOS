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
}

@synthesize article = _article;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return self;
}

- (void)setArticle:(WICNewsArticle *)article {
    _article = article;
    
    self.textLabel.text = _article.articleTitle;
    self.detailTextLabel.text = _article.articleBody;
    NSString* avatarUrl = [NSString stringWithFormat:@"http://www.walkincoma.co.uk/wic-media/%@", article.bandMember.avatar];
    [self.imageView setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"user"]];
    
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithArticle:(WICNewsArticle *)article {
    CGSize sizeToFit = [article.articleBody sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(220.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    return fmaxf(70.0f, sizeToFit.height + 45.0f);
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10.0f, 10.0f, 50.0f, 50.0f);
    self.textLabel.frame = CGRectMake(70.0f, 10.0f, 240.0f, 20.0f);
    
    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
    detailTextLabelFrame.size.height = [[self class] heightForCellWithArticle:_article] - 45.0f;
    self.detailTextLabel.frame = detailTextLabelFrame;
}

@end