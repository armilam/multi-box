//
//  MBFile.h
//  Multi Box
//
//  Created by Aaron Milam on 4/21/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBFileSystemObject.h"
#import "MBFolder.h"

@interface MBFile : MBFileSystemObject

/// The ID of the file, usually as given by the service API
@property NSString* id;

/// The name of the file
@property NSString* name;

/// The MBFolder object that contains the file
@property MBFolder* parent;

/// A description of the file
@property NSString* desc;

/// The file's size in bytes
@property NSNumber* size;

/// A date representing the creation date and time of this folder
@property NSDate* createdAt;

/// A date representing the date and time of the last modification of this folder
@property NSDate* modifiedAt;

/// The user who created this folder
@property MBUser* createdBy;

/// The user who last modified this folder
@property MBUser* modifiedBy;

/// The user who owns this folder
@property MBUser* ownedBy;

/// The URL to share this folder
@property NSString* sharedLinkUrlString;

/// Whether this item is deleted or not
@property BOOL isDeleted;

@end
