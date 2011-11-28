//
//  NewsView.m
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "NewsView.h"
#import "NewsDataSource.h"
#import <Three20UI/UIViewAdditions.h>
#import "TTTableViewDelegate+URLAdditions.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NewsView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.title = @"News";
		self.variableHeightRows = YES;
        //self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Packages",nil) image:image tag:0] autorelease];
	}

	return self;
}

- (void)createModel {
	self.dataSource = [[[NewsDataSource alloc]
						initWithFeedUrl:@"http://www.walkincoma.co.uk/feed"] autorelease];
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end

