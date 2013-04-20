//
//  MBUser.m
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUser.h"
#import "MBFolder.h"

@interface MBUser()

@property (nonatomic, strong, readwrite) NSDate* accessTokenExpiration;
@property (nonatomic, strong, readwrite) NSDate* refreshTokenExpiration;

#pragma mark - Box User Information
@property (nonatomic, strong, readwrite) NSString* userId;
@property (nonatomic, strong, readwrite) NSString* name;
@property (nonatomic, strong, readwrite) NSNumber* boxSizeBytes;
@property (nonatomic, strong, readwrite) NSNumber* boxBytesUsed;
@property (nonatomic, strong, readwrite) NSNumber* maxUploadSizeBytes;
@property (nonatomic, strong, readwrite) NSString* status;
@property (nonatomic, strong, readwrite) NSString* avatarUrlString;
@property (nonatomic, assign, readwrite) BOOL isSyncEnabled;

#pragma mark - Box User Information (currently unused by this app)
@property (nonatomic, strong, readwrite) NSString* userType;
@property (nonatomic, strong, readwrite) NSString* loginId;
@property (nonatomic, strong, readwrite) NSDate* createdAt;
@property (nonatomic, strong, readwrite) NSDate* modifiedAt;
@property (nonatomic, strong, readwrite) NSString* language;
@property (nonatomic, strong, readwrite) NSString* role;
@property (nonatomic, strong, readwrite) NSString* jobTitle;
@property (nonatomic, strong, readwrite) NSString* phone;
@property (nonatomic, strong, readwrite) NSString* address;
@property (nonatomic, strong, readwrite) NSArray* trackingCodes;
@property (nonatomic, assign, readwrite) BOOL canSeeManagedUsers;
@property (nonatomic, assign, readwrite) BOOL isExemptFromDeviceLimits;
@property (nonatomic, assign, readwrite) BOOL isExemptFromLoginVerification;
//@property (nonatomic, strong, readwrite) MBEnterprise* enterprise;

#pragma mark - MB Info

@property (nonatomic, strong, readwrite) MBFolder* rootFolder;

@end

@implementation MBUser

- (MBUser*)init
{
    self = [super init];
    
    self.rootFolder = [[MBFolder alloc] initRootFolderForUser:self];
    
    return self;
}

- (MBUser*)initWithRefreshToken:(NSString*)refreshToken expiration:(NSDate*)expiration;
{
    self = [self init];

    self.refreshToken = refreshToken;
    self.refreshTokenExpiration = expiration;

    self.accessToken = nil;
    self.accessTokenExpiration = [NSDate date];

    return self;
}

- (void)setExpiresIn:(NSInteger)expiresIn
{
    _expiresIn = expiresIn;
    self.accessTokenExpiration = [[NSDate date] dateByAddingTimeInterval:expiresIn];
}

- (void)resetRefreshTokenExpiration
{
    // 14 days each time the refresh token is, well... refreshed
    self.refreshTokenExpiration = [[NSDate date] dateByAddingTimeInterval:1209600];
}

@end
