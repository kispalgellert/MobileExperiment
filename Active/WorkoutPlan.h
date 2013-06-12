//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This class keeps track of the schduled workouts. Stores an array of exercises
//

#import <Foundation/Foundation.h>

@class Exercise;

@interface WorkoutPlan : NSObject <NSCoding>

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSMutableArray *exercises;
@property (strong, nonatomic) NSMutableArray *numberOfReps;

@end
