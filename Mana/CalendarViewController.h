//
//  CalendarViewController.h
//  Mana
//
//  Created by Scott Shebby on 6/9/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSLCalendarView.h"

typedef enum {
    UPDATE_FIELD_START_DATE,
    UPDATE_FIELD_RSVP_END_DATE
} UPDATE_FIELD;


@interface CalendarViewController : UIViewController
@property(nonatomic,assign) UPDATE_FIELD updateField;
@end
