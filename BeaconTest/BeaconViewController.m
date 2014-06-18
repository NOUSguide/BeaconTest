//
//  BeaconViewController.m
//  BeaconTest
//
//  Created by Todd Fearn on 3/10/14.
//  Copyright (c) 2014 Todd Fearn. All rights reserved.
//

#import "BeaconViewController.h"

#import "NSDate+NGIAddition.h"

#import "NGIBeacon.h"

static NSString * kNGICellIdentifier = @"RoximityBeaconCell";

@interface BeaconViewController ()

@property (nonatomic, strong) NSArray *beacons;

@end

@implementation BeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.beacons = @[];
    
    self.navigationItem.title = @"My Beacons";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kNGICellIdentifier];
    self.tableView.rowHeight = 80.f;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedStatusNotification:) name:ROX_NOTIF_BEACON_RANGE_UPDATE object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(regionEntered:)
                                                 name:ROX_NOTIF_REGION_ENTERED
                                               object:nil];
}


/**
 This function is the application’s response to the observation of the “ROX_NOTIF_BEACON_RANGE_UPDATE” string from the Notification Center. Here it is passed a notification containing the userInfo dictionary. */
- (void)receivedStatusNotification:(NSNotification *)notification {
    NSDictionary *rangedBeaconsDictionary = notification.userInfo;
    
    for (NSString *key in rangedBeaconsDictionary.allKeys){
        NSDictionary *beaconDictionary = rangedBeaconsDictionary[key];
        NSString *beaconName = beaconDictionary[ROX_BEACON_RANGE_KEY_BEACON_NAME];
        NSNumber *proximityNumber = beaconDictionary[ROX_BEACON_RANGE_KEY_PROXIMITY_VALUE];
        
        NGIROXProximity proximity = NGIROXProximityUnknown;
        
        if (proximityNumber != nil) {
            proximity = (NGIROXProximity)[proximityNumber unsignedIntegerValue];
        }
        
        [self updateBeaconStatusForBeaconWithName:beaconName proximity:proximity];
    }
    
    [self.tableView reloadData];
}

/**
 This function is the application’s response to the observation of the “ROX_NOTIF_REGION_ENTERED” string from the Notification Center. Here it is passed a notification containing the userInfo dictionary */
- (void)regionEntered:(NSNotification *)notification {
    
    // implements a pointer called “userInfo” that points to the userInfo dictionary of the notification
    NSDictionary *userInfo = notification.userInfo;
}

- (void)updateBeaconStatusForBeaconWithName:(NSString *)name proximity:(enum NGIROXProximity)proximity {
    NSParameterAssert(name != nil);
    
    NSArray *beaconsMatchingName = [self.beacons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@", name]];

    NSAssert([beaconsMatchingName count] < 2, @"multiple beacons with same name not supported");

    NGIBeacon *beacon;
    if ([beaconsMatchingName count] == 1) {
        beacon = [beaconsMatchingName firstObject];
    }
    else if ([beaconsMatchingName count] == 0) {
        beacon = [[NGIBeacon alloc] init];
        beacon.name = name;
        
        self.beacons = [self.beacons arrayByAddingObject:beacon];
    }
    
    beacon.proximity = proximity;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource
////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.beacons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNGICellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row < [self.beacons count]) {
        NGIBeacon *beacon = self.beacons[indexPath.row];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = [NSString stringWithFormat:@"%@ \nProximity: %@ \nUpdated: %@",
                               beacon.name,
                               [beacon proximityDescription],
                               [beacon.updated relativeDateString]];
    }
    else {
        cell.textLabel.text = @"";
    }
    
    return cell;
}

@end
