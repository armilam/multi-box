//
//  MBBoxUser.h
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBUser.h"

@class MBBoxFolder;

@interface MBBoxUser : MBUser

#pragma mark Box info
/// The access token required to identify the user each for request. It is valid for one hour.
/// This is provided by the Box API.
@property (nonatomic, strong) NSString* accessToken;

/// The amount of time in seconds that the MBBoxUser::accessToken will expire after generation.
/// This has always been 3600 (one hour) for me so far.
/// This is provided by the Box API.
@property (nonatomic, assign) NSInteger expiresIn;

/// As far as I have been able to tell so far, this will always be "bearer".
/// This is provided by the Box API.
@property (nonatomic, strong) NSString* tokenType;

/// The refresh token required to refresh the user's MBBoxUser::accessToken and MBBoxUser::refreshToken.
/// This is valid for two weeks.
/// This is provided by the Box API.
@property (nonatomic, strong) NSString* refreshToken;

/// This is a calculated time of expiration for MBBoxUser::accessToken.
@property (nonatomic, strong, readonly) NSDate* accessTokenExpiration;

/// This is a calculated time of expiration for MBBoxUser::refreshToken.
@property (nonatomic, strong, readonly) NSDate* refreshTokenExpiration;

#pragma mark - Box User Information
/// The id used by the Box API to identify the user.
@property (nonatomic, strong, readonly) NSString* userId;

/// The user's real (or registered) name.
@property (nonatomic, strong, readonly) NSString* name;

/// The capacity of the user's Box in bytes.
@property (nonatomic, strong, readonly) NSNumber* boxSizeBytes;

/// The amount of space used in the user's Box in bytes.
@property (nonatomic, strong, readonly) NSNumber* boxBytesUsed;

/// The maximum upload size for the user in bytes.
@property (nonatomic, strong, readonly) NSNumber* maxUploadSizeBytes;

/// The user's status as given by the Box API.
/// The possible values are "active" and "inactive".
@property (nonatomic, strong, readonly) NSString* status;

/// A URL string to the user's avatar image.
@property (nonatomic, strong, readonly) NSString* avatarUrlString;

/// Indicates whether the user has sync enabled.
@property (nonatomic, assign, readonly) BOOL isSyncEnabled;

#pragma mark - Box User Information (currently unused by this app)
@property (nonatomic, strong, readonly) NSString* userType;
@property (nonatomic, strong, readonly) NSString* loginId;
@property (nonatomic, strong, readonly) NSDate* createdAt;
@property (nonatomic, strong, readonly) NSDate* modifiedAt;
@property (nonatomic, strong, readonly) NSString* language;
@property (nonatomic, strong, readonly) NSString* role;
@property (nonatomic, strong, readonly) NSString* jobTitle;
@property (nonatomic, strong, readonly) NSString* phone;
@property (nonatomic, strong, readonly) NSString* address;
@property (nonatomic, strong, readonly) NSArray* trackingCodes;
@property (nonatomic, assign, readonly) BOOL canSeeManagedUsers;
@property (nonatomic, assign, readonly) BOOL isExemptFromDeviceLimits;
@property (nonatomic, assign, readonly) BOOL isExemptFromLoginVerification;
//@property (nonatomic, strong, readonly) MBEnterprise* enterprise;

#pragma mark - MB Info

@property (nonatomic, strong, readonly) MBBoxFolder* rootFolder;

#pragma mark - Methods

/// To be used when deserializing a saved user
- (MBBoxUser*)initWithRefreshToken:(NSString*)refreshToken expiration:(NSDate*)expiration;

/// Calls the Box API to refresh the user's MBBoxUser::accessToken and MBBoxUser::refreshToken.
/// TODO: Pass in a block so the caller can find out whether the refresh was successful.
- (void)resetRefreshTokenExpiration;

@end
