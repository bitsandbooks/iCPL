/**
 * Title:     CPLBranch.h
 * Author:    Rob Dumas
 * Web:       http://bitsandbooks.com
 * Date:      12 September 2012
 * Copyright: Copyright (c) 2012 Bits and Books. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CPLBranch : NSObject

+ (CPLBranch *)branchWithDictionary:(NSDictionary *)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (UIImage *)image;
- (NSString *)phoneUrl;
- (NSString *)scheduleToday;
- (NSString *)scheduleFull;
- (NSString *)mapURL;

@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *shortName;
@property (strong, nonatomic) NSString *abbrev;
@property (strong, nonatomic) NSString *streetAddress;
@property (strong, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *endecaBranch;
@property (strong, nonatomic) NSString *scheduleType;
@property (strong, nonatomic) NSURL *url;
@property (assign, nonatomic) BOOL hasCyberNavigator;
@property (assign, nonatomic) CLLocationCoordinate2D coords;

@end
