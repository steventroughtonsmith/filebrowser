//
//  Pepper.h
//  WatchNativeHack
//
//  Created by Steven Troughton-Smith on 13/06/2015.
//  Copyright © 2015 High Caffeine Content. All rights reserved.
//

#ifndef Pepper_h
#define Pepper_h

#import <UIKit/UIKit.h>

@interface PUICNavigationController : UINavigationController

@end

@interface PUICTableViewController : UITableViewController

@end

@interface PUICTableViewCell : UITableViewCell

@end

@interface PUICActionController : NSObject
- (id)initWithActionItems:(id)arg1;
- (void)dismiss;
- (void)present;
+ (void)_setActionControllerOrbGestureEnabled:(_Bool)arg1 inWindow:(id)arg2;

@end

@interface PUICSideBySideButtons : UIView
@property(copy, nonatomic) NSString *rightTitle;
@property(copy, nonatomic) NSString *leftTitle;
@end

@interface PUICActionItem : NSObject
+ (id)actionItemWithImage:(id)arg1 actionItems:(id)arg2;
+ (id)actionItemWithImage:(id)arg1 target:(id)arg2 action:(SEL)arg3;
+ (id)actionItemWithTitle:(id)arg1 actionGroup:(id)arg2;
+ (id)actionItemWithTitle:(id)arg1 actionItems:(id)arg2;
+ (id)actionItemWithImage:(id)arg1 title:(id)arg2 actionGroup:(id)arg3;
+ (id)actionItemWithImage:(id)arg1 title:(id)arg2 actionItems:(id)arg3;
+ (id)actionItemWithTitle:(id)arg1 target:(id)arg2 action:(SEL)arg3;
+ (id)actionItemWithImage:(id)arg1 title:(id)arg2 target:(id)arg3 action:(SEL)arg4;
@property(nonatomic) long long actionItemType;
@end

@interface PUICSideBySideButtonsAlertSheetController : PUICActionController
+ (id)sideBySideButtonsAlertWithTitle:(NSString *)title message:(NSString *)message buttons:(PUICSideBySideButtons *)buttons;
@end

@interface ORBTapGestureRecognizer : UIGestureRecognizer
- (id)initWithTarget:(id)arg1 action:(SEL)arg2;
@property BOOL hasLatched;
@end

#endif /* Pepper_h */
