//
//  ContentViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/26/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ContentViewController.h"
#import "REFrostedViewController.h"
#import "UIViewController+RSVPButton.h"

@interface ContentViewController ()
@property(nonatomic) NSArray * menuItems;
@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}
- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}
- (void) setup{
    
    
    NSLog(@"Setup Content Layout");
    
    self.viewPager.dataSource = self;
    self.viewPager.delegate   = self;
    
    self.menuItems = @[@"Feed", @"Experiences"];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.viewPager reloadData];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftNavigationButtonPressed:(id)sender
{
    [self.frostedViewController presentMenuViewController];
}
- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager
{
    return self;
}

- (UIImage *)indexIndicatorImageForViewPager:(SHViewPager *)viewPager
{
    return [UIImage imageNamed:@"horizontal_line.png"];
}

- (UIImage *)indexIndicatorImageDuringScrollAnimationForViewPager:(SHViewPager *)viewPager
{
    return [UIImage imageNamed:@"horizontal_line_moving.png"];
}

- (SHViewPagerMenuWidthType)menuWidthTypeInViewPager:(SHViewPager *)viewPager
{
    return SHViewPagerMenuWidthTypeWide;
}

#pragma mark - SHViewPagerDelegate stack

- (void)firstContentPageLoadedForViewPager:(SHViewPager *)viewPager
{
    NSLog(@"first viewcontroller content loaded");
}

- (void)viewPager:(SHViewPager *)viewPager willMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    if( toIndex == 0 ){
        [self addButton];
    }
    else{
        [self removeButton];
    }
    NSLog(@"content will move to page %d from page: %d", toIndex, fromIndex);
}

- (void)viewPager:(SHViewPager *)viewPager didMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"content moved to page %d from page: %d", toIndex, fromIndex);
}


- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager
{
    return self.menuItems.count;
}
- (NSString *)viewPager:(SHViewPager *)viewPager titleForPageMenuAtIndex:(NSInteger)index
{
    return self.menuItems[index];
}

- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index
{
    UIViewController * vc;
    if( index == 0 ){
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Feed"];
    }
    if( index == 1 )
    {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RightMenu"];
    }
    return vc;
}
@end
