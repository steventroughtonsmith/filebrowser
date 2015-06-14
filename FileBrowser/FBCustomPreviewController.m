//
//  FBCustomPreviewController.m
//  FileBrowser
//
//  Created by Steven Troughton-Smith on 29/09/2014.
//  Copyright (c) 2014 High Caffeine Content. All rights reserved.
//

#import "FBCustomPreviewController.h"

@interface FBCustomPreviewController ()

@end

@implementation FBCustomPreviewController

- (instancetype)initWithFile:(NSString *)file
{
	self = [super init];
	if (self) {
		textView = [[UITextView alloc] initWithFrame:[UIScreen mainScreen].bounds];
		textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		textView.editable = NO;
		
		self.view = textView;
		
		[self loadFile:file];
	}
	return self;
}

+(BOOL)canHandleExtension:(NSString *)fileExt
{
	return ([fileExt isEqualToString:@"plist"] || [fileExt isEqualToString:@"strings"]);
}

-(void)loadFile:(NSString *)file
{
	if ([file.pathExtension isEqualToString:@"plist"] || [file.pathExtension isEqualToString:@"strings"])
	{
		NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:file];
		[textView setText:[d description]];
	}
	
	self.title = file.lastPathComponent;
}

@end
