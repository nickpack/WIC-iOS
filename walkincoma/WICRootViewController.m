//
//  WICRootViewController.m
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICRootViewController.h"
#import "WICNewsArticle.h"

@interface WICRootViewController ()

- (void)revealSidebar;
- (void)reload:(id)sender;

@end

@implementation WICRootViewController {
@private
NSArray *_news;
__strong UIActivityIndicatorView *_activityIndicatorView;
}

- (void)reload:(id)sender {
    [_activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    NSLog(@"Reload");
    [WICNewsArticle newsArticlesWithBlock:^(NSArray *news) {
        if (news) {
            _news = news;
            [self.tableView reloadData];
        }
    }];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [_activityIndicatorView stopAnimating];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}


#pragma mark Memory Management
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
		self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                      target:self
                                                      action:@selector(revealSidebar)];
	}
	return self;
}

#pragma mark UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reload:nil];
}

- (void)loadView {
    [super loadView];
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicatorView.hidesWhenStopped = YES;
}

- (void)revealSidebar {
	_revealBlock();
}

#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier2 = @"Cell2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier2];
    }
    
    WICNewsArticle *art = [_news objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = art.articleTitle;
    cell.detailTextLabel.text = art.articleDate;
    NSLog(@"%d", indexPath.row);
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"Sections");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"RowsInSection");
    return [_news count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSLog(@"Section Title");
    return @"Title";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Height");
    return 80.0f;
}

@end
