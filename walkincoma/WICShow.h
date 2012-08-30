//
//  WICShow.h
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WICShow : NSObject
@property (readonly) NSString* title;
@property (readonly) NSString* location;
@property (readonly) NSString* venuePic;
@property (readonly) NSString* eventInfo;
@property (readonly) NSString* otherBands;
@property (readonly) NSDate* startTime;
@property (readonly) NSDate* endTime;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)showsWithBlock:(void (^)(NSArray *shows))block;

@end
