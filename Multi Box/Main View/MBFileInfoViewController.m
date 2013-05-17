//
//  MBFileInfoViewController.m
//  Multi Box
//
//  Created by Aaron Milam on 5/16/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBFileInfoViewController.h"
#import "MBFile.h"

@interface MBFileInfoViewController ()

@end

@implementation MBFileInfoViewController

- (void)setFile:(MBFile *)file
{
    _file = file;

    [self.filenameLabel setStringValue:file.name];
}

@end
