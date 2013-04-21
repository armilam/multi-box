//
//  MBBoxFile.m
//  Multi Box
//
//  Created by Aaron Milam on 4/20/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBBoxFile.h"
#import "MBBoxFolder.h"

@interface MBBoxFile()

@property (readwrite) NSString* bid;
@property (readwrite) NSString* name;
@property (readwrite) MBBoxFolder* parent;

@end

@implementation MBBoxFile

+ (MBBoxFile*)fileFromResponse:(MBBoxFileResponse*)fileResponse withParent:(MBBoxFolder*)parent
{
    MBBoxFile* newFile = [[MBBoxFile alloc] init];
    newFile.parent = parent;
    newFile.bid = fileResponse.id;
    newFile.name = fileResponse.name;
    
    return newFile;
}

@end
