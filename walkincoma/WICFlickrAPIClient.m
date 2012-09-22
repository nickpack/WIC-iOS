//
//  WICFlickrAPIClient.m
//  WalkInComa
//
//  Created by Nick Pack on 21/09/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICFlickrAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kAPIBaseURLString = @"http://api.flickr.com/services/";

@implementation WICFlickrAPIClient

+ (WICFlickrAPIClient *)sharedClient {
    static WICFlickrAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[WICFlickrAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
   	[self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}

@end
