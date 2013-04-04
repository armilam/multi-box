//
//  MBUserListViewController.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBUserListCell.h"

@interface MBUserListViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) IBOutlet NSTableView* tableView;
@property (nonatomic, strong) IBOutlet MBUserListCell* userListCell;

@end
