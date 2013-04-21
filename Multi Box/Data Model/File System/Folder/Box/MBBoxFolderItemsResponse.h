//
//  MBBoxFolderItemsResponse.h
//  Multi Box
//
//  Created by Aaron Milam on 4/20/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBBoxFolderItemsResponse : NSObject

@property NSNumber* total_count;
@property NSArray* entries;
@property NSNumber* offset;
@property NSNumber* limit;

@end
