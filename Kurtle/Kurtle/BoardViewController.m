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


@interface BoardViewController ()

@end

@implementation BoardViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [self.boardView foldOnTiles:^(int x, int y, TileView *tile) {
        [tile setLetter: [self returnRandomLetter]];
    }];
    
    //Start listening to board moves
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(letterAdded:) name:kMoveLetterMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wordAdded:) name:kEndWordMessage object:nil];
}

- (void) letterAdded:(NSNotification*) sender
{
    TileView* obj = sender.object;
    self.wordLabel.text = [NSString stringWithFormat:@"%@%@", self.wordLabel.text, obj.letter];
}

- (void) wordAdded:(id) sender
{
    self.wordLabel.text = @"";
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
