//
//  PopcornuaAppDelegate.h
//  Popcornua
//
//  Created by Alex on 9/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCUDataController.h"
#import "GANTracker.h"

@class MainNavController;

@interface PopcornuaAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;
@property (nonatomic, retain) IBOutlet MainNavController *navController;

@property (nonatomic, retain) IBOutlet UITabBarItem *moviesTab;
@property (nonatomic, retain) IBOutlet UITabBarItem *cinemasTab;
@property (nonatomic, retain) IBOutlet UITabBarItem *mapTab;
@property (nonatomic, retain) IBOutlet UITabBarItem *settingsTab;

- (void)settingChanged:(NSNotification *)notification;
- (void)syncDataCore:(BOOL)withCleanup;
- (void)syncDataCore;


@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
