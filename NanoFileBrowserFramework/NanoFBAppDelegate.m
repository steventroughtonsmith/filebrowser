//
//  FBAppDelegate.m
//  FileBrowser
//
//  Created by Steven Troughton-Smith on 18/06/2013.
//  Copyright (c) 2013 High Caffeine Content. All rights reserved.
//

#import "NanoFBAppDelegate.h"
#import "NanoFBFilesTableViewController.h"

#include <sys/stat.h>

#if TARGET_OS_SIMULATOR
NSString *startingPath = @"/Applications/Xcode.app/Contents/Developer/Platforms/WatchSimulator.platform/Developer/SDKs/WatchSimulator.sdk";
#else
NSString *startingPath = @"/";
#endif

@implementation FBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	FBFilesTableViewController *startingVC = [[FBFilesTableViewController alloc] initWithPath:startingPath];
	PUICNavigationController *navController = [[PUICNavigationController alloc] initWithRootViewController:startingVC];
	self.window.rootViewController = navController;

	[self.window makeKeyAndVisible];

	return YES;
}

@end
