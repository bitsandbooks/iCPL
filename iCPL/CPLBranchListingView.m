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
	NSString *path = [[NSBundle mainBundle] pathForResource:BRANCHLIST_KEY ofType:@"plist"];
	NSLog(@"%@", path);
	NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:path];
	self.branchListing = tempArray;
	[tempArray release];
	
	// Create sections.
	self.sections = [[NSMutableDictionary alloc] init];
	BOOL found; 
	
	// Loop through the branches and create the keys.
    for (NSDictionary *branch in self.branchListing) {
        NSString *c = [[branch objectForKey:SHORTNAME_KEY] substringToIndex:1];
        found = NO;
        
        for (NSString *str in [self.sections allKeys]) {
            if ([str isEqualToString:c]) {
                found = YES;
            }
        }
		
		if (!found) {
			[self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
		}
    }
	
	// Loop through again and sort the branches into their respective keys.
	for (NSDictionary *branch in self.branchListing) {
		[[self.sections objectForKey:[[branch objectForKey:SHORTNAME_KEY] substringToIndex:1]] addObject:branch];
	}
	
	// Sort each section array.
	for (NSString *key in [self.sections allKeys]) {
		[[self.sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:SHORTNAME_KEY ascending:YES]]];
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
	UIView *v = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
	[v setBackgroundColor:[UIColor colorWithRed:0.0 green:0.3 blue:0.0 alpha:0.7]];
	
	UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 18)] autorelease];
	l.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
	l.textColor = [UIColor whiteColor];
	l.font = [UIFont boldSystemFontOfSize:20];
	l.backgroundColor = [UIColor clearColor];
	
	[v addSubview:l];
	
	return v;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSDictionary *branchDictionary = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    // Configure the cell...
	cell.textLabel.text = [branchDictionary objectForKey:SHORTNAME_KEY];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPLBranchView *branchView = [[CPLBranchView alloc] initWithNibName:@"CPLBranchView" bundle:nil];
	branchView.branchDetails = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	NSLog(@"Branch passed to *branchView: %@", [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]);
	
	// Push the selected object onto the stack.
	[self.navigationController pushViewController:branchView animated:YES];
	[branchView release];
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


- (void)dealloc
{
	[branchListing release];
	[sections release];
	[super dealloc];
}

@end
