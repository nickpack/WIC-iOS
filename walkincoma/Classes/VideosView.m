//
//  VideosView.m
//  TNWLM2
//
//  Created by Nick on 28/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "VideosView.h"
#import "VideoDataSource.h"

//http://gdata.youtube.com/feeds/api/videos?alt=rss&format=1&author=thenursewholovedme
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation VideosView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.variableHeightRows = YES;
		self.title = @"Videos";
        //self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Packages",nil) image:image tag:0] autorelease];
	}

	return self;
}

- (void)createModel {
	self.dataSource = [[[VideoDataSource alloc]
						initWithFeedUrl:@"http://gdata.youtube.com/feeds/api/videos?alt=rss&format=1&author=WalkInComaOfficial"] autorelease];
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end

