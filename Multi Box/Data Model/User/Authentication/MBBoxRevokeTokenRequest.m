//
//  MBBoxRevokeTokenRequest.m
//  Multi Box
//
//  Created by Aaron Milam on 4/1/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBBoxRevokeTokenRequest.h"
#import "MBAPIKey.h"

@interface MBBoxRevokeTokenRequest()

@property (nonatomic, strong) MBBoxUser* user;

@end

@implementation MBBoxRevokeTokenRequest

- (id)initWithUser:(MBBoxUser *)user
{
    self = [super init];
    self.user = user;
    return self;
}

- (NSDictionary *)requestParameters
{
    return @{ @"token": self.user.refreshToken,
              @"client_id": [MBAPIKey getClientId],
              @"client_secret": [MBAPIKey getClientSecret] };
}

@end
