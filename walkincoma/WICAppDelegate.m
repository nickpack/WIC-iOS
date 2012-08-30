//
//  WICAppDelegate.m
//  WalkInComa
//
//  Created by Nick Pack on 28/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICAppDelegate.h"
#import "WICMenuCell.h"
#import "WICRootViewController.h"
#import "WICShowsViewController.h"
#import "WICMembersViewController.h"
#import "GHRevealViewController.h"
#import "WICMenuViewController.h"
#import "AFHTTPRequestOperationLogger.h"

@interface WICAppDelegate ()
@property (nonatomic, strong) GHRevealViewController *revealController;
@property (nonatomic, strong) WICMenuViewController *menuController;
@end

@implementation WICAppDelegate

@synthesize window;
@synthesize revealController, menuController;

#pragma mark UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[[AFHTTPRequestOperationLogger sharedLogger] startLogging];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
	
	UIColor *bgColor = [UIColor colorWithRed:(50.0f/255.0f) green:(57.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
	self.revealController = [[GHRevealViewController alloc] initWithNibName:nil bundle:nil];
	self.revealController.view.backgroundColor = bgColor;
	
	RevealBlock revealBlock = ^(){
		[self.revealController toggleSidebar:!self.revealController.sidebarShowing
									duration:kGHRevealSidebarDefaultAnimationDuration];
	};
	
	NSArray *headers = @[
    [NSNull null],
    @"Live",
    @"Band",
    @"Media"
	];
	NSArray *controllers = @[
    @[
    [[UINavigationController alloc] initWithRootViewController:[[WICRootViewController alloc] initWithTitle:@"News" withRevealBlock:revealBlock]]
    ],
    @[
    [[UINavigationController alloc] initWithRootViewController:[[WICShowsViewController alloc] initWithTitle:@"Upcoming Shows" withRevealBlock:revealBlock withShowType:1]],
    [[UINavigationController alloc] initWithRootViewController:[[WICShowsViewController alloc] initWithTitle:@"Previous Shows" withRevealBlock:revealBlock withShowType:1]],
    ],
    @[
    [[UINavigationController alloc] initWithRootViewController:[[WICShowsViewController alloc] initWithTitle:@"Biography" withRevealBlock:revealBlock withShowType:1]],
    [[UINavigationController alloc] initWithRootViewController:[[WICMembersViewController alloc] initWithTitle:@"Members" withRevealBlock:revealBlock]],
    ],
    @[
    [[UINavigationController alloc] initWithRootViewController:[[WICShowsViewController alloc] initWithTitle:@"Discography" withRevealBlock:revealBlock withShowType:1]],
    [[UINavigationController alloc] initWithRootViewController:[[WICShowsViewController alloc] initWithTitle:@"Photos" withRevealBlock:revealBlock withShowType:1]],
    [[UINavigationController alloc] initWithRootViewController:[[WICShowsViewController alloc] initWithTitle:@"Videos" withRevealBlock:revealBlock withShowType:1]],
    ]
	];
	NSArray *cellInfos = @[
    @[
    @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"News", @"")}
    ],
    @[
    @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"Upcoming Shows", @"")},
    @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"Previous Shows", @"")},
    ],
    @[
    @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"Biography", @"")},
    @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"Members", @"")},
    ],
    @[
    @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"Discography", @"")},
    @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"Photos", @"")},
    @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"Videos", @"")},
    ]
	];
	
        // Add drag feature to each root navigation controller
	[controllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
		[((NSArray *)obj) enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx2, BOOL *stop2){
			UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.revealController
																						 action:@selector(dragContentView:)];
			panGesture.cancelsTouchesInView = YES;
			[((UINavigationController *)obj2).navigationBar addGestureRecognizer:panGesture];
		}];
	}];
	
	self.menuController = [[WICMenuViewController alloc] initWithSidebarViewController:self.revealController
																		  withHeaders:headers
																	  withControllers:controllers
																		withCellInfos:cellInfos];
	
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.revealController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
