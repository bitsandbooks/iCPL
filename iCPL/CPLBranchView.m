/**
 * Title:    CPLBranchView.m
 * Author:   Robert Dumas
 * Project:  iCPL
 * Created:  2/9/12
 * Copyright © 2012 Bits and Books. All rights reserved.
 */

#import "CPLBranchView.h"
#import "CPLConstants.h"


@interface CPLBranchView ()
- (NSString *)formatStreetAddress;
- (NSString *)formatPhoneStringAsUrl;
- (NSString *)formatPhoneStringForPhoneButton;
- (UIImage  *)loadBranchImage;
- (NSString *)fillScheduleTextArea;
@end


@implementation CPLBranchView

#pragma mark - Synthesizers

@synthesize branchDetails;
@synthesize scrollView;
@synthesize fullNameLabel;
@synthesize streetAddressTextView;
@synthesize imageView;
@synthesize scheduleTextView;
@synthesize actionButton;
@synthesize phoneButton;
@synthesize mapButton;
@synthesize addToContactsButton;
@synthesize addToFavoriteBranchesButton;

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
	self.navigationItem.title	= [branchDetails objectForKey:SHORTNAME_KEY];
	
	// Put the actionButton on the right side of the navigation bar.
	self.navigationItem.rightBarButtonItem = self.actionButton;
	
	// Set up the scrollView.
  self.scrollView.contentSize = self.view.frame.size;
  self.scrollView.scrollEnabled = YES;
	
	// Set text labels.
	fullNameLabel.text = [branchDetails objectForKey:FULLNAME_KEY];
	streetAddressTextView.text = [self formatStreetAddress];
  
	[imageView setImage:[self loadBranchImage]];
	[imageView setUserInteractionEnabled:NO];
	
	scheduleTextView.text		= [self fillScheduleTextArea];
  
  [phoneButton setTitle:[self formatPhoneStringForPhoneButton]
               forState:UIControlStateNormal];
}

#pragma mark - UIActionSheet setup

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == actionSheet.cancelButtonIndex) {
		NSLog(@"User tapped 'Cancel' Button");
		return;
	} // end if
	
	switch (buttonIndex) {
		case 0: // Calling the branch.
			NSLog(@"User tapped 'Call this branch' button");
			NSString *thePhoneUrl = [self formatPhoneStringAsUrl];
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:thePhoneUrl]];
			break;
	} // end switch
}

#pragma mark - IBActions

- (IBAction)actionButtonTapped:(id)sender
{
	NSLog(@"INSTANCE REPORT: actionButton tapped.");
  
  NSString *callThisBranchButtonTitle = [NSString stringWithFormat:@"%@%@", @"Call: ", [branchDetails objectForKey:PHONE_KEY]];
  
	UIActionSheet *branchActionSheet = [[UIActionSheet alloc]
										initWithTitle:@"What would you like to do?" 
										delegate:self 
										cancelButtonTitle:@"Cancel" 
										destructiveButtonTitle:nil 
										otherButtonTitles:callThisBranchButtonTitle, nil];
	[branchActionSheet showInView:self.view];
	[branchActionSheet release];
}

- (IBAction)phoneButtonTapped:(id)sender
{
    NSLog(@"INSTANCE REPORT: phoneButton tapped.");
    NSString *thePhoneUrl = [self formatPhoneStringAsUrl];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:thePhoneUrl]];
}

- (IBAction)mapButtonTapped:(id)sender
{
  // Do something!
}
- (IBAction)addToContactsButtonTapped:(id)sender
{
  // Do something!
}
- (IBAction)addToFavoriteBranchesButtonTapped:(id)sender
{
  // Do something!
}

#pragma mark - Custom methods

- (NSString *)formatPhoneStringAsUrl 
{
	NSString *phoneUrl;
	
	phoneUrl = [NSString stringWithFormat:@"tel://+1%@", [branchDetails objectForKey:PHONE_KEY]];
	phoneUrl = [phoneUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
	phoneUrl = [phoneUrl stringByReplacingOccurrencesOfString:@"(" withString:@""];
	phoneUrl = [phoneUrl stringByReplacingOccurrencesOfString:@")" withString:@""];
	phoneUrl = [phoneUrl stringByReplacingOccurrencesOfString:@"-" withString:@""];
	
	NSLog(@"INSTANCE REPORT: String returned from formatPhoneStringAsUrl: %@", phoneUrl);
	
	return phoneUrl;
}

- (NSString *)formatPhoneStringForPhoneButton
{
  NSString *phoneButtonText = [NSString stringWithFormat:@"Call: %@",
                               [branchDetails objectForKey:PHONE_KEY]];
    
  NSLog(@"INSTANCE REPORT: String returned from formatPhoneStringForPhoneButton: %@", phoneButtonText);
  
  return phoneButtonText;
}

- (NSString *)formatStreetAddress
{
	return [NSString stringWithFormat:@"%@\nChicago, IL %@",
          [branchDetails objectForKey:STREETADDRESS_KEY],
          [branchDetails objectForKey:ZIPCODE_KEY]];
}

- (UIImage  *)loadBranchImage
{
	NSString *theImagePath = [NSString stringWithFormat:
							  @"branchImages/%@.png", [branchDetails objectForKey:ABBREV_KEY] ];
	UIImage  *image = [UIImage imageNamed: theImagePath];
	
	if (image == nil) {
		NSLog(@"INSTANCE REPORT: branch image failed to load; using default image instead.");
		image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] 
												  pathForResource:@"NONE" 
														ofType:@"png"]];
	} else {
		NSLog(@"INSTANCE REPORT: branch image loaded successfully.");
	}
	
	return image;
}

- (NSString *)fillScheduleTextArea
{
	NSArray *openTimes = [NSArray arrayWithObjects:
                        @"1:00 p.m. — 5:00 p.m.", // 0: Sunday
                        @"9:00 a.m. — 9:00 p.m.", // 1: Monday
                        @"9:00 a.m. — 9:00 p.m.", // 2: Tuesday
                        @"9:00 a.m. — 9:00 p.m.", // 3: Wednesday
                        @"9:00 a.m. — 9:00 p.m.", // 4: Thursday
                        @"9:00 a.m. — 5:00 p.m.", // 5: Friday
                        @"9:00 a.m. — 5:00 p.m.", // 6: Saturday
                        nil];
  
  NSUInteger dayOfWeek = ([[NSCalendar currentCalendar]
                           ordinalityOfUnit:NSDayCalendarUnit
                                     inUnit:NSWeekCalendarUnit
                                    forDate:[NSDate date]] - 1);
  
  NSString *scheduleToday = [openTimes objectAtIndex:(dayOfWeek)];
  
  NSLog(@"INSTANCE REPORT: dayOfWeek = %u, scheduleToday = %@", (dayOfWeek), scheduleToday);
  
  return scheduleToday;
}

#pragma mark - Cleanup

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	[branchDetails                release], branchDetails               = nil;
	[fullNameLabel                release], fullNameLabel               = nil;
	[streetAddressTextView        release], streetAddressTextView       = nil;
	[imageView                    release], imageView                   = nil;
	[actionButton                 release], actionButton                = nil;
	[scheduleTextView             release], scheduleTextView            = nil;
  [phoneButton                  release], phoneButton                 = nil;
  [mapButton                    release], mapButton                   = nil;
  [scrollView                   release], scrollView                  = nil;
  [addToContactsButton          release], addToContactsButton         = nil;
  [addToFavoriteBranchesButton  release], addToFavoriteBranchesButton = nil;
  
	[super dealloc];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}
@end
