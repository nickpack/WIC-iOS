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
    NSMutableArray *_shows;
    NSMutableArray *_prevShows;
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
        _shows = [[NSMutableArray alloc] initWithCapacity:1];
        _prevShows = [[NSMutableArray alloc] initWithCapacity:1];
	}
    
	return self;
}

- (void)reload:(id)sender {
    [_activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;

    [WICShow showsWithBlock:^(NSArray *shows) {
        _shows = [[NSMutableArray alloc] initWithCapacity:1];
        _prevShows = [[NSMutableArray alloc] initWithCapacity:1];
        if (shows) {
            for(WICShow *show in shows) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
                NSDate *articleDate = [dateFormat dateFromString:show.endTime];
                NSDate *currentDate = [NSDate date];
                
                if([articleDate compare:currentDate] == NSOrderedAscending) {
                    [_prevShows addObject:show];
                } else {
                    [_shows addObject:show];
                }
            }
            
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
    
    WICShow *show;
    if (indexPath.section == 0) {
        if ([_shows count] < 1) {
            cell.textLabel.text = NSLocalizedString(@"No upcoming shows at present...", nil);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.text = nil;
            return cell;
        }
        show = [_shows objectAtIndex:indexPath.row];
    } else {
        if ([_prevShows count] < 1) {
            cell.textLabel.text = NSLocalizedString(@"No previous shows at present...", nil);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.text = nil;
            return cell;
        }
        show = [_prevShows objectAtIndex:indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = show.title;
    cell.detailTextLabel.text = show.startTime;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        if ([_prevShows count] < 1) {
            return 1;
        }
        
        return [_prevShows count];
    } else {
        if ([_shows count] < 1) {
            return 1;
        }
        
        return [_shows count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Upcoming";
    } else {
        return @"Previous";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}



@end
