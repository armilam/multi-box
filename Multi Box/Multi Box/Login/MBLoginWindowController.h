//
//  MBLoginWindowController.h
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface MBLoginWindowController : NSWindowController

@property (nonatomic, strong) IBOutlet WebView* webView;

@end
