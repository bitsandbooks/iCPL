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
- (NSString *)formatStreetAddress:(NSString *)streetString zipCode:(NSString *)zipString;
- (NSString *)formatPhoneStringAsUrl:(NSString *)phoneString;
- (UIImage  *)loadBranchImage;
@end


@implementation CPLBranchView

#pragma mark - Synthesizers

@synthesize 
	branchDetails, 
	fullNameLabel, 
	streetAddressTextView,  
	phoneStringLabel, 
	imageView, 
	actionButton;

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
	
	// Set text labels.
	fullNameLabel.text			= [branchDetails objectForKey:FULLNAME_KEY];
	streetAddressTextView.text	= [self formatStreetAddress:[branchDetails objectForKey:STREETADDRESS_KEY] 
												    zipCode:[branchDetails objectForKey:ZIPCODE_KEY]];
	phoneStringLabel.text		= [branchDetails objectForKey:PHONE_KEY];
	
	[imageView setImage:[self loadBranchImage]];
	[imageView setUserInteractionEnabled:NO];
}

- (void)viewDidUnload
{
	branchDetails			= nil;
	fullNameLabel			= nil;
	streetAddressTextView	= nil;
	phoneStringLabel		= nil;
	imageView				= nil;
	actionButton			= nil;
	
    [super viewDidUnload];    
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
			NSString *thePhoneUrl = [self formatPhoneStringAsUrl:[branchDetails objectForKey:PHONE_KEY]];
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:thePhoneUrl]];
			break;
	} // end switch
}

#pragma mark - IBActions

- (IBAction)actionButtonTapped:(id)sender
{
	NSLog(@"INSTANCE REPORT: actionButton tapped.");
	UIActionSheet *branchActionSheet = [[UIActionSheet alloc]
										initWithTitle:@"What would you like to do?" 
										delegate:self 
										cancelButtonTitle:@"Cancel" 
										destructiveButtonTitle:nil 
										otherButtonTitles:@"Call this branch", nil];
	[branchActionSheet showInView:self.view];
	[branchActionSheet release];
}

#pragma mark - Custom methods

- (NSString *)formatPhoneStringAsUrl:(NSString *)phoneString 
{
	NSString *phoneUrl;
	
	phoneUrl = [NSString stringWithFormat:@"tel://+%@", phoneString];
	phoneUrl = [phoneUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
	phoneUrl = [phoneUrl stringByReplacingOccurrencesOfString:@"(" withString:@""];
	phoneUrl = [phoneUrl stringByReplacingOccurrencesOfString:@")" withString:@""];
	phoneUrl = [phoneUrl stringByReplacingOccurrencesOfString:@"-" withString:@""];
	
	NSLog(@"INSTANCE REPORT: String returned from formatPhoneStringAsUrl: %@", phoneUrl);
	
	return phoneUrl;
}

- (NSString *)formatStreetAddress:(NSString *)streetString zipCode:(NSString *)zipString
{
	return [NSString stringWithFormat:@"%@\nChicago, IL %@", streetString, zipString];
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
	[branchDetails			release];
	[fullNameLabel			release];
	[streetAddressTextView	release];
	[phoneStringLabel		release];
	[imageView				release];
	[actionButton			release];
	[super dealloc];
}

@end
