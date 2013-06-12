//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This class keeps track of the schduled workouts. Stores an array of exercises
//

#import "WorkoutPlan.h"
#import "Exercise.h"

@implementation WorkoutPlan

- (id) init {
    self = [super init];

    if( self ) {
        Exercise *a = [[Exercise alloc] init];
        Exercise *b = [[Exercise alloc] init];
        // try to use the instance variables backing a property inside of init methods rather
        // than something like self.name = @"Character Name"
        _name = @"Workout 1";
        _exercises = [[NSMutableArray alloc] initWithObjects:a, b, nil];
        _numberOfReps = [[NSMutableArray alloc] init];
    }
    return self;
}



- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if( self ){
        _name = [aDecoder decodeObjectForKey:@"name"];
        _exercises = [aDecoder decodeObjectForKey:@"exercises"];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.exercises forKey:@"exercises"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

@end
