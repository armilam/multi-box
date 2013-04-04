//
//  MBMainViewController.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MBUserListViewController.h"

@interface MBMainViewController : NSViewController

@property (nonatomic, strong) IBOutlet MBUserListViewController* userListViewController;

- (IBAction)login:(id)sender;

@end
