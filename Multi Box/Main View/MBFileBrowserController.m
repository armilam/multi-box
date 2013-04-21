//
//  MBFileBrowserController.m
//  Multi Box
//
//  Created by Aaron Milam on 4/10/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBFileBrowserController.h"
#import "MBBoxFolder.h"
#import "MBBoxFile.h"
#import "MBBoxUser+GetInfo.h"

@interface MBFileBrowserController()

@end

@implementation MBFileBrowserController

- (void)setUser:(MBBoxUser *)user
{
    _user = user;
    
    //TODO: Spinner while we wait?
    [user.rootFolder refreshContents:^(MBBoxFolder* folder)
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
    if([item isKindOfClass:[MBBoxFolder class]])
    {
        MBBoxFolder* folderItem = (MBBoxFolder*)item;
        return folderItem.children.count;
    }
    else
    {
        return 0;
    }
}

- (id)browser:(NSBrowser*)browser child:(NSInteger)index ofItem:(id)item
{
    // Assumes the item is an MBBoxFolder object
    MBBoxFolder* folderItem = (MBBoxFolder*)item;
    return [folderItem.children objectAtIndex:index];
}

- (BOOL)browser:(NSBrowser*)browser isLeafItem:(id)item
{
    // It's a leaf item if and only if the item is an MBBoxFile object
    return [item isKindOfClass:[MBBoxFile class]];
}

- (id)browser:(NSBrowser*)browser objectValueForItem:(id)item
{
    if([item isKindOfClass:[MBBoxFolder class]])
    {
        MBBoxFolder* folderItem = (MBBoxFolder*)item;
        return folderItem.name;
    }
    else if([item isKindOfClass:[MBBoxFile class]])
    {
        MBBoxFile* fileItem = (MBBoxFile*)item;
        return fileItem.name;
    }
    
    return @"INVALID TYPE";
}

- (NSIndexSet *)browser:(NSBrowser *)browser selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes inColumn:(NSInteger)column
{
    NSInteger row = [proposedSelectionIndexes firstIndex];
    id selectedItem = [browser itemAtRow:row inColumn:column];
    
    if([selectedItem isKindOfClass:[MBBoxFolder class]])
    {
        MBBoxFolder* selectedFolder = selectedItem;
        //TODO: Expand folder
        [selectedFolder refreshContents:^(MBBoxFolder* refreshedFolder)
        {
            [browser reloadColumn:column+1];
        }];
    }
    else if([selectedItem isKindOfClass:[MBBoxFile class]])
    {
        MBBoxFile* selectedFile = selectedItem;
        //TODO: Show leaf details
    }
    
    return proposedSelectionIndexes;
}

@end
