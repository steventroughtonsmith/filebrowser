//
//  FBAppDelegate.m
//  FileBrowser
//
//  Created by Steven Troughton-Smith on 18/06/2013.
//  Copyright (c) 2013 High Caffeine Content. All rights reserved.
//

#import "FBAppDelegate.h"

#if TARGET!=TVFileBrowser
#import "FBFilesTableViewController.h"
#else
#import "FBTVFilesTableViewController.h"
#endif

#include <sys/stat.h>

#if TARGET_OS_SIMULATOR
#if !TARGET_OS_TV
NSString *startingPath = @"/Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk";
#else
NSString *startingPath = @"/Applications/Xcode-beta.app/Contents/Developer/Platforms/AppleTVSimulator.platform/Developer/SDKs/AppleTVSimulator.sdk";
#endif

#else
NSString *startingPath = @"/";
#endif
@implementation FBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone || UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		self.window.backgroundColor = [UIColor whiteColor];
	
    [self.window makeKeyAndVisible];
	
	FBFilesTableViewController *startingVC = [[FBFilesTableViewController alloc] initWithPath:startingPath];
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:startingVC];
	UINavigationController *detailNavController = [[UINavigationController alloc] init];


	UISplitViewController *splitController = [[UISplitViewController alloc] init];
	splitController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
	
	
	splitController.viewControllers = @[navController, detailNavController];

	
	if (UI_USER_INTERFACE_IDIOM() == 3)
	{
//		UINavigationController *outerNavController = [[UINavigationController alloc] initWithRootViewController:splitController];

		
		splitController.preferredPrimaryColumnWidthFraction = 0.4;
		self.window.rootViewController = splitController;


	}
	else
		self.window.rootViewController = splitController;
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
