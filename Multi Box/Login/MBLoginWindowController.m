//
//  MBLoginWindowController.m
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBLoginWindowController.h"
#import "MBAPIKey.h"

@interface MBLoginWindowController ()

@end

@implementation MBLoginWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    NSString* url = [NSString stringWithFormat:@"https://www.box.com/api/oauth2/authorize?response_type=code&client_id=%@&state=authenticated", [MBAPIKey getClientId]];
    [[self.webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

@end
