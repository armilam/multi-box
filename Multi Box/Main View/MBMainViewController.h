//
//  MBMainViewController.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MBUserListViewController.h"
#import "MBFileBrowserController.h"

/// The controller for the main window of the application.
@interface MBMainViewController : NSViewController

@property (nonatomic, strong) IBOutlet MBUserListViewController* userListViewController;
@property (nonatomic, strong) IBOutlet MBFileBrowserController* fileBrowserController;

/// Called when the '+' button under the user list is clicked.
/// Starts the process for logging a user in.
- (IBAction)login:(id)sender;

@end
