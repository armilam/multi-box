//
//  MBBoxUser+Authentication.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBBoxUser.h"

@interface MBBoxUser (Authentication)

/// Gets a user's accessToken and refreshToken.
/// Also populates the MBBoxUser object with details about the user, including name, email address, and avatar image URL.
/// @param params The params returned from the Box API after a user logs in.
/// @param completion A block to be called once the user is authenticated (or authentication failed).
/// The block passes in the new MBBoxUser object and an NSException object which will be nil unless any errors occurred.
+ (void)authenticateNewUser:(NSDictionary*)params completion:(void(^)(MBBoxUser* newUser, NSException* error))completion;

/// Refreshes MBBoxUser::accessToken. The Box API invalidates MBBoxUser::accessToken every hour, so this must
/// be called in order to have continued access. As long as MBBoxUser::refreshToken is still valid,
/// calling this will give the MBBoxUser object a new valid MBBoxUser::accessToken.
/// @param completion A block to be called once the user is refreshed (or refresh failed).
/// The block passes in the same MBBoxUser object and an NSException object which will be nil unless any errors occurred.
- (void)refreshAccessTokenCompletion:(void(^)(MBBoxUser* user, NSException* error))completion;

/// Revokes the MBBoxUser object's MBBoxUser::accessToken and MBBoxUser::refreshToken. Useful on logout.
/// @param completion A block to run upon completion of the request. The block passes in a BOOL which indicates success of the request.
- (void)revokeWithCompletion:(void(^)(BOOL success))completion;

@end
