//
//  MBBoxFolder.h
//  Multi Box
//
//  Created by Aaron Milam on 4/4/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBFolder.h"
#import "MBBoxUser.h"

@interface MBBoxFolder : MBFolder

#pragma mark - Box-specific properties

/// A unique ID for use with the /events endpoint
@property (readonly) NSString* sequenceId;

/// A unique string identifying the version of the folder
@property (readonly) NSString* etag;

/// The path of folders to this item, starting at the root
@property (readonly) NSArray* pathCollection;

/// The upload email address for this folder
@property (readonly) NSString* folderUploadEmail;

/// Whether this folder will be synced by the Box clients
@property (readonly) NSString* syncState;

#pragma mark - Box-typed properties

/// The user who created this folder
@property (readonly) MBBoxUser* createdBy;

/// The user who last modified this folder
@property (readonly) MBBoxUser* modifiedBy;

/// The user who owns this folder
@property (readonly) MBBoxUser* ownedBy;

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
