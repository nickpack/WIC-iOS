//
//  WICMenuViewController.h
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GHRevealViewController;

@interface WICMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
@private
	GHRevealViewController *_sidebarVC;
	UITableView *_menuTableView;
	NSArray *_headers;
	NSArray *_controllers;
	NSArray *_cellInfos;
}

- (id)initWithSidebarViewController:(GHRevealViewController *)sidebarVC
						withHeaders:(NSArray *)headers
					withControllers:(NSArray *)controllers
					  withCellInfos:(NSArray *)cellInfos;

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath
					animated:(BOOL)animated
			  scrollPosition:(UITableViewScrollPosition)scrollPosition;

@end

