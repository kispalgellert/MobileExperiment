//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  Basic class that keeps track of the start, stop and reset button inside the container
//

#import <UIKit/UIKit.h>

@class ActivitySelection;

@interface ActivitySelectionContainerViewController : UIViewController

- (IBAction)start:(id)sender;

- (IBAction)stop:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end
