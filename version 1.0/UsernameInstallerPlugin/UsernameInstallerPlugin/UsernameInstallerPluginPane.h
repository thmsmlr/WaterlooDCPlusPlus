//
//  UsernameInstallerPluginPane.h
//  UsernameInstallerPlugin
//
//  Created by Thomas Millar on 11-09-11.
//  Copyright 2011 -. All rights reserved.
//

#import <InstallerPlugins/InstallerPlugins.h>

@interface UsernameInstallerPluginPane : InstallerPane <NSTextFieldDelegate>
{
    NSTextField *userNameField;
    NSTextField *errorMessageField;
}

@property (nonatomic, retain) IBOutlet NSTextField *userNameField;
@property (nonatomic, retain) IBOutlet NSTextField *errorMessageField;

-(void)writeToPlist;
@end
