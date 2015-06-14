//
//  FBFilesTableViewController.h
//  FileBrowser
//
//  Created by Steven Troughton-Smith on 18/06/2013.
//  Copyright (c) 2013 High Caffeine Content. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

#import "Pepper.h"

@interface FBFilesTableViewController : PUICTableViewController <QLPreviewControllerDataSource>

- (id)initWithPath:(NSString *)path;

@property __strong NSString *path;
@property __strong NSArray *files;
@end
