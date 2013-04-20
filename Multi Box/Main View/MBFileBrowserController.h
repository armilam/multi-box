//
//  MBFileBrowserController.h
//  Multi Box
//
//  Created by Aaron Milam on 4/10/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBUser.h"

@interface MBFileBrowserController : NSViewController <NSBrowserDelegate>

@property (nonatomic, strong) IBOutlet NSBrowser* fileBrowser;

@property (nonatomic, strong) MBUser* user;

@end
