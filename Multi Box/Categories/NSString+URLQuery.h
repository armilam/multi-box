//
//  NSString+URLQuery.h
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLQuery)

- (NSMutableDictionary *)dictionaryFromQueryComponents;
+ (NSString*)queryStringFromDictionary:(NSDictionary*)queryDictionary;

@end
