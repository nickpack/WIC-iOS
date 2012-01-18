//
//  FeedModel.h
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FeedModel : TTURLRequestModel {
	NSString* _feedUrl;
	NSArray*  _items;
    BOOL      _youTube;
}

@property (nonatomic)           BOOL      youTube;
@property (nonatomic, copy)     NSString* feedUrl;
@property (nonatomic, readonly) NSArray*  items;

- (id)initWithFeedUrl:(NSString*)feedUrl;
- (id)initWithYoutubeUrl:(NSString*)feedUrl;

@end
