//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  Basic class that keeps track of the start, stop and reset button inside the container
//

#import "ActivitySelectionContainerViewController.h"

#import "ActivitySelection.h"

@interface ActivitySelectionContainerViewController ()

@end

@implementation ActivitySelectionContainerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)resetButtonPressedInCont:(id)sender {
    [(ActivitySelection*)self.parentViewController resetButtonPressed:self];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender
{
    [(ActivitySelection*)self.parentViewController start:self];
}

- (IBAction)stop:(id)sender
{
    [(ActivitySelection*)self.parentViewController stop:self];
}


@end
