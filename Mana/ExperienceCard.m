//
//  ExperienceCard.m
//  Mana
//
//  Created by Scott Shebby on 6/12/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ExperienceCard.h"

@interface ExperienceCard ()
@property(nonatomic,weak) IBOutlet UILabel * titleLabel;
@property(nonatomic,weak) ExperienceSnapshot * experience;
@end

@implementation ExperienceCard


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setExperienceSnapshot:(ExperienceSnapshot*)experience
{
    self.experience = experience;
    self.titleLabel.text = experience.category;
    
}

- (void) prepareForReuse{
    
    
    
}
@end
