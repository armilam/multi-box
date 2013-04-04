//
//  MBUser+Authentication.m
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUser+Authentication.h"
#import "MBAccessTokenRequest.h"
#import "MBAccessTokenResponse.h"
#import "MBRefreshTokenRequest.h"
#import "MBRefreshTokenResponse.h"
#import "MBRevokeTokenRequest.h"
#import "MBUser+GetInfo.h"
#import <RestKit/RestKit.h>

@implementation MBUser (Authentication)

+ (void)authenticateNewUser:(NSDictionary*)params completion:(void(^)(MBUser* newUser, NSException* error))completion
{
    NSString* error = [[params objectForKey:@"error"] objectAtIndex:0];
    NSString* state = [[params objectForKey:@"state"] objectAtIndex:0];
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
        NSString* authCode = [[params objectForKey:@"code"] objectAtIndex:0];
        
        RKObjectMapping* tokenMapping = [RKObjectMapping mappingForClass:[MBAccessTokenResponse class]];
        [tokenMapping addAttributeMappingsFromDictionary:@{
         @"access_token":   @"accessToken",
         @"expires_in":     @"expiresIn",
         @"token_type":     @"tokenType",
         @"refresh_token":  @"refreshToken"
         }];
        
        NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:tokenMapping pathPattern:@"/api/oauth2/token" keyPath:nil statusCodes:statusCodes];
        
        RKObjectMapping* requestMapping = [RKObjectMapping requestMapping];
        [requestMapping addAttributeMappingsFromDictionary:@{
         @"grantType":     @"grant_type",
         @"code":          @"code",
         @"clientId":      @"client_id",
         @"clientSecret":  @"client_secret"
         }];
        
        RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[MBAccessTokenRequest class] rootKeyPath:nil];
        
        RKObjectManager* manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://www.box.com"]];
        manager.requestSerializationMIMEType = RKMIMETypeFormURLEncoded;
        [manager addRequestDescriptor:requestDescriptor];
        [manager addResponseDescriptor:responseDescriptor];
        
        MBAccessTokenRequest* tokenRequest = [[MBAccessTokenRequest alloc] init];
        tokenRequest.code = authCode;
        
        [manager postObject:nil path:@"/api/oauth2/token" parameters:[tokenRequest requestParameters] success:^(RKObjectRequestOperation* operation, RKMappingResult* result)
         {
             if([result array].count < 1)
             {
                 if(completion) completion(nil, [NSException exceptionWithName:@"No data returned" reason:@"No data was returned in authentication" userInfo:nil]);
             }
             
             MBAccessTokenResponse* tokenResponse = [[result array] objectAtIndex:0];
             MBUser* newUser = [[MBUser alloc] init];
             newUser.accessToken = tokenResponse.accessToken;
             newUser.expiresIn = tokenResponse.expiresIn;
             newUser.tokenType = tokenResponse.tokenType;
             newUser.refreshToken = tokenResponse.refreshToken;
             [newUser resetRefreshTokenExpiration];
             
             // Now get the user's details
             [newUser getUserInfoWithCompletion:^(MBUser* user){ if(completion) completion(user, nil); }];
         }
                    failure:^(RKObjectRequestOperation *operation, NSError *error)
         {
             if(completion) completion(nil, [NSException exceptionWithName:@"Auth error" reason:error.localizedDescription userInfo:nil]);
             NSLog(@"Failed with error: %@", [error localizedDescription]);
         }];
    }
    else
    {
        //TODO: Something? Not authenticated but no error?
    }
}

- (void)refreshAccessToken
{
    //TODO: I can see potential race conditions here when the app tries to use the user's access token while this refresh is still happening
    RKObjectMapping* tokenMapping = [RKObjectMapping mappingForClass:[MBRefreshTokenResponse class]];
    [tokenMapping addAttributeMappingsFromDictionary:@{
     @"access_token":   @"accessToken",
     @"expires_in":     @"expiresIn",
     @"token_type":     @"tokenType",
     @"refresh_token":  @"refreshToken"
     }];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:tokenMapping pathPattern:@"/api/oauth2/token" keyPath:nil statusCodes:statusCodes];
    
    RKObjectMapping* requestMapping = [RKObjectMapping requestMapping];
    [requestMapping addAttributeMappingsFromDictionary:@{
     @"grantType":     @"grant_type",
     @"refreshToken":  @"refresh_token",
     @"clientId":      @"client_id",
     @"clientSecret":  @"client_secret"
     }];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[MBRefreshTokenRequest class] rootKeyPath:nil];
    
    RKObjectManager* manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://www.box.com"]];
    manager.requestSerializationMIMEType = RKMIMETypeFormURLEncoded;
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:responseDescriptor];
    
    MBRefreshTokenRequest* tokenRequest = [[MBRefreshTokenRequest alloc] initWithUser:self];
    
    [manager postObject:nil path:@"/api/oauth2/token" parameters:[tokenRequest requestParameters] success:^(RKObjectRequestOperation* operation, RKMappingResult* result)
     {
         if([result array].count < 1)
         {
             NSLog(@"Got no data back for refresh token");
             return ;
         }
         
         MBRefreshTokenResponse* tokenResponse = [[result array] objectAtIndex:0];
         self.accessToken = tokenResponse.accessToken;
         self.expiresIn = tokenResponse.expiresIn;
         self.tokenType = tokenResponse.tokenType;
         self.refreshToken = tokenResponse.refreshToken;
         [self resetRefreshTokenExpiration];
         
         NSLog(@"Got refreshed token");
     }
                failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         NSLog(@"Token refresh failed with error: %@", [error localizedDescription]);
     }];
}

- (void)revokeWithCompletion:(void(^)(BOOL success))completion
{
    //TODO: Figure out how to revoke
    @throw [NSException exceptionWithName:@"revokeUser not available" reason:@"For some reason, I can't figure out the whole object mapping thing in this case. I get a text/html response, but I don't know how to handle that. Figure that out, and maybe I'll get revoke to work." userInfo:nil];
    
    //TODO: I can see potential race conditions here when the app tries to use the user's access token while this revoke is still happening
    
    //    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    //    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:nil pathPattern:@"/api/oauth2/revoke" keyPath:nil statusCodes:statusCodes];
    
    RKObjectMapping* requestMapping = [RKObjectMapping requestMapping];
    [requestMapping addAttributeMappingsFromDictionary:@{
     @"token":         @"token",
     @"clientId":      @"client_id",
     @"clientSecret":  @"client_secret"
     }];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[MBRevokeTokenRequest class] rootKeyPath:nil];
    
    RKObjectManager* manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://www.box.com"]];
    manager.requestSerializationMIMEType = RKMIMETypeFormURLEncoded;
    [manager addRequestDescriptor:requestDescriptor];
    //    [manager addResponseDescriptor:responseDescriptor];
    
    MBRevokeTokenRequest* tokenRequest = [[MBRevokeTokenRequest alloc] initWithUser:self];
    //TODO: CRASH: Mapping is incorrect. Test to see the error.
    [manager postObject:nil path:@"/api/oauth2/revoke" parameters:[tokenRequest requestParameters] success:^(RKObjectRequestOperation* operation, RKMappingResult* result)
     {
         if(completion) completion(YES);
         NSLog(@"Got revoked token");
     }
                failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         if(completion) completion(NO);
         NSLog(@"Token refresh failed with error: %@", [error localizedDescription]);
     }];
}

@end
