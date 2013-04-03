//
//  MBUser.m
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUser.h"

@interface MBUser()

@property (nonatomic, strong, readwrite) NSDate* accessTokenExpiration;
@property (nonatomic, strong, readwrite) NSDate* refreshTokenExpiration;

@end

@implementation MBUser

- (MBUser*)initWithRefreshToken:(NSString*)refreshToken expiration:(NSDate*)expiration;
{
    self = [super init];

    self.refreshToken = refreshToken;
    self.refreshTokenExpiration = expiration;

    self.accessToken = nil;
    self.accessTokenExpiration = [NSDate date];

    return self;
}

- (void)setExpiresIn:(NSInteger)expiresIn
{
    _expiresIn = expiresIn;
    self.accessTokenExpiration = [[NSDate date] dateByAddingTimeInterval:expiresIn];
}

- (void)resetRefreshTokenExpiration
{
    // 14 days each time the refresh token is, well... refreshed
    self.refreshTokenExpiration = [[NSDate date] dateByAddingTimeInterval:1209600];
}

@end
