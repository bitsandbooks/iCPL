/**
 Title: 	CPLAppDelegate.m
 Author:	Rob Dumas
 Web: 		http://bitsandbooks.com
 Date:		23 January 2012
 Copyright:	Copyright © 2012 Bits and Books. All rights reserved.
 */

#import "CPLAppDelegate.h"
#import "CPLFirstView.h"
#import "CPLConstants.h"
#import "CPLBranch.h"

@implementation CPLAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize branches;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
  // Override point for customization after application launch.
  
  // Load initial view.
	CPLFirstView *firstView = [[CPLFirstView alloc] initWithNibName:@"CPLFirstView" bundle:nil];
	self.navigationController = [[[UINavigationController alloc] init] initWithRootViewController:firstView];
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:0.0];
	self.window.rootViewController = self.navigationController;  
  [self.window makeKeyAndVisible];
  
  // Load branch data into an NSArray [branches] of CPLBranch objects.
  branches = [self loadBranches];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

#pragma mark - Custom methods

- (NSArray *)loadBranches
{
  /*
   * 1. Load the plist file path into an NSString [path].
   * 2. Load the contents of [path] into a temporary NSArray [tempArray].
   * 3. Create an NSMutableArray of the same size as [tempArray].
   * 4. For each entry in [tempArray], create a CPLBranch object [newBranch] and 
   *    add it to [tempArray].
   * 5. Turn [mutable] into a new NSArray [theArray].
   * 5. Set [tempArray] and [mutable] to nil (so ARC may clean them up).
   * 6. Return [theArray].
   */
  NSString *path = [[NSBundle mainBundle] pathForResource:BRANCHLIST_FILE
                                                   ofType:@"plist"
                                              inDirectory:ASSETS_FOLDER];
  NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
  NSMutableArray *mutable = [NSMutableArray arrayWithCapacity:[tempArray count]];
  
  for (int i = 0; i < [tempArray count]; i++) {
    NSDictionary *tempDict = [NSDictionary dictionaryWithDictionary:[tempArray objectAtIndex:i]];
    CPLBranch *newBranch = [CPLBranch branchWithDictionary:tempDict];
    [mutable addObject:newBranch]; // Add the new CPLBranch object to the array.
  } // end for loop
  
  NSArray *theArray = [NSArray arrayWithArray:mutable];
  tempArray = nil;
  mutable = nil;
  
  return theArray;
}

@end
