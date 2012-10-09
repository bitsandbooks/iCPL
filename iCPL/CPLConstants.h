/**
 Title:     CPLConstants.h
 Author:    Rob Dumas
 Web:       http://bitsandbooks.com
 Date:      23 January 2012
 Copyright: Copyright © 2012 Bits and Books. All rights reserved.
 */

#ifndef iCPL_CPLConstants_h
#define iCPL_CPLConstants_h

// App-Wide Constants
#define METERS_PER_MILE		1609.344

// File constants
#define BRANCHLIST_FILE		@"BranchList"
#define SERVICEHOURS_FILE @"ServiceHours"

// CPLBranch field constants. Correspond to keys in BranchList.plist.
#define FULLNAME_KEY      @"longName"
#define SHORTNAME_KEY     @"shortName"
#define STREETADDRESS_KEY	@"streetAddress"
#define ZIPCODE_KEY       @"zipCode"
#define PHONE_KEY         @"phone"
#define ABBREV_KEY        @"abbrev"
#define SCHEDULE_KEY      @"scheduleType"
#define ENDECA_KEY        @"endecaBranch"
#define URL_KEY           @"url"
#define LATITUDE_KEY      @"geoLat"
#define LONGITUDE_KEY     @"geoLong"


#endif
