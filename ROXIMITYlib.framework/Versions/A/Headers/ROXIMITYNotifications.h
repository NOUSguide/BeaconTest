//
//  ROXIMITYNotifications.h
//  ROXIMITYlib
//
//  Created by Danny Pier on 9/18/13.
//  Copyright (c) 2013 ROXIMITY. All rights reserved.
//

/**
 @brief The ROXIMITYNotifications class
 */
#import <Foundation/Foundation.h>

@interface ROXIMITYNotifications : NSObject

extern NSString * const ROX_NOTIF_BEACON_RANGE_UPDATE;
extern NSString * const ROX_NOTIF_REGION_ENTERED;
extern NSString * const ROX_NOTIF_REGION_EXITED;
extern NSString * const ROX_NOTIF_BLUETOOTH_OFF;
extern NSString * const ROX_NOTIF_MESSAGE_FIRED;

extern NSString * const ROX_BEACON_RANGE_KEY_BEACON_ID;
extern NSString * const ROX_BEACON_RANGE_KEY_BEACON_NAME;
extern NSString * const ROX_BEACON_RANGE_KEY_BEACON_TAGS;
extern NSString * const ROX_BEACON_RANGE_KEY_PROXIMITY_VALUE;
extern NSString * const ROX_BEACON_RANGE_KEY_PROXIMITY_STRING;


@end
