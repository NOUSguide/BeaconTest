//
//  Beacon.m
//  BeaconTest
//
//  Created by Todd Fearn on 3/10/14.
//  Copyright (c) 2014 Todd Fearn. All rights reserved.
//

#import "Beacon.h"

#define MAX_PROXIMITIES     5

@implementation Beacon
@synthesize name = _name;
@synthesize proximities= _proximities;
@synthesize lastProximity = _lastProximity;
@synthesize lastUpdate = _lastUpdate;

-(id) init {
    if((self = [super init])) {
        _proximities = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addProximity:(NSString *)proximity {
    [self.proximities addObject:proximity];
    
    // Remove the first proximity
    if([self.proximities count] > MAX_PROXIMITIES) {
        [self.proximities removeObjectAtIndex:0];
    }
    
    self.lastUpdate = [NSDate date];
}

- (NSString *)getProximity {
    if(! [self.proximities count])
        return nil;
    
    int unknown = 0;
    int far = 0;
    int near = 0;
    int immediate = 0;
    for(NSString *proximity in self.proximities) {
        if([proximity isEqualToString:@"unknown"])
            unknown++;
        else if([proximity isEqualToString:@"far"])
            far++;
        else if([proximity isEqualToString:@"near"])
            near++;
        else if([proximity isEqualToString:@"immediate"])
            immediate++;
    }
    
    NSString *proximity = @"";
    if(unknown > far && unknown > near && unknown > immediate)
        proximity = @"unknown";
    else if(far > unknown && far > near && far > immediate)
        proximity = @"far";
    else if(near > unknown && near > far && near > immediate)
        proximity = @"near";
    else if(immediate > unknown && immediate > far && immediate > near)
        proximity = @"immediate";
    else {
        if(self.lastProximity != nil)
            proximity = self.lastProximity;
        else
            proximity = @"unknown";
    }
    
    self.lastProximity = proximity;
    return proximity;
}

@end
