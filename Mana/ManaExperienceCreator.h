//
//  ManaExperienceCreator.h
//  Mana
//
//  Created by Scott Shebby on 6/7/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManaExperienceCreator : NSObject
+ (ManaExperienceCreator*)sharedInstance;
- (void) beginCreatingExperience;
- (void) endCreatingExperience:(BOOL)commit;

@property(nonatomic) Experience * experience;
@end
