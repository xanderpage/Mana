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
#import "NSDate+ShortCuts.h"

@interface HostWhenTableViewController ()
@property(nonatomic,weak) IBOutlet UILabel * durationLabel;
@property (nonatomic,weak) IBOutlet DSLCalendarView *calendarView;
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
    
    self.cellIdentifierOrder = @[@"CELL_DESCRIPTION",@"CELL_ANYTIME", @"CELL_DATE", @"CELL_TIME",@"CELL_DURATION",@"CELL_RSVP_END"];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    
    Firebase * fb = [ManaExperienceCreator sharedInstance].experience.firebase;
    [fb observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [ManaExperienceCreator sharedInstance].experience.snapshot = snapshot;
        [self.tableView reloadData];
    }];
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

- (void) nextButtonTapped:(id)sender{
    [self performSegueWithIdentifier:@"next" sender:self];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeNextButton];
}

- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if( indexPath.row == 2 ){
        CalendarViewController * cal = [self.storyboard instantiateViewControllerWithIdentifier:@"Calendar"];
        
        [self presentViewController:cal animated:YES completion:nil];
    }
    
    return NO;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * ident = [self.cellIdentifierOrder objectAtIndex:indexPath.row];
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    
    if (indexPath.row == 2 ) {
        NSDictionary * ob = [ManaExperienceCreator sharedInstance].experience.snapshot.value;
        NSDictionary * when = ob[@"when"];
        NSString * sd = when[@"startDate"];
        NSLog(@"%@", sd);
        cell.textLabel.text = sd;
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
}

- (IBAction)durationStepperAction:(UIStepper*)sender
{
    int count = (int)sender.value;
    self.durationLabel.text = [NSString stringWithFormat:@"%d hrs",count];
    
    [[ManaExperienceCreator sharedInstance].experience setDuration:count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if( indexPath.row == 0 ){
        return 100.;
    }
    return 50.;
}



@end
