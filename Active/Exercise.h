//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  This class keeps track of the name, and counts of an exercise, very basic
//

#import <Foundation/Foundation.h>

@interface Exercise : NSObject <NSCoding>

@property NSString * name;
@property NSNumber * totalDone;
@property NSNumber * targetCount;
@property NSMutableArray * history;

@end
