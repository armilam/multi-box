//
//  MBBoxFolder.h
//  Multi Box
//
//  Created by Aaron Milam on 4/4/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBFolder.h"

@class MBBoxUser, MBBoxFolderResponse;

@interface MBBoxFolder : MBFolder

/// Point of convention - I'm going to use "bid" from now on as the "id" property I get back from
/// the Box API for any object. It stands for "Box id". Hopefully that will be obvious enough.
/// This extends beyond id. It goes for any property from Box that already has a meaning in
/// Objective-C or Cocoa. "description", for example, is "bdescription" in this class.
@property (nonatomic, strong, readonly) NSString* bid;

/// A unique ID for use with the /events endpoint
@property (nonatomic, strong, readonly) NSString* sequenceId;

/// A unique string identifying the version of the folder
@property (nonatomic, strong, readonly) NSString* etag;

/// The name of the folder
@property (nonatomic, strong, readonly) NSString* name;

/// A date representing the creation date and time of this folder
@property (nonatomic, strong, readonly) NSDate* createdAt;

/// A date representing the date and time of the last modification of this folder
@property (nonatomic, strong, readonly) NSDate* modifiedAt;

/// A description of the folder
@property (nonatomic, strong, readonly) NSString* bdescription;

/// The folder size in bytes
@property (nonatomic, assign, readonly) NSInteger size;

/// The path of folders to this item, starting at the root
@property (nonatomic, strong, readonly) NSArray* pathCollection;

/// The user who created this folder
@property (nonatomic, strong, readonly) MBBoxUser* createdBy;

/// The user who last modified this folder
@property (nonatomic, strong, readonly) MBBoxUser* modifiedBy;

/// The user who owns this folder
@property (nonatomic, strong, readonly) MBBoxUser* ownedBy;

/// The URL to share this folder
@property (nonatomic, strong, readonly) NSString* sharedLinkUrlString;

/// The upload email address for this folder
@property (nonatomic, strong, readonly) NSString* folderUploadEmail;

/// The parent to this folder
@property (nonatomic, strong, readonly) MBBoxFolder* parent;

/// Whether this item is deleted or not
@property (nonatomic, strong, readonly) NSString* itemStatus;

/// A collection of the files and folders within this folder
@property (nonatomic, strong, readonly) NSArray* itemCollection;

/// Whether this folder will be synced by the Box clients
@property (nonatomic, strong, readonly) NSString* syncState;

#pragma mark - Methods

/// Initializes an MBBoxFolder object with the correct details as the user's root folder;
/// MBBoxFolder::refreshContents: must be called in order to get the folder's info and contents.
/// @param user The user to whom this folder belongs.
- (MBBoxFolder*)initRootFolderForUser:(MBBoxUser*)user;

/// Refreshes the contents of the folder from Box.
/// @param returnBlock A block to be called once the folder contents are retrieved.
/// The block passes in the MBBoxFolder object whose contents and info have been refreshed.
- (void)refreshContents:(void(^)(MBBoxFolder* folder))returnBlock;


@end
