//
//  MBGetUserInfoResponse.h
//  Multi Box
//
//  Created by Aaron Milam on 4/4/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBGetUserInfoResponse : NSObject

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

@end
