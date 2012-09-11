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
	IBOutlet UILabel *fullNameLabel;
	IBOutlet UITextView *streetAddressTextView;
	IBOutlet UIImageView *imageView;
	IBOutlet UITextView *scheduleTextView;
	IBOutlet UIBarButtonItem *actionButton;
  IBOutlet UIButton *phoneButton;
  IBOutlet UIButton *mapButton;
  IBOutlet UIButton *addToContactsButton;
  IBOutlet UIButton *addToFavoriteBranchesButton;
}

- (IBAction)actionButtonTapped:(id)sender;
- (IBAction)phoneButtonTapped:(id)sender;
- (IBAction)mapButtonTapped:(id)sender;
- (IBAction)addToContactsButtonTapped:(id)sender;
- (IBAction)addToFavoriteBranchesButtonTapped:(id)sender;

@property (retain, nonatomic) NSDictionary *branchDetails;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (retain, nonatomic) IBOutlet UITextView *streetAddressTextView;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UITextView *scheduleTextView;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *actionButton;
@property (retain, nonatomic) IBOutlet UIButton *phoneButton;
@property (retain, nonatomic) IBOutlet UIButton *mapButton;
@property (retain, nonatomic) IBOutlet UIButton *addToContactsButton;
@property (retain, nonatomic) IBOutlet UIButton *addToFavoriteBranchesButton;

@end
