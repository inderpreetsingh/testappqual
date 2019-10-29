//
//  NetworkAvailability.h
//  NIPLiOSFramework
//
//  Created by Prerna on 5/25/15.
//  Copyright (c) 2015 Prerna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetworkAvailability : NSObject

@property (nonatomic,strong) Reachability *hostReachability;
@property (nonatomic,strong) Reachability *internetReachability;
@property (nonatomic,strong) Reachability *wifiReachability;


- (BOOL) isReachable;
+ (instancetype)instance;
- (void) reachabilityChanged:(NSNotification *)note;
- (void)registerReachabilityNotification;
- (void)unRegisterReachabilityNotification;
- (NSDictionary *)reachabilityStatusDisplay:(Reachability *)reachability;

@end
