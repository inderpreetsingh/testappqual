//
//  Common.h
//  SQLExample
//
//  Created by Prerna on 5/13/15.
//  Copyright (c) 2015 Prerna. All rights reserved.


#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Function : NSObject
{
    
}
#pragma mark - dictionary functions
+(NSString *) getStringFromObject:(NSString *) key fromDictionary:(NSDictionary *) values;
+(NSString *) getStringForKey:(NSString *) key fromDictionary:(NSDictionary *) values;

+(int) getIntegerForKey:(NSString *) key fromDictionary:(NSDictionary *) values;
+(double) getDoubleForKey:(NSString *) key fromDictionary:(NSDictionary *) values;

#pragma mark - string functions
+ (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet forString:(NSString *)string;
+ (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet forString:(NSString *)string;
+ (BOOL ) stringIsEmpty:(NSString *) aString;
+(NSString*)generateRandomString:(int)num;

#pragma mark - dateFormats
+(NSDateFormatter *)getDateFormatForApp;
+(NSDate *)getDateFromString: (NSString *)strDate;


#pragma mark - User defaults
+ (void)setStringValueToUserDefaults:(NSString *)strValue ForKey:(NSString *)strKey;
+ (NSString *)getStringValueFromUserDefaults_ForKey:(NSString *)strKey;

+ (void)setIntegerValueToUserDefaults:(int)intValue ForKey:(NSString *)intKey;
+ (int)getIntegerValueFromUserDefaults_ForKey:(NSString *)intKey;

+ (void)setBooleanValueToUserDefaults:(bool)booleanValue ForKey:(NSString *)booleanKey;
+ (bool)getBooleanValueFromUserDefaults_ForKey:(NSString *)booleanKey;

+ (void)setObjectValueToUserDefaults:(id)idValue ForKey:(NSString *)strKey;
+ (id)getObjectValueFromUserDefaults_ForKey:(NSString *)strKey;

#pragma mark - View controller methods

+ (UIViewController*) topMostController;

#pragma mark - QR Code generation
+(UIImage *) generateQRCodeWithString:(NSString *)string scale:(CGFloat) scale;

#pragma mark - timezone
+(NSDate *) convertStringToServerDate:(NSString *)strDate fromTimeZone : (NSTimeZone *) fromTZ toTimeZone : (NSTimeZone *) toTZ;
+(NSString *)returnCurrentDate;

#pragma mark - html utilities
+(NSAttributedString *)extractHTMLtags:(NSString *)htmlstr;

#pragma mark - image utilities
+ (NSString *)encodeImageToBase64String:(UIImage *)image;

#pragma mark - Animation
#pragma mark  image resize
+ (UIImage *)scaleAndRotateImage:(UIImage *)image;

//#pragma mark Label Text Animation
+ (void)animateLabelShowText:(NSString*)newText characterDelay:(NSTimeInterval)delay forLabel : (UILabel *) lbl ;
//
//#pragma mark Shake effect animation
+ (void) shakeAnimForCustomTextfield : (UITextField *)txt;
+ (void) shakeAnimForTextField : (UITextField *) txt;
+ (void) shakeAnimForLabel : (UILabel *)lbl ;
+ (void) shakeAnimForButton : (UIButton *)txt;
+ (void) shakeAnimForTextView : (UITextView *) txt;

#pragma mark - GET IMAGE FROM VIDEO

+ (NSIndexPath *)getIndexpathfromTouchLocation:(id)sender event:(id)event;
+(UIImage*)getVideoImage:(AVAsset *) asset;

@end
