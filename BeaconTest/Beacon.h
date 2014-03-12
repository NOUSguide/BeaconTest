//
//  Beacon.h
//  BeaconTest
//
//  Created by Todd Fearn on 3/10/14.
//  Copyright (c) 2014 Todd Fearn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beacon : NSObject {
    NSString *_name;
    NSMutableArray *_proximities;
    NSString *_lastProximity;
    NSDate *_lastUpdate;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *proximities;
@property (nonatomic, strong) NSString *lastProximity;
@property (nonatomic, strong) NSDate *lastUpdate;

- (void)addProximity:(NSString *)proximity;
- (NSString *)getProximity;

@end
