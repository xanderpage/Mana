//
//  ManageExperiencesTableViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/30/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManageExperiencesTableViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface ManageExperiencesTableViewController ()

@end

@implementation ManageExperiencesTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)leftBarButtonItemPressed:(id)sender{
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

@end
