//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This class provides the mail functionality of our app, it is where we analyze accelerometer
//  readings, and display feedback for the exercises done
//

#import "WorkoutTableController.h"
#import "ActivitySelection.h"
#import "ActivitySelectionDetailViewController.h"
#import "Exercise.h"
#import "WorkoutPlan.h"

@interface ActivitySelection ()

@end

@implementation ActivitySelection

@synthesize motionManager;


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

//returns path of data file
- (NSString*) characterDataPath {
    NSString * documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [documentsPath stringByAppendingPathComponent:@"WorkoutFile.dat"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Exercise List";

    //stop pressed count is the number of times stop has been pressed, to keep track of which exercise is being done
    _stopPressedCount = [[NSNumber alloc] initWithInt:-1];
        
    if(! _objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    // show some edit buttons for adding/removing items from the table view
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertItem:)],nil];
    
    // somewhere in our app's lifetime we need to save
    // two goods spots to save are when we go into the background (become inactive), or when
    // we are terminated
    UIApplication * app = [UIApplication sharedApplication];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    
    // listen for resign-active notifications (we're going into the background)
    [center addObserver:self
               selector:@selector(willResignActive:)
                   name:UIApplicationWillResignActiveNotification
                 object:app];
    
    // listen for will-terminate notifications (we're being forced to quit)
    [center addObserver:self
               selector:@selector(willTerminate:)
                   name:UIApplicationWillTerminateNotification
                 object:app];
    
    [self setUpAccelerometer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//inserts an exercise into queue
- (void) insertItem:(id)sender {
    Exercise * exercise = [[Exercise alloc] init];
    
    NSIndexPath * newIndexPath = [[NSIndexPath alloc] init];
    
    // add our our character to the model, and update the table
    if(_objects.count > 0) {
        [_objects insertObject:exercise atIndex:_objects.count-1];
        newIndexPath = [NSIndexPath indexPathForRow:_objects.count-1 inSection:0];

    }
    else {
        [_objects insertObject:exercise atIndex:0];
        newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self saveData];
}
- (void) willResignActive:(NSNotification*)notification {
    [self saveData];
}


- (void)viewWillDisappear:(BOOL)animated {
    [self saveData];
}

- (void) willTerminate:(NSNotification*)notification {
    [self saveData];
}

- (void) saveData {
    // we need to save our data here using a NSKeyedArchiver instance
    [NSKeyedArchiver archiveRootObject:_workoutListInAct toFile:self.characterDataPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    _currentIndex = indexPath;
    
    // Configure the cell...
    Exercise * character = _objects[indexPath.row]; // Is the same as: [_objects objectAtIndex:indexPath.row];
    
    UILabel * exerciseNameLabel = (id)[cell viewWithTag:1];
    UILabel * progressLable = (id)[cell viewWithTag:2];
    
    exerciseNameLabel.text = character.name;
    NSMutableString *newString = [[NSMutableString alloc] init];
    newString = [character.totalDone.stringValue stringByAppendingString: @" / "];
    newString = [newString stringByAppendingString:character.targetCount.stringValue];
    progressLable.text = newString;
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_objects removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if( [segue.identifier isEqualToString:@"exerciseAction"] ) {
        ActivitySelectionDetailViewController * detailViewController = (UIViewController*)segue.destinationViewController;
        NSIndexPath * selection = [self.tableView indexPathForSelectedRow];
        detailViewController.exercise = ((Exercise *) _objects[selection.row]);
        detailViewController.updateHandler = ^{
            [self.tableView reloadData];
        };
    }
}


//Start pressed on the container
- (IBAction)start:(id)sender {
    self.navigationItem.title = @"Start pressed";

    //data for a standard Gellert push-up
    NSDictionary * Dict1 = @{@"x" : [NSNumber numberWithFloat:-.35],
    @"y": [NSNumber numberWithFloat:0.29],
    @"z": [NSNumber numberWithFloat:-1.02]};
    
    NSDictionary * Dict2 = @{@"x" : [NSNumber numberWithFloat:-0.42],
    @"y": [NSNumber numberWithFloat:0.26],
    @"z": [NSNumber numberWithFloat:-1.1]};
    
    NSDictionary * Dict3 = @{@"x" : [NSNumber numberWithFloat:-0.4],
    @"y": [NSNumber numberWithFloat:0.18],
    @"z": [NSNumber numberWithFloat:-0.93]};
    
    NSDictionary * Dict4 = @{@"x" : [NSNumber numberWithFloat:-0.25],
    @"y": [NSNumber numberWithFloat:0.33],
    @"z": [NSNumber numberWithFloat:-0.96]};
    
    NSDictionary * Dict5 = @{@"x" : [NSNumber numberWithFloat:-0.25],
    @"y": [NSNumber numberWithFloat:0.36],
    @"z": [NSNumber numberWithFloat:-0.95]};
    
    NSDictionary * Dict6 = @{@"x" : [NSNumber numberWithFloat:-0.25],
    @"y": [NSNumber numberWithFloat:0.3],
    @"z": [NSNumber numberWithFloat:-0.86]};
    
    NSDictionary * Dict7 = @{@"x" : [NSNumber numberWithFloat:-0.25],
    @"y": [NSNumber numberWithFloat:0.37],
    @"z": [NSNumber numberWithFloat:-0.75]};
    
    NSDictionary * Dict8 = @{@"x" : [NSNumber numberWithFloat:-0.18],
    @"y": [NSNumber numberWithFloat:0.41],
    @"z": [NSNumber numberWithFloat:-0.75]};
    
    NSDictionary * Dict9 = @{@"x" : [NSNumber numberWithFloat:-0.15],
    @"y": [NSNumber numberWithFloat:0.43],
    @"z": [NSNumber numberWithFloat:-0.83]};
    
    NSDictionary * Dict10 = @{@"x" : [NSNumber numberWithFloat:-0.24],
    @"y": [NSNumber numberWithFloat:0.32],
    @"z": [NSNumber numberWithFloat:-0.81]};
    
    NSDictionary * Dict11 = @{@"x" : [NSNumber numberWithFloat:-0.24],
    @"y": [NSNumber numberWithFloat:0.34],
    @"z": [NSNumber numberWithFloat:-0.81]};
    
    NSDictionary * Dict12 = @{@"x" : [NSNumber numberWithFloat:-0.22],
    @"y": [NSNumber numberWithFloat:0.35],
    @"z": [NSNumber numberWithFloat:-0.88]};
    
    NSDictionary * Dict13 = @{@"x" : [NSNumber numberWithFloat:-0.27],
    @"y": [NSNumber numberWithFloat:0.31],
    @"z": [NSNumber numberWithFloat:-1.0]};
    
    [self.pushUp addObject:Dict1];
    [self.pushUp addObject:Dict2];
    [self.pushUp addObject:Dict3];
    [self.pushUp addObject:Dict4];
    [self.pushUp addObject:Dict5];
    [self.pushUp addObject:Dict6];
    [self.pushUp addObject:Dict7];
    [self.pushUp addObject:Dict8];
    [self.pushUp addObject:Dict9];
    [self.pushUp addObject:Dict10];
    [self.pushUp addObject:Dict11];
    [self.pushUp addObject:Dict12];
    [self.pushUp addObject:Dict13];
    _startPressedBool = true;
}

//resets number of exercises done, and stoppressed to index first exercise
- (IBAction)resetButtonPressed:(id)sender {
    self.navigationItem.title = @"Reset pressed";
    for(Exercise *temp in _objects) {
        temp.totalDone = [NSNumber numberWithInt:0];
    }
    _stopPressedCount = [NSNumber numberWithInt:-1];    
    for(int i = 0; i < _objects.count; i++) {
        NSIndexPath * newIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:newIndexPath];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transparent.png"]];
    }
    [self.tableView reloadData];

}

//stop pressed on the container
- (IBAction)stop:(id)sender {
    if(_startPressedBool) {
        self.navigationItem.title = @"Stop pressed";
        int tempVar = [_stopPressedCount intValue];
        tempVar++;
        _stopPressedCount = [NSNumber numberWithInt:tempVar];
        if([_stopPressedCount integerValue] >= _objects.count) {
            int tempVar = [_stopPressedCount intValue];
            tempVar--;
            _stopPressedCount = [NSNumber numberWithInt:tempVar];
        }
        _startPressedBool = NO;
        [self checkMotion];
    }
}

-(void) writeAccelDataToFile {
    NSString *accumilateLines = [[NSString alloc] init];
    NSString *temp = [[NSString alloc] init];
    
    for(NSDictionary *iterator in _values) {
        NSNumber *tempNumberX = [iterator objectForKey:@"x"];
        NSNumber *tempNumberY = [iterator objectForKey:@"y"];
        NSNumber *tempNumberZ = [iterator objectForKey:@"z"];
        
        temp = [tempNumberX stringValue];
        temp = [temp stringByAppendingString:@"\t"];
        temp = [temp stringByAppendingString:[tempNumberY stringValue]];
        temp = [temp stringByAppendingString:@"\t"];
        temp = [temp stringByAppendingString:[tempNumberZ stringValue]];
        temp = [temp stringByAppendingString:@"\n"];
        
        accumilateLines = [accumilateLines stringByAppendingString:temp];
    }

    NSDate *timeStamp = [NSDate date];
    NSString *dateString = [timeStamp descriptionWithLocale:NSLocaleCountryCode];
    NSString *fileName = [dateString stringByAppendingString:@" AccelData.txt"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString *docFile = [docDir stringByAppendingPathComponent:fileName];

    [accumilateLines writeToFile:docFile atomically:NO encoding:1 error:nil]; // Writes text file in human readable ascii encoding format
}

- (void) setUpAccelerometer {    
    // instanciate motion manager
    self.motionManager = [[CMMotionManager alloc] init];
    
    // CJ: accelerometer
    if (motionManager.accelerometerAvailable) {
        motionManager.accelerometerUpdateInterval = 1.0/10.0;
        // CJ: start updates of accelerometer
        [motionManager startAccelerometerUpdates];
    }
    
    self.values = [NSMutableArray array];
    self.pushUp = [NSMutableArray array];
    
    _startPressedBool = false;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //CJ: create new timer, which will fire every 1/10 second
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                        target:self
                                                      selector:@selector(updateDisplay)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.updateTimer = nil;
}

- (void)updateDisplay {
    // CJ: accelerometer
    if (motionManager.accelerometerAvailable) {
        // CJ: get data from motion manager
        CMAccelerometerData *accelerometerData = motionManager.accelerometerData;
        // CJ: set label text
        
        if(_startPressedBool) {
        
            printf("%.2f \t %.2f \t %.2f \n", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
            
            [self recordDataX:accelerometerData.acceleration.x
                            y:accelerometerData.acceleration.y
                            z:accelerometerData.acceleration.z];
        }
    }
}
// Main functionality of the program this function goes through the data aquired from the accelerometer and
// classifies whether any exercises have been done
//
- (void) checkMotion {
    NSIndexPath * newIndexPath = [NSIndexPath indexPathForRow:[_stopPressedCount intValue] inSection:0];
    Exercise *temp = [[Exercise alloc] init];
    temp = (Exercise *) _objects[newIndexPath.row];
    
    //how many classified exercises have been done
    int exerciseCount = 0;	
    //threshold defines the minimum signal from accelerometer
    //variation defines how much the signals must vary before considering a valid exercise
    float threshold = 2.5, variation = 0.6, leeway = 0.4;
    bool valid = true;

    //we will classify whether or not pushups have been done
    if([temp.name isEqualToString:@"Pushup"]) {
	//total is the absolute difference between the signal value, and pushup value
        float total = 0.0;
        NSMutableArray *totals = [[NSMutableArray alloc] init];
	
	//we iterate over the accelerometer signals
        for(unsigned int i = 0; i < _values.count - _pushUp.count && i < _values.count && _values.count > _pushUp.count; i++) {
            total = 0.0;
        
	//the pushup values are shifted along the accelerometer signals, and populate totals with the difference between the values
            for (int j = 0; j < _pushUp.count; j++) {                
                float sensorValue = [[[self.values objectAtIndex:i + j] objectForKey:@"z"] floatValue];
                float pushupValue = [[[self.pushUp objectAtIndex:j] objectForKey:@"z"] floatValue];
                total += fabs(sensorValue - pushupValue);
            }
            [totals addObject:[NSNumber numberWithFloat:total]];
        }
        exerciseCount = 0;
        threshold = 2.5;
        variation = 0.6;
        leeway = 0.4;
        valid = true;
	
	//now that we have the differences computed, we check them based on threshold, variation, and leeway
        for(unsigned int i = 11; totals.count > 31 && i < totals.count-20; i++) {
            if( [[totals objectAtIndex:i-1] floatValue] > threshold + variation )
                valid = true;
            
            if( valid == true && [[totals objectAtIndex:i] floatValue] < threshold + leeway )
            {
                exerciseCount++;
                valid = false;   
            }
            
            if( [[totals objectAtIndex:i-1] floatValue] < threshold )
                threshold = [[totals objectAtIndex:i-1] floatValue];
            
        }
    }
    //checking if any jumps, or number of jogging steps has been done
    else if([temp.name isEqualToString:@"Jump"]) {
        exerciseCount = 0;
        threshold = 0.5;
        variation = 2.0;
        leeway = 0.4;
        valid = true;
	
	//we loop through the sensor values
        for(unsigned int i = 1; i < _values.count; i++) {
            float sensorValue = [[[self.values objectAtIndex:i] objectForKey:@"y"] floatValue];
            float oldSensorValue = [[[self.values objectAtIndex:i-1] objectForKey:@"y"] floatValue];
            
	    //if sensor is above variation, the person is about to come down from the air
            if( oldSensorValue > threshold + variation )
                valid = true;
            
	    //if the sensor has touched the floor, we count a jump/step
            if( valid == true && sensorValue < threshold + leeway ) {
                exerciseCount++;
                valid = false;
            }
            
	    //update minimum threshold
            if( sensorValue < threshold )
                threshold = sensorValue;
        }
        NSLog(@"Exercise Count = %d", exerciseCount);
	//for jogging, the device only picks up one leg movement
        exerciseCount *= 2;
    }

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:newIndexPath];
    //update the cell background to be green to indicate the exercise is done
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greencolor.png"]];

    [self.tableView reloadData];
    
        
    int totalDoneIntVal = [temp.totalDone integerValue];
    totalDoneIntVal += exerciseCount;
    temp.totalDone = [NSNumber numberWithInt:totalDoneIntVal];
        
    [self.tableView reloadData];
    //NSString* labelUpdate = [NSString stringWithFormat:@"%i", exerciseCount];
    
    [self writeAccelDataToFile];

    
    _values = [[NSMutableArray alloc] init];
    
}

//records acceleromater data
- (void) recordDataX:(float)x y:(float)y z:(float)z {
    NSDictionary *aDict = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithFloat: roundf(x * 1000) / 1000], @"x",
                           [NSNumber numberWithFloat: roundf(y * 1000) / 1000], @"y",
                           [NSNumber numberWithFloat: roundf(z * 1000) / 1000], @"z", nil];
    
    [self.values addObject:aDict];
}

@end
