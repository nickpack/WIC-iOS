//
//  WICMemberNameAvatarCell.h
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WICBandMember;

@interface WICMemberNameAvatarCell : UITableViewCell

@property (nonatomic, strong) WICBandMember *member;

+ (CGFloat)heightForCellWithMember:(WICBandMember *)tweet;
@end
