//
//  FeedViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/23/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "FeedViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface FeedViewController ()
@property(nonatomic) IBOutlet UIScrollView * scrollView;
@end

@implementation FeedViewController

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
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 645+1);
    self.scrollView.contentOffset = CGPointMake(0, 200);
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
