//
//  MBFolderResponse.h
//  Multi Box
//
//  Created by Aaron Milam on 4/20/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBFolderResponse : NSObject

@property NSString* id;
@property NSString* name;

/* From folder content listing
 {
 "type": "folder",
 "id": "409047868",
 "sequence_id": "1",
 "etag": "1",
 "name": "Here's your folder"
 },
 */

@end
