/**
 Title: 	CPLFirstView.h
 Author:	Rob Dumas
 Web: 		http://bitsandbooks.com
 Date:		23 January 2012
 Copyright:	Copyright © 2012 Bits and Books. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface CPLFirstView : UIViewController {
	IBOutlet UIButton *showBranchListingButton;
}

@property (strong, nonatomic) IBOutlet UIButton *showBranchListingButton;

- (IBAction)showBranchListingButtonTapped:(id)sender;

@end
