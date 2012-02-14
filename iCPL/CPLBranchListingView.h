/**
 * Title:    CPLBranchListingView.h
 * Author:   Robert Dumas
 * Project:  iCPL
 * Date:     2/13/12
 * Copyright © 2012 Bits and Books. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface CPLBranchListingView : UITableViewController {
	NSArray *branchListing;
	NSMutableDictionary *sections;
}

@property (strong, nonatomic) NSArray *branchListing;
@property (strong, nonatomic) NSMutableDictionary *sections;

@end
