/**
 * Title:     CPLBranch.m
 * Author:    Rob Dumas
 * Web:       http://bitsandbooks.com
 * Date:      12 September 2012
 * Copyright: Copyright (c) 2012 Bits and Books. All rights reserved.
 */

#import "CPLBranch.h"
#import "CPLConstants.h"

@implementation CPLBranch

@synthesize fullName;
@synthesize shortName;
@synthesize abbrev;
@synthesize streetAddress;
@synthesize zipCode;
@synthesize phone;
@synthesize endecaBranch;
@synthesize coords;
@synthesize scheduleType;
@synthesize url;
@synthesize hasCyberNavigator;

#pragma mark - Class Methods

+ (CPLBranch *)branchWithDictionary:(NSDictionary *)dictionary
{
  return [[self alloc] initWithDictionary:dictionary];
}

#pragma mark - Initialization

- (id)initWithDictionary:(NSDictionary *)dictionary {
  coords.latitude     = [[dictionary objectForKey:LATITUDE_KEY]  doubleValue];
  coords.longitude    = [[dictionary objectForKey:LONGITUDE_KEY] doubleValue];
  hasCyberNavigator   = [[dictionary objectForKey:HASCYBERNAV_KEY] boolValue];
  self.fullName       =  [dictionary objectForKey:FULLNAME_KEY];
  self.shortName      =  [dictionary objectForKey:SHORTNAME_KEY];
  self.abbrev         =  [dictionary objectForKey:ABBREV_KEY];
  self.streetAddress  =  [dictionary objectForKey:STREETADDRESS_KEY];
  self.zipCode        =  [dictionary objectForKey:ZIPCODE_KEY];
  self.phone          =  [dictionary objectForKey:PHONE_KEY];
  self.endecaBranch   =  [dictionary objectForKey:ENDECA_KEY];
  self.scheduleType   =  [dictionary objectForKey:SCHEDULE_KEY];
  self.url            =  [NSURL URLWithString:[NSString stringWithFormat:
                                               @"http://www.chipublib.org/branch/details/library/%@/",
                                               [dictionary objectForKey:URL_KEY]]];
  
  return self;
}

#pragma mark - Utility methods

- (UIImage  *)image { // Returns the branch's image.
	NSString *theImagePath = [NSString stringWithFormat:@"branchImages/%@.png", self.abbrev];
	UIImage  *image = [UIImage imageNamed:theImagePath];
	
	if (image == nil) {
		NSLog(@"WARNING: branch image failed to load; using default image instead.");
		image = [UIImage imageWithContentsOfFile:
             [[NSBundle mainBundle] pathForResource:@"branchImages/NONE" ofType:@"png"]];
	}
	
	return image;
}
          
- (NSString *)phoneUrl { // Returns the branch's phone, formatted as a URL.
	NSString *urlString;
	
	urlString = [NSString stringWithFormat:@"tel://+1%@", self.phone];
	urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
	urlString = [urlString stringByReplacingOccurrencesOfString:@"(" withString:@""];
	urlString = [urlString stringByReplacingOccurrencesOfString:@")" withString:@""];
	urlString = [urlString stringByReplacingOccurrencesOfString:@"-" withString:@""];
	
	NSLog(@"INSTANCE REPORT: String returned from phoneUrl: %@", urlString);
	
	return urlString;
}

- (NSString *)scheduleToday { // Returns the branch's schedule today (as NSString).
  NSString *todayString;
  
  // Check if today is on the list of Holidays.
  // If YES, return "Closed for $holiday."
  
  NSDictionary *allSchedules =
  [[NSDictionary alloc] initWithContentsOfFile:
   [[NSBundle mainBundle] pathForResource:SERVICEHOURS_FILE
                                   ofType:@"plist"]];
  
  NSArray *branchSchedule = [allSchedules objectForKey:scheduleType];
  
  NSUInteger dayOfWeek =
  ([[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit
                                           inUnit:NSWeekCalendarUnit
                                          forDate:[NSDate date]]
   - 1); // don't forget to subtract the 1 or you'll be a day ahead!
  
  todayString = [NSString stringWithFormat:@"%@ today",
                             [branchSchedule objectAtIndex:(dayOfWeek)]];
  
  return todayString;
}

- (NSString *)scheduleFull {
  NSMutableString *fullString = [NSMutableString stringWithFormat:@""];
  
  NSString *path = [[NSBundle mainBundle] pathForResource:SERVICEHOURS_FILE
                                                   ofType:@"plist"];
  NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:path];
  NSArray *tempSchedule = [tempDict objectForKey:scheduleType];
  
  for (int i = 0; i < [tempSchedule count]; i++) {
    [fullString appendFormat:@"%@\n", [tempSchedule objectAtIndex:i]];
  }  
  
  
  return fullString;
}

@end
