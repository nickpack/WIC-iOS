//
//  PhotoResponse.m
//  TNWLM2
//
//  Created by Nick Pack on 17/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "PhotoResponse.h"
#import "PhotoItem.h"
#import "Three20/Three20+Additions.h"
#import "extThree20XML/extThree20XML.h"

@implementation PhotoResponse

@synthesize objects, totalObjectsAvailableOnServer;

- (id)init {
	if ((self = [super init])) {
        objects = [[NSMutableArray alloc] init];
    }
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(objects);
	[super dealloc];
}

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
	TTDASSERT([data isKindOfClass:[NSData class]]);

	if ([data isKindOfClass:[NSData class]]) {
		NSString *utf8Response = [[[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding] autorelease];
		// oh ooh. server sent us data in ISO-8859-1? [hack around standards]
		// http://stackoverflow.com/questions/1207867/nsxmlparser-rss-issue-nsxmlparserinvalidcharactererror
		if (!utf8Response) {
			NSString *dataString = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
			data = [dataString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
		}

		TTXMLParser* parser = [[[TTXMLParser alloc] initWithData:data] autorelease];
		parser.treatDuplicateKeysAsArrayItems = YES;
		[parser parse];

		NSDictionary* feed = [parser.rootObject retain];

		NSDictionary *root = [feed objectForKey:@"photos"];
		self.totalObjectsAvailableOnServer = [[root objectForKey:@"total"] integerValue];

		NSArray *results = [root objectForKey:@"photo"];
		for (NSDictionary *rawResult in results) {
				NSString* bigURL = [rawResult objectForKey:@"url_m"];
				NSString* smallURL = [rawResult objectForKey:@"url_t"];
				NSString* title = [rawResult objectForKey:@"title"];
				CGSize bigSize = CGSizeMake([[rawResult objectForKey:@"width_m"] floatValue],
										[[rawResult objectForKey:@"height_m"] floatValue]);
				PhotoItem* photo = [[PhotoItem alloc] initWithURL:bigURL smallURL:smallURL size:bigSize caption:title];
				[self.objects addObject:photo];
				[photo release];
		}
        
        [feed release];
	}

	return nil;
}

@end
