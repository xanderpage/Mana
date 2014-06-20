//
//  ManaExperienceCreator.m
//  Mana
//
//  Created by Scott Shebby on 6/7/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaExperienceCreator.h"

@implementation ManaExperienceCreator
+ (ManaExperienceCreator*)sharedInstance{
    static ManaExperienceCreator * sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [ManaExperienceCreator new];
    });
    
    return sharedInstance;
}

- (void) beginCreatingExperience
{
    self.experience = [Experience new];
}

- (void) endCreatingExperience:(BOOL)commit
{
    if( commit ){
        [Experience createWithDictionary:self.experience.data];
    }
    else{
        NSLog(@"Cancelled? Why do that.");
    }
}
@end
