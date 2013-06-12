//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This view provides the picker that can set the exervises and thier counts
//

#import <UIKit/UIKit.h>

@class Exercise;
@class AvailableWorkouts;

#define kFillingComponent 0
#define kBreadComponent   1

typedef void(^ActivityUpdateHandler)(void);

@interface ActivitySelectionDetailViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>

@property (readwrite, nonatomic, copy) ActivityUpdateHandler updateHandler;
@property (readwrite, nonatomic, strong) Exercise * exercise;
@property (strong, nonatomic) IBOutlet UIPickerView *doublePicker;
@property (strong, nonatomic) NSArray *exerciseNames;
@property (strong, nonatomic) NSMutableArray *targetNumbersPicker;

-(IBAction)buttonPressed;
@end