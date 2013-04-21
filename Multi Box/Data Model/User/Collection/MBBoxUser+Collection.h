//
//  MBBoxUser+Collection.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBBoxUser.h"

@interface MBBoxUser (Collection)

/// Loads the persisted users into memory and gets access tokens for those with
/// a still-valid refresh token. This should be used only at load time, by the app delegate.
+ (void)loadPersistedUsersLoadCompletion:(void(^)(MBBoxUser* user, BOOL success))completion;

/// Returns an NSArray of MBBoxUser objects representing all users currently registered in the app.
/// @return An NSArray of MBBoxUser objects
+ (NSArray*)registeredUsers;

/// Adds a registered user to the collection. If the user is already represented in the list
/// (identified by MBBoxUser::userId), then the user is not added. This is normally called after authenticating a user.
/// @param user The user to add
/// @return A BOOL indicating whether the user was added to the collection
+ (BOOL)addRegisteredUser:(MBBoxUser*)user;

/// Persists the user's most basic info so that the user can be automatically logged back in
/// when the app is loaded.
+ (void)persistUser:(MBBoxUser*)user;

@end
