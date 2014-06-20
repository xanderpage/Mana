//
//  User.h
//  Mana
//
//  Created by Scott Shebby on 6/17/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
+ (void) createMe;
+ (void) meWithCompletion:(void (^)(FDataSnapshot* snapshot))completed;
+ (void) userWithId:(NSString*)fbid withCompletion:(void (^)(FDataSnapshot* snapshot))completed;
@end
