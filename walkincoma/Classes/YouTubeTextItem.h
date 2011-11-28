//
//  YouTubeTextItem.h
//  TNWLM2
//
//  Created by Nick Pack on 24/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

@interface YoutubeTextItem : TTTableTextItem {
	NSString* urlPath;
}

@property (nonatomic, copy) NSString* urlPath;

+ (id)itemWithText:(NSString *)text url:(NSString* )urlPath;

@end
