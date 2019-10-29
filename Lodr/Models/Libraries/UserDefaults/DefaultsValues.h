//
//  DefaultsValues.h
//  Informer
//
//  Created by Manan Sheth on 06/08/13.
//  Copyright (c) 2013 Narola Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultsValues : NSObject

+ (void)setUserValueToUserDefaults:(NSDictionary *)userValue ForKey:(NSString *)strKey;
+ (NSDictionary *)getUserValueFromUserDefaults_ForKey:(NSString *)strKey;

+ (void)setStringValueToUserDefaults:(NSString *)strValue ForKey:(NSString *)strKey;
+ (NSString *)getStringValueFromUserDefaults_ForKey:(NSString *)strKey;

+ (void)setIntegerValueToUserDefaults:(int)intValue ForKey:(NSString *)intKey;
+ (int)getIntegerValueFromUserDefaults_ForKey:(NSString *)intKey;

+ (void)setBooleanValueToUserDefaults:(bool)booleanValue ForKey:(NSString *)booleanKey;
+ (bool)getBooleanValueFromUserDefaults_ForKey:(NSString *)booleanKey;

+ (void)setCustomObjToUserDefaults:(id)CustomObj ForKey:(NSString *)CustomObjKey;
+ (id)getCustomObjFromUserDefaults_ForKey:(NSString *)CustomObjKey;

+ (void)removeObjectForKey:(NSString *)objectKey;

@end
