//
//  VideoDataSource.m
//  TNWLM2
//
//  Created by Nick on 28/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "VideoDataSource.h"
#import "FeedModel.h"
#import "FeedItem.h"
#import "YouTubeTextItem.h"
#import "YoutubeTableCell.h"
#import <Three20Core/NSDateAdditions.h>
#import <Three20Core/NSStringAdditions.h>

@implementation VideoDataSource

- (id)initWithFeedUrl:(NSString*)feedUrl {
	if ((self = [super init])) {
		_feedModel = [[FeedModel alloc] initWithFeedUrl:feedUrl];
	}
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_feedModel);

	[super dealloc];
}

- (id<TTModel>)model {
	return _feedModel;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object {

	if([object isKindOfClass:[YoutubeTextItem class]])
		return [YoutubeTableCell class];
	else
		return [super tableView:tableView cellClassForObject:object];
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {

	NSMutableArray* items = [[NSMutableArray alloc] init];

	for (FeedItem* item in _feedModel.items) {
		[items addObject:[YoutubeTextItem itemWithText:item.title url:item.link]];
	}
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating Videos List...", @"Video feed updating text");
    } else {
        return NSLocalizedString(@"Loading Videos List...", @"Video feed loading text");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return NSLocalizedString(@"No videos found.", @"Video feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return NSLocalizedString(@"Sorry, there was an error loading the Video feed.", @"");
}


@end
