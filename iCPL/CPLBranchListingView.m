/**
 * Title:    CPLBranchListingView.m
 * Author:   Robert Dumas
 * Project:  iCPL
 * Date:     2/13/12
 * Copyright © 2012 Bits and Books. All rights reserved.
 */

#import "CPLBranchListingView.h"
#import "CPLBranchView.h"
#import "CPLConstants.h"
#import "CPLBranch.h"

@implementation CPLBranchListingView

#pragma mark - Synthesizers

@synthesize branchListing;
@synthesize sections;

#pragma mark - Initializer(s)

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  self.navigationItem.title = @"Branches";
	
	// Initialize array of branches from plist.
	NSString *path = [[NSBundle mainBundle] pathForResource:BRANCHLIST_FILE ofType:@"plist"];
	
  // Read the file into a temporary array.
  NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:path];
  
  // Now create a new array of CPLBranch objects.
  NSMutableArray *secondArray = [[NSMutableArray alloc] initWithCapacity:[tempArray count]];
  
  for (int i = 0; i < [tempArray count]; i++) {
    NSDictionary *tempDict = [[NSDictionary alloc] initWithDictionary:
                              [tempArray objectAtIndex:i]];
    CPLBranch *newBranch = [[CPLBranch alloc] initWithDictionary:tempDict];
    [secondArray addObject:newBranch]; // Add the new CPLBranch object to the array.
  } // end for loop
  
	self.branchListing = secondArray;
	
	// Create sections.
	self.sections = [[NSMutableDictionary alloc] init];
	BOOL found; 
	
	// Loop through the branches and create the keys.
  for (CPLBranch *b in self.branchListing) {
    NSString *c = [b.shortName substringToIndex:1];
    found = NO;
    
    for (NSString *str in [self.sections allKeys]) {
      if ([str isEqualToString:c]) {
        found = YES;
      }
    }
		
		if (!found) {
      [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
		}
  } // end for loop
	
	// Loop through again and sort the branches into their respective keys.
	for (CPLBranch *b in self.branchListing) {
		[[self.sections objectForKey:[b.shortName substringToIndex:1]] addObject:b];
	}
	
	// Sort each section array.
	for (NSString *key in [self.sections allKeys]) {
		[[self.sections objectForKey:key] sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:SHORTNAME_KEY ascending:YES]]]; // Huh?
	}
	
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[self.sections allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
	[v setBackgroundColor:[UIColor colorWithRed:0.0 green:0.3 blue:0.0 alpha:0.7]];
	
	UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 18)];
	l.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
	l.textColor = [UIColor whiteColor];
	l.font = [UIFont boldSystemFontOfSize:20];
	l.backgroundColor = [UIColor clearColor];
	
	[v addSubview:l];
	
	return v;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:CellIdentifier];
  }
	
  
  CPLBranch *b = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    // Configure the cell...
	cell.textLabel.text = b.shortName;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  CPLBranchView *branchView = [[CPLBranchView alloc] initWithNibName:@"CPLBranchView" bundle:nil];
  
	branchView.branch = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	
	// Push the selected object onto the stack.
	[self.navigationController pushViewController:branchView animated:YES];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	branchListing = nil;
	sections = nil;
}

@end
