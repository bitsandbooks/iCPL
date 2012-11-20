/**
 Title: 	CPLAppDelegate.h
 Author:	Rob Dumas
 Web: 		http://bitsandbooks.com
 Date:		23 January 2012
 Copyright:	Copyright © 2012 Bits and Books. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface CPLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSArray *branches;

- (NSArray *)loadBranches;

@end
