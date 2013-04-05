//
//  MBUserListCell.h
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MBUser.h"

@interface MBUserListCell : NSView

@property (nonatomic, strong) IBOutlet NSTextField* userNameTextField;
@property (nonatomic, strong) IBOutlet NSTextField* userEmailTextField;
@property (nonatomic, strong) IBOutlet NSImageView* avatarImageView;
@property (nonatomic, strong) MBUser* user;

@end
