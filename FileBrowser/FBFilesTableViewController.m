//
//  FBFilesTableViewController.m
//  FileBrowser
//
//  Created by Steven Troughton-Smith on 18/06/2013.
//  Copyright (c) 2013 High Caffeine Content. All rights reserved.
//

#import "FBFilesTableViewController.h"

@interface FBFilesTableViewController ()

@end

@implementation FBFilesTableViewController

- (id)initWithPath:(NSString *)path
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
		self.path = path;
		
		self.title = [path lastPathComponent];
		
		NSError *error = nil;
		self.files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
		
		if (error)
		{
			NSLog(@"ERROR: %@", error);
			
			if ([path isEqualToString:@"/System"])
				self.files = @[@"Library"];
			
			if ([path isEqualToString:@"/Library"])
				self.files = @[@"Preferences"];
			
			
			if ([path isEqualToString:@"/var"])
				self.files = @[@"mobile"];
			
		}
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	
	NSString *newPath = [self.path stringByAppendingPathComponent:self.files[indexPath.row]];
	
	BOOL isDirectory;
	BOOL fileExists = [[NSFileManager defaultManager ] fileExistsAtPath:newPath isDirectory:&isDirectory];
	
    cell.textLabel.text = self.files[indexPath.row];
	
	if (fileExists && !isDirectory)
		cell.accessoryType = UITableViewCellAccessoryDetailButton;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	NSString *newPath = [self.path stringByAppendingPathComponent:self.files[indexPath.row]];
	
	NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingPathComponent:newPath.lastPathComponent];
	
	NSError *error = nil;
	
	[[NSFileManager defaultManager] copyItemAtPath:newPath toPath:tmpPath error:&error];
	
	if (error)
		NSLog(@"ERROR: %@", error);
	
	UIActivityViewController *shareActivity = [[UIActivityViewController alloc] initWithActivityItems:@[[NSURL fileURLWithPath:tmpPath]] applicationActivities:nil];
	
	shareActivity.completionHandler = ^(NSString *activityType, BOOL completed){
		[[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
		
	};
	
	[self.navigationController presentViewController:shareActivity animated:YES completion:^{
		
	}];
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *newPath = [self.path stringByAppendingPathComponent:self.files[indexPath.row]];
	
	
	BOOL isDirectory;
	BOOL fileExists = [[NSFileManager defaultManager ] fileExistsAtPath:newPath isDirectory:&isDirectory];
	
	
	if (fileExists)
	{
		if (isDirectory)
		{
			FBFilesTableViewController *vc = [[FBFilesTableViewController alloc] initWithPath:newPath];
			[self.navigationController pushViewController:vc animated:YES];
		}
		else
		{
			
			QLPreviewController *preview = [[QLPreviewController alloc] init];
			preview.dataSource = self;
			
			[self.navigationController pushViewController:preview animated:YES];
			
		}
	}
}

#pragma mark - QuickLook

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item {
	
    return YES;
}

- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller {
	
    return 1;
}

- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index {
	
	NSString *newPath = [self.path stringByAppendingPathComponent:self.files[self.tableView.indexPathForSelectedRow.row]];
	
    return [NSURL fileURLWithPath:newPath];
}



@end
