//
//  WICShowsViewController.h
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealBlock.h"

@interface WICShowsViewController : UITableViewController {
    @private RevealBlock _revealBlock;
}

- (id)initWithTitle:(NSString *)title
    withRevealBlock:(RevealBlock)revealBlock
       withShowType:(NSInteger)showType;

@end
