//
//  NSDate+_NGIAddition.m
//  BeaconTest
//
//  Created by Philipp Kinschel on 18.06.14.
//  Copyright (c) 2014 Philipp Kinschel. All rights reserved.
//
// relativeDateString logic mainly copied from http://foundationkit.github.io/FoundationKit/

#import "NSDate+NGIAddition.h"

@implementation NSDate (NGIAddition)

- (NSString *)relativeDateString {
	NSTimeInterval time = [self timeIntervalSince1970];
	NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
	NSTimeInterval diff = now - time;
    
	if(diff < 10) {
		return @"just now";
	} else if(diff < (1. / 60)) {
		return [NSString stringWithFormat:@"%d seconds ago", (NSInteger)diff];
	}
    
	diff = round(diff / (1. / 60));
	if(diff < 60.) {
		if(diff == 1.) {
			return [NSString stringWithFormat:@"%d minute ago", (NSInteger)diff];
		} else {
			return [NSString stringWithFormat:@"%d minutes ago", (NSInteger)diff];
		}
	}
    
	diff = round(diff / 60.);
	if(diff < 24.) {
		if(diff == 1.) {
			return [NSString stringWithFormat:@"%d hour ago", (NSInteger)diff];
		} else {
			return [NSString stringWithFormat:@"%d hours ago", (NSInteger)diff];
		}
	}
    
	if(diff < 7.) {
		if(diff == 1.) {
			return [NSString stringWithFormat:@"yesterday"];
		} else {
			return [NSString stringWithFormat:@"%d days ago", (NSInteger)diff];
		}
	}
    
    NSString *formatterString = [NSDateFormatter dateFormatFromTemplate:@"EEEddMMyyyy" options:0 locale:[NSLocale currentLocale]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterString];
    
    return [formatter stringFromDate:self];
}

@end