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
    NSString *_proximity;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *proximity;

@end
