//
//  MBRefreshTokenRequest.m
//  Multi Box
//
//  Created by Aaron Milam on 4/1/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBRefreshTokenRequest.h"
#import "MBAPIKey.h"

@interface MBRefreshTokenRequest()

@property (nonatomic, strong) MBUser* user;

@end

@implementation MBRefreshTokenRequest

- (id)initWithUser:(MBUser *)user
{
    self = [super init];
    self.user = user;
    return self;
}

- (NSDictionary *)requestParameters
{
    return @{ @"refresh_token": self.user.refreshToken,
              @"client_id": [MBAPIKey getClientId],
              @"client_secret": [MBAPIKey getClientSecret],
              @"grant_type": @"refresh_token" };
    
    //TODO: Look into option device_id and device_name
}

@end
