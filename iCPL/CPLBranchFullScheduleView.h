/**
 * Title:     CPLBranchFullScheduleView.h
 * Author:    Rob Dumas
 * Web:       http://bitsandbooks.com
 * Date:      12 September 2012
 * Copyright: Copyright (c) 2012 Bits and Books. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface CPLBranchFullScheduleView : UIViewController

@property (strong, nonatomic) NSString *fullScheduleText;
@property (strong, nonatomic) IBOutlet UITextView *fullScheduleTextView;

@end
