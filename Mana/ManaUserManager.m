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
            [self handleAuthError:error];
        }
    }];
    
    NSLog(@"Opened Syncroundously: %d", opened);
}

- (void)handleAuthError:(NSError *)error
{
    NSString *alertText;
    NSString *alertTitle;
    if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
        // Error requires people using you app to make an action outside your app to recover
        alertTitle = @"Something went wrong";
        alertText = [FBErrorUtility userMessageForError:error];
        [self showMessage:alertText withTitle:alertTitle];
        
    } else {
        // You need to find more information to handle the error within your app
        if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
            //The user refused to log in into your app, either ignore or...
            alertTitle = @"Login cancelled";
            alertText = @"You need to login to access this part of the app";
            [self showMessage:alertText withTitle:alertTitle];
            
        } else {
            // All other errors that can happen need retries
            // Show the user a generic error message
            alertTitle = @"Something went wrong";
            alertText = @"Please retry";
            [self showMessage:alertText withTitle:alertTitle];
        }
    }
}

- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}
@end
