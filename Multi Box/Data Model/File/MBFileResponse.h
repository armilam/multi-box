//
//  MBFileResponse.h
//  Multi Box
//
//  Created by Aaron Milam on 4/20/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBFileResponse : NSObject

@property NSString* id;
@property NSString* name;

/* From folder content listing
 {
 "type": "file",
 "id": "409042868",
 "sequence_id": "1",
 "etag": "1",
 "name": "A choice file"
 }
 */

@end
