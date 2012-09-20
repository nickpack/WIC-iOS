//
//  WICBandMember.m
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICBandMember.h"
#import "WICAPIClient.h"

@implementation WICBandMember {
    @private
    __strong NSString* _firstName;
    __strong NSString* _lastName;
    __strong NSString* _bio;
    __strong NSString* _gear;
    __strong NSString* _role;
    __strong NSString* _avatar;
    __strong NSString* _nickname;
}

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize bio = _bio;
@synthesize gear = _gear;
@synthesize role = _role;
@synthesize avatar = _avatar;
@synthesize nickname = _nickname;

- (id)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _firstName = [attributes valueForKeyPath:@"first_name"];
    _lastName = [attributes valueForKeyPath:@"last_name"];
    _bio = [attributes valueForKeyPath:@"bio"];
    _gear = [attributes valueForKeyPath:@"gear"];
    _role = [attributes valueForKeyPath:@"role_in_band"];
    _avatar = [attributes valueForKeyPath:@"avatar"];
    _nickname = [attributes valueForKeyPath:@"nickname"];
    
    NSLog(@"%@", _avatar);
    
    return self;
}

+ (void)membersWithBlock:(void (^)(NSArray *members))block {
    [[WICAPIClient sharedClient] getPath:@"members" parameters:Nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *mutableMembers = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON) {
            WICBandMember *member = [[WICBandMember alloc] initWithAttributes:attributes];
            [mutableMembers addObject:member];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableMembers]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        
        if (block) {
            block(nil);
        }
    }];
}


@end
