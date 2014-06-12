//
//  ExperienceSnapshot.h
//  Mana
//
//  Created by Scott Shebby on 6/12/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExperienceSnapshot : NSObject
- (id) initWithSnapshotValue:(NSDictionary*)val;

- (NSString*)title;
- (NSString*)category;
@end
