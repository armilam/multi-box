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
#import "MBUser.h"

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
        NSDictionary* queryParams = [urlString dictionaryFromQueryComponents];
        
        NSString* error = [queryParams objectForKey:@"error"];
        NSString* state = [queryParams objectForKey:@"state"];
        if(error)
        {
            //TODO: Do something with errors
            NSString* errorDescription = [queryParams objectForKey:@"error_description"];
            [[NSAlert alertWithMessageText:@"Not authenticated" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"%@: %@", error, errorDescription] runModal];
            NSLog(@"Error occurred during authentication: (%@) %@", error, errorDescription);
        }
        else if(state && [state isEqualToString:@"authenticated"])
        {
            // The user's auth code
            NSString* authCode = [queryParams objectForKey:@"code"];
            
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
    
    [self.loginWindow close];
}



- (void)loginButtonClicked:(id)sender
{
    self.loginWindow = [[MBLoginWindowController alloc] initWithWindowNibName:@"MBLoginWindowController"];
    [self.loginWindow showWindow:self];
}

@end
