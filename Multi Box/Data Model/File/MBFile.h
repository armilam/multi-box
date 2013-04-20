//
//  MBFile.h
//  Multi Box
//
//  Created by Aaron Milam on 4/20/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBFileResponse.h"

@class MBFolder;

@interface MBFile : NSObject

@property (readonly) NSString* bid;
@property (readonly) NSString* name;
@property (readonly) MBFolder* parent;

/// Creates and populates an MBFile object using values from fileResponse.
/// @param fileResponse The object containing the info from Box API about the file.
/// @param parent The file's parent folder.
/// @return A new MBFile object.
+ (MBFile*)fileFromResponse:(MBFileResponse*)fileResponse withParent:(MBFolder*)parent;

@end
