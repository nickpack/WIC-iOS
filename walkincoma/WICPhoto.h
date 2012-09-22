//
//  WICPhoto.h
//  WalkInComa
//
//  Created by Nick Pack on 21/09/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WICPhoto : NSObject
@property (readonly) NSString* title;
@property (readonly) NSString* thumbUrl;
@property (readonly) NSString* medUrl;
@property (readonly) NSString* dateAdded;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)photosWithBlock:(void (^)(NSArray *photos))block;

@end
