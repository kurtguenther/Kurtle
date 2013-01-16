//
//  TileView.h
//  Kurtle
//
//  Created by Kurt Guenther on 1/15/13.
//  Copyright (c) 2013 Kurt Guenther. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileView : UIView

@property (retain, nonatomic) NSString* letter;
@property (retain, nonatomic) UILabel *letterLabel;

@property CGPoint location;
@property BOOL isTouched;

- (void) setTouched: (BOOL) touched;


@end
