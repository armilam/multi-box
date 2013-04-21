//
//  MBUserListViewController.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBUserListCell.h"
#import "MBBoxUser.h"

/// Controls the user list in the MBMainViewController.
/// Uses MBBoxUser::registeredUsers to populate with the registered users.
@interface MBUserListViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) IBOutlet NSTableView* tableView;
@property (nonatomic, strong) IBOutlet MBUserListCell* userListCell;

/// This is called when a user is selected.
@property (nonatomic, copy) void(^userSelectedAction)(MBBoxUser* user);

- (IBAction)selectedRow:(id)sender;

- (void)reloadUser:(MBBoxUser*)user;

@end
