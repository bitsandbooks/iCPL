/**
 * Title:    CPLBranchListingView.h
 * Author:   Robert Dumas
 * Project:  iCPL
 * Date:     2/13/12
 * Copyright © 2012 Bits and Books. All rights reserved.
 */

#import <UIKit/UIKit.h>

@class CPLBranch;

@interface CPLBranchListingView : UITableViewController

- (NSDictionary *)sectionswithArray:(NSArray *)array;

@property (strong, nonatomic) NSDictionary *sections;

@end
