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
	imageView;

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
    
	// Do any additional setup after loading the view from its nib.
	self.navigationItem.title	= [branchDetails objectForKey:SHORTNAME_KEY];
	
	// Set text labels.
	fullNameLabel.text			= [branchDetails objectForKey:FULLNAME_KEY];
	streetAddressTextView.text	= [self formatStreetAddress:[branchDetails objectForKey:STREETADDRESS_KEY] 
												    zipCode:[branchDetails objectForKey:ZIPCODE_KEY]];
	phoneStringLabel.text		= [branchDetails objectForKey:PHONE_KEY];
	// phoneUrlLabel.text			= [self formatPhoneStringAsUrl:[branchDetails objectForKey:PHONE_KEY]];
	
	[imageView setImage:[self loadBranchImage]];
	[imageView setUserInteractionEnabled:NO];
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
							  @"branchimages/%@.png", [branchDetails objectForKey:ABBREV_KEY] ];
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

- (void)viewDidUnload
{
	branchDetails			= nil;
	fullNameLabel			= nil;
	streetAddressTextView	= nil;
	phoneStringLabel		= nil;
	imageView				= nil;
	
    [super viewDidUnload];    
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

	[super dealloc];
}
@end
