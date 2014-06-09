//
//  ExperienceCategoryTableViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/20/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ExperienceCategoryTableViewController.h"
#import "UITableViewController+NextButtonSegue.h"
#import "REFrostedViewController.h"

@interface ExperienceCategoryTableViewController ()
@property(nonatomic) NSArray * categories;
@end

@implementation ExperienceCategoryTableViewController

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
    
    self.categories = @[
                        @"Outdoors",
                        @"Music",
                        @"Home",
                        @"Food",
                        @"Service",
                        @"Spirituality",
                        @"Entertainment",
                        @"Sight Seeing"
                        ];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    
}
- (IBAction)leftBarButtonItemPressed:(id)sender{
    [self.frostedViewController presentMenuViewController];
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self addNextButton];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self removeNextButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count-1; //first cell is the descrioption
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cat = [self.categories objectAtIndex:indexPath.row];
    
    [[ManaExperienceCreator sharedInstance] beginCreatingExperience];
    [[ManaExperienceCreator sharedInstance].experience setCategory:cat];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * ident = indexPath.row == 0 ? @"DescriptionCell" : @"CategoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];

    
    if( indexPath.row > 0 ){
        UILabel * label = [cell viewWithTag:100];
        label.text = [self.categories objectAtIndex:indexPath.row];            
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( indexPath.row == 0 ){
        return 90.;
    }
    return 44.;
}



@end
