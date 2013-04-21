//
//  MBFolder.h
//  Multi Box
//
//  Created by Aaron Milam on 4/21/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBFileSystemObject.h"

@class MBUser;

@interface MBFolder : MBFileSystemObject

/// The ID of the folder, usually as given by the service API.
@property (readonly) NSString* id;

/// The name of the folder
@property (readonly) NSString* name;

/// A date representing the creation date and time of this folder
@property (readonly) NSDate* createdAt;

/// A date representing the date and time of the last modification of this folder
@property (readonly) NSDate* modifiedAt;

/// A description of the folder
@property (readonly) NSString* desc;

/// The folder size in bytes
@property (readonly) NSInteger size;

/// The user who created this folder
@property (readonly) MBUser* createdBy;

/// The user who last modified this folder
@property (readonly) MBUser* modifiedBy;

/// The user who owns this folder
@property (readonly) MBUser* ownedBy;

/// The URL to share this folder
@property (readonly) NSString* sharedLinkUrlString;

/// The parent to this folder
@property (readonly) MBFolder* parent;

/// Whether this item is deleted or not
@property (readonly) BOOL isDeleted;

/// A collection of the files and folders within this folder
@property (readonly) NSArray* children;

#pragma mark - Methods

/// Initializes an MBFolder object with the correct details as the user's root folder;
/// MBFolder::refreshContents: must be called in order to get the folder's info and contents.
/// @param user The user to whom this folder belongs.
- (MBFolder*)initRootFolderForUser:(MBUser*)user;

/// Refreshes the contents of the folder from the service API.
/// @param returnBlock A block to be called once the folder contents are retrieved.
/// The block passes in the MBFolder object whose contents and info have been refreshed.
- (void)refreshContents:(void(^)(MBFolder* folder))returnBlock;

@end
