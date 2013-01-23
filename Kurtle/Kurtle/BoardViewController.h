//
//  BoardViewController.h
//  Kurtle
//
//  Created by Kurt Guenther on 1/15/13.
//  Copyright (c) 2013 Kurt Guenther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@class BoardView;

typedef enum
{
    kRunning = 0,
    kPaused = 1,
    kEnded = 2
}  GameState;


@interface BoardViewController : UIViewController <UIGestureRecognizerDelegate>

@property (retain, nonatomic) Game* game;


@property GameState state;
@property float timeLeft;
@property int score;
@property (retain, nonatomic) NSMutableArray* words;


@property (retain, nonatomic) IBOutlet UILabel *timerLabel;
@property (retain, nonatomic) IBOutlet BoardView *boardView;
@property (retain, nonatomic) IBOutlet UILabel* wordLabel;

#pragma mark - Actions
- (IBAction) hitPause: (id) sender;

@end
