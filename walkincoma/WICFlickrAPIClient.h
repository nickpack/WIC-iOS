//
//  WICFlickrAPIClient.h
//  WalkInComa
//
//  Created by Nick Pack on 21/09/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "AFHTTPClient.h"

@interface WICFlickrAPIClient : AFHTTPClient
+ (WICFlickrAPIClient *)sharedClient;
@end
