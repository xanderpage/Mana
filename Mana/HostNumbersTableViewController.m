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
@property(nonatomic,weak) IBOutlet UIPickerView * rsvpPicker;
@property(nonatomic,strong) NSArray * rsvpTimes;
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
    self.rsvpTimes = @[
                       @{@"name":@"At time of event",@"secs":[NSNumber numberWithLong:0]},
                       @{@"name":@"30m before",      @"secs":[NSNumber numberWithLong:30*60]},
                       @{@"name":@"1hr before",      @"secs":[NSNumber numberWithLong:60*60]},
                       @{@"name":@"2hr before",      @"secs":[NSNumber numberWithLong:2*60*60]},
                       @{@"name":@"1 day before",    @"secs":[NSNumber numberWithLong:24*60*60]},
                       @{@"name":@"2 days before",   @"secs":[NSNumber numberWithLong:2*24*60*60]},
                       @{@"name":@"1 week before",   @"secs":[NSNumber numberWithLong:7*24*60*60]}
                       ];

    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    /*
     if( indexPath.row == 4 ){
     UIPickerView * picker = (UIPickerView*)[cell viewWithTag:100];
     picker.dataSource = self;
     picker.delegate = self;
     UILabel * title = (UILabel*)[cell viewWithTag:200];
     title.backgroundColor = [UIColor whiteColor];
     title.alpha = 1.0;
     title.opaque = YES;
     title.clipsToBounds = YES;
     [cell bringSubviewToFront:title];
     }
*/
    
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
    
    int selection = (int)[self.rsvpPicker selectedRowInComponent:0];
    NSDictionary * entry = [self.rsvpTimes objectAtIndex:selection];
    NSNumber * secs = entry[@"secs"];
    
    [[ManaExperienceCreator sharedInstance].experience setRSVPEndSeconds:secs];
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




- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.rsvpTimes.count;
}
- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSDictionary * entry = [self.rsvpTimes objectAtIndex:row];
    return entry[@"name"];
}

@end
