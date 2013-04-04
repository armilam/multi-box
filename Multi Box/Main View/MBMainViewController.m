//
//  MBMainViewController.m
//  Multi Box
//
//  Created by Aaron Milam on 4/3/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBMainViewController.h"
#import "MBAPIKey.h"

@interface MBMainViewController ()

@end

@implementation MBMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)login:(id)sender
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.box.com/api/oauth2/authorize?response_type=code&client_id=%@&state=authenticated", [MBAPIKey getClientId]]];
    [[NSWorkspace sharedWorkspace] openURL:url];
    
}

@end
