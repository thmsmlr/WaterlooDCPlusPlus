//
//  ShareMediaInstallerPluginPane.m
//  ShareMediaInstallerPlugin
//
//  Created by Thomas Millar on 11-09-12.
//  Copyright 2011 -. All rights reserved.
//

#import "ShareMediaInstallerPluginPane.h"

@implementation ShareMediaInstallerPluginPane
@synthesize pathField;

- (NSString *)title
{
	return [[NSBundle bundleForClass:[self class]] localizedStringForKey:@"PaneTitle" value:nil table:nil];
}

-(BOOL)shouldExitPane:(InstallerSectionDirection)dir
{
    [self writeToPlist];
    return YES;
}
-(IBAction)browseButtonPushed:(id)sender
{
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:NO];
    
    // Multiple files not allowed
    [openDlg setAllowsMultipleSelection:NO];
    
    // Can't select a directory
    [openDlg setCanChooseDirectories:YES];
    [openDlg setDelegate:self];
    
    // Display the dialog. If the OK button was pressed,
    // process the files.
    
    [openDlg beginSheetModalForWindow:[pathField window]  completionHandler:^(NSInteger result) {
		if (NSFileHandlingPanelOKButton == result)
		{
			for (NSURL *URL in [openDlg URLs])
			{
                [pathField setStringValue:[URL path]];
			}
		}
	}];
}
-(void)writeToPlist
{
    NSString *filePath = @"~/Library/Preferences/se.hedenfalk.shakespeer.plist";
    filePath = [filePath stringByExpandingTildeInPath];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *temp = [[NSArray alloc] initWithObjects:[pathField stringValue], nil];
    [plistDict setValue:temp forKey:@"sharedPaths"];
    [plistDict writeToFile:filePath atomically: YES];
}
@end
