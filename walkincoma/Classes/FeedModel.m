//
//  FeedModel.m
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "FeedModel.h"
#import "FeedItem.h"
#import "extThree20XML/extThree20XML.h"

@implementation FeedModel

@synthesize feedUrl = _feedUrl;
@synthesize items = _items;

- (id)initWithFeedUrl:(NSString*)feedUrl {
	if ((self = [super init])) {
		self.feedUrl = feedUrl;
	}
	return self;
}

- (void) dealloc {
	TT_RELEASE_SAFELY(_feedUrl);
	TT_RELEASE_SAFELY(_items);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading) {

		TTURLRequest* request = [TTURLRequest
								 requestWithURL: self.feedUrl
								 delegate: self];
        request.cachePolicy = cachePolicy;
        request.cacheExpirationAge = 1;
        
		TTURLXMLResponse* response = [[TTURLXMLResponse alloc] init];
		response.isRssFeed = YES;
		request.response = response;
		TT_RELEASE_SAFELY(response);

		[request send];
	}
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLXMLResponse* response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);

	NSDictionary* feed = response.rootObject;

	//TTDASSERT([[feed objectForKey:@"channel"] objectForKey:@"item"] isKindOfClass:[NSArray class]]);

	NSArray* entries = [[feed objectForKey:@"channel"] objectForKey:@"item"];
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
	[dateFormatter setDateFormat:@"EEE, dd MMMM yyyy HH:mm:ss Z"];

	TT_RELEASE_SAFELY(_items);
	NSMutableArray* items = [[NSMutableArray alloc] initWithCapacity:[entries count]];

	for (NSDictionary* entry in entries) {
		FeedItem* item = [[FeedItem alloc] init];
		NSDate* date = [dateFormatter dateFromString:[[entry objectForKey:@"pubDate"] objectForXMLNode]];
		item.posted = date;
        item.ts = [[entry objectForKey:@"pubDate"] objectForXMLNode];
		item.title = [[entry objectForKey:@"title"] objectForXMLNode];
		item.body = [[entry objectForKey:@"content:encoded"] objectForXMLNode];
		item.link = [[entry objectForKey:@"link"] objectForXMLNode];
		item.poster = [[entry objectForKey:@"dc:creator"] objectForXMLNode];
		item.description = [[entry objectForKey:@"description"] objectForXMLNode];
		[items addObject:item];
		TT_RELEASE_SAFELY(item);
	}
	_items = items;
	TT_RELEASE_SAFELY(dateFormatter);

	[super requestDidFinishLoad:request];
}

@end
