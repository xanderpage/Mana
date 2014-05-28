//
//  ContentViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/26/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ContentViewController.h"
#import "MMDrawerVisualState.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}
- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}
- (void) setup{
    self.centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RootNavigation"];
    self.leftDrawerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
//    self.rightDrawerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenu"];

    [self setShowsShadow:NO];
    [self setRestorationIdentifier:@"MMDrawer"];
    [self setMaximumRightDrawerWidth:200.0];
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoProfile:) name:@"GotoProfile" object:nil];
}
- (void) gotoProfile:(NSNotification*)note{
    UINavigationController * nav = self.centerViewController;
    
    nav.viewControllers = @[ [self.storyboard instantiateViewControllerWithIdentifier:@"Profile"] ];
    [self closeDrawerAnimated:YES completion:nil];
}

- (void) gotoFeed{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
