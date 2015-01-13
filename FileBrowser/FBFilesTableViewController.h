//
//  FBFilesTableViewController.h
//  FileBrowser
//
//  Created by Steven Troughton-Smith on 18/06/2013.
//  Copyright (c) 2013 High Caffeine Content. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface FBFilesTableViewController : UITableViewController <QLPreviewControllerDataSource>

- (id)initWithPath:(NSString *)path;

@property NSString *path;
@property NSArray *files;
@end
