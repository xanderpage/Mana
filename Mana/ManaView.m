//
//  ManaView.m
//  Mana
//
//  Created by Scott Shebby on 6/20/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaView.h"
@implementation ManaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}
- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if( self )
    {
        [self setup];
    }
    return self;
}

- (void) setManaValue:(NSNumber *)manaValue
{
    UILabel * label = (UILabel*)[self viewWithTag:100];
    NSInteger intvalue = [manaValue integerValue];
    label.text = [NSString stringWithFormat:@"%ld", intvalue];
}
- (void) setup
{
    if( self.subviews.count == 0 ){
        UIView * v = [[[NSBundle mainBundle] loadNibNamed:@"ManaView" owner:self options:nil] objectAtIndex:0];
        v.frame = self.bounds;
        [self addSubview:v];
        [self bringSubviewToFront:v];
    }
    
}


@end
