//
//  ImagePagerViewController.m
//  testballs
//
//  Created by Scott Shebby on 5/30/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ImagePagerViewController.h"

@interface ImagePagerViewController ()
@property(nonatomic) NSArray * vcs;
@end

@implementation ImagePagerViewController

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
    
    self.vcs = @[ @"girl-alt1.png", @"girl-alt2.png", @"girl-alt3.png" ];
    self.dataSource = self;
    self.delegate = self;
    NSArray *viewControllers = @[[self viewControllerAtIndex:0]];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
}
- (UIViewController*) viewControllerAtIndex:(NSInteger)index{
    
    CGRect frame = self.view.frame;
    NSString * imageName = self.vcs[index];
    
    UIViewController * imageViewController = [[UIViewController alloc] init];
    UIImageView      * iv                   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.frame = frame;
    imageViewController.view.tag = index;
    imageViewController.view.frame = frame;
    [imageViewController.view addSubview:iv];
    return imageViewController;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    NSUInteger index = viewController.view.tag;

    if( index == NSNotFound ) return nil;
    if( index+1 >= self.vcs.count ) return nil;
    return [self viewControllerAtIndex:index+1];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = viewController.view.tag;
    
    if( index == NSNotFound ) return nil;
    if( index-1 >= self.vcs.count ) return nil;
    return [self viewControllerAtIndex:index-1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.vcs count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
