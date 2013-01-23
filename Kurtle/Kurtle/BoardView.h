//
//  BoardView.h
//  Kurtle
//
//  Created by Kurt Guenther on 1/15/13.
//  Copyright (c) 2013 Kurt Guenther. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TileView;

@interface BoardView : UIView

@property (retain, nonatomic) IBOutlet TileView *tile00;
@property (retain, nonatomic) IBOutlet TileView *tile01;
@property (retain, nonatomic) IBOutlet TileView *tile02;
@property (retain, nonatomic) IBOutlet TileView *tile03;
@property (retain, nonatomic) IBOutlet TileView *tile10;
@property (retain, nonatomic) IBOutlet TileView *tile11;
@property (retain, nonatomic) IBOutlet TileView *tile12;
@property (retain, nonatomic) IBOutlet TileView *tile13;
@property (retain, nonatomic) IBOutlet TileView *tile20;
@property (retain, nonatomic) IBOutlet TileView *tile21;
@property (retain, nonatomic) IBOutlet TileView *tile22;
@property (retain, nonatomic) IBOutlet TileView *tile23;
@property (retain, nonatomic) IBOutlet TileView *tile30;
@property (retain, nonatomic) IBOutlet TileView *tile31;
@property (retain, nonatomic) IBOutlet TileView *tile32;
@property (retain, nonatomic) IBOutlet TileView *tile33;

@property (retain, nonatomic) NSArray* tiles;

@property (retain, nonatomic) NSMutableArray* selectedTiles;
@property (readonly) TileView* lastTile;

- (IBAction) dragGesture:(UIPanGestureRecognizer*) sender;
- (void) foldOnTiles:(void (^)(int x, int y, TileView* tile)) function;

@end
