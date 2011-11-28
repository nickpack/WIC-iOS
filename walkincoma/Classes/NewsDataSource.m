//
//  NewsDataSource.m
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "NewsDataSource.h"
#import "FeedModel.h"
#import "FeedItem.h"
#import <Three20Core/NSDateAdditions.h>
#import <Three20Core/NSStringAdditions.h>
#import "RegexKitLite.h"

@implementation NewsDataSource

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

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];

	for (FeedItem* item in _feedModel.items) {
		NSString *avatar = [[item.poster stringByReplacingOccurrencesOfRegex:@"\\W+"
																   withString:@""]
																	lowercaseString];
		NSString *avatarUrl;
		if (![avatar isEqualToString:@"tom"] && ![avatar isEqualToString:@"nickpack"] && ![avatar isEqualToString:@"tobygore"] && ![avatar isEqualToString:@"meatarm"]) {
			avatarUrl = @"bundle://news-nobg.png";
		} else {
			avatarUrl = [NSString stringWithFormat:@"http://app.thenursewholovedme.com/nickpack.jpg", avatar];
		}

		NSString* body = [item.description stringByRemovingHTMLTags];
		body = [body stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		TTTableMessageItem* tableRow = [TTTableMessageItem itemWithTitle:item.title caption:[NSString stringWithFormat:@"Posted by: %@",item.poster]
																	text:body timestamp:item.posted
																imageURL:avatarUrl URL:@"wic://viewnews"];
		NSDictionary* rowInfo = [NSDictionary dictionaryWithObjectsAndKeys:
								 item.title,
								 @"title",
								 item.poster,
								 @"postedBy",
								 item.body,
								 @"articleBody",
								 item.posted,
								 @"timestamp",
								 item.link,
								 @"original",
								 nil];
		tableRow.userInfo = rowInfo;
		[items addObject:tableRow];
	}

	self.items = items;

	TT_RELEASE_SAFELY(items);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating News Feed...", @"News feed updating text");
    } else {
        return NSLocalizedString(@"Loading News Feed...", @"News feed loading text");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return NSLocalizedString(@"No news articles found.", @"News feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return NSLocalizedString(@"Sorry, there was an error loading the News Feed.", @"");
}


@end
