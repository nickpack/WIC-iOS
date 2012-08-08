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
	}
    
	return self;
}

- (void)createModel {
	self.title = NSLocalizedString(@"News",nil);
    self.dataSource = [[[NewsDataSource alloc]
                        initWithJSONUrl:@"http://walkincoma.co.uk/api/news/"] autorelease];
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end

