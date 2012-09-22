//
//  WICPhoto.m
//  WalkInComa
//
//  Created by Nick Pack on 21/09/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICPhoto.h"
#import "WICFlickrAPIClient.h"

@implementation WICPhoto

- (id)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _title = [attributes valueForKeyPath:@"title"];
    _thumbUrl = [attributes valueForKeyPath:@"url_t"];
    _medUrl = [attributes valueForKeyPath:@"url_m"];
    _dateAdded = [attributes valueForKeyPath:@"venue_pic"];
    
    return self;
}

+ (void)photosWithBlock:(void (^)(NSArray *photos))block {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"flickr.groups.pools.getPhotos", @"method",
                                @"1685472@N24", @"group_id",
                                @"json", @"format",
                                @"200", @"per_page",
                                @"1", @"nojsoncallback",
                                @"url_m,url_t", @"extras",
                                @"f2ee9894036e6aac85333460172d63eb", @"api_key",
                                nil];
    
    [[WICFlickrAPIClient sharedClient] getPath:@"rest" parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *mutablePhotos = [NSMutableArray arrayWithCapacity:[JSON count]];
        
        for (NSDictionary *attributes in [[JSON valueForKeyPath:@"photos"] valueForKeyPath:@"photo"]) {
            WICPhoto *pic = [[WICPhoto alloc] initWithAttributes:attributes];
            [mutablePhotos addObject:pic];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablePhotos]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        
        if (block) {
            block(nil);
        }
    }];
}

@end
