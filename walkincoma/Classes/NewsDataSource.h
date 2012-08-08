//
//  NewsDataSource.h
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedModel;

@interface NewsDataSource : TTSectionedDataSource {
	FeedModel* _feedModel;
}

- (id)initWithFeedUrl:(NSString*)feedUrl;
- (id)initWithJSONUrl:(NSString*)feedUrl;
NSComparisonResult dateSort(NSString *s1, NSString *s2, void *context);

@end
