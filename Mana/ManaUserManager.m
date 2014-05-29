//
//  ManaUserManager.m
//  Mana
//
//  Created by Scott Shebby on 5/27/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaUserManager.h"

@implementation ManaUserManager
+ (ManaUserManager*) sharedInstance{
    static ManaUserManager * manaUserManagerSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manaUserManagerSingleton = [ManaUserManager new];
    });
    
    return manaUserManagerSingleton;
}

#pragma mark Facebook Login Delegate
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    self.facebookUser = user;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GotoProfile" object:nil];
}
- (void) loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    // already logged in
    [FBRequestConnection startWithGraphPath:@"me"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  NSLog(@"user events: %@", result);
                                  self.facebookUser = result;
                                  NSLog(@"%@",self.facebookUser.birthday);
                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"LoggedIn" object:nil];
                              } else {
                                  NSLog([error localizedDescription]);
                              }
                          }];
    
   }
- (void) loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    // logged out
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoggedOut" object:nil];

}
- (void) loginView:	(FBLoginView *)loginView handleError:(NSError *)error{
    // error happen
    NSLog(@"%@", error);
}
@end
