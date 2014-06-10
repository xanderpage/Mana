//
//  ManaNavigationViewController.m
//  Mana
//
//  Created by Scott Shebby on 5/26/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaNavigationViewController.h"
#import "REFrostedViewController.h"
#import "UIViewController+RSVPButton.h"

@implementation ManaNavigationViewController
- (void) awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self setup];
    return self;
}

- (void) setup{
 
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRootView:) name:@"GotoProfile" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRootView:) name:@"GotoHost" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRootView:) name:@"GotoFeed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRootView:) name:@"GotoManageExperiences" object:nil];
}


-(void) setRootView:(NSNotification*)note
{
    [self removeButton];
    NSLog(@"Note: %@", note.object);
    UIViewController * root = [self.storyboard instantiateViewControllerWithIdentifier:note.object];
    self.viewControllers = @[root];
    [self.frostedViewController hideMenuViewController];
    
   

}


@end
