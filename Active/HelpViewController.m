//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This view contains the slider and the instructional images
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

@synthesize slider;
@synthesize imageView;

- (IBAction)sliderChanged:(id)sender {
    
    if (slider.value >= 0.0 && slider.value < 0.166) {
        imageView.image = [UIImage imageNamed:@"InstructionStep1"];
    } else if (slider.value >= 0.166 && slider.value < 0.332) {
        imageView.image = [UIImage imageNamed:@"InstructionStep2"];
    } else if (slider.value >= 0.332 && slider.value < 0.498) {
        imageView.image = [UIImage imageNamed:@"InstructionStep3"];
    } else if (slider.value >= 0.498 && slider.value < 0.664) {
        imageView.image = [UIImage imageNamed:@"InstructionStep4"];
    } else if (slider.value >= 0.664 && slider.value < 0.830) {
        imageView.image = [UIImage imageNamed:@"InstructionStep5"];
    } else if (slider.value > 0.830) {
        imageView.image = [UIImage imageNamed:@"InstructionStep6"];
    }

    imageView.animationDuration = 1; //whatever you want (in seconds)
    [imageView startAnimating];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Instructions";
    [self.navigationController.navigationBar setTintColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"nav1.png"]]];
    
    imageView.image = [UIImage imageNamed:@"InstructionStep1"];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end