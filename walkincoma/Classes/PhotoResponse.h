//
//  PhotoResponse.h
//  TNWLM2
//
//  Created by Nick Pack on 17/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhotoResponse : NSObject <TTURLResponse>
{
	NSMutableArray* objects;
	NSUInteger totalObjectsAvailableOnServer;
}

@property (nonatomic, readonly) NSMutableArray *objects;
@property (nonatomic) NSUInteger totalObjectsAvailableOnServer;

@end