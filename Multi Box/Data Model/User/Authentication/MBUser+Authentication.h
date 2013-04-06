//
//  MBUser+Authentication.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUser.h"

@interface MBUser (Authentication)

/// Gets a user's accessToken and refreshToken.
/// Also populates the MBUser object with details about the user, including name, email address, and avatar image URL.
/// @param params The params returned from the Box API after a user logs in.
/// @param completion A block to be called once the user is authenticated (or authentication failed).
/// The block passes in the new MBUser object and an NSException object which will be nil unless any errors occurred.
+ (void)authenticateNewUser:(NSDictionary*)params completion:(void(^)(MBUser* newUser, NSException* error))completion;

/// Refreshes MBUser::accessToken. The Box API invalidates MBUser::accessToken every hour, so this must
/// be called in order to have continued access. As long as MBUser::refreshToken is still valid,
/// calling this will give the MBUser object a new valid MBUser::accessToken.
- (void)refreshAccessToken;

/// Revokes the MBUser object's MBUser::accessToken and MBUser::refreshToken. Useful on logout.
/// @param completion A block to run upon completion of the request. The block passes in a BOOL which indicates success of the request.
- (void)revokeWithCompletion:(void(^)(BOOL success))completion;

@end
