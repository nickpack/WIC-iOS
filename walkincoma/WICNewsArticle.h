//
//  WICNewsArticle.h
//  WalkInComa
//
//  Created by Nikki Pack on 18/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WICBandMember.h"

@interface WICNewsArticle : NSObject
@property (readonly) NSString *articleBody;
@property (readonly) NSString *articleTitle;
@property (readonly) NSString *articleDate;
@property (readonly) WICBandMember *bandMember;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)newsArticlesWithBlock:(void (^)(NSArray *articles))block;
@end
