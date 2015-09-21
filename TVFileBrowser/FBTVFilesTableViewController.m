//
//  FBFilesTableViewController.m
//  FileBrowser
//
//  Created by Steven Troughton-Smith on 18/06/2013.
//  Copyright (c) 2013 High Caffeine Content. All rights reserved.
//

#import "FBTVFilesTableViewController.h"
#import "FBTVCustomPreviewController.h"

@implementation FBFilesTableViewController

- (id)initWithPath:(NSString *)path
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
		self.path = path;
		
		self.title = [path lastPathComponent];
		
		NSError *error = nil;
		NSArray *tempFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
		
		if (error)
		{
			NSLog(@"ERROR: %@", error);
			
			if ([path isEqualToString:@"/System"])
				tempFiles = @[@"Library"];
			
			if ([path isEqualToString:@"/Library"])
				tempFiles = @[@"Preferences"];
			
			if ([path isEqualToString:@"/var"])
				tempFiles = @[@"mobile"];
			
			if ([path isEqualToString:@"/usr"])
				tempFiles = @[@"lib", @"libexec", @"bin"];
		}
		
		self.files = [tempFiles sortedArrayWithOptions:0 usingComparator:^NSComparisonResult(NSString* file1, NSString* file2) {
			NSString *newPath1 = [self.path stringByAppendingPathComponent:file1];
			NSString *newPath2 = [self.path stringByAppendingPathComponent:file2];

			BOOL isDirectory1, isDirectory2;
			[[NSFileManager defaultManager ] fileExistsAtPath:newPath1 isDirectory:&isDirectory1];
			[[NSFileManager defaultManager ] fileExistsAtPath:newPath2 isDirectory:&isDirectory2];
			
			if (isDirectory1 && !isDirectory2)
				return NSOrderedDescending;
			
			return  NSOrderedAscending;
		}];
		
		self.view.tintColor = [UIColor lightGrayColor];
		self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
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
	
	if (isDirectory)
		cell.imageView.image = [UIImage imageNamed:@"Folder"];
	else if ([[newPath pathExtension] isEqualToString:@"png"])
		cell.imageView.image = [UIImage imageNamed:@"Picture"];
	else
		cell.imageView.image = nil;
	
	if (fileExists && isDirectory)
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;

	return cell;
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
			[self.navigationController showViewController:vc sender:self];
		}
		else if ([FBCustomPreviewController canHandleExtension:[newPath pathExtension]])
		{
			FBCustomPreviewController *preview = [[FBCustomPreviewController alloc] initWithFile:newPath];
			
			UINavigationController *detailNavController = [[UINavigationController alloc] initWithRootViewController:preview];

			[self.navigationController showDetailViewController:detailNavController sender:self];
		}
		
	}
}


@end
