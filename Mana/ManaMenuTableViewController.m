//
//  ManaMenuTableViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/28/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaMenuTableViewController.h"

@interface ManaMenuTableViewController ()
@property(nonatomic,weak) IBOutlet FBLoginView * loginView;
@end

@implementation ManaMenuTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];

    self.loginView.delegate = [ManaUserManager sharedInstance];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoProfileButtonTapped:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GotoProfile" object:nil];
}

- (IBAction)logoutButtonTapped:(id)sender{
    [[ManaUserManager sharedInstance] logout];
}
@end