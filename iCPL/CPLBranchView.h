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
	IBOutlet UILabel *shortNameLabel;
	IBOutlet UILabel *abbrevLabel;
	IBOutlet UILabel *streetAddressLabel;
	IBOutlet UILabel *zipCodeLabel;
	IBOutlet UILabel *phoneStringLabel;
	IBOutlet UILabel *phoneUrlLabel;
	IBOutlet UILabel *scheduleTypeLabel;
	IBOutlet UILabel *endecaIdLabel;
	IBOutlet UIImageView *imageView;
}

@property (retain, nonatomic) NSDictionary *branchDetails;
@property (retain, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *shortNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *abbrevLabel;
@property (retain, nonatomic) IBOutlet UILabel *streetAddressLabel;
@property (retain, nonatomic) IBOutlet UILabel *zipCodeLabel;
@property (retain, nonatomic) IBOutlet UILabel *phoneStringLabel;
@property (retain, nonatomic) IBOutlet UILabel *phoneUrlLabel;
@property (retain, nonatomic) IBOutlet UILabel *scheduleTypeLabel;
@property (retain, nonatomic) IBOutlet UILabel *endecaIdLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end
