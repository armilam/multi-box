//
//  MBBoxFileResponse.h
//  Multi Box
//
//  Created by Aaron Milam on 4/20/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBUser.h"

@interface MBBoxFileResponse : NSObject

@property NSString* id;
@property NSString* name;
@property NSString* sequence_id;
@property NSString* etag;
@property NSString* description;
@property NSNumber* size;
@property NSDate* created_at;
@property NSDate* modified_at;
@property MBUser* created_by;
@property MBUser* modified_by;
@property MBUser* owned_by;
@property NSString* shared_link;
@property NSString* item_status;

/* From folder content listing
 {
 "type": "file",
 "id": "409042868",
 "sequence_id": "1",
 "etag": "1",
 "name": "A choice file"

 @"sequence_id" : @"sequenceId",
 @"etag" : @"etag",
 @"description" : @"desc",
 @"size" : @"size",
 @"created_at" : @"createdAt",
 @"modified_at" : @"modifiedAt",
 @"created_by" : @"createdBy",
 @"modified_by" : @"modifiedBy",
 @"owned_by" : @"ownedBy",
 @"shared_link" : @"sharedLinkUrlString",
 @"item_status" : @"isDeleted"
 }
 */

@end
