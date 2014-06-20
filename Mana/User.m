//
//  User.m
//  Mana
//
//  Created by Scott Shebby on 6/17/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "User.h"
#import "ManaFirebase.h"

@implementation User
+ (NSDictionary*) defaults{
    NSDictionary * mana = @{@"balance":[NSNumber numberWithDouble:50.0]};
    NSDictionary * ratings = @{
                               @"host":[NSNumber numberWithInt:3+arc4random()%3],
                               @"guest":[NSNumber numberWithInt:3+arc4random()%3]
                               };
    return @{
             @"tagline": @"Live music is what I'm at!",
             @"ratings":ratings,
             @"mana":mana
            };
}
+ (void) createMe
{
    NSString * fbid        = [ManaUserManager sharedInstance].facebookUser.id;
    NSAssert(fbid, @"Must have a facebook id to create a new user");
    
    NSString * resourceUrl = [NSString stringWithFormat:@"%@/%@/%@",[ManaFirebase sharedInstance].baseURLString, @"users", fbid];

    
    Firebase * fb = [[Firebase alloc] initWithUrl:resourceUrl];
    [fb observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if( [[NSNull null] isEqual:snapshot.value] ){
            // load em up defalts style for partner is it time to do yes.
            [fb setValue:[self defaults]];
        }
    }];

}
+ (void) meWithCompletion:(void (^)(FDataSnapshot*))completed
{
    [self userWithId:[ManaUserManager sharedInstance].facebookUser.id withCompletion:completed];
}
+ (void) userWithId:(NSString*)fbid withCompletion:(void (^)(FDataSnapshot*))completed
{
    NSString * resourceUrl = [NSString stringWithFormat:@"%@/%@/%@",[ManaFirebase sharedInstance].baseURLString, @"users", fbid];
    Firebase * fb = [[Firebase alloc] initWithUrl:resourceUrl];
    [fb observeSingleEventOfType:FEventTypeValue withBlock:completed];
}
@end
