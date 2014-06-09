//
//  ManaTableViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/22/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaTableViewController.h"
#import "UITableViewController+NextButtonSegue.h"

@interface ManaTableViewController ()
@property(nonatomic) IBOutlet UISlider * slider;
@property(nonatomic) IBOutlet UILabel  * manaCostLabel;
@property(nonatomic) IBOutlet UITextField * costTextField;
@property(nonatomic) IBOutlet UITextField * prepTextField;
@end

@implementation ManaTableViewController

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
- (void) nextButtonTapped:(id)sender{
    float cost = [self.costTextField.text floatValue];
    float prep = [self.prepTextField.text floatValue];
    float total= self.slider.value;
    
    
    [[ManaExperienceCreator sharedInstance].experience setCost:cost];
    [[ManaExperienceCreator sharedInstance].experience setPrepTime:prep];
    [[ManaExperienceCreator sharedInstance].experience setTotalManaValue:total];
    
    [self performSegueWithIdentifier:@"next" sender:self];
}
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeNextButton];
}
- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.costTextField resignFirstResponder];
    [self.prepTextField resignFirstResponder];
    
    return NO;
}

- (IBAction)sliderChanged:(id)sender{
    int value = [[NSNumber numberWithFloat:self.slider.value] intValue];
    
    self.manaCostLabel.text = [NSString stringWithFormat:@"%d", value];
}

- (IBAction)resetToSuggestedButton:(id)sender{
    self.slider.value = 115;
    int value = [[NSNumber numberWithFloat:self.slider.value] intValue];
    self.manaCostLabel.text = [NSString stringWithFormat:@"%d", value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
