//
//  NSDate+ShortCuts.m
//  Joyflips
//
//  Created by Scott Shebby on 4/21/14.
//  Copyright (c) 2014 scott. All rights reserved.
//

#import "NSDate+ShortCuts.h"

@implementation NSDate (ShortCuts)

+ (NSString*) dateTimeStringFromDatabaseString:(NSString*)s{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SZ"];
    NSDate * d = [dateFormatter dateFromString:[s stringByReplacingOccurrencesOfString:@"T" withString:@" "] ];
    
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    [inFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
//    [inFormat setDateFormat:@"MMM dd, HH:mm a"];
    [inFormat setDateFormat:@"MMM dd"];
    return [inFormat stringFromDate: d];
}
+ (NSDate*) dateFromDatabaseString:(NSString*)s{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SZ"];
    NSDate * d = [dateFormatter dateFromString:[s stringByReplacingOccurrencesOfString:@"T" withString:@" "] ];

    return d;
}
+ (NSInteger) ageFromFacebookBirthday:(NSString*)birthday{
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    [inFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [inFormat setDateFormat:@"MM/dd/yyyy"];
    NSDate * date = [inFormat dateFromString:birthday];
    
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:date
                                       toDate:[NSDate date]
                                       options:0];
    NSInteger age = [ageComponents year];
    return age;
}
- (NSString*) shortString {
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    [inFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    //    [inFormat setDateFormat:@"MMM dd, HH:mm a"];
    [inFormat setDateFormat:@"MMM dd"];
    return [inFormat stringFromDate: self];

}

- (NSString*) toDateString {
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    [inFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    //    [inFormat setDateFormat:@"MMM dd, HH:mm a"];
    [inFormat setDateFormat:@"MMM dd yyyy"];
    return [inFormat stringFromDate: self];
    
}
- (NSDate*) fromDateString:(NSString*)string {
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    [inFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    //    [inFormat setDateFormat:@"MMM dd, HH:mm a"];
    [inFormat setDateFormat:@"MMM dd yyyy"];
    return [inFormat dateFromString:string];
}
- (NSString*) dayPart{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * comps = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit) fromDate:self];
    return [NSString stringWithFormat:@"%ld", (long)comps.day];
}
- (NSString*) monthPart{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    
    NSDateComponents * comps = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit) fromDate:self];
    
    return [[inFormat monthSymbols] objectAtIndex:comps.month-1];
}
@end
