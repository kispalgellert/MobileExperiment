//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This view is the start view of the application. It allows the user to scheudle their workouts
//  The logic is similar to the one use in the charaters keyed example

#import "WorkoutTableController.h"
#import "Exercise.h"
#import "ActivitySelection.h"
#import "WorkoutPlan.h"


@interface WorkoutTableController ()

@end

@implementation WorkoutTableController
{
    NSMutableArray * _workoutList;
    UIAlertView * alert;
    UITextField * alertTextField;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (NSString*) characterDataPath {
    NSString * documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [documentsPath stringByAppendingPathComponent:@"WorkoutFile.dat"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"nav1.png"]]];
    
    self.navigationItem.title = @"Workouts";
    
    NSString * characterDataFile = self.characterDataPath;
    
    // if we have a data file, try to load it
    if( [[NSFileManager defaultManager] fileExistsAtPath:characterDataFile] ) {
        // we need to load the data from our file here using a NSKeyedUnarchive instance
        _workoutList = [NSKeyedUnarchiver unarchiveObjectWithFile:characterDataFile];
        
        if(!_workoutList) {
            _workoutList = [NSMutableArray array];
        }
    }
    else {

        // we couldn't find the file, so create some default data
        _workoutList = [NSMutableArray array];
        
        // just recycle our insertItem method to add a default item
        [self insertItem:self];
    }
    
    // show some edit buttons for adding/removing items from the table view
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertItem:)], nil];
    
    
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
    [NSKeyedArchiver archiveRootObject:_workoutList toFile:self.characterDataPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) insertItem:(id)sender {
    alert = [[UIAlertView alloc] initWithTitle:@"Workout Name" message:@"Please name your workout:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeAlphabet;
    alertTextField.placeholder = @"ex: Workout #2";
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) { // if cancel button was pressed
        return;
    }
    
    if (buttonIndex == 1) { // if ok button was pressed
        if (alertTextField.text.length < 2) {
            UIAlertView *tooShortAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Name is too short" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [tooShortAlert show];
        }
        else {
            // create our character dictionary
            WorkoutPlan * workPlan = [[WorkoutPlan alloc] init];
            workPlan.name = alertTextField.text;
            
            // add our our character to the model, and update the table
            [_workoutList insertObject:workPlan atIndex:0];
            
            //need an instance of current work
            
            NSIndexPath * newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self saveData];
        }
    }    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _workoutList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    WorkoutPlan * workPlan = _workoutList[indexPath.row]; // Is the same as: [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = workPlan.name;
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_workoutList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if( [segue.identifier isEqualToString:@"showPersonDetails"] ) {
        ActivitySelection *activitySelViewCon = (ActivitySelection*)segue.destinationViewController;
        NSIndexPath * selection = [self.tableView indexPathForSelectedRow];
        activitySelViewCon.objects = ((WorkoutPlan *) _workoutList[selection.row]).exercises;
        activitySelViewCon.workoutListInAct = _workoutList;
    }
}

@end