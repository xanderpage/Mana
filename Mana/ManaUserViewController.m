//
//  ManaUserViewController.m
//  Mana
//
//  Created by Scott Shebby on 6/6/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaUserViewController.h"


#import "ManaProfileViewController.h"
#import "NSDate+ShortCuts.h"
#import "REFrostedViewController.h"


@interface ManaUserViewController ()
@property(nonatomic,weak) IBOutlet KIImagePager * profileImageView;
@property(nonatomic,weak) IBOutlet UIImageView * coverImageView;
@property(nonatomic,weak) IBOutlet UILabel      * nameLabel;
@property(nonatomic,weak) IBOutlet UILabel      * locationLabel;
@property(nonatomic) NSMutableArray * profilePhotoUrls;
@property(nonatomic) NSMutableArray * displayTypes;
@end

@implementation ManaUserViewController

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
    
//    self.profilePhotoUrls = [NSMutableArray new];
//    self.facebookPhotos   = [NSMutableArray new];
//    self.locationLabel.text = [ManaUserManager sharedInstance].facebookUser.location.name;
//    
//    NSInteger age = [NSDate ageFromFacebookBirthday:[ManaUserManager sharedInstance].facebookUser.birthday];
//    self.nameLabel.text = [NSString stringWithFormat:@"%@, %d",[ManaUserManager sharedInstance].facebookUser.first_name, age];
   
}



- (IBAction)leftBarButtonItemPressed:(id)sender
{
    [self.frostedViewController presentMenuViewController];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage*) placeHolderImageForImagePager{
    return [[UIImage alloc] init];
}
- (NSArray*) arrayWithImages{
    
    return @[ [[[NSBundle mainBundle] URLForResource:@"pretty normal looking girl" withExtension:@"jpg"] absoluteString],
              [[[NSBundle mainBundle] URLForResource:@"girl-alt1" withExtension:@"png"] absoluteString],
              [[[NSBundle mainBundle] URLForResource:@"girl-alt2" withExtension:@"png"] absoluteString],
              [[[NSBundle mainBundle] URLForResource:@"girl-alt3" withExtension:@"png"] absoluteString]
              ];
}
- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    switch (image) {
        case 0:
            return UIViewContentModeScaleAspectFill;
            break;
        case 1:
            return UIViewContentModeScaleAspectFit;
            break;
        case 2:
            return UIViewContentModeScaleAspectFill;
            break;
        case 3:
            return UIViewContentModeScaleAspectFit;
            break;
        default:
            break;
    }
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
