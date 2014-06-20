//
//  FirebaseSnapshot.h
//  Mana
//
//  Created by Scott Shebby on 6/17/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirebaseSnapshot : NSObject
+ (NSString*) stringField:(NSString*)fieldName childField:(NSString*)child fromSnapshot:(FDataSnapshot*)snapshot;
+ (NSString*) stringField:(NSString*)fieldName childField:(NSString*)child withDefault:(NSString*)def fromSnapshot:(FDataSnapshot*)snapshot;
+ (NSString*) stringField:(NSString*)fieldName fromSnapshot:(FDataSnapshot*)snapshot;
+ (NSString*) stringField:(NSString*)fieldName withDefault:(NSString*)def fromSnapshot:(FDataSnapshot*)snapshot;

+ (NSNumber*) numberField:(NSString*)fieldName childField:(NSString*)child fromSnapshot:(FDataSnapshot*)snapshot;
+ (NSNumber*) numberField:(NSString*)fieldName fromSnapshot:(FDataSnapshot*)snapshot;

+ (UIImage*) imageField:(NSString*)fieldName fromSnapshot:(FDataSnapshot*)snapshot;
@end
