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
    

    [self.boardView foldOnTiles:^(TileView *tile) {
        [tile setLetter: [self returnRandomLetter]];
    }];
    
}

     
-(NSString*) returnRandomLetter
{
    //Be smarter;
    
    NSString *alphabet  = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";    
    int index = arc4random() % 26;
    return [alphabet substringWithRange:NSMakeRange(index, 1)];
}

@end
