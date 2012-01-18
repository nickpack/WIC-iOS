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
		self.variableHeightRows = YES;
        self.title = NSLocalizedString(@"News",nil);
        UIImage* image = [[UIImage imageNamed:@"News.png"] autorelease];
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"News",nil) image:image tag:0] autorelease];
        CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
        _listTabs = [[TTTabBar alloc] initWithFrame:CGRectMake(0, _listTabs.bottom, applicationFrame.size.width, 40)];
        _listTabs.tabItems = [NSArray arrayWithObjects:
                              [[[TTTabItem alloc] initWithTitle:NSLocalizedString(@"News",nil)] autorelease],
                              [[[TTTabItem alloc] initWithTitle:NSLocalizedString(@"Shows",nil)] autorelease],
                              nil];
        _listTabs.delegate = self;
        _listTabs.contentMode = UIViewContentModeScaleToFill;
        self.tableView.tableHeaderView = _listTabs;
	}

	return self;
}

- (void)createModel {
	self.title = NSLocalizedString(@"News",nil);
    self.dataSource = [[[NewsDataSource alloc]
                        initWithFeedUrl:@"http://www.walkincoma.co.uk/category/blogs/feed/"] autorelease];
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger)selectedIndex {
    [self invalidateModel];
    if (selectedIndex == 1) {
        self.title = NSLocalizedString(@"Shows",nil);
        self.dataSource = [[[NewsDataSource alloc]
                            initWithFeedUrl:@"http://www.walkincoma.co.uk/category/shows/feed/"] autorelease];
        
    } else {
        self.title = NSLocalizedString(@"News",nil);
        self.dataSource = [[[NewsDataSource alloc]
                            initWithFeedUrl:@"http://www.walkincoma.co.uk/category/blogs/feed/"] autorelease];
    }
}


@end

