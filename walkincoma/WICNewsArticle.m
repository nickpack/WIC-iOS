//
//  WICNewsArticle.m
//  WalkInComa
//
//  Created by Nikki Pack on 18/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WICNewsArticle.h"
#import "WICNewsArticle.h"
#import "WICAPIClient.h"

@implementation WICNewsArticle {
@private
    __strong NSString *_articleTitle;
    __strong NSString *_articleBody;
    __strong NSString *_articleDate;
    __strong WICBandMember *_bandMember;
}

@synthesize articleTitle = _articleTitle;
@synthesize articleBody = _articleBody;
@synthesize articleDate = _articleDate;
@synthesize bandMember = _bandMember;

- (id)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _articleTitle = [attributes valueForKeyPath:@"title"];
    _articleBody = [attributes valueForKeyPath:@"article_body"];
    _articleDate  = [attributes valueForKeyPath:@"article_date"];
    _bandMember = [[WICBandMember alloc] initWithAttributes:[attributes valueForKeyPath:@"posted_by"]];
    
    return self;
}

+ (void)newsArticlesWithBlock:(void (^)(NSArray *articles))block {
    [[WICAPIClient sharedClient] getPath:@"news" parameters:Nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *mutableArticles = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON) {
            WICNewsArticle *article = [[WICNewsArticle alloc] initWithAttributes:attributes];
            [mutableArticles addObject:article];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableArticles]);
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
