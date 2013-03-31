//
//  MBAPIKey.m
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBAPIKey.h"

@implementation MBAPIKey

+ (NSString *)getClientId
{
    return [NSString stringWithFormat:@"%@%@%@%@%@%@",
            [MBAPIKey idPart1],
            [MBAPIKey idPart2],
            [MBAPIKey idPart3],
            [MBAPIKey idPart4],
            [MBAPIKey idPart5],
            [MBAPIKey idPart6]];
}

+ (NSString*)idPart1
{
    return @"h3l9ze";
}

+ (NSString*)idPart2
{
    return @"jm7h6s1qdt";
}

+ (NSString*)idPart3
{
    return @"889as";
}

+ (NSString*)idPart4
{
    return @"7gatzzzf";
}

+ (NSString*)idPart5
{
    return @"isi";
}

+ (NSString*)idPart6
{
    return @"";
}

+ (NSString *)getClientSecret
{
    return [NSString stringWithFormat:@"%@%@%@%@%@%@",
            [MBAPIKey secretPart1],
            [MBAPIKey secretPart2],
            [MBAPIKey secretPart3],
            [MBAPIKey secretPart4],
            [MBAPIKey secretPart5],
            [MBAPIKey secretPart6]];
}

+ (NSString*)secretPart1
{
    return @"yOUqDGv";
}

+ (NSString*)secretPart2
{
    return @"TGQdZZ1";
}

+ (NSString*)secretPart3
{
    return @"85R";
}

+ (NSString*)secretPart4
{
    return @"vhLbgenEB";
}

+ (NSString*)secretPart5
{
    return @"c4F93";
}

+ (NSString*)secretPart6
{
    return @"G";
}

@end
