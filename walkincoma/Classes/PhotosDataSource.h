//
//  PhotosDataSource.h
//  TNWLM2
//
//  Created by Nick Pack on 14/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoResponse.h"

@interface PhotosDataSource : TTURLRequestModel <TTPhotoSource> {
    NSString* _title;
	NSArray* _photos;
	PhotoResponse* responseProcessor;
	NSUInteger page;
}

@end
