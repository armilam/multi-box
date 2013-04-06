//
//  MBUser+GetInfo.h
//  Multi Box
//
//  Created by Aaron Milam on 4/4/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUser.h"

@interface MBUser (GetInfo)

/// Requests the user's detailed information from the Box API.
/// This will fill in the MBUser object's user detail properties.
/// @param returnBlock A block to be called once the user info is retrieved.
/// The block passes in an MBUser object with the user's filled-in details.
- (void)getUserInfoWithCompletion:(void(^)(MBUser* user))returnBlock;

@end
