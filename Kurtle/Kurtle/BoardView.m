//
//  BoardView.m
//  Kurtle
//
//  Created by Kurt Guenther on 1/15/13.
//  Copyright (c) 2013 Kurt Guenther. All rights reserved.
//

#import "BoardView.h"
#import "TileView.h"

@implementation BoardView


#define TILE_SIZE 60
#define TILE_SPACER 7
#define TOUCH_EPSILON 7

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib
{
    self.tiles = [NSArray arrayWithObjects:
                  [NSArray arrayWithObjects: self.tile00, self.tile01,self.tile02, self.tile03, nil],
                  [NSArray arrayWithObjects: self.tile10, self.tile11,self.tile12, self.tile13, nil],
                  [NSArray arrayWithObjects: self.tile20, self.tile21,self.tile22, self.tile23, nil],
                  [NSArray arrayWithObjects: self.tile30, self.tile31,self.tile32, self.tile33, nil],
                  nil];
}

- (TileView*) convertPointToTile:(CGPoint) point
{
    TileView* retVal = nil;
    
//    int x = floor((point.y - TILE_SPACER)/ (TILE_SIZE + TILE_SPACER));
//    int y = floor((point.x - TILE_SPACER) / (TILE_SIZE + TILE_SPACER));
    int x = floor(point.y / (TILE_SIZE + TILE_SPACER));
    int y = floor(point.x / (TILE_SIZE + TILE_SPACER));
    
    if (x < X_TILE_COUNT && x >= 0 && y < Y_TILE_COUNT && y >= 0)
    {
        //Check where in the square we are.
        int sq_x = (int) point.y % (TILE_SIZE + TILE_SPACER);
        int sq_y = (int) point.x % (TILE_SIZE + TILE_SPACER);
        
        if(sq_x > TILE_SPACER + TOUCH_EPSILON && sq_x < TILE_SIZE - TOUCH_EPSILON &&
           sq_y > TILE_SPACER + TOUCH_EPSILON && sq_y < TILE_SIZE - TOUCH_EPSILON)
        {
            retVal = self.tiles[x][y];
        }
    }
    
    return retVal;
}

- (IBAction) dragGesture:(UIPanGestureRecognizer*) sender
{
    CGPoint p = [sender locationInView:self];
    TileView* tile = [self convertPointToTile:p];    
    switch(sender.state)
    {
        case UIGestureRecognizerStateBegan:
            NSLog(@"------------ start ---------------");
            if(!tile.isTouched)
            {
                [tile setTouched:YES];
            }

            break;
        case UIGestureRecognizerStateChanged:
            if(!tile.isTouched)
            {
                [tile setTouched:YES];
            }

            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"------------ stop! ---------------");
            //entered a word
            [self foldOnTiles:^(TileView *tile) {
                [tile setTouched: NO];
            }];
            break;
        default:
            break;
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        CGPoint p = [touch locationInView:self];
        TileView* tile = [self convertPointToTile:p];
        if(!tile.isTouched)
        {
            [tile setTouched:YES];
        }
    }

}

- (void) foldOnTiles:(void (^)(TileView* tile)) function
{

    for(int i = 0; i < X_TILE_COUNT; i++)
    {
        for(int j = 0; j < Y_TILE_COUNT; j++)
        {
            TileView* tv = self.tiles[i][j];
            function(tv);
        }
    }
}


@end
