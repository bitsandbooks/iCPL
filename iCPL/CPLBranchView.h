/**
 * Title:    CPLBranchView.h
 * Author:   Robert Dumas
 * Project:  iCPL
 * Created:  2/9/12
 * Copyright © 2012 Bits and Books. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface CPLBranchView : UIViewController <UIActionSheetDelegate> {
	NSDictionary *branchDetails;
  IBOutlet UIScrollView *scrollView;
  IBOutlet UIImageView *imageView;
	IBOutlet UILabel *fullNameLabel;
	IBOutlet UITextView *streetAddressTextView;
  IBOutlet UILabel *scheduleLabel;
  IBOutlet UIButton *fullScheduleButton;
  IBOutlet UIButton *phoneButton;
  IBOutlet UIButton *mapButton;
  IBOutlet UIButton *addToContactsButton;
  IBOutlet UIButton *addToFavoriteBranchesButton;
	IBOutlet UIBarButtonItem *actionButton;
}

- (IBAction)actionButtonTapped:(id)sender;
- (IBAction)fullScheduleButtonTapped:(id)sender;
- (IBAction)phoneButtonTapped:(id)sender;
- (IBAction)mapButtonTapped:(id)sender;
- (IBAction)addToContactsButtonTapped:(id)sender;
- (IBAction)addToFavoriteBranchesButtonTapped:(id)sender;

@property (retain, nonatomic) NSDictionary *branchDetails;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (retain, nonatomic) IBOutlet UITextView *streetAddressTextView;
@property (retain, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (retain, nonatomic) IBOutlet UIButton *fullScheduleButton;
@property (retain, nonatomic) IBOutlet UIButton *phoneButton;
@property (retain, nonatomic) IBOutlet UIButton *mapButton;
@property (retain, nonatomic) IBOutlet UIButton *addToContactsButton;
@property (retain, nonatomic) IBOutlet UIButton *addToFavoriteBranchesButton;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *actionButton;

@end
