//
//  MBUser+Collection.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUser.h"

@interface MBUser (Collection)

+ (NSArray*)registeredUsers;
+ (BOOL)addRegisteredUser:(MBUser*)user;

@end
