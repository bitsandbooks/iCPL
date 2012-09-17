/**
 * Title:     CPLBranchFullScheduleView.m
 * Author:    Rob Dumas
 * Web:       http://bitsandbooks.com
 * Date:      12 September 2012
 * Copyright: Copyright (c) 2012 Bits and Books. All rights reserved.
 */

#import "CPLBranchFullScheduleView.h"

@implementation CPLBranchFullScheduleView

@synthesize fullScheduleText;
@synthesize fullScheduleTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationItem.title	= @"Full Schedule";
  fullScheduleTextView.text = fullScheduleText;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload
{
  fullScheduleText     = nil;
  fullScheduleTextView = nil;
  
  [super viewDidUnload];
}

@end
