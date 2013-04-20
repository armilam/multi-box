//
//  MBUser+Collection.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUser.h"

@interface MBUser (Collection)

/// Returns an NSArray of MBUser objects representing all users currently registered in the app.
/// @return An NSArray of MBUser objects
+ (NSArray*)registeredUsers;

/// Adds a registered user to the collection. If the user is already represented in the list
/// (identified by MBUser::userId), then the user is not added. This is normally called after authenticating a user.
/// @param user The user to add
/// @return A BOOL indicating whether the user was added to the collection
+ (BOOL)addRegisteredUser:(MBUser*)user;

@end
