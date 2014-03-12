//
//  BeaconViewController.m
//  BeaconTest
//
//  Created by Todd Fearn on 3/10/14.
//  Copyright (c) 2014 Todd Fearn. All rights reserved.
//

#import "BeaconViewController.h"

@interface BeaconViewController ()

@end

@implementation BeaconViewController
@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _beacons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"My Beacons";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedStatusNotification:) name:ROX_NOTIF_BEACON_RANGE_UPDATE object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(regionEntered:)
                                                 name:ROX_NOTIF_REGION_ENTERED
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//This function is the application’s response to the observation of the “ROX_NOTIF_BEACON_RANGE_UPDATE” string from the Notification Center. Here it is passed a notification containing the userInfo dictionary.
-(void) receivedStatusNotification:(NSNotification *) notification
{
    NSDictionary *rangedBeaconsDictionary = notification.userInfo;
    
    for (NSString * key in rangedBeaconsDictionary.allKeys){
        
        NSDictionary *beaconDictionary = [rangedBeaconsDictionary objectForKey:key];
        NSString *beaconName = [beaconDictionary objectForKey:ROX_BEACON_RANGE_KEY_BEACON_NAME];
        NSString *proximity = [beaconDictionary objectForKey:ROX_BEACON_RANGE_KEY_PROXIMITY_STRING];
        
        [self addBeaconStatus:beaconName proximity:proximity];
        [self.tableView reloadData];
        
        
        NSLog(@"Beacon: %@ is at %@ proximity", beaconName, proximity);
    }
    
}

//This function is the application’s response to the observation of the “ROX_NOTIF_REGION_ENTERED” string from the Notification Center. Here it is passed a notification containing the userInfo dictionary.
-(void) regionEntered:(NSNotification *) notification
{
    //implements a pointer called “userInfo” that points to the userInfo dictionary of the notification
    NSDictionary *userInfo = notification.userInfo;
    
}

- (void)addBeaconStatus:(NSString *)name proximity:(NSString *)proximity {
    
    BOOL found = NO;
    for(Beacon *beacon in self.beacons) {
        if([beacon.name isEqualToString:name]) {
            [beacon addProximity:proximity];
            found = YES;
            break;
        }
    }
    
    if(! found) {
        Beacon *beacon = [[Beacon alloc] init];
        beacon.name = [NSString stringWithString:name];
        [beacon addProximity:proximity];
        [self.beacons addObject:beacon];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.beacons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Beacon *beacon = [self.beacons objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", beacon.name, [beacon getProximity]];
    
    return cell;
}

@end
