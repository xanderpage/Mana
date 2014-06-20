//
//  FeedCollectionViewController.m
//  Mana
//
//  Created by Scott Shebby on 6/12/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "FeedCollectionViewController.h"
#import "UIViewController+RSVPButton.h"

@interface FeedCollectionViewController ()
@property(nonatomic,strong) ExperienceList * dataSource;
@end

@implementation FeedCollectionViewController

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
    self.dataSource = [[ExperienceList alloc] initWithDelegate:self];
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.contentInset = UIEdgeInsetsZero;
    
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self addButton];
}
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self removeButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) experienceListDidFinishLoading:(ExperienceList*)e{
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}


@end
