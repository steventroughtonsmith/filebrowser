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

NSString *startingPath = @"/";

@implementation FBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
	
	FBFilesTableViewController *startingVC = [[FBFilesTableViewController alloc] initWithPath:startingPath];
	
	PUICNavigationController *navController = [[PUICNavigationController alloc] initWithRootViewController:startingVC];
	
	self.window.rootViewController = navController;
	
    return YES;
}

@end
