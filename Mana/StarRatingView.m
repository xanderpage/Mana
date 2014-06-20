//
//  StarRatingView.m
//  Mana
//
//  Created by Scott Shebby on 6/17/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "StarRatingView.h"

@implementation StarRatingView

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

- (void) setup
{
    UIView * v = [[[NSBundle mainBundle] loadNibNamed:@"StarRatingView" owner:self options:nil] objectAtIndex:0];
    v.frame = self.bounds;
    [self addSubview:v];
    [self bringSubviewToFront:v];
}

- (void) setStarRating:(NSNumber*)rating
{
    int r = [rating intValue];
    for( int i=0; i< 5; i++ ){
    
        UIImageView * star = (UIImageView*)[[self.subviews firstObject] viewWithTag:(i+1)*100];
        star.image = (i < r ? [UIImage imageNamed:@"star"] : [UIImage imageNamed:@"star-g"]);
    }
}
@end
