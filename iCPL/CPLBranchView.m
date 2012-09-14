/**
 * Title:    CPLBranchView.m
 * Author:   Robert Dumas
 * Project:  iCPL
 * Created:  2/9/12
 * Copyright © 2012 Bits and Books. All rights reserved.
 */

#import "CPLBranchView.h"
#import "CPLConstants.h"
#import "CPLBranchFullScheduleView.h"
#import "CPLBranch.h"

@implementation CPLBranchView

#pragma mark - Synthesizers

@synthesize branch;
@synthesize scrollView;
@synthesize fullNameLabel;
@synthesize streetAddressTextView;
@synthesize imageView;
@synthesize scheduleLabel;
@synthesize fullScheduleButton;
@synthesize phoneButton;
@synthesize mapButton;
@synthesize addToContactsButton;
@synthesize addToFavoriteBranchesButton;
@synthesize actionButton;

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
    
	// Give the view a title for the navigation bar.
	self.navigationItem.title	= branch.shortName;
	
	// Put the actionButton on the right side of the navigation bar.
	self.navigationItem.rightBarButtonItem = self.actionButton;
	
	// Set up the scrollView.
  self.scrollView.contentSize = self.view.frame.size;
  self.scrollView.scrollEnabled = YES;
	
	// Set text labels.
	fullNameLabel.text = branch.longName;
	streetAddressTextView.text = [NSString stringWithFormat:@"%@\nChicago, IL %@",
                                branch.streetAddress, branch.zipCode];
  scheduleLabel.text = branch.scheduleToday;
  
  
  // Set up imageView & phoneButton.
	[imageView setImage:branch.image];
	[imageView setUserInteractionEnabled:NO];
  [phoneButton setTitle:[NSString stringWithFormat:@"Call: %@", branch.phone]
               forState:UIControlStateNormal];
}

#pragma mark - UIActionSheet setup

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == actionSheet.cancelButtonIndex) return;
	
	switch (buttonIndex) {
		case 0: // Calling the branch.
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:branch.phoneUrl]];
			break;
	} // end switch
}

#pragma mark - IBActions

- (IBAction)actionButtonTapped:(id)sender {
  NSString *callBranchButtonTitle =
  [NSString stringWithFormat:@"Call: %@", branch.phone];
  
	UIActionSheet *branchActionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"What would you like to do?"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:callBranchButtonTitle, nil];
	[branchActionSheet showInView:self.view];
	[branchActionSheet release];
}

- (IBAction)fullScheduleButtonTapped:(id)sender {
  CPLBranchFullScheduleView *fullScheduleView =
  [[CPLBranchFullScheduleView alloc] initWithNibName:@"CPLBranchFullScheduleView"
                                              bundle:nil];
  
  fullScheduleView.fullScheduleText = branch.scheduleFull;

  [self.navigationController pushViewController:fullScheduleView animated:YES];
  [fullScheduleView release];
}

- (IBAction)phoneButtonTapped:(id)sender {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:branch.phoneUrl]];
}

- (IBAction)mapButtonTapped:(id)sender {
  // Do something!
}

- (IBAction)addToContactsButtonTapped:(id)sender {
  // Do something!
}

- (IBAction)addToFavoriteBranchesButtonTapped:(id)sender {
  // Do something!
}

#pragma mark - Cleanup

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
  [branch                       release], branch                      = nil;
  [scrollView                   release], scrollView                  = nil;
	[imageView                    release], imageView                   = nil;
	[fullNameLabel                release], fullNameLabel               = nil;
	[streetAddressTextView        release], streetAddressTextView       = nil;
  [scheduleLabel                release], scheduleLabel               = nil;
  [fullNameLabel                release], fullNameLabel               = nil;
  [phoneButton                  release], phoneButton                 = nil;
  [mapButton                    release], mapButton                   = nil;
  [addToContactsButton          release], addToContactsButton         = nil;
  [addToFavoriteBranchesButton  release], addToFavoriteBranchesButton = nil;
	[actionButton                 release], actionButton                = nil;
  
  [super viewDidUnload];
}

- (void)dealloc { [super dealloc]; }

@end
