//
//  MBRevokeTokenRequest.h
//  Multi Box
//
//  Created by Aaron Milam on 4/1/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBUser.h"

@interface MBRevokeTokenRequest : NSObject

- (id)initWithUser:(MBUser*)user;

- (NSDictionary*)requestParameters;

@end
