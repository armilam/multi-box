//
//  MBBoxUser+Collection.m
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBBoxUser+Collection.h"
#import "MBBoxUser+Authentication.h"
#import "MBBoxUser+GetInfo.h"

/// A collection of MBBoxUser objects
static NSMutableArray* _registeredUsers;

static NSString* const user_id_key = @"user_id";
static NSString* const name_key = @"name";
static NSString* const refresh_token_expiration_key = @"refresh_token_exp";
static NSString* const refresh_token_key = @"refresh_token";
static NSString* const avatar_url_key = @"avatar_url";
static NSString* const persisted_users_key = @"persisted_users";

@interface MBBoxUser()

@property (nonatomic, strong, readwrite) NSDate* refreshTokenExpiration;
@property (nonatomic, strong, readwrite) NSDate* accessTokenExpiration;

#pragma mark - Box User Information
@property (nonatomic, strong, readwrite) NSString* userId;
@property (nonatomic, strong, readwrite) NSString* name;
@property (nonatomic, strong, readwrite) NSString* avatarUrlString;

@end

@implementation MBBoxUser (Collection)

+ (void)loadPersistedUsersLoadCompletion:(void(^)(MBBoxUser* user, BOOL success))completion
{
    NSMutableArray* allPersistedUsers = [MBBoxUser persistedUsers];
    NSMutableArray* registeredUsers = [MBBoxUser mutableRegisteredUsers];
    [registeredUsers removeAllObjects];
    
    for(NSDictionary* persistedUser in allPersistedUsers)
    {
        MBBoxUser* regUser = [[MBBoxUser alloc] initWithPersistentDictionary:persistedUser completion:completion];
        [registeredUsers addObject:regUser];
    }
}

- (NSDictionary*)persistentDictionary
{
    return
    @{
        user_id_key: self.userId,
        name_key: self.name,
        refresh_token_expiration_key: [NSNumber numberWithDouble:[self.refreshTokenExpiration timeIntervalSince1970]],
        refresh_token_key: self.refreshToken,
        avatar_url_key: self.avatarUrlString
    };
}

- (MBBoxUser*)initWithPersistentDictionary:(NSDictionary*)dictionary completion:(void(^)(MBBoxUser* user, BOOL success))completion
{
    self = [self init];
    
    self.userId = [dictionary objectForKey:user_id_key];
    self.name = [dictionary objectForKey:name_key];
    self.refreshTokenExpiration = [NSDate dateWithTimeIntervalSince1970:[[dictionary objectForKey:refresh_token_expiration_key] doubleValue]];
    self.refreshToken = [dictionary objectForKey:refresh_token_key];
    self.avatarUrlString = [dictionary objectForKey:avatar_url_key];

    self.accessToken = nil;
    self.accessTokenExpiration = [NSDate date];
    
    if([self.refreshTokenExpiration compare:[NSDate date]] == NSOrderedDescending)
    {
        // Get an access token, since the refresh token is still valid
        [self refreshAccessTokenCompletion:^(MBBoxUser* user, NSException* error)
        {
            if(error)
            {
                if(completion) completion(user, NO);
            }
            else
            {
                [user getUserInfoWithCompletion:^(MBBoxUser* user)
                {
                    if(completion) completion(user, YES);
                }];
            }
        }];
    }
    else
    {
        //TODO: Indicate not-logged-in-ness
        NSLog(@"User %@ (%@) needs logged in again", self.userId, self.name);
    }
    
    return self;
}

//TODO: Persist user using this method every time the user's refreshToken or refreshTokenExpiration changes.
//TODO: It may be better to, instead of persisting one user, to persist all users at the same time.
//      This way, we don't have the complexity of trying to find and update a user.
//      We are keeping track of all persisted users in the registeredUsers property, anyway.
+ (void)persistUser:(MBBoxUser*)user
{
    // Get the existing persisted users
    NSMutableArray* userArray = [MBBoxUser persistedUsers];
    
    // Find the user in the existing persisted users array
    NSUInteger userIndex = [userArray indexOfObjectPassingTest:^(NSDictionary* dUser, NSUInteger index, BOOL* stop)
    {
        if([[dUser objectForKey:user_id_key] isEqualToString:user.userId]) return YES;
        else return NO;
    }];
    
    if(userIndex == NSNotFound)
    {
        // Add the user to the persisted collection
        [userArray addObject:[user persistentDictionary]];
    }
    else
    {
        // Replace the existing persisted user
        [userArray setObject:[user persistentDictionary] atIndexedSubscript:userIndex];
    }
    
    // Persist the updated users array
    [[NSUserDefaults standardUserDefaults] setObject:userArray forKey:persisted_users_key];
}

+ (NSMutableArray*)persistedUsers
{
    // Get the persisted users array, or create it if it doesn't exist
    NSMutableArray* userArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:persisted_users_key]];
    if(!userArray) userArray = [NSMutableArray arrayWithCapacity:1];
    return userArray;
}

+ (NSMutableArray*)mutableRegisteredUsers
{
    if(!_registeredUsers) _registeredUsers = [NSMutableArray array];
    return _registeredUsers;
}

+ (NSArray *)registeredUsers
{
    return [NSArray arrayWithArray:[MBBoxUser mutableRegisteredUsers]];
}

+ (BOOL)addRegisteredUser:(MBBoxUser*)user
{
    NSMutableArray* users = [MBBoxUser mutableRegisteredUsers];
    
    //TODO: If user is already in the list, return NO

    [users addObject:user];
    [MBBoxUser persistUser:user];

    return YES;
}

+ (BOOL)removeRegisteredUser:(MBBoxUser*)user
{
    NSMutableArray* users = [MBBoxUser mutableRegisteredUsers];
    
    //TODO: If user is not in the list, return NO
    
    //TODO: Revoke the user using [user revokeWithCompletion:] when it is implemented
    
    //TODO: Remove the persisted user
    
    [users removeObject:user];
    return YES;
}

@end
