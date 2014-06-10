//
//  NSDate+ShortCuts.h
//  Joyflips
//
//  Created by Scott Shebby on 4/21/14.
//  Copyright (c) 2014 scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ShortCuts)
+ (NSString*) dateTimeStringFromDatabaseString:(NSString*)s;
+ (NSDate*) dateFromDatabaseString:(NSString*)s;
- (NSString*) shortString;
- (NSString*) monthPart;
- (NSString*) dayPart;
- (NSDate*) fromDateString:(NSString*)string;
- (NSString*) toDateString;
+ (NSInteger) ageFromFacebookBirthday:(NSString*)birthday;
@end
