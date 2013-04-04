//
//  MBUserListViewController.m
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUserListViewController.h"
#import "MBUser+Collection.h"

@implementation MBUserListViewController

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[MBUser registeredUsers] count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    self.userListCell = [tableView makeViewWithIdentifier:@"MBUserListCell" owner:self];
    [self.userListCell setUser:[[MBUser registeredUsers] objectAtIndex:row]];
    return self.userListCell;
}

@end
