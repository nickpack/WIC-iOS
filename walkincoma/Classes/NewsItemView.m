//
//  NewsItemView.m
//  TNWLM2
//
//  Created by Nick Pack on 25/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "NewsItemView.h"
#import "Three20/Three20+Additions.h"
#import <Three20Core/NSDateAdditions.h>
#import <Three20Core/NSStringAdditions.h>
#import "RegexKitLite.h"
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NewsItemView

@synthesize article;

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    if (self = [self initWithNibName:nil bundle:nil]) {
		//self.title = [query objectForKey:@"title"];
		//self.title = @"Article Viewer";
        self.article = query;
		self.variableHeightRows = YES;
		//self.tableViewStyle = UITableViewStyleGrouped;
		self.tableView.autoresizesSubviews = YES;
	}
    return self;
}


- (void) createModel {
    
    NSString *avatar = [[[self.article objectForKey:@"postedBy"] stringByReplacingOccurrencesOfRegex:@"\\W+"
                                                              withString:@""]
                        lowercaseString];
    NSString *avatarUrl;
    if (![avatar isEqualToString:@"tom"] && ![avatar isEqualToString:@"nick"] && ![avatar isEqualToString:@"alex"] && ![avatar isEqualToString:@"mark"]) {
        avatarUrl = @"bundle://news-nobg.png";
    } else {
        avatarUrl = [NSString stringWithFormat:@"http://app.walkincoma.co.uk/%@.jpg", avatar];
    }
    
	TTStyledText* text = [TTStyledText textFromXHTML:[self.article objectForKey:@"articleBody"] lineBreaks:YES URLs:YES];
	TTTableStyledTextItem* articleBody = [TTTableStyledTextItem itemWithText:text URL:nil];
    
    NSString* dateAndBy = [NSString stringWithFormat:@"%@: %@", [self.article objectForKey:@"postedBy"], [[self.article objectForKey:@"timestamp"] formatRelativeTime]];
    
	TTTableSubtitleItem* postedBy = [TTTableSubtitleItem 
                                     itemWithText:[self.article objectForKey:@"title"]
                                     subtitle:dateAndBy
                                     imageURL:avatarUrl 
                                     defaultImage:nil
                                     URL:nil 
                                     accessoryURL:nil];
    TTTableButton* viewOriginal = [TTTableButton itemWithText:@"View Original Article" URL:[self.article objectForKey:@"original"]];
	NSArray* info = [NSArray arrayWithObjects:postedBy,articleBody,viewOriginal,nil];
	
	self.dataSource = [[[TTSectionedDataSource alloc] initWithItems:[NSArray arrayWithObjects:info, nil] sections:[NSArray arrayWithObjects:@"", nil]] autorelease];
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

