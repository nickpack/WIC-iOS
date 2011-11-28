//
//  NewsItem.h
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FeedItem : NSObject {
	NSDate*   _posted;
	NSString* _title;
	NSString* _body;
	NSString* _link;
	NSString* _poster;
	NSString* _description;
}

@property (nonatomic, retain) NSDate* posted;
@property (nonatomic, copy)   NSString* title;
@property (nonatomic, copy)   NSString* body;
@property (nonatomic, copy)   NSString* link;
@property (nonatomic, copy)   NSString* poster;
@property (nonatomic, copy)	  NSString* description;

@end
