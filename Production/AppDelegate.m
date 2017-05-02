//
//  AppDelegate.m
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import "AppDelegate.h"
#import "Production-Swift.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
	{
	[[ProductionSystem new] dumpDatabase];
	[StylePalette dumpAllFontNames];
	// Insert code here to initialize your application
	}

- (void)applicationWillTerminate:(NSNotification *)aNotification 
	{
	// Insert code here to tear down your application
	}

@end
