//
//  ManaFirebase.h
//  Mana
//
//  Created by Scott Shebby on 6/6/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManaFirebase : NSObject
@property(nonatomic) NSString * baseURLString;

+ (ManaFirebase*) sharedInstance;
@end
