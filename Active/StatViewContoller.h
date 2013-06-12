//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This view contains the a picker and view that we project the graph on
//

#import <UIKit/UIKit.h>
#import "CKSparkline.h"

@interface StatViewContoller : UIViewController
{
    CKSparkline *sparkline;
    CKSparkline *sparkline2;
}

@property (nonatomic, retain) IBOutlet CKSparkline *sparkline;
@property (weak, nonatomic) IBOutlet UIPickerView *plotPicker;
@property (strong, nonatomic) NSArray *arrayForPlotPicker;
@property (strong, nonatomic) NSString *selectedGraph;
@end

