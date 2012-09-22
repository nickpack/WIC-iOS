//
//  WICPhotosViewController.h
//  WalkInComa
//
//  Created by Nick Pack on 21/09/2012.
//  Copyright (c) 2012 Nick Pack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealBlock.h"
@interface WICPhotosViewController : UIViewController {
    @private RevealBlock _revealBlock;
}

- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock;

@end