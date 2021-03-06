//
//  MBBoxRefreshTokenResponse.h
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBBoxRefreshTokenResponse : NSObject

@property (nonatomic, strong) NSString* accessToken;
@property (nonatomic, assign) NSInteger expiresIn;
@property (nonatomic, strong) NSString* tokenType;
@property (nonatomic, strong) NSString* refreshToken;

@end
