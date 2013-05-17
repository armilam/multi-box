//
//  MBBoxFile.h
//  Multi Box
//
//  Created by Aaron Milam on 4/20/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBBoxFileResponse.h"
#import "MBFile.h"
#import "MBBoxFolder.h"

@interface MBBoxFile : MBFile

/// The MBBoxFolder object that contains the file
@property (readonly) MBBoxFolder* parent;

/// A unique ID for use with the /events endpoint
@property (readonly) NSString* sequenceId;

/// The SHA1 hash of the file's contents
@property (readonly) NSString* sha1;

/// A unique string identifying the version of the file
@property (readonly) NSString* etag;

/// Creates and populates an MBBoxFile object using values from fileResponse.
/// @param fileResponse The object containing the info from Box API about the file.
/// @param parent The file's parent folder.
/// @return A new MBBoxFile object.
+ (MBBoxFile*)fileFromResponse:(MBBoxFileResponse*)fileResponse withParent:(MBBoxFolder*)parent;

@end
