//
//  MBUser+Collection.m
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUser+Collection.h"

static NSMutableArray* _registeredUsers;

@implementation MBUser (Collection)

+ (NSMutableArray*)mutableRegisteredUsers
{
    if(!_registeredUsers) _registeredUsers = [NSMutableArray array];
    return _registeredUsers;
}

+ (NSArray *)registeredUsers
{
    return [NSArray arrayWithArray:[MBUser mutableRegisteredUsers]];
}

+ (BOOL)addRegisteredUser:(MBUser*)user
{
    NSMutableArray* users = [MBUser mutableRegisteredUsers];
    
    //TODO: If user is already in the list, return NO
    
    //TODO: Add new user to persistent storage
    
    [users addObject:user];
    return YES;
}

+ (BOOL)removeRegisteredUser:(MBUser*)user
{
    NSMutableArray* users = [MBUser mutableRegisteredUsers];
    
    //TODO: If user is not in the list, return NO
    
    //TODO: Revoke the user using [user revokeWithCompletion:] when it is implemented
    
    [users removeObject:user];
    return YES;
}

@end
