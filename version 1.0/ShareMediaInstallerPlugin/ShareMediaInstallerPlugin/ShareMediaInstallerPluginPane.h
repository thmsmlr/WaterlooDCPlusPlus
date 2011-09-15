//
//  ShareMediaInstallerPluginPane.h
//  ShareMediaInstallerPlugin
//
//  Created by Thomas Millar on 11-09-12.
//  Copyright 2011 -. All rights reserved.
//

#import <InstallerPlugins/InstallerPlugins.h>


@interface ShareMediaInstallerPluginPane : InstallerPane <NSOpenSavePanelDelegate>
{
    NSTextField *pathField;
}

@property (nonatomic, retain) IBOutlet NSTextField *pathField;

-(void)writeToPlist;
-(IBAction)browseButtonPushed:(id)sender;
@end
