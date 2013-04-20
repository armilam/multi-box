//
//  MBFileBrowserController.m
//  Multi Box
//
//  Created by Aaron Milam on 4/10/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBFileBrowserController.h"
#import "MBFolder.h"
#import "MBFile.h"
#import "MBUser+GetInfo.h"

@interface MBFileBrowserController()

@end

@implementation MBFileBrowserController

- (void)setUser:(MBUser *)user
{
    _user = user;
    
    //TODO: Spinner while we wait?
    [user.rootFolder refreshContents:^(MBFolder* folder)
    {
        [self.fileBrowser loadColumnZero];
         //TODO: Clear all other columns
    }];
}

- (id)rootItemForBrowser:(NSBrowser*)browser
{
    return self.user.rootFolder;
}

- (NSInteger)browser:(NSBrowser*)browser numberOfChildrenOfItem:(id)item
{
    if([item isKindOfClass:[MBFolder class]])
    {
        MBFolder* folderItem = (MBFolder*)item;
        return folderItem.itemCollection.count;
    }
    else
    {
        return 0;
    }
}

- (id)browser:(NSBrowser*)browser child:(NSInteger)index ofItem:(id)item
{
    // Assumes the item is an MBFolder object
    MBFolder* folderItem = (MBFolder*)item;
    return [folderItem.itemCollection objectAtIndex:index];
}

- (BOOL)browser:(NSBrowser*)browser isLeafItem:(id)item
{
    // It's a leaf item if and only if the item is an MBFile object
    return [item isKindOfClass:[MBFile class]];
}

- (id)browser:(NSBrowser*)browser objectValueForItem:(id)item
{
    if([item isKindOfClass:[MBFolder class]])
    {
        MBFolder* folderItem = (MBFolder*)item;
        return folderItem.name;
    }
    else if([item isKindOfClass:[MBFile class]])
    {
        MBFile* fileItem = (MBFile*)item;
        return fileItem.name;
    }
    
    return @"INVALID TYPE";
}

@end
