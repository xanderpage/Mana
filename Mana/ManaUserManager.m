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

- (NSArray*) facebookReadPermissions{
    return @[@"public_profile", @"email", @"user_friends", @"user_birthday", @"user_location", @"user_interests", @"user_photos"];
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
    BOOL opened = [FBSession openActiveSessionWithPermissions:[self facebookReadPermissions] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        if(FB_ISSESSIONOPENWITHSTATE(status)) {
            //do something
            [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error){
                    NSLog(@"success on first try");
                } else if ([[error userInfo][FBErrorParsedJSONResponseKey][@"body"][@"error"][@"code"] compare:@190] == NSOrderedSame) {
                    //requestForMe failed due to error validating access token (code 190), so retry login
                    [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                        if (!error){
                            //do something again, or consider recursive call with a max retry count.
                            NSLog(@"success on retry");
                        }
                    }];
                }
            }];
        }
        else{
            [session closeAndClearTokenInformation];
            [[FBSession activeSession] closeAndClearTokenInformation];

        }
    }];
    
    NSLog(@"Opened Syncroundously: %d", opened);
}
@end
