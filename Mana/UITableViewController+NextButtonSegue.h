//
//  UITableViewController+NextButtonSegue.h
//  Mana
//
//  Created by Scott Shebby on 5/20/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewController (NextButtonSegue)
- (void) addNextButtonWithDelegate:(id)delegate;
- (void) addNextButtonWithTitle:(NSString*)title andDelegate:(id)delegate;

- (void) removeNextButton;
@end
