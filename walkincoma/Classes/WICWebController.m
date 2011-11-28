//
//  WICWebController.m
//  walkincoma
//
//  Created by Nikki Pack on 01/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WICWebController.h"

@implementation WICWebController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.hidesBottomBarWhenPushed = NO;
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    
    _webView = [[UIWebView alloc] initWithFrame:TTToolbarNavigationFrame()];
    _webView.delegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleHeight;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    UIActivityIndicatorView* spinner =
    [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
      UIActivityIndicatorViewStyleWhite] autorelease];
    [spinner startAnimating];
    _activityItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    _backButton =
    [[UIBarButtonItem alloc] initWithImage:TTIMAGE(@"bundle://Three20.bundle/images/backIcon.png")
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(backAction)];
    _backButton.tag = 2;
    _backButton.enabled = NO;
    _forwardButton =
    [[UIBarButtonItem alloc] initWithImage:
     TTIMAGE(@"bundle://Three20.bundle/images/forwardIcon.png")
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(forwardAction)];
    _forwardButton.tag = 1;
    _forwardButton.enabled = NO;
    _refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                      UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction)];
    _refreshButton.tag = 3;
    _stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                   UIBarButtonSystemItemStop target:self action:@selector(stopAction)];
    _stopButton.tag = 3;
    
    UIBarItem* space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                         UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    
    _toolbar = [[UIToolbar alloc] initWithFrame:
                CGRectMake(0, self.view.height - TTToolbarHeight(),
                           self.view.width, TTToolbarHeight())];
    _toolbar.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    _toolbar.tintColor = TTSTYLEVAR(toolbarTintColor);
    _toolbar.items = [NSArray arrayWithObjects:
                      _backButton,
                      space,
                      _forwardButton,
                      // CRAPTASTIC!
                      space,
                      space,
                      space,
                      space,
                      _refreshButton,
                      nil];
    [self.view addSubview:_toolbar];
}

@end
