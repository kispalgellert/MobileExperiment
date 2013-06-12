//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This class keeps track of the name, and counts of an exercise, very basic
//

#import "Exercise.h"

@implementation Exercise

- (id) init
{
    self = [super init];
    
    if( self )
    {
        // try to use the instance variables backing a property inside of init methods rather
        // than something like self.name = @"Character Name"
        _name = @"Exercise Name ";
        _totalDone = [[NSNumber alloc] initWithInt:0];
        _targetCount = [[NSNumber alloc] initWithInt:0];
    }
    
    return self;
}


- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if( self )
    {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _totalDone = [aDecoder decodeObjectForKey:@"totalDone"];
        _targetCount = [aDecoder decodeObjectForKey:@"targetCount"];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.totalDone forKey:@"totalDone"];
    [aCoder encodeObject:self.targetCount forKey:@"targetCount"];
}

@end
