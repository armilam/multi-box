//
//  MBUser.h
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBUser : NSObject

@property (nonatomic, strong) NSString* accessToken;
@property (nonatomic, assign) NSInteger expiresIn;
@property (nonatomic, strong) NSString* tokenType;
@property (nonatomic, strong) NSString* refreshToken;
@property (nonatomic, strong, readonly) NSDate* accessTokenExpiration;
@property (nonatomic, strong, readonly) NSDate* refreshTokenExpiration;

#pragma mark - Box User Information
@property (nonatomic, strong, readonly) NSString* userId;
@property (nonatomic, strong, readonly) NSString* name;
@property (nonatomic, strong, readonly) NSNumber* boxSizeBytes;
@property (nonatomic, strong, readonly) NSNumber* boxBytesUsed;
@property (nonatomic, strong, readonly) NSNumber* maxUploadSizeBytes;
@property (nonatomic, strong, readonly) NSString* status;
@property (nonatomic, strong, readonly) NSString* avatarUrlString;
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

#pragma mark - Methods

// To be used when deserializing a saved user
- (MBUser*)initWithRefreshToken:(NSString*)refreshToken expiration:(NSDate*)expiration;

- (void)resetRefreshTokenExpiration;

@end
