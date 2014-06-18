//
//  Beacon.m
//  BeaconTest
//
//  Created by Todd Fearn on 3/10/14.
//  Copyright (c) 2014 Todd Fearn. All rights reserved.
//

#import "NGIBeacon.h"

@implementation NGIBeacon

////////////////////////////////////////////////////////////////////////
#pragma mark - Custom Setter & Getter
////////////////////////////////////////////////////////////////////////

- (void)setProximity:(enum NGIROXProximity)proximity {
    _proximity = proximity;
    
    self.updated = [NSDate date];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGIBeacon
////////////////////////////////////////////////////////////////////////

- (NSString *)proximityDescription {
    NSString *proximityDescription;
    
    switch (self.proximity) {
        case NGIROXProximityImmediate:
            proximityDescription = NSLocalizedString(@"immediate", @"immediate");
            
            break;
        case NGIROXProximityNear:
            proximityDescription = NSLocalizedString(@"near", @"near");
            
            break;
        case NGIROXProximityFar:
            proximityDescription = NSLocalizedString(@"far", @"far");
            
            break;
            
        default:
            proximityDescription = NSLocalizedString(@"unknown", @"unknown");
            
            break;
    }
    
    return proximityDescription;
}

@end