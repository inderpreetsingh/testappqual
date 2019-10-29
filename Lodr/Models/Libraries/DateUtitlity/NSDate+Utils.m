//
//  NSDate+Utils.m
//  MustPlanItApp
//
//  Created by C174 on 16/03/16.
//  Copyright © 2016 C174. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)


-(NSDate *) toLocalTime
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}

-(NSDate *) toGlobalTime
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = -[tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}

@end
