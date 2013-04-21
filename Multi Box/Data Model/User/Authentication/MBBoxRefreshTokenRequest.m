//
//  MBBoxRefreshTokenRequest.m
//  Multi Box
//
//  Created by Aaron Milam on 4/1/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBBoxRefreshTokenRequest.h"
#import "MBAPIKey.h"

@interface MBBoxRefreshTokenRequest()

@property (nonatomic, strong) MBBoxUser* user;

@end

@implementation MBBoxRefreshTokenRequest

- (id)initWithUser:(MBBoxUser *)user
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
