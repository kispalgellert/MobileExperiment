//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This class provides the mail functionality of our app, it is where we analyze accelerometer
//  readings, and display feedback for the exercises done
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@class ActivitySelectionContainerViewController;

@class WorkoutPlan;

@interface ActivitySelection : UITableViewController

@property (strong,nonatomic) CMMotionManager *motionManager;
@property NSMutableArray * objects;             //Keeps tracks of object (Exercises) in this current view
@property NSMutableArray * workoutListInAct;    //Used to keep track of workouts of the previous
@property bool startPressedBool;                //boolean triggered when start is pressed
@property NSMutableArray *values;               //Array that keeps track of the data we get from accelerometer
@property NSMutableArray *pushUp;               //Array that hold the values of an ideal pushup
@property NSNumber *stopPressedCount;           //Keeps track of the number of times we press stop
@property NSIndexPath *currentIndex;            //Keep track of the selected index
@property (retain) NSTimer *updateTimer;        // Add a timer to trigger display updates

- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
-(IBAction) resetButtonPressed:(id)sender;

@end
