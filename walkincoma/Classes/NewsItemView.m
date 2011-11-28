//
//  NewsItemView.m
//  TNWLM2
//
//  Created by Nick Pack on 25/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "NewsItemView.h"
#import "Three20/Three20+Additions.h"
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NewsItemView

@synthesize article;

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    if (self = [self initWithNibName:nil bundle:nil]) {
		self.title = [query objectForKey:@"title"];
		self.article = query;
		self.variableHeightRows = YES;
		self.tableViewStyle = UITableViewStyleGrouped;
		self.tableView.autoresizesSubviews = YES;
	}
    return self;
}


- (void) createModel {
	TTTableCaptionItem* timestamp = [TTTableCaptionItem
									itemWithText:[[self.article objectForKey:@"timestamp"] formatRelativeTime]
									caption: @"Posted"
									URL: nil];
	TTStyledText* text = [TTStyledText textFromXHTML:[self.article objectForKey:@"articleBody"] lineBreaks:YES URLs:YES];
	TTTableStyledTextItem* articleBody = [TTTableStyledTextItem itemWithText:text URL:nil];
	TTTableCaptionItem* postedBy = [TTTableCaptionItem
								  itemWithText:[self.article objectForKey:@"postedBy"]
								  caption: @"Posted by"
								  URL: nil];
	NSArray* info = [NSArray arrayWithObjects:timestamp,articleBody,postedBy,nil];
	NSArray* links = [NSArray arrayWithObject:[TTTableButton itemWithText:@"View Original Article" URL:[self.article objectForKey:@"original"]]];
	self.dataSource = [[TTSectionedDataSource alloc] initWithItems:[NSArray arrayWithObjects:info, links, nil] sections:[NSArray arrayWithObjects:[self.article objectForKey:@"title"], @"", nil]];

	timestamp = nil;
	text = nil;
	articleBody = nil;
	postedBy = nil;
	info = nil;
	links = nil;
	[timestamp dealloc];
	[text dealloc];
	[articleBody dealloc];
	[postedBy dealloc];
	[info dealloc];
	[links dealloc];
}

- (BOOL)persistView:(NSMutableDictionary*)state {
	return NO;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];	
}

-(void)dealloc {
	self.dataSource = nil;
	[super dealloc];
}

@end

