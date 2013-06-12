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
        imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"1.png"],nil];
    } else if (slider.value >= 0.166 && slider.value < 0.332) {
        imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"2.png"],nil];
    } else if (slider.value >= 0.332 && slider.value < 0.498) {
        imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"3.png"],nil];
    } else if (slider.value >= 0.498 && slider.value < 0.664) {
        imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"4.JPG"],nil];
    } else if (slider.value >= 0.664 && slider.value < 0.830) {
        imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"5.png"],nil];
    } else if (slider.value > 0.830) {
        imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"6.png"],nil];
    }

    imageView.animationDuration = 1; //whatever you want (in seconds)
    [imageView startAnimating];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Instructions";
    [self.navigationController.navigationBar setTintColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"nav1.png"]]];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end