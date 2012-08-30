//
//  WICAPIClient.h
//  WalkInComa
//
//  Created by Nikki Pack on 18/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AFHTTPClient.h"

@interface WICAPIClient : AFHTTPClient
+ (WICAPIClient *)sharedClient;
@end
