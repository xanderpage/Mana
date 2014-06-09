//
//  ManaFirebase.m
//  Mana
//
//  Created by Scott Shebby on 6/6/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "ManaFirebase.h"

@implementation ManaFirebase
+ (ManaFirebase*) sharedInstance{
    static ManaFirebase * firebase;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        firebase = [ManaFirebase new];
        [firebase setup];
    });
    
    return firebase;
}

- (void) setup{
    self.baseURLString = @"https://glowing-fire-7751.firebaseio.com/";
}
@end

