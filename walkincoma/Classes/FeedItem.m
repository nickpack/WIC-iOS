//
//  NewsItem.m
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "FeedItem.h"


@implementation FeedItem

@synthesize posted = _posted;
@synthesize title = _title;
@synthesize body = _body;
@synthesize link = _link;
@synthesize poster = _poster;
@synthesize description = _description;

- (void) dealloc {
	TT_RELEASE_SAFELY(_posted);
	TT_RELEASE_SAFELY(_title);
	TT_RELEASE_SAFELY(_body);
	TT_RELEASE_SAFELY(_link);
	TT_RELEASE_SAFELY(_poster);
	TT_RELEASE_SAFELY(_description);
	[super dealloc];
}

@end
