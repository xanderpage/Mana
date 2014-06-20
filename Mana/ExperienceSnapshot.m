//
//  ExperienceSnapshot.m
//  Mana
//
//  Created by Scott Shebby on 6/12/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ExperienceSnapshot.h"
#import "NSDate+ShortCuts.h"

@interface ExperienceSnapshot()
@property(nonatomic) NSDictionary * snapshot;
@end
@implementation ExperienceSnapshot
- (id) initWithSnapshotValue:(NSDictionary*)val
{
    self = [super init];
    if( self ){
        self.snapshot = val;
    }
    return self;
}

- (NSString*)title
{
    return [self fieldByName:@"title"];
}
- (NSString*)category
{
    return [self fieldByName:@"category"];
}
- (NSString*)description
{
    return [self fieldByName:@"description"];
}
- (NSString*)location {
    if( !self.snapshot ) return @"";
    NSDictionary * locationDictionary = self.snapshot[@"location"];
    
    if( !locationDictionary ) return @"";
    
    return [NSString stringWithFormat:@"%@, %@", locationDictionary[@"locality"], locationDictionary[@"administrativeArea"]];
}
- (UIImage*) image
{
    NSDictionary * imageDict = self.snapshot[@"image"];
    if( !imageDict ) return [[UIImage alloc] init];
    NSString * b64 = imageDict[@"image"];
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:b64 options:0];
    UIImage * image = [UIImage imageWithData:decodedData];
    return image;
}
- (NSDate*) startDateTime
{
    NSString * s = [self child:@"when" fieldByName:@"starts"];
    NSDate * date = [NSDate fromISOString:s];
    
    return date;
}
- (BOOL) isAnytime
{
    NSString * s = [self child:@"when" fieldByName:@"anytime"];
    return [s boolValue];
}
- (NSString*) manaCost
{
    if( !self.snapshot ) return @"";
    
    NSDictionary * dic = self.snapshot[@"mana"];
    if( !dic ) return @"";
    
    NSNumber * val = dic[@"total"];
    return [NSString stringWithFormat:@"%d", val.intValue];
}
- (NSString*)creator
{
    return [self child:@"created_by" fieldByName:@"fbid"];
}
- (NSString*) child:(NSString*)child fieldByName:(NSString*)name{
    if( !self.snapshot ) return @"";
    
    NSDictionary * dic = self.snapshot[child];
    if( !dic ) return @"";
    
    return dic[name];
}
- (NSString*) fieldByName:(NSString*)name
{
    if( !self.snapshot ) return @"";
    if( !self.snapshot[name] ) return @"";
    return self.snapshot[name];
}
@end
