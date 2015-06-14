//
//  FBFrameworkMain.m
//  FileBrowser
//
//  Created by Steven Troughton-Smith on 13/06/2015.
//  Copyright © 2015 High Caffeine Content. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import <runtime.h>

@import ObjectiveC.runtime;

void __attribute__((constructor)) injected_main()
{

	@autoreleasepool {
		UIApplicationMain(0, nil, @"PUICApplication", @"FBAppDelegate");
	}
}