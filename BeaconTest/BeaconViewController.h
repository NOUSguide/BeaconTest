//
//  BeaconViewController.h
//  BeaconTest
//
//  Created by Todd Fearn on 3/10/14.
//  Copyright (c) 2014 Todd Fearn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ROXIMITYlib/ROXIMITYlib.h>
#import "Beacon.h"

@interface BeaconViewController : UIViewController {
    IBOutlet UITableView *_tableView;
    NSMutableArray *_beacons;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *beacons;

@end
