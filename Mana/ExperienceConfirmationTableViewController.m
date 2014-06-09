//
//  ExperienceConfirmationTableViewController.m
//  Mana
//
//  Created by Scott Shebby on 6/8/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ExperienceConfirmationTableViewController.h"

@interface ExperienceConfirmationTableViewController ()

@end

@implementation ExperienceConfirmationTableViewController

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
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    self.navigationItem.hidesBackButton = YES;
}
- (IBAction)doneButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
