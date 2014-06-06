//
//  UIViewController+RSVPButton.m
//  Mana
//
//  Created by Scott Shebby on 6/5/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "UIViewController+RSVPButton.h"

@implementation UIViewController (RSVPButton)
- (void) addButton{
    [self removeButton];
    
    UIView * parent = self.navigationController.view;
    
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat buttonHeight = 50.;
    CGFloat buttony      = parent.frame.size.height-tabBarHeight-buttonHeight;
    UIButton * nextButton = (UIButton*)[parent viewWithTag:20000];
    
    nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, buttony, self.view.frame.size.width, buttonHeight)];
    nextButton.tag = 20000;
    [nextButton setTitle:@"Sign me up!" forState:UIControlStateNormal];
    nextButton.backgroundColor = [UIColor colorWithRed:217./255. green:4./255. blue:34./255. alpha:0.7];
    nextButton.titleLabel.font = [UIFont fontWithName:@"Avenir Light" size:23.];
    
    
    [parent addSubview:nextButton];
    [parent bringSubviewToFront:nextButton];
    
}

- (void) removeButton{
    UIView * parent = self.navigationController.view;
    if( !parent ) parent = self.view;
    UIButton * button = (UIButton*)[parent viewWithTag:20000];
    if( button ){
        [button removeFromSuperview];
    }
}
@end
