//
//  PhotosDataSource.m
//  TNWLM2
//
//  Created by Nick Pack on 14/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "PhotosDataSource.h"
#import "PhotoItem.h"
#import "PhotoResponse.h"
#import "Three20/Three20+Additions.h"
#import "extThree20XML/extThree20XML.h"

@implementation PhotosDataSource

@synthesize title = _title;

- (id)init {
	if ((self = [super init])) {
        _title = @"Photos";
        page = 1;
        responseProcessor = [[PhotoResponse alloc] init];
    }
	return self;
}

- (NSArray *)flickrPhotos
{
    return [[[responseProcessor objects] copy] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating Photos...", @"Photos feed updating text");
    } else {
        return NSLocalizedString(@"Loading  Photos...", @"Photos feed loading text");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return NSLocalizedString(@"No photos found.", @"Photos feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return NSLocalizedString(@"Sorry, there was an error loading the photo stream.", @"");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTPhotoSource

- (NSInteger)numberOfPhotos {
	return [responseProcessor totalObjectsAvailableOnServer];
}

- (NSInteger)maxPhotoIndex {
	return [self flickrPhotos].count - 1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)index {
	if (index < [self flickrPhotos].count) {
		id<TTPhoto> photo = [[self flickrPhotos] objectAtIndex:index];
		photo.index = index;
		photo.photoSource = self;
		return photo;
	} else {
		return nil;
	}
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (more) {
		page++;
	}
	if (!self.isLoading) {
		NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
		 @"flickr.groups.pools.getPhotos", @"method",
		 @"1685472@N24", @"group_id",
		 @"rest", @"format",
		 [NSString stringWithFormat:@"%lu", (unsigned long)page], @"page",
		 @"16", @"per_page",
		 @"url_m,url_t", @"extras",
		 @"f2ee9894036e6aac85333460172d63eb", @"api_key", // TNWLM API KEY

		 nil];

		 NSString *apiurl = @"http://api.flickr.com/services/rest/";
		 NSString *url = [apiurl stringByAddingQueryDictionary:parameters];
		TTURLRequest* request = [TTURLRequest
								 requestWithURL: url
								 delegate: self];

		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = 600;

		request.response = responseProcessor;
		[request send];
	}
}

@end
