//
//  AppDelegate.m
//  Mana
//
//  Created by Scott Shebby on 5/14/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "AppDelegate.h"
#import "Mixpanel.h"
#import "ManaLoginViewController.h"
#import "ContentViewController.h"
#import "ManaNavigationViewController.h"
#import "REFrostedViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBLoginView class];
    
    // Facebook is configured in the Mana-Info.plist
    [ManaUserManager sharedInstance];
    
    //https://mixpanel.com/help/reference/ios
    [Mixpanel sharedInstanceWithToken:@"TOKEN"];
    [[Mixpanel sharedInstance] registerSuperPropertiesOnce:@{@"user":@"guy@mana.com"}];
    [[Mixpanel sharedInstance] track:@"App Launch" properties:nil];
    

    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];

    
   //
//    // Create a reference to a Firebase location
//    Firebase* f = [[Firebase alloc] initWithUrl:@"https://glowing-fire-7751.firebaseio.com/"];
//    
//    // Write data to Firebase
//    [f setValue:@"Do you have data? You'll love Firebase."];
//    
//    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"email-icon"], 1.0);
//    [f setValue:@{@"image":[imageData base64Encoding]}];
//    
//    // Read data and react to changes
//    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
//    }];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loggedIn:) name:@"LoggedIn" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loggedOut:) name:@"LoggedOut" object:nil];        
    });
    

    return YES;
}



- (void) loggedIn:(NSNotification*)note{
    if( [self.window.rootViewController isKindOfClass:[REFrostedViewController class]] ) return;

    
    ManaNavigationViewController * nav = (ManaNavigationViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RootNavigation"];
    
    UIViewController * leftNav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftMenu"];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:nav menuViewController:leftNav];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.panGestureEnabled = NO;
    frostedViewController.liveBlur             = YES;
//    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
//    frostedViewController.blurRadius           = 3;
//    frostedViewController.backgroundFadeAmount = 0.6;

//    Uncomment this to make the calendar view background transparent
//    frostedViewController.modalPresentationStyle = UIModalPresentationCurrentContext;

    [self.window setRootViewController:frostedViewController];
   
}
- (void) loggedOut:(NSNotification*)note{
    if( [self.window.rootViewController isKindOfClass:[ManaLoginViewController class]] ) return;

    UIViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Login"];
    [self.window setRootViewController:vc];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];

    return wasHandled;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
