//
//  FirebaseSnapshot.m
//  Mana
//
//  Created by Scott Shebby on 6/17/14.
//  Copyright (c) 2014 Scott Shebby. All rights reserved.
//

#import "FirebaseSnapshot.h"

@implementation FirebaseSnapshot
+ (NSString*) stringField:(NSString*)fieldName childField:(NSString*)child fromSnapshot:(FDataSnapshot*)snapshot
{
    return [self stringField:fieldName childField:child withDefault:@"" fromSnapshot:snapshot];
}
+ (NSString*) stringField:(NSString*)fieldName childField:(NSString*)child withDefault:(NSString*)def fromSnapshot:(FDataSnapshot*)snapshot
{
    if( !snapshot   ) return def;
    
    NSDictionary * val = snapshot.value;
    if( !val        ) return def;
    
    NSDictionary * dic = val[child];
    if( !dic        ) return def;
    
    NSString * field = dic[fieldName];
    if( !field      ) return def;
    
    return field;
}
+ (NSString*) stringField:(NSString*)fieldName fromSnapshot:(FDataSnapshot*)snapshot
{
    return [self stringField:fieldName withDefault:@"" fromSnapshot:snapshot];
}
+ (NSString*) stringField:(NSString*)fieldName withDefault:(NSString*)def fromSnapshot:(FDataSnapshot*)snapshot
{
    if( !snapshot   ) return def;
    
    if( [[NSNull null] isEqual:snapshot.value] ) return def;

    NSDictionary * val = snapshot.value;

    if( !val        ) return def;
    
    NSString * field = val[fieldName];
    if( !field      ) return def;
    
    return field;
}
+ (NSNumber*) numberField:(NSString*)fieldName fromSnapshot:(FDataSnapshot*)snapshot
{
    if( !snapshot   ) return [NSNumber numberWithInt:0];;
    
    if( [[NSNull null] isEqual:snapshot.value] ) return [NSNumber numberWithInt:0];;
    
    NSDictionary * val = snapshot.value;
    
    if( !val        ) return [NSNumber numberWithInt:0];;
    
    NSNumber * field = val[fieldName];
    if( !field      ) return [NSNumber numberWithInt:0];;
    
    return field;

}
+ (NSNumber*) numberField:(NSString*)fieldName childField:(NSString*)child fromSnapshot:(FDataSnapshot*)snapshot
{
    if( !snapshot   ) return [NSNumber numberWithInt:0];
    
    NSDictionary * val = snapshot.value;
    if( !val        ) return [NSNumber numberWithInt:0];
    
    NSDictionary * dic = val[child];
    if( !dic        ) return [NSNumber numberWithInt:0];
    
    NSNumber * field = dic[fieldName];
    if( !field      ) return [NSNumber numberWithInt:0];
    
    return field;

}




@end
