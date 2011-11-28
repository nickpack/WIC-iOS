//
//  YouTubeTextItem.m
//  TNWLM2
//
//  Created by Nick Pack on 24/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "YoutubeTextItem.h"

@implementation YoutubeTextItem

@synthesize urlPath;

/////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString *)text url:(NSString* )urlPath {
	YoutubeTextItem *item = [[[self alloc] init] autorelease];
	item.text = text;
	item.urlPath = urlPath;
	return item;
}

/////////////////////////////////////////////////////////

- (void) dealloc {
	TT_RELEASE_SAFELY(urlPath);
	[super dealloc];
}

/////////////////////////////////////////////////////////

- (id)initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		self.urlPath = [decoder decodeObjectForKey:@"urlPath"];
	}
	return self;
}

//////////////////////////////////////////////////////////

- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];
	if (self.urlPath) {
		[encoder encodeObject:self.urlPath forKey:@"urlPath"];
	}
}

@end
