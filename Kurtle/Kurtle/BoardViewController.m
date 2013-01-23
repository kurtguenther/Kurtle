//
//  BoardViewController.m
//  Kurtle
//
//  Created by Kurt Guenther on 1/15/13.
//  Copyright (c) 2013 Kurt Guenther. All rights reserved.
//

#import "BoardViewController.h"
#import "BoardView.h"
#import "TileView.h"

#import "Lexicontext.h"

#define IGNORE_DICTIONARY YES

@interface BoardViewController ()

@end

@implementation BoardViewController

@synthesize game = _game;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.timeLeft = 2 * 60 + 1;
        self.state = kRunning;
        self.score = 0;
        self.words = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Start the timer.
    int64_t delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self updateTime];
    });

    [self.boardView foldOnTiles:^(int x, int y, TileView *tile) {
        [tile setLetter: [self returnRandomLetter]];
    }];
    
    //Start listening to board moves
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(letterAdded:) name:kMoveLetterMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wordAdded:) name:kEndWordMessage object:nil];
}

- (NSString*) formatForTime:(float) timeInSeconds
{
    int mins = floor(timeInSeconds / 60.0);
    int seconds = (int)timeInSeconds % 60;
    return seconds < 10 ? [NSString stringWithFormat:@"%d:0%d", mins, seconds] : [NSString stringWithFormat:@"%d:%d", mins, seconds];
}

- (void) hitPause: (id) sender
{
    switch (self.state) {
        case kRunning: //hit pause
            self.state = kPaused;
            break;
        case kPaused: // hit play
            self.state = kRunning;
            [self updateTime];
            break;
        case kEnded: // do nothing.
        default:
            break;
    }

}

- (void) updateTime
{
    //Don't update the timer if it's not a running game (paused, ended, etc.)
    if(self.state == kRunning)
    {
        //Time left, keep counting down
        if(self.timeLeft > 0)
        {
            self.timeLeft -= 1.0;
            
            self.timerLabel.text = [self formatForTime: self.timeLeft];
            
            //Continue the timer.
            int64_t delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self updateTime];
            });
        }
        //Game over, son.
        else
        {
            UIAlertView * gameover = [[UIAlertView alloc] initWithTitle:@"Game Over!" message:@"Great job, dingus" delegate:self cancelButtonTitle:nil otherButtonTitles:@"God dammit.", nil];
            [gameover show];
            self.state = kEnded;
            
            [self.boardView setUserInteractionEnabled:NO];
        }
    }
}

- (void) letterAdded:(NSNotification*) sender
{
    TileView* obj = sender.object;
    self.wordLabel.text = [NSString stringWithFormat:@"%@%@", self.wordLabel.text, obj.letter];
}

- (void) wordAdded:(NSNotification*) sender
{
    NSArray* tiles = (NSArray*) sender.object;
    //Todo: make this based on tiles.
    NSMutableString* word = [NSMutableString string];
    for(int i = 0; i < [tiles count]; i++)
    {
        [word appendString:((TileView*) tiles[i]).letter];
    }

    if([self isValidWord:word])
    {
        if(![self.words containsObject:word])
        {
            //add some score.
            [self updateScore: self.score + [self getScoreForWord:tiles]];
            [self.words addObject:word];        
        }
        else
        {
            //Some kind of error for dingus.
        }
    }
    else // bad word dingus
    {
        
    }
    
    //Always just...
    self.wordLabel.text = @"";
}

- (BOOL) isValidWord: (NSString*) word
{
    //debugging.
//    if(IGNORE_DICTIONARY)
//        return YES;
    
    Lexicontext *dictionary = [Lexicontext sharedDictionary];
    BOOL wordExists = [dictionary containsDefinitionFor:[word lowercaseString]];
    return wordExists;
}

- (int) getScoreForWord:(NSArray*) tiles
{
    //Todo: fancy math
    return [tiles count];
}

- (void) updateScore:(int) newScore
{
    self.score = newScore;
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%d",self.score]];
}
     
-(NSString*) returnRandomLetter
{
    //Be smarter.
    
    // Straight 1 in 26.
    
    //    NSString *alphabet  = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //    int index = arc4random() % 26;
    //    return [alphabet substringWithRange:NSMakeRange(index, 1)];
   
    //Ok, use Boggle frequency: http://boardgamegeek.com/thread/300883/letter-distribution
    NSString *boggleAlphabet = @"EEEEEEEEEEEEEEEEEEETTTTTTTTTTTTTAAAAAAAAAAAARRRRRRRRRRRRIIIIIIIIIIINNNNNNNNNNNOOOOOOOOOOOSSSSSSSSSDDDDDDCCCCCHHHHHFFFFLLLLLMMMMPPPPUUUUGGGYYYWWBJKVQXZ";
    int index = arc4random() % boggleAlphabet.length;
    
    NSString* letter = [boggleAlphabet substringWithRange:NSMakeRange(index, 1)];
    
    return [letter isEqualToString:@"Q"] ? @"Qu" : letter;
}

@end
