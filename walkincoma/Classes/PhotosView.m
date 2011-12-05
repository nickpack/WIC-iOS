//
//  PhotosView.m
//  TNWLM2
//
//  Created by Nick Pack on 14/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "PhotosView.h"
#import "PhotosDataSource.h"

static CGFloat kThumbnailRowHeight = 79.0f;
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation PhotosView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.statusBarStyle = UIStatusBarStyleBlackTranslucent;
        self.navigationBarStyle = UIBarStyleBlackTranslucent;
        self.navigationBarTintColor = nil;
        self.wantsFullScreenLayout = YES;
        self.hidesBottomBarWhenPushed = NO;
        self.title = NSLocalizedString(@"Photos",nil);
        UIImage* image = [[UIImage imageNamed:@"Photos.png"] autorelease];
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Photos",nil) image:image tag:0] autorelease];
    }
    
    return self;
}


- (void) createModel {
	PhotosDataSource *flickrPhotoSource = [[PhotosDataSource alloc] init];
	self.photoSource = flickrPhotoSource;
	flickrPhotoSource = nil;
	TT_RELEASE_SAFELY(flickrPhotoSource);
}

- (void)loadView {
    [super loadView];
    
    self.tableView.rowHeight = kThumbnailRowHeight;
    self.tableView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.backgroundColor = TTSTYLEVAR(backgroundColor);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self updateTableLayout];
}

- (void)updateTableLayout {
    self.tableView.contentInset = UIEdgeInsetsMake(TTBarsHeight()+4, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(TTBarsHeight(), 0, 0, 0);
}

@end

