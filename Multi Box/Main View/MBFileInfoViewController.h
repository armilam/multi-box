//
//  MBFileInfoViewController.h
//  Multi Box
//
//  Created by Aaron Milam on 5/16/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MBFile;

@interface MBFileInfoViewController : NSViewController

@property (nonatomic, strong) IBOutlet NSTextField* filenameLabel;

@property (nonatomic, strong) MBFile* file;

@end
