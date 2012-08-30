//
//  WICAPIClient.m
//  WalkInComa
//
//  Created by Nikki Pack on 18/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WICAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kAPIBaseURLString = @"http://www.walkincoma.co.uk/api/";

@implementation WICAPIClient

+ (WICAPIClient *)sharedClient {
    static WICAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[WICAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
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
    [self setDefaultHeader:@"APIKey" value:@"wicd1r7y5ou7hwic"];
    return self;
}

@end
