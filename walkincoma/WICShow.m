//
//  WICShow.m
//  WalkInComa
//
//  Created by Nick Pack on 30/08/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import "WICShow.h"
#import "WICAPIClient.h"

@implementation WICShow {
    @private
    __strong NSString* _title;
    __strong NSString* _location;
    __strong NSString* _venuePic;
    __strong NSString* _eventInfo;
    __strong NSString* _otherBands;
    __strong NSString* _startTime;
    __strong NSString* _endTime;
}

@synthesize title = _title;
@synthesize location = _location;
@synthesize venuePic = _venuePic;
@synthesize eventInfo = _eventInfo;
@synthesize otherBands = _otherBands;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;

- (id)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _title = [attributes valueForKeyPath:@"title"];
    _location = [attributes valueForKeyPath:@"location"];
    _venuePic = [attributes valueForKeyPath:@"venue_pic"];
    _eventInfo = [attributes valueForKeyPath:@"event_info"];
    _otherBands = [attributes valueForKeyPath:@"other_bands"];
    _startTime = [attributes valueForKeyPath:@"start_date"];
    _endTime = [attributes valueForKeyPath:@"end_date"];
    
    return self;
}

+ (void)showsWithBlock:(void (^)(NSArray *shows))block {
    [[WICAPIClient sharedClient] getPath:@"live" parameters:Nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *mutableShows = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON) {
            WICShow *show = [[WICShow alloc] initWithAttributes:attributes];
            [mutableShows addObject:show];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableShows]);
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
