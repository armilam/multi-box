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
#import "MBAuthentication.h"

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
        
        [MBAuthentication processOAuthInfo:queryParams completion:^(MBUser* newUser, NSError* error)
        {
            //TODO: Do something with the new user
        }];
    }
    
    [self.loginWindow close];
}



- (void)loginButtonClicked:(id)sender
{
    self.loginWindow = [[MBLoginWindowController alloc] initWithWindowNibName:@"MBLoginWindowController"];
    [self.loginWindow showWindow:self];
}

@end
