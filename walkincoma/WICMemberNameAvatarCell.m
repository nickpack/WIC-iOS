//
//  WICMemberNameAvatarCell.m
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICMemberNameAvatarCell.h"
#import "WICBandMember.h"
#import "UIImageView+AFNetworking.h"

@implementation WICMemberNameAvatarCell {
@private
    __strong WICBandMember *_member;
}

@synthesize member = _member;

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

- (void)setMember:(WICBandMember *)member {
    _member = member;
    
    self.textLabel.text = [NSString stringWithFormat:@"%@ \"%@\" %@",
                            _member.firstName,
                            _member.nickname,
                            _member.lastName
                            ];
    self.detailTextLabel.text = _member.role;
    NSString* avatarUrl = [NSString stringWithFormat:@"http://www.walkincoma.co.uk/wic-media/%@", _member.avatar];
    [self.imageView setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"user"]];
    
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithMember:(WICBandMember *)member {
    CGSize sizeToFit = [member.role sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(220.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    return fmaxf(70.0f, sizeToFit.height + 45.0f);
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10.0f, 10.0f, 50.0f, 50.0f);
    self.textLabel.frame = CGRectMake(70.0f, 10.0f, 240.0f, 20.0f);
    
    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
    detailTextLabelFrame.size.height = [[self class] heightForCellWithMember:_member] - 45.0f;
    self.detailTextLabel.frame = detailTextLabelFrame;
}

@end
