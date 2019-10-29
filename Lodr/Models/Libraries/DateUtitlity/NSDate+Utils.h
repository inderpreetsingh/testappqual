//
//  NSDate+Utils.h
//  MustPlanItApp
//
//  Created by C174 on 16/03/16.
//  Copyright © 2016 C174. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDate *toLocalTime;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDate *toGlobalTime;

@end
