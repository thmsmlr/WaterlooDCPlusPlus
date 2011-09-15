//
//  UsernameInstallerPluginPane.m
//  UsernameInstallerPlugin
//
//  Created by Thomas Millar on 11-09-11.
//  Copyright 2011 -. All rights reserved.
//

#import "UsernameInstallerPluginPane.h"

@implementation UsernameInstallerPluginPane

@synthesize errorMessageField;
@synthesize userNameField;

- (NSString *)title
{
	return [[NSBundle bundleForClass:[self class]] localizedStringForKey:@"PaneTitle" value:nil table:nil];
}
-(void)didEnterPane:(InstallerSectionDirection)dir
{
    if([[userNameField stringValue] length] == 0)
    {
        [self setNextEnabled:NO];
    }
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/mv"];
    
    NSString *path = @"~/Library/Preferences/";
    path = [path stringByExpandingTildeInPath];
    
    NSArray *arguments;
    arguments = [NSArray arrayWithObjects: @"-f", @"/Applications/se.hedenfalk.shakespeer.plist", path, nil];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    

    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/rm"];
        
    arguments = [NSArray arrayWithObjects: @"-f", @"/Applications/se.hedenfalk.shakespeer.plist", nil];
    [task setArguments: arguments];
    
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    file = [pipe fileHandleForReading];
    
    [task launch];
    [task release];
}
-(BOOL)shouldExitPane:(InstallerSectionDirection)dir
{
    if([[userNameField stringValue] length] == 0)
    {
        [errorMessageField setHidden:NO];
        return NO;
    }
    else
    {
        [errorMessageField setHidden:YES];
        [self writeToPlist];
        return YES;
    }
}
-(void)controlTextDidChange:(NSNotification *)obj
{    
    if([[userNameField stringValue] length] == 0)
    {
        [self setNextEnabled:NO];
    }
    else
    {
        [self setNextEnabled:YES];
    }
    if ([[userNameField stringValue] rangeOfString:@" "].location != NSNotFound)
    {
        [errorMessageField setHidden:NO];
        [self setNextEnabled:NO];
    }
    else
    {
        [errorMessageField setHidden:YES];
        [self setNextEnabled:YES];
    }
   
}
-(void)writeToPlist
{
    NSString *filePath = @"~/Library/Preferences/se.hedenfalk.shakespeer.plist";
    filePath = [filePath stringByExpandingTildeInPath];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    
    [plistDict setValue:[userNameField stringValue] forKey:@"nick"];
    [plistDict writeToFile:filePath atomically: YES];
}

@end
