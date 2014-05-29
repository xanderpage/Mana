//
//  ManaProfileViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/26/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaProfileViewController.h"
#import "NSDate+ShortCuts.h"
#import "UIViewController+MMDrawerController.h"


@interface ManaProfileViewController ()
@property(nonatomic,weak) IBOutlet UIImageView * profileImageView;
@property(nonatomic,weak) IBOutlet UILabel      * nameLabel;
@property(nonatomic,weak) IBOutlet UILabel      * locationLabel;
@end

@implementation ManaProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [FBRequestConnection startWithGraphPath:@"/me?fields=picture.height(961)"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  NSLog(@"user events: %@", result);
                                  NSDictionary * picture = result[@"picture"];
                                  NSDictionary * data    = picture[@"data"];
                                  NSString     * urls    = data[@"url"];
                                  
                                  [self.profileImageView setImageWithURL:[NSURL URLWithString:urls]];
                              } else {
                                  NSLog([error localizedDescription]);
                              }
                          }];

    self.locationLabel.text = [ManaUserManager sharedInstance].facebookUser.location.name;

    NSInteger age = [NSDate ageFromFacebookBirthday:[ManaUserManager sharedInstance].facebookUser.birthday];
    self.nameLabel.text = [NSString stringWithFormat:@"%@, %d",[ManaUserManager sharedInstance].facebookUser.first_name, age];
}
- (IBAction)leftBarButtonItemPressed:(id)sender{
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray*) arrayWithImages{
    return @[ [UIImage imageNamed:@"pretty normal looking girl.jpg"],
              [UIImage imageNamed:@"pretty normal looking girl.jpg"]
              ];
}
- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFill;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
