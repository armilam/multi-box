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

@class MBBoxFolder;

@interface MBBoxFile : MBFile

@property (readonly) NSString* bid;
@property (readonly) NSString* name;
@property (readonly) MBBoxFolder* parent;

/// Creates and populates an MBBoxFile object using values from fileResponse.
/// @param fileResponse The object containing the info from Box API about the file.
/// @param parent The file's parent folder.
/// @return A new MBBoxFile object.
+ (MBBoxFile*)fileFromResponse:(MBBoxFileResponse*)fileResponse withParent:(MBBoxFolder*)parent;

@end
