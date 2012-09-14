/**
 * Title:     CPLBranch.h
 * Author:    Rob Dumas
 * Web:       http://bitsandbooks.com
 * Date:      12 September 2012
 * Copyright: Copyright (c) 2012 Bits and Books. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CPLBranch : NSObject {
  NSString  *longName,
            *shortName,
            *abbrev,
            *streetAddress,
            *zipCode,
            *phone,
            *endecaBranch,
            *scheduleType;
  CLLocationCoordinate2D coords;
}

- (id)initFromDictionary:(NSDictionary *)dictionary;
- (UIImage *)image;
- (NSString *)phoneUrl;
- (NSString *)scheduleToday;
- (NSString *)scheduleFull;

@property (nonatomic, strong) NSString *longName;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *abbrev;
@property (nonatomic, strong) NSString *streetAddress;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *endecaBranch;
@property (nonatomic, strong) NSString *scheduleType;
@property (nonatomic, assign) CLLocationCoordinate2D coords;

@end
