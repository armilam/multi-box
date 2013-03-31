//
//  MBAuthentication.m
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBAuthentication.h"

@implementation MBAuthentication

+ (void)processOAuthInfo:(NSDictionary*)params completion:(void(^)(MBUser* newUser, NSError* error))completion
{
    NSString* error = [params objectForKey:@"error"];
    NSString* state = [params objectForKey:@"state"];
    if(error)
    {
        //TODO: Do something with errors
        NSString* errorDescription = [params objectForKey:@"error_description"];
        [[NSAlert alertWithMessageText:@"Not authenticated" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"%@: %@", error, errorDescription] runModal];
        NSLog(@"Error occurred during authentication: (%@) %@", error, errorDescription);
    }
    else if(state && [state isEqualToString:@"authenticated"])
    {
        // The user's auth code
        NSString* authCode = [params objectForKey:@"code"];
        
        //TODO: Use RestKit for getting the access_token
        
        
        /* WRONG: Because I get an auth code, not a token... yet
         MBUser* newUser = [[MBUser alloc] init];
         newUser.userToken = [queryParams objectForKey:@"code"];
         //TODO: Only add if user not already in collection
         [self.users addObject:newUser];
         */
    }
    else
    {
        //TODO: Something? Not authenticated but no error?
    }
}

@end
