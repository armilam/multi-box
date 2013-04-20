//
//  MBFile.m
//  Multi Box
//
//  Created by Aaron Milam on 4/20/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBFile.h"
#import "MBFolder.h"

@interface MBFile()

@property (readwrite) NSString* bid;
@property (readwrite) NSString* name;
@property (readwrite) MBFolder* parent;

@end

@implementation MBFile

+ (MBFile*)fileFromResponse:(MBFileResponse*)fileResponse withParent:(MBFolder*)parent
{
    MBFile* newFile = [[MBFile alloc] init];
    newFile.parent = parent;
    newFile.bid = fileResponse.id;
    newFile.name = fileResponse.name;
    
    return newFile;
}

@end
