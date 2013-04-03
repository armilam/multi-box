//
//  MBAccessTokenRequest.m
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBAccessTokenRequest.h"
#import "MBAPIKey.h"

@implementation MBAccessTokenRequest

- (NSString *)grantType
{
    return @"authorization_code";
}

- (NSString *)clientId
{
    return [MBAPIKey getClientId];
}

- (NSString *)clientSecret
{
    return [MBAPIKey getClientSecret];
}

- (NSDictionary *)requestParameters
{
    return @{ @"code": self.code,
              @"grant_type": self.grantType,
              @"client_id": self.clientId,
              @"client_secret": self.clientSecret };
}

@end
