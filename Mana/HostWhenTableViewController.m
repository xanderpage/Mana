//
//  HostWhenTableViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/20/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "HostWhenTableViewController.h"
#import "UITableViewController+NextButtonSegue.h"
#import "CalendarViewController.h"
#import "TimePickerViewController.h"
#import "NSDate+ShortCuts.h"

@interface HostWhenTableViewController ()
@property(nonatomic) NSArray * cellIdentifierOrder;
@end


@implementation HostWhenTableViewController

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
    
    self.cellIdentifierOrder = @[@"CELL_DESCRIPTION",@"CELL_ANYTIME", @"CELL_DURATION", @"CELL_DATE"];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellIdentifierOrder.count;
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addNextButtonWithDelegate:self];
}



- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeNextButton];
}

- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void) nextButtonTapped:(id)sender{
    
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    UIDatePicker * picker = (UIDatePicker*)[cell viewWithTag:200];

    [[ManaExperienceCreator sharedInstance].experience setStartDateTime:picker.date];
    
    [self performSegueWithIdentifier:@"next" sender:self];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * ident = [self.cellIdentifierOrder objectAtIndex:indexPath.row];
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    
    if (indexPath.row == 3 ) {
        NSDictionary * ob = [ManaExperienceCreator sharedInstance].experience.data;
        NSDictionary * when = ob[@"when"];
        NSString * sd = when[@"starts"];
        UIDatePicker * picker = (UIDatePicker*)[cell viewWithTag:200];
        picker.minimumDate = [NSDate date];
        picker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:60*24*60*60];
        
        NSLog(@"Start Date: %@", sd);
        if( sd ){
            picker.date = [NSDate fromISOString:sd];
        }
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)anytimeSwitchAction:(UISwitch*)sender
{
    BOOL anytime = sender.on;
    [[ManaExperienceCreator sharedInstance].experience setAnytime:anytime];
    
    if( anytime ){
        self.cellIdentifierOrder = @[@"CELL_DESCRIPTION",@"CELL_ANYTIME"];
        [self.tableView deleteRowsAtIndexPaths:@[
                                                 [NSIndexPath indexPathForRow:2 inSection:0],
                                                 [NSIndexPath indexPathForRow:3 inSection:0]
        ]
                              withRowAnimation:UITableViewRowAnimationFade];

    }
    else{
        self.cellIdentifierOrder = @[@"CELL_DESCRIPTION",@"CELL_ANYTIME", @"CELL_DATE",@"CELL_DURATION",@"CELL_RSVP_END"];
        [self.tableView insertRowsAtIndexPaths:@[
                                                 [NSIndexPath indexPathForRow:2 inSection:0],
                                                 [NSIndexPath indexPathForRow:3 inSection:0]
         ]
                              withRowAnimation:UITableViewRowAnimationFade];

    }
}

- (IBAction)durationStepperAction:(UIStepper*)sender
{
    int count = (int)sender.value;
    UITableViewCell * durationCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITextField * label = [durationCell viewWithTag:100];
    label.text = [NSString stringWithFormat:@"%d hrs",count];
    
    [[ManaExperienceCreator sharedInstance].experience setDuration:count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if( indexPath.row == 0 ){
        return 100.;
    }
    if( indexPath.row == 3 ){
        return 200.;
    }
    return 50.;
}



@end
