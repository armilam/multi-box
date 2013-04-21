//
//  MBBoxRefreshTokenRequest.h
//  Multi Box
//
//  Created by Aaron Milam on 4/1/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBBoxUser.h"

@interface MBBoxRefreshTokenRequest : NSObject

- (id)initWithUser:(MBBoxUser*)user;

- (NSDictionary*)requestParameters;

@end
