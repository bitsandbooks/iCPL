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
  
  // NSLog() branch details.
  NSLog(
        @"INSTANCE REPORT\n(from CPLBranchView.m : -viewDidLoad:)\n\nBranch Info:\n========================================\nLong Name:      %@\nShort Name:     %@\nAbbreviation:   %@\nStreet Address: %@\nZIP Code:       %@\nLat/Long:       (%f, %f)\nPhone:          %@\nEndeca ID:      %@\nURL:            %@\nSchedule Type:  %@\nSchedule Today: %@\nFull Schedule:\n%@\n",
        branch.fullName, branch.shortName, branch.abbrev, branch.streetAddress, branch.zipCode, branch.coords.latitude, branch.coords.longitude, branch.phone, branch.endecaBranch, branch.url, branch.scheduleType, branch.scheduleToday, branch.scheduleFull
        );
    
	// Give the view a title for the navigation bar.
	self.navigationItem.title	= @"Branch Details";
  
	// Set up the scrollView.
  self.scrollView.contentSize = self.view.frame.size;
  self.scrollView.scrollEnabled = YES;
	
	// Set text labels.
  fullNameLabel.numberOfLines = 1;
  fullNameLabel.adjustsFontSizeToFitWidth = YES;
  fullNameLabel.text = branch.fullName;
  
  streetAddressTextView.textAlignment = UITextAlignmentLeft;
  streetAddressTextView.contentInset = UIEdgeInsetsMake(-7,-7,0,0);
  streetAddressTextView.text = branch.addressString;
  
  scheduleLabel.text = branch.scheduleToday;
  
  
  // Set up imageView & phoneButton.
	[imageView setImage:branch.image];
	[imageView setUserInteractionEnabled:NO];
  [phoneButton setTitle:[NSString stringWithFormat:@"Call: %@", branch.phone]
               forState:UIControlStateNormal];
}

#pragma mark - IBActions

- (IBAction)fullScheduleButtonTapped:(id)sender {
  CPLBranchFullScheduleView *fullScheduleView =
  [[CPLBranchFullScheduleView alloc] initWithNibName:@"CPLBranchFullScheduleView"
                                              bundle:nil];
  
  fullScheduleView.fullScheduleText = branch.scheduleFull;

  [self.navigationController pushViewController:fullScheduleView animated:YES];
}

- (IBAction)phoneButtonTapped:(id)sender {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:branch.phoneURL]];
}

- (IBAction)mapButtonTapped:(id)sender {
  
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[branch mapURL]]];
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
  branch                      = nil;
  scrollView                  = nil;
  imageView                   = nil;
  fullNameLabel               = nil;
  streetAddressTextView       = nil;
  scheduleLabel               = nil;
  fullNameLabel               = nil;
  phoneButton                 = nil;
  mapButton                   = nil;
  
  [super viewDidUnload];
}

@end
