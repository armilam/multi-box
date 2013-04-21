//
//  MBFolder.m
//  Multi Box
//
//  Created by Aaron Milam on 4/21/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBFolder.h"
#import "MBUser.h"

@interface MBFolder()

@property (readwrite) NSString* id;
@property (readwrite) NSString* name;
@property (readwrite) NSDate* createdAt;
@property (readwrite) NSDate* modifiedAt;
@property (readwrite) NSString* desc;
@property (readwrite) NSInteger size;
@property (readwrite) MBUser* createdBy;
@property (readwrite) MBUser* modifiedBy;
@property (readwrite) MBUser* ownedBy;
@property (readwrite) NSString* sharedLinkUrlString;
@property (readwrite) MBFolder* parent;
@property (readwrite) BOOL isDeleted;
@property (readwrite) NSArray* children;

@property MBUser* user;

@end

@implementation MBFolder

- (MBFolder*)initRootFolderForUser:(MBUser*)user
{
    self = [self init];

    self.user = user;
    
    return self;
}

- (void)refreshContents:(void (^)(MBFolder*))returnBlock
{
    @throw [NSException exceptionWithName:@"Abstract method not implemented" reason:@"MBFolder::refreshContents must be overloaded by its subclasses" userInfo:nil];
}

@end
