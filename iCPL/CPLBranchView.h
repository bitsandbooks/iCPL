/**
 * Title:    CPLBranchView.h
 * Author:   Robert Dumas
 * Project:  iCPL
 * Created:  2/9/12
 * Copyright © 2012 Bits and Books. All rights reserved.
 */

#import <UIKit/UIKit.h>

@class CPLBranch;

@interface CPLBranchView : UIViewController <UIActionSheetDelegate> 

- (IBAction)actionButtonTapped:(id)sender;
- (IBAction)fullScheduleButtonTapped:(id)sender;
- (IBAction)phoneButtonTapped:(id)sender;
- (IBAction)mapButtonTapped:(id)sender;
- (IBAction)addToContactsButtonTapped:(id)sender;
- (IBAction)addToFavoriteBranchesButtonTapped:(id)sender;
- (IBAction)branchWebViewButtonTapped:(id)sender;

@property (strong, nonatomic) CPLBranch *branch;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UITextView *streetAddressTextView;
@property (strong, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (strong, nonatomic) IBOutlet UIButton *fullScheduleButton;
@property (strong, nonatomic) IBOutlet UIButton *phoneButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UIButton *addToContactsButton;
@property (strong, nonatomic) IBOutlet UIButton *addToFavoriteBranchesButton;
@property (strong, nonatomic) IBOutlet UIButton *branchWebViewButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *actionButton;

@end
