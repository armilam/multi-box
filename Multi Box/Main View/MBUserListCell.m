//
//  MBUserListCell.m
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBUserListCell.h"

@implementation MBUserListCell

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (void)setUser:(MBBoxUser *)user
{
    _user = user;
    self.userNameTextField.stringValue = user.name;
    if(user.loginId) self.userEmailTextField.stringValue = user.loginId;
    else self.userEmailTextField.stringValue = @"";
    [self.avatarImageView setImage:[[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:user.avatarUrlString]]];
}

@end
