//
//  FeedModel.m
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "FeedModel.h"
#import "FeedItem.h"
#import "extThree20JSON/extThree20JSON.h"
#import "extThree20XML/extThree20XML.h"

@implementation FeedModel

@synthesize feedUrl = _feedUrl;
@synthesize items = _items;
@synthesize youTube = _youTube;
@synthesize isJSON = _isJSON;

// This should be a parameter on initWithFeedUrl but I dont have time to refactor
- (id)initWithYoutubeUrl:(NSString*)feedUrl {
	if ((self = [super init])) {
		self.youTube = YES;
        self.feedUrl = feedUrl;
	}
	return self;
}

- (id)initWithJSONUrl:(NSString*)feedUrl {
    if ((self = [super init])) {
		self.youTube = YES;
        self.feedUrl = feedUrl;
        self.isJSON = YES;
	}
    
	return self;
}

- (id)initWithFeedUrl:(NSString*)feedUrl {
	if ((self = [super init])) {
        self.youTube = NO;
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
        
        if (self.isJSON) {
            TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
            request.response = response;
            TT_RELEASE_SAFELY(response);
        } else {
            TTURLXMLResponse* response = [[TTURLXMLResponse alloc] init];
            response.isRssFeed = YES;
            request.response = response;
            TT_RELEASE_SAFELY(response);
        }

		[request send];
	}
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
    
    if (!self.isJSON) {
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
            item.poster = [[entry objectForKey:@"dc:creator"] objectForXMLNode];
            item.description = [[entry objectForKey:@"description"] objectForXMLNode];
            item.link = [[entry objectForKey:@"link"] objectForXMLNode];
            
            if (self.youTube) {
                item.thumb = [[[[entry objectForKey:@"media:group"] objectForKey:@"media:thumbnail"] objectAtIndex:0] objectForKey:@"url"];
            }
            
            [items addObject:item];
            TT_RELEASE_SAFELY(item);
        }
        _items = items;
        TT_RELEASE_SAFELY(dateFormatter);
    } else {
        TTURLJSONResponse* response = request.response;
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDictionary* entries = response.rootObject;
        TT_RELEASE_SAFELY(_items);
        
        NSMutableArray* items = [[NSMutableArray alloc] initWithCapacity:[entries count]];
        
        for (NSDictionary* entry in entries) {
            FeedItem* item = [[FeedItem alloc] init];
            NSDate* date = [dateFormatter dateFromString:[entry objectForKey:@"article_date"]];
            item.posted = date;
            item.ts = [entry objectForKey:@"article_date"];
            item.title = [entry objectForKey:@"title"];
            item.body = [entry objectForKey:@"article_body"];
            item.poster = [[[entry objectForKey:@"posted_by"] objectAtIndex:0] objectForKey:@"first_name"];
            item.description = [entry objectForKey:@"article_body"];
            item.link = [NSString stringWithFormat:@"http://www.walkincoma.co.uk/news/%@", [entry objectForKey:@"slug"]];

            [items addObject:item];
            TT_RELEASE_SAFELY(item);
        }
        _items = items;
    }
    
	[super requestDidFinishLoad:request];
}

@end
