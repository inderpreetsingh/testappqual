//
//  GlobalFunction.h
//  TabRabbit
//
//  Created by C174 on 08/02/17.
//  Copyright © 2017 C174. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalFunction : NSObject
+(void) cornerRadious:(CGFloat)radious toView:(UIView *)view;
+(void) paddintoTextField:(UITextField *)textField withPadding:(int)width;
+ (UIImage*) drawImage:(UIImage*) drawImage
            inImage:(UIImage*)  image
            atPoint:(CGPoint)   point
            color :(UIColor *)colorname;
+ (CGFloat)getLabelHeight:(UILabel*)label;

+ (UIView *)roundCornersOnView:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius;
+ (NSString *)dateAfter1Hour:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat;
+(void)drawInnerShadowOnView:(UIView *)view;
+ (NSString *)stringDate:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat;
+ (NSDate *)dateString:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat;
//+ (NSString *) getRemainingTime : (NSString *)startTime valideHours:(int)hours;
+ (NSDate *)endTimeFromDate:(NSDate *)date withHours:(int)hours ;
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval;

//+(NSString *) getCurrentTime:(NSString *)UTCTime;
+(NSString *)getDateStringFromDate :(NSDate *)date withFormate:(NSString *)format;
+(NSDate *)getDateFromDateString :(NSString *)dateString withFormate:(NSString *)format;
+(NSString *)getRemainingTime:(NSString *)currentTime;
+(NSString *) getDateDifferance : (NSString *)endingTime;
+(NSString *)dateStringLocal:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat;
+(NSDate *)dateStringUTC:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat;
+(NSString*)remaningTime:(NSDate*)startDate endDate:(NSDate*)endDate;
+ (NSString *)calenderstringDate:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat;
+(NSString *)changeformate_string24hr:(NSString *)date;
+(NSString *)changeformate_string12hr:(NSString *)date;
+(void) ShowAlert:(NSString *) title Message:(NSString *)message;
+ (NSDate *)convertDateToLocalTimeZoneForDateFromString:(NSString *)givenDate;
+ (UIViewController*) topMostController;
@end


