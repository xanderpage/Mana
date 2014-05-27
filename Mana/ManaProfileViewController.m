//
//  ManaProfileViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/26/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaProfileViewController.h"

@interface ManaProfileViewController ()
@property(nonatomic,weak) IBOutlet KIImagePager * imagePager;
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
