//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This view provides the picker that can set the exervises and thier counts
//

#import "ActivitySelectionDetailViewController.h"
#import "Exercise.h"

@interface ActivitySelectionDetailViewController ()

@end

@implementation ActivitySelectionDetailViewController


@synthesize doublePicker;
@synthesize exerciseNames;
@synthesize targetNumbersPicker;


-(IBAction)buttonPressed
{
    NSInteger fillingRow = [doublePicker selectedRowInComponent:
                            kFillingComponent];
    NSInteger breadRow = [doublePicker selectedRowInComponent:
                          kBreadComponent];
    
    
    NSString *targetNumberForExercise = [targetNumbersPicker objectAtIndex:breadRow];
    
    
    
    NSString *exerciseNameSet = [exerciseNames objectAtIndex:fillingRow];
    
    NSString *message = [[NSString alloc] initWithFormat:@"You have added %@ %@",targetNumberForExercise, exerciseNameSet];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfull"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    
    self.exercise.name = exerciseNameSet;
    self.exercise.targetCount = [NSNumber numberWithInt:[targetNumberForExercise integerValue]];
    
    [alert show];
    
    if( self.updateHandler )
        self.updateHandler();
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Pick Exercise";
    // Do any additional setup after loading the view from its nib.
    exerciseNames = [[NSArray alloc] initWithObjects:@"Pushup", @"Jump", nil];

    targetNumbersPicker = [[NSMutableArray alloc] init];

    for(int i = 1; i < 100; i++){
        NSString *number = [[NSNumber numberWithInt:i] stringValue];
        [self.targetNumbersPicker addObject:number];
    }
        
    [self.navigationController.navigationBar setTintColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"nav1.png"]]];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.doublePicker = nil;
    self.targetNumbersPicker = nil;
    self.exerciseNames = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    if (component == kBreadComponent)
        return [self.targetNumbersPicker count];
    
    return [self.exerciseNames count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    if (component == kBreadComponent)
        return [self.targetNumbersPicker objectAtIndex:row];
    return [self.exerciseNames objectAtIndex:row];
}

@end