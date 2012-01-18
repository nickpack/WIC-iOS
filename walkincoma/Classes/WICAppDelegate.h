//
//  WICAppDelegate.h
//  walkincoma
//
//  Created by Nikki Pack on 01/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WICAppDelegate : UIResponder <UIApplicationDelegate> {
    BOOL shouldOpenStream;
	BOOL uiIsVisible;
}

@property (nonatomic) BOOL				uiIsVisible;
@property (nonatomic) BOOL				shouldOpenStream;


@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
