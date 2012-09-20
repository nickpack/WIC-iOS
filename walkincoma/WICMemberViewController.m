//
//  WICMemberViewController.m
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICMemberViewController.h"
#import "WICMemberNameAvatarCell.h"
#import "UIImageView+AFNetworking.h"

@interface WICMemberViewController ()

@end

@implementation WICMemberViewController

@synthesize member;

- (id)initWithStyle:(UITableViewStyle)style withMember:(WICBandMember*)memberObject
{
    self = [super initWithStyle:style];
    if (self) {
        self.member = memberObject;
        self.title = memberObject.firstName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if (indexPath.section == 0) {
        WICMemberNameAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[WICMemberNameAvatarCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        cell.member = member;
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        }
        
        switch (indexPath.row) {
            case 0:
                    // Role
                cell.textLabel.text = NSLocalizedString(@"Role", @"");
                cell.detailTextLabel.text = self.member.role;
                break;
            case 1:
                cell.textLabel.text = NSLocalizedString(@"Gear", @"");
                cell.detailTextLabel.text = self.member.gear;
                break;
            case 2:
                cell.textLabel.text = NSLocalizedString(@"Influences", @"");
                cell.detailTextLabel.text = self.member.bio;
                break;
        }
        
        cell.detailTextLabel.adjustsFontSizeToFitWidth = NO;
        CGRect detailTextLabelFrame = CGRectOffset(cell.textLabel.frame, 0.0f, 25.0f);
        detailTextLabelFrame.size.width = cell.textLabel.frame.size.width + 80.0f;
        detailTextLabelFrame.size.height = [self heightForCellWithCopy:cell.detailTextLabel.text];
        cell.detailTextLabel.frame = detailTextLabelFrame;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
    
}

-(CGFloat) heightForCellWithCopy:(NSString*)copy {
    CGSize sizeToFit = [copy sizeWithFont:[UIFont systemFontOfSize:12.0f]
                             constrainedToSize:CGSizeMake(1000.0f, CGFLOAT_MAX)
                                 lineBreakMode:UILineBreakModeWordWrap];
    
    return fmaxf(70.0f, sizeToFit.height + 45.0f);
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [WICMemberNameAvatarCell heightForCellWithMember:member];
    } else {
        NSString* cellText;
        switch (indexPath.row) {
            case 0:
                cellText = self.member.role;
                break;
            case 1:
                cellText = self.member.gear;
                break;
            case 2:
                cellText = self.member.bio;
                break;
        }
        
        return [self heightForCellWithCopy:cellText];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
