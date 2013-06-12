//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This view contains the a picker and view that we project the graph on
//

#import "StatViewContoller.h"
#import "Exercise.h"
#import "WorkoutPlan.h"

@interface StatViewContoller ()

@end

@implementation StatViewContoller

@synthesize sparkline;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
    _arrayForPlotPicker = [[NSArray alloc] initWithObjects:@"Pushup", @"Jump", @"All", nil];
    _selectedGraph = @"Pushup";

    
    
    [self.navigationController.navigationBar setTintColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"nav1.png"]]];
    self.navigationItem.title = @"Progress";
    // Set the line color
    self.sparkline.lineColor = [UIColor greenColor];
    
    // Set the line width
    self.sparkline.lineWidth = 0.5;
    
    // Enable display of data point dots
    self.sparkline.drawPoints = YES;
    
    // Enable display of area below line
    self.sparkline.drawArea = YES;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {    
    return [self.arrayForPlotPicker count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    return [self.arrayForPlotPicker objectAtIndex:row];
}

//Function called by the delegate to indicate when the picker selection is done
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSObject *temp = [[NSObject alloc] init];
    temp = [self.arrayForPlotPicker objectAtIndex:row];
    _selectedGraph = temp.description;
    
    [self plotHistory];
}

-(void) plotHistory {
    NSString * documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *characterDataFile = [documentsPath stringByAppendingPathComponent:@"WorkoutFile.dat"];
    NSMutableArray *workoutListForGraph = [NSKeyedUnarchiver unarchiveObjectWithFile:characterDataFile];
    
    WorkoutPlan *example = [[WorkoutPlan alloc] init];
    
    example = workoutListForGraph[0];

    NSMutableArray *history = [[NSMutableArray alloc] init];
    
    
    for(WorkoutPlan *workout in workoutListForGraph) {
        for(Exercise *exercise in workout.exercises){
            if([_selectedGraph isEqualToString:@"All"] ||
            ([_selectedGraph isEqualToString:@"Pushup"] && [exercise.name isEqualToString:@"Pushup"])) {
                [history addObject:[NSNumber numberWithFloat:[exercise.totalDone floatValue]]];
                
            }
            else if([_selectedGraph isEqualToString:@"Jump"] && [exercise.name isEqualToString:@"Jump"]) {
                [history addObject:[NSNumber numberWithFloat:[exercise.totalDone floatValue]]];
            }

        }
    }
    
    sparkline.data = history;

}

- (void)viewWillAppear:(BOOL)animated {
    [self plotHistory];
}

@end
