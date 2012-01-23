/**
 Title: 	CPLFirstView.m
 Author:	Rob Dumas
 Web: 		http://bitsandbooks.com
 Date:		23 January 2012
 Copyright:	Copyright © 2012 Bits and Books. All rights reserved.
 */

#import "CPLFirstView.h"

@implementation CPLFirstView

@synthesize showOneBranchButton;
@synthesize showBranchListingButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [showOneBranchButton release], showOneBranchButton = nil;
    [showBranchListingButton release], showBranchListingButton = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showOneBranchButtonTapped:(id)sender {
}

- (IBAction)showBranchListingButtonTapped:(id)sender {
}
- (void)dealloc {
    [showOneBranchButton release];
    [showBranchListingButton release];
    [super dealloc];
}
@end
