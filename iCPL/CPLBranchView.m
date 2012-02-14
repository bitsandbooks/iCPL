/**
 * Title:    CPLBranchView.m
 * Author:   Robert Dumas
 * Project:  iCPL
 * Created:  2/9/12
 * Copyright © 2012 Bits and Books. All rights reserved.
 */

#import "CPLBranchView.h"
#import "CPLConstants.h"

@implementation CPLBranchView

#pragma mark - Synthesizers

@synthesize 
	branchDetails, 
	fullNameLabel, 
	shortNameLabel, 
	abbrevLabel, 
	streetAddressLabel, 
	zipCodeLabel, 
	phoneStringLabel, 
	phoneUrlLabel, 
	scheduleTypeLabel, 
	endecaIdLabel, 
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
	shortNameLabel.text			= [branchDetails objectForKey:SHORTNAME_KEY];
	abbrevLabel.text			= [branchDetails objectForKey:ABBREV_KEY];
	streetAddressLabel.text		= [branchDetails objectForKey:STREETADDRESS_KEY];
	zipCodeLabel.text			= [branchDetails objectForKey:ZIPCODE_KEY];
	phoneStringLabel.text		= [branchDetails objectForKey:PHONE_KEY];
	phoneUrlLabel.text			= [branchDetails objectForKey:PHONE_KEY];
	scheduleTypeLabel.text		= [branchDetails objectForKey:SCHEDULE_KEY];
	endecaIdLabel.text			= [branchDetails objectForKey:ENDECA_KEY];
	
	// Load the branch's image into the UIImageView.
	NSString *theImagePath	= [NSString 
							   stringWithFormat:@"branchimages/%@.png", 
							   [branchDetails objectForKey:ABBREV_KEY] ];
	UIImage  *theImage		= [UIImage imageNamed:theImagePath];	
	
	// Test to make sure the image loaded. If it didn't, use NONE.png instead.
	if (theImage == nil) { // theImage failed to load (default state)
		NSLog(@"UIImage *theImage failed to load.");
		theImage = [UIImage imageWithContentsOfFile:
					[[NSBundle mainBundle] pathForResource:@"NONE" 
													ofType:@"png"]];
	} else {
		NSLog(@"UIImage *theImage loaded successfully");
	}
	
	[imageView setImage:theImage];
	[imageView setUserInteractionEnabled:NO];
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
	branchDetails		= nil;
	fullNameLabel		= nil;
	shortNameLabel		= nil;
	abbrevLabel			= nil;
	streetAddressLabel	= nil;
	zipCodeLabel		= nil;
	phoneStringLabel	= nil;
	phoneUrlLabel		= nil;
	scheduleTypeLabel	= nil;
	endecaIdLabel		= nil;
	imageView			= nil;
	
    [super viewDidUnload];    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	[branchDetails		release];
	[fullNameLabel		release];
	[shortNameLabel		release];
	[abbrevLabel		release];
	[streetAddressLabel	release];
	[zipCodeLabel		release];
	[phoneStringLabel	release];
	[phoneUrlLabel		release];
	[scheduleTypeLabel	release];
	[endecaIdLabel		release];
	[imageView			release];

	[super dealloc];
}
@end
