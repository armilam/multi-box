//
//  MBUser+GetInfo.m
//  Multi Box
//
//  Created by Aaron Milam on 4/4/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUser+GetInfo.h"
#import "MBGetUserInfoResponse.h"
#import "MBFolder.h"
#import <RestKit/RestKit.h>
#import <RestKit/RKObjectManager.h>

@interface MBUser()

#pragma mark - Box User Information
@property (nonatomic, strong, readwrite) NSString* userId;
@property (nonatomic, strong, readwrite) NSString* name;
@property (nonatomic, strong, readwrite) NSString* loginId;
@property (nonatomic, strong, readwrite) NSNumber* boxSizeBytes;
@property (nonatomic, strong, readwrite) NSNumber* boxBytesUsed;
@property (nonatomic, strong, readwrite) NSNumber* maxUploadSizeBytes;
@property (nonatomic, strong, readwrite) NSString* status;
@property (nonatomic, strong, readwrite) NSString* avatarUrlString;
@property (nonatomic, assign, readwrite) BOOL isSyncEnabled;

#pragma mark - Box User Information (currently unused by this app)
@property (nonatomic, strong, readwrite) NSString* userType;
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

@end

@implementation MBUser (GetInfo)

- (void)getUserInfoWithCompletion:(void(^)(MBUser* user))returnBlock
{
    RKObjectMapping* responseMapping = [RKObjectMapping mappingForClass:[MBGetUserInfoResponse class]];
    [responseMapping addAttributeMappingsFromDictionary:@{
        @"id" : @"userId",
        @"name" : @"name",
        @"login" : @"loginId",
        @"space_amount" : @"boxSizeBytes",
        @"space_used" : @"boxBytesUsed",
        @"max_upload_size" : @"maxUploadSizeBytes",
        @"status" : @"status",
        @"avatar_url" : @"avatarUrlString",
        @"is_sync_enabled" : @"isSyncEnabled"
     }];
    
    NSIndexSet* statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping pathPattern:@"/2.0/users/me" keyPath:nil statusCodes:statusCodes];
    
    //TODO: Break out URLs
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.box.com/2.0/users/me"]];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", self.accessToken] forHTTPHeaderField:@"Authorization"];
    RKObjectRequestOperation* operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result)
     {
         NSLog(@"Got user info");
         [self copyUserInfoFrom:[[result array] objectAtIndex:0]];
         if(returnBlock) returnBlock(self);
     }
                                     failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         if(returnBlock) returnBlock(nil);
         NSLog(@"Failed with error: %@", [error localizedDescription]);
     }];
    [operation start];
}

#pragma mark - Helpers

- (void)copyUserInfoFrom:(MBGetUserInfoResponse*)response
{
    self.userId = response.userId;
    self.name = response.name;
    self.loginId = response.loginId;
    self.boxSizeBytes = response.boxSizeBytes;
    self.boxBytesUsed = response.boxBytesUsed;
    self.maxUploadSizeBytes = response.maxUploadSizeBytes;
    self.status = response.status;
    self.avatarUrlString = response.avatarUrlString;
    self.isSyncEnabled = response.isSyncEnabled;
}

@end
