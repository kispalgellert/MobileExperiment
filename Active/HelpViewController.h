//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This view contains the slider and the instructional images
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)sliderChanged:(id)sender;

@end
