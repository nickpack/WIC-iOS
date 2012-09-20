//
//  WICRootViewController.m
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICRootViewController.h"
#import "WICNewsArticle.h"
#import "WICNewsCell.h"

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
    
    static NSString *CellIdentifier2 = @"NewsCell";
    
    WICNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    if (!cell) {
        cell = [[WICNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier2];
    }
    
    WICNewsArticle *art = [_news objectAtIndex:indexPath.row];
    
    cell.article = art;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_news count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WICNewsCell heightForCellWithArticle:[_news objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WICNewsArticle *article = [_news objectAtIndex:indexPath.row];
        //UIViewController *vc = [[WICMemberViewController alloc] initWithStyle:UITableViewStyleGrouped withMember:member];
        //[self.navigationController pushViewController:vc animated:YES];
}

@end
