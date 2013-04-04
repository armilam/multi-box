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

- (void)setUser:(MBUser *)user
{
    _user = user;
    self.userNameTextField.stringValue = user.accessToken;
}

@end
