//
//  Experience.h
//  Mana
//
//  Created by Scott Shebby on 6/6/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Experience : NSObject

+ (Experience*) create;
- (void) setTitle:(NSString*)title;
- (void) setLocation:(CLLocationCoordinate2D)coordinates withName:(NSString*)string;
- (void) setLocationLocality:(NSString*)name withAdministrativeArea:(NSString*)area;
- (void) setLocation:(CLLocationCoordinate2D)coordinates;
- (void) setAnytime:(BOOL) anytime;
- (void) setManaValue:(NSInteger)value;
- (void) setDescription:(NSString*)description;
- (void) setAddress:(NSString*)address;
- (void) setCreator;
- (void) addImage:(UIImage*)image;
- (void) setCategory:(NSString*)cat;
- (void) setStartTime:(NSString*)startTime;
- (void) setRSVPEndTime:(NSString*)endTime;
- (void) setDuration:(float) duration;
- (void) setMinimumGuests:(int) guests;
- (void) setMaximumGuests:(int) guests;
- (void) setCost:(float) cost;
- (void) setPrepTime:(float)hrs;
- (void) setTotalManaValue:(float)amount;

@property (nonatomic,strong) Firebase * firebase;
@end
