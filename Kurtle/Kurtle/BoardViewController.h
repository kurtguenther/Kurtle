//
//  BoardViewController.h
//  Kurtle
//
//  Created by Kurt Guenther on 1/15/13.
//  Copyright (c) 2013 Kurt Guenther. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoardView;

@interface BoardViewController : UIViewController <UIGestureRecognizerDelegate>


@property (retain, nonatomic) IBOutlet BoardView *boardView;
@property (retain, nonatomic) IBOutlet UILabel* wordLabel;

@end
