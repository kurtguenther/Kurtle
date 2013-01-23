//
//  AppDelegate.h
//  Kurtle
//
//  Created by Kurt Guenther on 1/15/13.
//  Copyright (c) 2013 Kurt Guenther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DataService* dataService;


+ (AppDelegate*) sharedDelegate;


#pragma mark - Core Data crap

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSPersistentStore *persistentStore;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
