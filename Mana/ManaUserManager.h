//
//  ManaUserManager.h
//  Mana
//
//  Created by Scott Shebby on 5/27/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManaUserManager : NSObject <FBLoginViewDelegate>
+ (ManaUserManager*) sharedInstance;
@property(nonatomic) id<FBGraphUser> facebookUser;


- (void) logout;
- (NSArray*) facebookReadPermissions;
@end
