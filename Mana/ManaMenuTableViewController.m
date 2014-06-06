//
//  ManaMenuTableViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/28/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaMenuTableViewController.h"
#import "REFrostedViewController.h"

@interface ManaMenuTableViewController ()
@property(nonatomic) IBOutlet FBLoginView * loginView;
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
//    self.tableView.tableHeaderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Mana-Logo-Vertical"]];
//    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 150);
    self.loginView.delegate = [ManaUserManager sharedInstance];
    
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.opaque = NO;
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoFeedButtonTapped:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GotoFeed" object:@"Content"];
}

- (IBAction)gotoHostButtonTapped:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GotoHost" object:@"Host"];
}

- (IBAction)gotoProfileButtonTapped:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GotoProfile" object:@"Profile"];
}
- (IBAction)gotoManageExperiencesButtonTapped:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GotoManageExperiences" object:@"Manage"];
}

- (IBAction)logoutButtonTapped:(id)sender{
    [[ManaUserManager sharedInstance] logout];
}
@end