//
//  WICBandMember.h
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WICBandMember : NSObject
@property (readonly) NSString *firstName;
@property (readonly) NSString *lastName;
@property (readonly) NSString *bio;
@property (readonly) NSString *gear;
@property (readonly) NSString *role;
@property (readonly) NSString *avatar;
@property (readonly) NSString *nickname;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)membersWithBlock:(void (^)(NSArray *members))block;

@end
