/**
 * Title:    CPLBranchView.h
 * Author:   Robert Dumas
 * Project:  iCPL
 * Created:  2/9/12
 * Copyright © 2012 Bits and Books. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface CPLBranchView : UIViewController {
	NSDictionary *branchDetails;
	IBOutlet UILabel *fullNameLabel;
	IBOutlet UITextView *streetAddressTextView;
	IBOutlet UILabel *phoneStringLabel;
	IBOutlet UIImageView *imageView;
}

@property (retain, nonatomic) NSDictionary *branchDetails;
@property (retain, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (retain, nonatomic) IBOutlet UITextView *streetAddressTextView;
@property (retain, nonatomic) IBOutlet UILabel *phoneStringLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end
