//
//  WICShowsViewController.m
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICShowsViewController.h"
#import "WICShow.h"

@interface WICShowsViewController ()
- (void)revealSidebar;
- (void)reload:(id)sender;
@end

@implementation WICShowsViewController {
@private
    NSArray *_shows;
    __strong UIActivityIndicatorView *_activityIndicatorView;
}


- (id)initWithTitle:(NSString *)title
    withRevealBlock:(RevealBlock)revealBlock
       withShowType:(NSInteger)showType {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
		self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                      target:self
                                                      action:@selector(revealSidebar)];
	}
    
	return self;
}

- (void)reload:(id)sender {
    [_activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;

    [WICShow showsWithBlock:^(NSArray *shows) {
        if (shows) {
            _shows = shows;
            [self.tableView reloadData];
            [_activityIndicatorView stopAnimating];
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    }];
}

- (void)loadView {
    [super loadView];
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicatorView.hidesWhenStopped = YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reload:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)revealSidebar {
	_revealBlock();
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier2 = @"Cell2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier2];
    }
    
    WICShow *show = [_shows objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = show.title;
    cell.detailTextLabel.text = show.startTime;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_shows count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}


@end
