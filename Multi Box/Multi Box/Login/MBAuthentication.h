//
//  MBAuthentication.h
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBUser.h"

@interface MBAuthentication : NSObject

+ (void)processOAuthInfo:(NSDictionary*)params completion:(void(^)(MBUser* newUser, NSException* error))completion;
+ (void)refreshAccessTokenForUser:(MBUser*)user;
+ (void)revokeUser:(MBUser*)user completion:(void(^)(BOOL success))completion;

@end
