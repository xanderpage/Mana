//
//  HostNumbersTableViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/20/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "HostNumbersTableViewController.h"
#import "UITableViewController+NextButtonSegue.h"

@interface HostNumbersTableViewController ()
@property(nonatomic,weak) IBOutlet UITextField * minTextField;
@property(nonatomic,weak) IBOutlet UITextField * maxTextField;
@end

@implementation HostNumbersTableViewController

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
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addNextButtonWithDelegate:self];
}
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeNextButton];
}

- (void) nextButtonTapped:(id)sender{
    int min= [self.minTextField.text intValue];
    int max= [self.maxTextField.text intValue];
    
    [[ManaExperienceCreator sharedInstance].experience setMinimumGuests:min];
    [[ManaExperienceCreator sharedInstance].experience setMaximumGuests:max];
    
    [self performSegueWithIdentifier:@"next" sender:self];
}
- (IBAction)minGuestsAction:(UIStepper*)sender
{
    int count = (int) sender.value;
    self.minTextField.text = [NSString stringWithFormat:@"%d", count];
}
- (IBAction)maxGuestsAction:(UIStepper*)sender
{
    int count = (int) sender.value;
    self.maxTextField.text = [NSString stringWithFormat:@"%d", count];
}
- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.minTextField resignFirstResponder];
    [self.maxTextField resignFirstResponder];
    
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
