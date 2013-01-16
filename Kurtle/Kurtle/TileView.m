//
//  TileView.m
//  Kurtle
//
//  Created by Kurt Guenther on 1/15/13.
//  Copyright (c) 2013 Kurt Guenther. All rights reserved.
//

#import "TileView.h"

@implementation TileView

@synthesize letter = _letter;
@synthesize letterLabel = _letterLabel;
@synthesize isTouched = _isTouched;

#define BORDER 5

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        
        self.letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(BORDER, BORDER, self.frame.size.width - 2 * BORDER, self.frame.size.height - 2 * BORDER)];
        self.letterLabel.backgroundColor = [UIColor clearColor];
        self.letterLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.letterLabel];
    }
    return self;
}

- (void)setLetter:(NSString *)letter
{
    _letter  = [letter retain];
    self.letterLabel.text = _letter;
}

- (void) setTouched: (BOOL) value
{
    _isTouched = value;
    
    if(value)
    {
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }
    else
    {
        self.transform = CGAffineTransformIdentity;
    }
}


@end
