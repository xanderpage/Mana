//
//  UITableViewController+NextButtonSegue.m
//  Mana
//
//  Created by Scott Shebby on 5/20/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "UITableViewController+NextButtonSegue.h"

@implementation UITableViewController (NextButtonSegue)
- (void) addNextButton{
    [self removeNextButton];
    
    UIView * parent = self.navigationController.view;
    
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat buttonHeight = 50.;
    CGFloat buttony      = parent.frame.size.height-tabBarHeight-buttonHeight;
    UIButton * nextButton = (UIButton*)[parent viewWithTag:10000];

    nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, buttony, self.view.frame.size.width, buttonHeight)];
    nextButton.tag = 10000;
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    nextButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.2 blue:0.8 alpha:0.7];
    nextButton.titleLabel.font = [UIFont fontWithName:@"Avenir Light" size:23.];
    
    [nextButton addTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom = buttonHeight;
    self.tableView.contentInset = insets;
    
    [parent addSubview:nextButton];
    [parent bringSubviewToFront:nextButton];

}

- (void) nextButtonTapped:(id)sender{
    [self performSegueWithIdentifier:@"next" sender:self];
}

- (void) removeNextButton{
    UIView * parent = self.navigationController.view;
    UIButton * button = (UIButton*)[parent viewWithTag:10000];
    if( button ){
         [button removeTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [button removeFromSuperview];
    }
}
@end
