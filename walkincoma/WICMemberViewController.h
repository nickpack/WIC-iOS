//
//  WICMemberViewController.h
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICBandMember.h"

@interface WICMemberViewController : UITableViewController

@property (nonatomic,retain) WICBandMember* member;
- (id)initWithStyle:(UITableViewStyle)style withMember:(WICBandMember*)memberObject;
@end
