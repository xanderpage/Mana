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
- (id) init
{
    self = [super init];
    if( self ){
        self.data = [NSMutableDictionary new];
        [self setCreator];
    }
    return self;
}
+ (void) createWithDictionary:(NSDictionary *)data{
    NSString * resourceUrl = [NSString stringWithFormat:@"%@/%@",[ManaFirebase sharedInstance].baseURLString, @"experiences"];
    
    __block Experience * exp = [Experience new];

    Firebase * fb = [[[Firebase alloc] initWithUrl:resourceUrl] childByAutoId];
    [fb setValue:data];
}

- (void) setCreator
{
    NSString * fbid = [ManaUserManager sharedInstance].facebookUser.id;
    NSDictionary * created_by = @{@"fbid": fbid};
    self.data[@"created_by"] = created_by;
    self.data[@"created_at"] = [[NSDate date] toISOString];
}

- (void) addImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    self.data[@"image"] = @{@"image":[imageData base64Encoding],@"width":[NSNumber numberWithInt:image.size.width], @"height":[NSNumber numberWithInt:image.size.height]};
}
- (NSString*)title
{
    NSString * title = self.data[@"title"];
    return title ? title : @"";
}
- (void) setTitle:(NSString*)title
{
    self.data[@"title"] = title;
}
- (NSString*) address
{
    NSString * address = self.data[@"address"];
    return address ? address : @"";
}
- (void) setAddress:(NSString*)address
{
    self.data[@"address"] = address;
}
- (void) setCategory:(NSString*)cat
{
    self.data[@"category"] = cat;
}

- (void) setLocation:(CLLocationCoordinate2D)coordinates
{
    NSDictionary * loc = self.data[@"location"];
    if( !loc ){
        loc = [NSDictionary new];
    }
    
    NSMutableDictionary * location = [loc mutableCopy];
    
    location[@"latitude"]  = [NSNumber numberWithDouble:coordinates.latitude];
    location[@"longitude"] = [NSNumber numberWithDouble:coordinates.longitude];
    
    self.data[@"location"] = location;
}
- (void) setLocationLocality:(NSString*)name withAdministrativeArea:(NSString*)area
{
    NSDictionary * loc = self.data[@"location"];
    if( !loc ){
        loc = [NSDictionary new];
    }
    
    NSMutableDictionary * location = [loc mutableCopy];
    
    location[@"locality"] = name;
    location[@"administrativeArea"] = area;
    
    self.data[@"location"] = location;

}
- (void) setCost:(float) cost
{
    NSDictionary * ma = self.data[@"mana"];
    if( !ma ){
        ma = [NSDictionary new];
    }
    
    NSMutableDictionary * mana = [ma mutableCopy];
    mana[@"cost"] = [NSNumber numberWithFloat:cost];
    
    self.data[@"mana"] = mana;
}
- (void) setPrepTime:(float)hrs
{
    NSDictionary * ma = self.data[@"mana"];
    if( !ma ){
        ma = [NSDictionary new];
    }
    
    NSMutableDictionary * mana = [ma mutableCopy];
    mana[@"prepTime"] = [NSNumber numberWithFloat:hrs];
    
    self.data[@"mana"] = mana;
}
- (void) setTotalManaValue:(float)amount
{
    NSDictionary * ma = self.data[@"mana"];
    if( !ma ){
        ma = [NSDictionary new];
    }
    
    NSMutableDictionary * mana = [ma mutableCopy];
    mana[@"total"] = [NSNumber numberWithFloat:amount];
    
    self.data[@"mana"] = mana;
}
- (NSString*) description
{
    NSString * val = self.data[@"description"];
    return val ? val : @"";
}
- (void) setDescription:(NSString*)description
{
    self.data[@"description"] = description;
}
- (void) setAnytime:(BOOL) anytime
{
    NSDictionary * wh = self.data[@"when"];
    if( !wh ){
        wh = [NSDictionary new];
    }
    
    NSMutableDictionary * when = [wh mutableCopy];

    when[@"anytime"] = [NSNumber numberWithBool:anytime];

    self.data[@"when"] = when;
}
- (void) setStartDateTime:(NSDate*)date
{
    if( !date ) return;
    
    NSDictionary * wh = self.data[@"when"];
    if( !wh ){
        wh = [NSDictionary new];
    }
    
    NSMutableDictionary * when = [wh mutableCopy];
    
    when[@"starts"] = [date toISOString];
    
    self.data[@"when"] = when;
}

- (void) setRSVPEndSeconds:(NSNumber*) secondsBefore
{
    NSDictionary * wh = self.data[@"guests"];
    if( !wh ){
        wh = [NSDictionary new];
    }
    
    NSMutableDictionary * when = [wh mutableCopy];
    
    when[@"rsvpSeconds"] = secondsBefore;
    
    self.data[@"guests"] = when;
}
- (void) setDuration:(float) duration
{
    NSDictionary * wh = self.data[@"when"];
    if( !wh ){
        wh = [NSDictionary new];
    }
    
    NSMutableDictionary * when = [wh mutableCopy];
    
    when[@"duration"] = [NSNumber numberWithFloat:duration];
    
    self.data[@"when"] = when;
}
- (void) setMinimumGuests:(int) guests
{
    NSDictionary * wh = self.data[@"guests"];
    if( !wh ){
        wh = [NSDictionary new];
    }
    
    NSMutableDictionary * when = [wh mutableCopy];
    
    when[@"min"] = [NSNumber numberWithInt:guests];
    
    self.data[@"guests"] = when;
}
- (void) setMaximumGuests:(int) guests
{
    
    NSDictionary * wh = self.data[@"guests"];
    if( !wh ){
        wh = [NSDictionary new];
    }
    
    NSMutableDictionary * when = [wh mutableCopy];
    
    when[@"max"] = [NSNumber numberWithInt:guests];
    
    self.data[@"guests"] = when;
}

@end
