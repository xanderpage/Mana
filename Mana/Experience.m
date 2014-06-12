//
//  Experience.m
//  Mana
//
//  Created by Scott Shebby on 6/6/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "Experience.h"
#import "ManaFirebase.h"
#import "NSDate+ShortCuts.h"

@implementation Experience

+ (Experience*) create{
    NSString * resourceUrl = [NSString stringWithFormat:@"%@/%@",[ManaFirebase sharedInstance].baseURLString, @"experiences"];
    
    __block Experience * exp = [Experience new];
    exp.firebase = [[[Firebase alloc] initWithUrl:resourceUrl] childByAutoId];
    [exp setPublished:NO];
    
    [exp performSelector:@selector(setCreator) withObject:nil afterDelay:0.1];
    return exp;
}

- (void) setCreator
{
    Firebase * creator = [self.firebase childByAppendingPath:@"created_by"];
    NSString * fbid = [ManaUserManager sharedInstance].facebookUser[@"id"];
    [creator setValue:@{@"fbid": fbid}];
}
- (void) setPublished:(BOOL) published{
    [self.firebase updateChildValues:@{@"published": [NSNumber numberWithBool:published]}];
}
- (void) addImage:(UIImage*)image
{
    Firebase * images = [self.firebase childByAppendingPath:@"images"];
    Firebase * child = [images childByAutoId];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [child setValue:@{@"image":[imageData base64Encoding],@"width":[NSNumber numberWithInt:image.size.width], @"height":[NSNumber numberWithInt:image.size.height]}];
}
- (NSString*)title
{
    if( !self.snapshot ) return @"";
    if( !self.snapshot.value[@"title"] ) return @"";
    return self.snapshot.value[@"title"];
}
- (void) setTitle:(NSString*)title
{
    [self.firebase updateChildValues:@{@"title":title}];
}
- (void) setAddress:(NSString*)address
{
    [self.firebase updateChildValues:@{@"address":address}];
}
- (void) setCategory:(NSString*)cat
{
    [self.firebase updateChildValues:@{@"category":cat}];
}
- (void) setLocation:(CLLocationCoordinate2D)coordinates withName:(NSString*)name
{
    Firebase * location = [self.firebase childByAppendingPath:@"location"];
    [location updateChildValues:@{@"name":name}];
    [location updateChildValues:@{@"latitude":[NSNumber numberWithDouble:coordinates.latitude]}];
    [location updateChildValues:@{@"longitude":[NSNumber numberWithDouble:coordinates.longitude]}];
}
- (void) setLocation:(CLLocationCoordinate2D)coordinates
{
    Firebase * location = [self.firebase childByAppendingPath:@"location"];
    [location updateChildValues:@{@"latitude":[NSNumber numberWithDouble:coordinates.latitude]}];
    [location updateChildValues:@{@"longitude":[NSNumber numberWithDouble:coordinates.longitude]}];
    
}
- (void) setLocationLocality:(NSString*)name withAdministrativeArea:(NSString*)area
{
    Firebase * location = [self.firebase childByAppendingPath:@"location"];
    [location updateChildValues:@{@"locality":name, @"administrativeArea":area}];
}
- (void) setManaValue:(NSInteger)value
{
    [self.firebase updateChildValues:@{@"mana":[NSNumber numberWithInt:value]}];
}
- (void) setDescription:(NSString*)description
{
    [self.firebase updateChildValues:@{@"description":description}];
}
- (void) setAnytime:(BOOL) anytime
{
    Firebase * location = [self.firebase childByAppendingPath:@"when"];
    [location updateChildValues:@{@"anytime":[NSNumber numberWithBool:anytime]}];
}
- (void) setStartDateTime:(NSDate*)date
{
    Firebase * location = [self.firebase childByAppendingPath:@"when"];
    NSString * dateString = [date toISOString];
    [location updateChildValues:@{@"starts":dateString}];
}

- (void) setRSVPEndSeconds:(NSNumber*) secondsBefore
{
    Firebase * location = [self.firebase childByAppendingPath:@"guests"];
    [location updateChildValues:@{@"rsvpSeconds":secondsBefore}];
}
- (void) setDuration:(float) duration
{
    Firebase * location = [self.firebase childByAppendingPath:@"when"];
    [location updateChildValues:@{@"duration":[NSNumber numberWithFloat:duration]}];
}
- (void) setMinimumGuests:(int) guests
{
    Firebase * location = [self.firebase childByAppendingPath:@"guests"];
    [location updateChildValues:@{@"min":[NSNumber numberWithInt:guests]}];
}
- (void) setMaximumGuests:(int) guests
{
    Firebase * location = [self.firebase childByAppendingPath:@"guests"];
    [location updateChildValues:@{@"max":[NSNumber numberWithInt:guests]}];
}
- (void) setCost:(float) cost
{
    Firebase * location = [self.firebase childByAppendingPath:@"mana"];
    [location updateChildValues:@{@"cost":[NSNumber numberWithFloat:cost]}];
}
- (void) setPrepTime:(float)hrs
{
    Firebase * location = [self.firebase childByAppendingPath:@"mana"];
    [location updateChildValues:@{@"prepTime":[NSNumber numberWithFloat:hrs]}];
}
- (void) setTotalManaValue:(float)amount
{
    Firebase * location = [self.firebase childByAppendingPath:@"mana"];
    [location updateChildValues:@{@"total":[NSNumber numberWithFloat:amount]}];
}
@end
