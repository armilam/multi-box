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
    
    self.mainViewController = [[MBMainViewController alloc] initWithNibName:@"MBMainViewController" bundle:[NSBundle mainBundle]];
    [self.window.contentView addSubview:self.mainViewController.view];

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

+ (MBAppDelegate*)appDelegate
{
    return [NSApp delegate];
}







//TODO: Remove this when it is handled elsewhere
- (void)loginButtonClicked:(id)sender
{
    self.loginWindow = [[MBLoginWindowController alloc] initWithWindowNibName:@"MBLoginWindowController"];
    [self.loginWindow showWindow:self];
}

@end
