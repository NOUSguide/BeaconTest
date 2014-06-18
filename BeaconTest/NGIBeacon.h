//
//  Beacon.h
//  BeaconTest
//
//  Created by Todd Fearn on 3/10/14.
//  Copyright (c) 2014 Todd Fearn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NGIROXProximity) {
    NGIROXProximityUnknown = 0,
    NGIROXProximityImmediate = 1,
    NGIROXProximityNear = 2,
    NGIROXProximityFar = 3
};

@interface NGIBeacon : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) enum NGIROXProximity proximity;
@property (nonatomic, strong) NSDate *updated;

- (NSString *)proximityDescription;

@end
