//
//  MBAppDelegate.h
//  Multi Box
//
//  Created by Aaron Milam on 3/31/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MBMainViewController.h"

@interface MBAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) MBMainViewController* mainViewController;

+ (MBAppDelegate*)appDelegate;

@end
