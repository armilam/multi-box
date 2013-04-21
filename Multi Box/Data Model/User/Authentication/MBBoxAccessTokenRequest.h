//
//  MBBoxAccessTokenRequest.h
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBBoxAccessTokenRequest : NSObject

@property (nonatomic, readonly) NSString* grantType;
@property (nonatomic, strong) NSString* code;
@property (nonatomic, readonly) NSString* clientId;
@property (nonatomic, readonly) NSString* clientSecret;

- (NSDictionary*)requestParameters;

@end
