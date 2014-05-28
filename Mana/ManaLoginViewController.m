//
//  ManaLoginViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/27/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaLoginViewController.h"
@interface ManaLoginViewController ()
@property(nonatomic,weak) IBOutlet FBLoginView * loginSubview;
@end

@implementation ManaLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [FBLoginView class];
    self.loginSubview.readPermissions = @[@"public_profile", @"email", @"user_friends", @"user_birthday", @"user_location"];
    self.loginSubview.delegate = [ManaUserManager sharedInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
