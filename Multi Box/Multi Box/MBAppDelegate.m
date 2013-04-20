//
//  MBAppDelegate.m
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBAppDelegate.h"
#import "MBLoginWindowController.h"
#import "NSString+URLQuery.h"
#import "MBUser+Authentication.h"
#import "MBUser+Collection.h"

@interface MBAppDelegate()

@property (nonatomic, strong) MBLoginWindowController* loginWindow;

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
            //TODO: Can I close the browser window after auth? Should I just use app-based browser window?
            if(newUser && [MBUser addRegisteredUser:newUser])
            {
                //TODO: Make a better interface for telling the tableView to update
                [self.mainViewController.userListViewController.tableView reloadData];
            }
            else
            {
                //TODO: else [do something with the error]
            }
            
        }];
    }
    
    [self.loginWindow close];
}

+ (MBAppDelegate*)appDelegate
{
    return [NSApp delegate];
}

@end
