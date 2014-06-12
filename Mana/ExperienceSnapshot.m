//
//  ExperienceSnapshot.m
//  Mana
//
//  Created by Scott Shebby on 6/12/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ExperienceSnapshot.h"
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

- (NSString*) fieldByName:(NSString*)name
{
    if( !self.snapshot ) return @"";
    if( !self.snapshot[name] ) return @"";
    return self.snapshot[name];
}
@end
