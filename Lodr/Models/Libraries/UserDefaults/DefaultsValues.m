//
//  DefaultsValues.m
//  Informer
//
//  Created by Manan Sheth on 06/08/13.
//  Copyright (c) 2013 Narola Infotech. All rights reserved.
//

#import "DefaultsValues.h"
#import "NSUserDefaults+SaveCustomObject.h"

@implementation DefaultsValues

#pragma mark -
#pragma mark - Defaults Dictionary Values

+ (void)setUserValueToUserDefaults:(NSDictionary *)userValue ForKey:(NSString *)strKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", userValue] forKey:strKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSDictionary *)getUserValueFromUserDefaults_ForKey:(NSString *)strKey
{
    NSDictionary *dict = nil;
    if ([NSUserDefaults standardUserDefaults]) {
        dict = [[NSUserDefaults standardUserDefaults] valueForKey:strKey];
    }
    return dict;
}

#pragma mark -
#pragma mark - Defaults String Values

+ (void)setStringValueToUserDefaults:(NSString *)strValue ForKey:(NSString *)strKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", strValue] forKey:strKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSString *)getStringValueFromUserDefaults_ForKey:(NSString *)strKey
{
    NSString *s = nil;
    if ([NSUserDefaults standardUserDefaults]) {
        s = [[NSUserDefaults standardUserDefaults] valueForKey:strKey];
    }
    return s;
}

#pragma mark - Defaults Integer Values

+ (void)setIntegerValueToUserDefaults:(int)intValue ForKey:(NSString *)intKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setInteger:intValue forKey:intKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (int)getIntegerValueFromUserDefaults_ForKey:(NSString *)intKey
{
    int i = 0;
    if ([NSUserDefaults standardUserDefaults]) {
        i = (int)[[NSUserDefaults standardUserDefaults] integerForKey:intKey];
    }
    return i;
}

#pragma mark - Defaults Boolean Values

+ (void)setBooleanValueToUserDefaults:(bool)booleanValue ForKey:(NSString *)booleanKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setBool:booleanValue forKey:booleanKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (bool)getBooleanValueFromUserDefaults_ForKey:(NSString *)booleanKey
{
    bool b = false;
    if ([NSUserDefaults standardUserDefaults]) {
        b = [[NSUserDefaults standardUserDefaults] boolForKey:booleanKey];
    }
    return b;
}

#pragma mark - Defaults Custom Object Values

+ (void)setCustomObjToUserDefaults:(id)CustomObj ForKey:(NSString *)CustomObjKey
{
    [[NSUserDefaults standardUserDefaults] setCustomObject:CustomObj forKey:CustomObjKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getCustomObjFromUserDefaults_ForKey:(NSString *)CustomObjKey
{
    return [[NSUserDefaults standardUserDefaults] customObjectForKey:CustomObjKey];
}

#pragma mark - Remove Defaults Values

+ (void)removeObjectForKey:(NSString *)objectKey
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:objectKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
