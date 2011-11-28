//
//  VideoDataSource.h
//  TNWLM2
//
//  Created by Nick on 28/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedModel;

@interface VideoDataSource : TTListDataSource {
	FeedModel* _feedModel;
}

- (id)initWithFeedUrl:(NSString*)feedUrl;

@end
