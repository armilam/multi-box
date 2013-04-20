//
//  MBFileBrowserController.m
//  Multi Box
//
//  Created by Aaron Milam on 4/10/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBFileBrowserController.h"
#import "MBFolder.h"
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
         [self.fileBrowser reloadColumn:0];
         //TODO: Clear all other columns
    }];
}

- (NSInteger)browser:(NSBrowser *)sender numberOfRowsInColumn:(NSInteger)column
{
    if(column == 0)
    {
        return self.user.rootFolder.itemCollection.count;
    }
    
    return 0;
}

@end
