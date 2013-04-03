//
//  MBAppDelegate.m
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBAppDelegate.h"
#import "MBLoginWindowController.h"
#import "NSString+ParseURLQuery.h"
#import "MBUser+Authentication.h"

@interface MBAppDelegate()

@property (nonatomic, strong) MBLoginWindowController* loginWindow;
@property (nonatomic, strong) NSMutableArray* users;

@end

@implementation MBAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self
                                                       andSelector:@selector(handleURLEvent:withReplyEvent:)
                                                     forEventClass:kInternetEventClass
                                                        andEventID:kAEGetURL];
    
    //TODO: Load existing users
    // Use initWithRefreshToken
    self.users = [NSMutableArray array];

}

- (void)handleURLEvent:(NSAppleEventDescriptor*)event withReplyEvent:(NSAppleEventDescriptor*)replyEvent
{
    NSString* urlString = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
    NSURL* url = [NSURL URLWithString:urlString];
    NSLog(@"URL called to the app: %@", urlString);
    
    if([url.host isEqualToString:@"authentication"])
    {
        // Box's OAuth returned us a token
        NSDictionary* queryParams = [url.query dictionaryFromQueryComponents];
        
        [MBUser authenticateNewUser:queryParams completion:^(MBUser* newUser, NSException* error)
        {
            //TODO: Check the user isn't already in the list
            //TODO: Add user to list
            if(newUser) [self.users addObject:newUser];
            //TODO: else [do something with the error]
            //TODO: Do other stuff like showing user in UI
            
        }];
    }
    
    [self.loginWindow close];
}

- (void)refreshAccessTokenForUser:(MBUser*)user
{
    //TODO: To prevent race conditions, consider having a completion block sent to refreshAccessTokenForUser.
    //      This could allow us to know when a user is safe to use again.
    [user refreshAccessToken];
}

- (void)revokeUser:(MBUser*)user
{
    [user revokeWithCompletion:^(BOOL success)
    {
        if(success)
        {
            //TODO: Remove user from list and do UI stuff
        }
        else
        {
            //TODO: Report failure?
        }
    }];
}



- (void)loginButtonClicked:(id)sender
{
    self.loginWindow = [[MBLoginWindowController alloc] initWithWindowNibName:@"MBLoginWindowController"];
    [self.loginWindow showWindow:self];
}

- (void)refreshButtonClicked:(id)sender
{
    [self refreshAccessTokenForUser:[self.users objectAtIndex:0]];
}

- (void)revokeButtonClicked:(id)sender
{
    [self revokeUser:[self.users objectAtIndex:0]];
}

@end
