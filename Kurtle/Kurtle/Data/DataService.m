//
//  DataService.m
//  Kurtle
//
//  Created by Kurt Guenther on 1/22/13.
//  Copyright (c) 2013 Kurt Guenther. All rights reserved.
//

#import "DataService.h"
#import "Game.h"

@implementation DataService

- (Game*) startgame
{
    Game* retVal = (Game*)[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:[AppDelegate sharedDelegate].managedObjectContext];
    NSError* saveError = nil;
    [retVal.managedObjectContext save:&saveError];
    NSAssert(saveError == nil, @"There was as problem saving the context: %@", [saveError localizedDescription]);
    
    return retVal;
}


@end

