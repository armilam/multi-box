//
//  MBUser+Authentication.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUser.h"

@interface MBUser (Authentication)

+ (void)authenticateNewUser:(NSDictionary*)params completion:(void(^)(MBUser* newUser, NSException* error))completion;

- (void)refreshAccessToken;
- (void)revokeWithCompletion:(void(^)(BOOL success))completion;

@end
