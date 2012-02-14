/**
 Title: 	CPLFirstView.m
 Author:	Rob Dumas
 Web: 		http://bitsandbooks.com
 Date:		23 January 2012
 Copyright:	Copyright © 2012 Bits and Books. All rights reserved.
 */

#import "CPLFirstView.h"
#import "CPLBranchListingView.h"

@implementation CPLFirstView

@synthesize showBranchListingButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
        // Custom initialization
		self.title = @"Home";
		
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"Home";
}

- (void)viewDidUnload
{
    [showBranchListingButton release],	showBranchListingButton	= nil;
	
	[super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES animated:animated];
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:NO animated:animated];
	[super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showBranchListingButtonTapped:(id)sender 
{
	NSLog(@"Branch Listing button tapped.");
	
	// Load new view and push it onto the stack.
	CPLBranchListingView *branchListingView = [[CPLBranchListingView alloc] initWithNibName:@"CPLBranchListingView" bundle:nil];
	[self.navigationController pushViewController:branchListingView animated:YES];
	[branchListingView release];
}

- (void)dealloc 
{
    [showBranchListingButton release];
    [super dealloc];
}
@end
