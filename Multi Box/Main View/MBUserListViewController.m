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

- (void)reloadUser:(MBUser *)user
{
    //TODO: Reload the user in the list instead of the whole list
    [self.tableView reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[MBUser registeredUsers] count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString* const userListCellIdentifier = @"MBUserListCell";
    
    self.userListCell = [tableView makeViewWithIdentifier:userListCellIdentifier owner:self];
    
    if(!self.userListCell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"MBUserListCell" owner:self topLevelObjects:nil];
        self.userListCell.identifier = userListCellIdentifier;
    }
    
    [self.userListCell setUser:[[MBUser registeredUsers] objectAtIndex:row]];
    return self.userListCell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 96.0;
}

- (void)selectedRow:(id)sender
{
    if(self.userSelectedAction) self.userSelectedAction([[MBUser registeredUsers] objectAtIndex:self.tableView.selectedRow]);
}

@end
