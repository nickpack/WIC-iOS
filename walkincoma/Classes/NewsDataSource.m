//
//  NewsDataSource.m
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "NewsDataSource.h"
#import "FeedModel.h"
#import "FeedItem.h"
#import <Three20Core/NSDateAdditions.h>
#import <Three20Core/NSStringAdditions.h>
#import "RegexKitLite.h"

@implementation NewsDataSource

- (id)initWithFeedUrl:(NSString*)feedUrl {
	if ((self = [super init])) {
		_feedModel = [[FeedModel alloc] initWithFeedUrl:feedUrl];
	}

	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_feedModel);

	[super dealloc];
}

- (id<TTModel>)model {
	return _feedModel;
}

NSComparisonResult dateSort(NSString *s1, NSString *s2, void *context) {
    NSDateFormatter* fmt1 = [[NSDateFormatter alloc] init];
    [fmt1 setDateFormat:@"dd/MM/yyyy"];
    NSDate *d1 = [fmt1 dateFromString:s1];
    NSDate *d2 = [fmt1 dateFromString:s2];
    [fmt1 release];
    return [d1 compare:d2];
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
    
    self.items = [NSMutableArray array];
    self.sections = [NSMutableArray array];
    
    NSMutableDictionary* groups = [NSMutableDictionary dictionary];
    
    
    
    for (FeedItem* item in _feedModel.items) {
        
        NSDateFormatter* fmt1 = [[NSDateFormatter alloc] init];
        [fmt1 setDateFormat:@"MM/yyyy"];
        NSString* headerDate = [fmt1 stringFromDate: item.posted];
        [fmt1 release];
        NSMutableArray* section = [groups objectForKey:headerDate];
        if (!section) {
            section = [NSMutableArray array];
            [groups setObject:section forKey:headerDate];
        }
        TTTableItem* row;
        NSString *avatar = [[item.poster stringByReplacingOccurrencesOfRegex:@"\\W+"
                                                                  withString:@""]
                            lowercaseString];
		NSString *avatarUrl;
		if (![avatar isEqualToString:@"tom"] && ![avatar isEqualToString:@"nick"] && ![avatar isEqualToString:@"alex"] && ![avatar isEqualToString:@"mark"]) {
			avatarUrl = @"bundle://news-nobg.png";
		} else {
			avatarUrl = [NSString stringWithFormat:@"http://app.walkincoma.co.uk/%@.jpg", avatar];
		}
        
		NSString* body = [item.description stringByRemovingHTMLTags];
		body = [body stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		row = [TTTableMessageItem itemWithTitle:item.title caption:[NSString stringWithFormat:@"Posted by: %@",item.poster]
																	text:body timestamp:item.posted
																imageURL:avatarUrl URL:@"wic://viewnews"];
		NSDictionary* rowInfo = [NSDictionary dictionaryWithObjectsAndKeys:
								 item.title,
								 @"title",
								 item.poster,
								 @"postedBy",
								 item.body,
								 @"articleBody",
								 item.posted,
								 @"timestamp",
								 item.link,
								 @"original",
								 nil];
		row.userInfo = rowInfo;        
        [section addObject:row];
        
    }
    
    NSArray* types = [groups.allKeys sortedArrayUsingComparator:^(id obj1, id obj2)
                      {
                          NSDateFormatter* fmt1 = [[NSDateFormatter alloc] init];
                          [fmt1 setDateFormat:@"MM/yyyy"];
                          NSDate *d1 = [fmt1 dateFromString:obj1];
                          NSDate *d2 = [fmt1 dateFromString:obj2];
                          [fmt1 release];
                          return [d2 compare:d1];
                      }];
    for (NSString* type in types) {
        NSArray* items = [groups objectForKey:type];
        [_sections addObject:type];
        [_items addObject:items];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating Feed...", @"News feed updating text");
    } else {
        return NSLocalizedString(@"Loading Feed...", @"News feed loading text");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return NSLocalizedString(@"No articles found.", @"News feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return NSLocalizedString(@"Sorry, there was an error loading the Feed.", @"");
}


@end
