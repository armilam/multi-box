//
//  MBFolder.h
//  Multi Box
//
//  Created by Aaron Milam on 4/4/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBUser;

@interface MBFolder : NSObject

// Point of convention - I'm going to use "bid" from now on as the "id" property I get back from
// the Box API for any object. It stands for "Box id". Hopefully that will be obvious enough.
// This extends beyond id. It goes for any property from Box that already has a meaning in
// Objective-C or Cocoa. "description", for example, is "bdescription" in this class.
@property (nonatomic, strong, readonly) NSString* bid;
@property (nonatomic, strong, readonly) NSString* sequenceId;
@property (nonatomic, strong, readonly) NSString* etag;
@property (nonatomic, strong, readonly) NSString* name;
@property (nonatomic, strong, readonly) NSDate* createdAt;
@property (nonatomic, strong, readonly) NSDate* modifiedAt;
@property (nonatomic, strong, readonly) NSString* bdescription;
@property (nonatomic, assign, readonly) NSInteger size;
@property (nonatomic, strong, readonly) NSArray* pathCollection;
@property (nonatomic, strong, readonly) MBUser* createdBy;
@property (nonatomic, strong, readonly) MBUser* modifiedBy;
@property (nonatomic, strong, readonly) MBUser* ownedBy;
@property (nonatomic, strong, readonly) NSString* sharedLinkUrlString;
@property (nonatomic, strong, readonly) NSString* folderUploadEmail;
@property (nonatomic, strong, readonly) MBFolder* parent;
@property (nonatomic, strong, readonly) NSString* itemStatus;
@property (nonatomic, strong, readonly) NSArray* itemCollection;
@property (nonatomic, strong, readonly) NSString* syncState;


@end
