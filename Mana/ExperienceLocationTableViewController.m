//
//  ExperienceLocationTableViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/20/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ExperienceLocationTableViewController.h"
#import <MapKit/MapKit.h>

@interface ExperienceLocationTableViewController ()
@property(nonatomic) CLLocationManager * locationManager;
@end

@implementation ExperienceLocationTableViewController

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
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];

    [self addNextButtonWithDelegate:self];
}

- (void) nextButtonTapped:(id)sender{
    [self performSegueWithIdentifier:@"next" sender:self];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addNextButtonWithDelegate:self];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeNextButton];
}
- (void) setMapLocation:(CLLocation*)location{
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    UITableViewCell * mapCell = [self.tableView cellForRowAtIndexPath:indexPath];
    MKMapView * map = [mapCell viewWithTag:100];
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.5, 0.5));
    [map setRegion:region animated:YES];
    [[ManaExperienceCreator sharedInstance].experience setLocation:location.coordinate];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation * location = [locations firstObject];
    [self setMapLocation:location];
    [self.locationManager stopUpdatingLocation];
}
- (IBAction)doneEnteringLocation:(id)sender{

    UITextField * field = (UITextField*)sender;
    CLGeocoder * geo = [[CLGeocoder alloc] init];
    [geo geocodeAddressString:field.text completionHandler:^(NSArray *placemarks, NSError *error) {
       
        CLPlacemark * first = [placemarks firstObject];
        [self setMapLocation:first.location];
        
        [[ManaExperienceCreator sharedInstance].experience setLocationLocality:first.locality withAdministrativeArea:first.administrativeArea];
        
    }];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
