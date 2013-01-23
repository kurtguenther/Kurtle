//
//  HomeViewController.m
//  Kurtle
//
//  Created by Kurt Guenther on 1/22/13.
//  Copyright (c) 2013 Kurt Guenther. All rights reserved.
//

#import "HomeViewController.h"
#import "Game.h"
#import "BoardViewController.h"

@implementation HomeViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Board-Segue"])
    {
        ((BoardViewController*)segue.destinationViewController).game = sender;
    }
}

- (void)startgame:(id)sender
{
    //Todo: options screen?
    
    Game* game = [[AppDelegate sharedDelegate].dataService startgame];
    [self performSegueWithIdentifier:@"Board-Segue" sender:game];
}

@end
