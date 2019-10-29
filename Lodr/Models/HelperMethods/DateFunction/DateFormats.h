//
//  DateFormats.h
//  mpa
//
//  Created by C218 on 25/08/16.
//  Copyright © 2016 C218. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GLOBAL_DATE_FORMAT  @"yyyy-MM-dd HH:mm:ss" //2018-02-02 12:36:08
#define UNIQUE_DATE_FORMAT  @"yyyyMMddHHmmss"
#define SIMPLE_DATE_FORMAT  @"yyyy-MM-dd HH:mm:ss"

#define SERVER_DATE_FORMAT  @"YYYY-MM-dd HH:mm a"

#define SERVER_DATE_FORMAT_TIMESLOT @"yyyy/MMM/dd"
#define ONLY_DATE_FORMAT    @"dd/MM/yyyy"
#define ONLY_TIME_FORMAT    @"HH:mm:00"

#define ONLY_DATE_TIME_FORMAT    @"yyyy-MM-dd HH:mm:00"
#define BIRTH_DATE_FORMAT    @"yyyy-MM-dd"
#define FB_BIRTH_DATE_FORMAT    @"MM/dd/yyyy"

#define PICKER_DATE_FORMAT  @"dd MMM, yyyy"
#define PICKER_TIME_FORMAT   @"hh:mm a"

#define PICKER_DATE_SELECTION_FORMAT  @"MM/yyyy"

#define ONLY_DATE_MONTH_FORMAT  @"dd-MMM"
#define MATCH_DATE_FORMAT  @"EEE d MMM yyyy"
#define MATCH_DATE_TIME_FORMAT  @"EEE, d MMM yyyy, hh:mm a"

#define FACEBOOK_FEED_DATE_FORMAT   @"dd MMM yyyy hh:mm a"

#define PICKER_DATE_TIME_FORMAT  @"dd MMM yyyy \t\t\thh:mm a"

#define PICKER_DATE_MONTH_TIME_FORMAT  @"dd MMM hh:mm a"

#define ONLY_DATE_TIME_CUSTOM_FORMAT    @"dd-MMM-yyyy HH:mm"
#define ONLY_TIME_CUSTOM_FORMAT    @"HH:mm"

#define PICKER_DATE    @"MMM-dd-yyyy"

#define TIME_STAMP_DATE @"MMM dd, YYYY, hh:mm a"

@interface DateFormats : NSObject

@property (nonatomic, strong) NSDateFormatter *dateFormat;

#pragma mark - Shared Manager

+ (DateFormats *) sharedDateFormatInstance;

#pragma mark - Convert To Local TimeZone

+ (NSString *)convertDateToLocalTimeZone:(NSString *)givenDate;
+ (NSDate *)convertDateToLocalTimeZoneForDate:(NSDate *)givenDate;
+ (NSDate *)convertDateToLocalTimeZoneForDateFromString:(NSString *)givenDate;
+ (NSDate *)convertDateToLocalTimeForDateFromString:(NSString *)givenDate;
+ (NSString *)convertLocalDateTimeToServerTimeZone:(NSString *)givenDate;

+ (NSString *)generateDateForGivenDateToServerTimeZone:(NSDate *)givenDate;

+ (NSString *)generateDefaultEndDateForGivenDateToServerTimeZone:(NSDate *)givenDate withDays:(int)days;

#pragma mark - Common Formats

+ (NSString *)getStringFromDateString:(NSString *)givenDate;
+ (NSString *)getStringFromDate:(NSDate *)givenDate;
+ (NSDate *)getDateFromString:(NSString *)givenDate;
+ (NSDate *)getDateFromDate:(NSDate *)givenDate;
+ (NSString *)getFullDateStringFromDate:(NSDate *)givenDate;
+ (NSString *)getFullDateStringFromString:(NSString *)givenDate;
+ (NSDate *)dateForCalenderResponse:(NSString*)givenDate;
+ (NSString *)getStringDateStringCalenderResponse:(NSString*)givenDate;


+(NSInteger)getYearFormDate:(NSDate*)givenDate;
+(NSInteger)getMonthFormDate:(NSDate*)givenDate;
+ (NSString *)getStringForCalenderFromDate:(NSDate *)givenDate;


#pragma mark - Timestamp Formats
//+ (NSString *)getTimestampUTC;
+ (NSString *)getTimestampUTC:(NSString *)strDate;

+ (NSDate *)getTimestampFromGivenDate:(NSString *)givenDate;

#pragma mark - Facebook Share Date Time

+ (NSString *)convertDateToFacebookFeed:(NSString *)givenDate;

#pragma mark - Picker Display Format

+ (NSString *)getDateStringValueFromDate:(NSDate *)givenDate;
+ (NSString *)getTimeStringValueFromDate:(NSDate *)givenDate;
+ (NSString *)getDateTimeStringValueFromDate:(NSDate *)givenDate;
+ (NSString *)getDateMonthTimeStringValueFromDate:(NSDate *)givenDate;

+ (NSString *)generateDateForGivenDate:(NSDate *)strDate andTime:(NSDate *)strTime;
+ (NSString *)generateDateForGivenDate:(NSDate *)strDate;
+ (NSString *)generateOnlyDateForGivenDate:(NSDate *)strDate;

#pragma mark - Birth Date

+ (NSDate *)getDateBirthdateFromFromGivenTimestamp:(NSString *)givenTimeStamp;
+ (NSDate *)getBirthDateFromString:(NSString *)givenDate;
+ (NSDate *)birthdayConstraintForPlayer:(NSDate *)givenDate;
+ (NSString *)generateBirthDateForGivenDate:(NSDate *)strDate;
+ (NSDate *)generateBirthDateForGivenFacebookDate:(NSString *)strDate;
+ (NSInteger)calculateAgeForPlayer:(NSString *)DOB;


+ (NSString *)getStringDateForBookFromString:(NSString *)givenDate;
+ (NSString *)getStringDateFromString:(NSString *)givenDate;
+ (NSString *)getStringTimeFromString:(NSString *)givenDate;
//+ (NSString *)getStringTimeFromStringUTC:(NSString *)givenDate;
+ (NSString *)getStringTimeFromStringUTC:(NSString *)givenDate DeliveryDate:(NSString *)deliveryDate;

+ (NSString *)getStringDateTimeFromString:(NSString *)givenDate;
+ (NSString *)GetDateAfterAddingmonth:(NSInteger)month givenDate:(NSDate *)givenDate;
+ (NSString *)GetDateAfterAddingYear:(NSInteger)Years givenDate:(NSDate *)givenDate;
+ (NSDate *)GetDateFormateAfterAddingYear:(NSInteger)Years givenDate:(NSDate *)givenDate;

+ (NSString *)getStringFullDateTimeFromString:(NSString *)givenDate;
+ (NSString *)getStringOnlyDateAndMonthFromString:(NSString *)givenDate;
+ (NSString *) getStringDateWithSuffix:(NSString *)givenDate;
+ (bool)isCheckCurrentDateBetween:(NSString *)startDate endDate:(NSString *)endDate;



#pragma mark - Is Upcoming / Past Verification
+ (bool)isUpcomingDate:(NSString *)givenDate;
+ (bool)isUpcomingDateForDate:(NSDate *)givenDate currentDate:(NSDate*)currentServerDate;
+ (bool)isPastDate:(NSString *)givenDate;
+ (bool)isUpcomingTimeForDate:(NSDate *)givenDate currentDate:(NSDate*)currentServerDate;
+ (bool)isUpcomingDateAndTimeForDate:(NSDate *)givenDate currentDate:(NSDate*)currentServerDate;


#pragma mark - Is Date Latest
+ (bool)isDateLatest:(NSDate *)endDate fromStartDate:(NSDate *)startDate;
+ (NSDate *)getLatestDateAddedByHour:(NSDate *)startDate;
+ (NSDate *)getLatestDateAddedByDay:(NSDate *)startDate addDay:(NSInteger)addDay;

#pragma mark - Calender End Date

+ (NSDate *)getCalenderEndDateFromString:(NSString *)givenDate withDuration:(int)duration;

+ (NSString *)getDifferenceFromStartDate:(NSDate *)startDate
                                 endDate:(NSDate *)endDate;

+ (NSString *)getTimeStampForChat:(NSString *)date;
+ (NSString *)getStringCustomTimeFromString:(NSString *)givenDate;
+ (NSString *)getUniqueDateString:(NSString *)strDateType;
+ (NSString *)getHourAndMinuteFromGivenDate:(NSString *)strDateType;

//+ (InteractionType)getInteractionTypeForStartDate:(NSDate *)startDate
//                                     endDate:(NSDate *)endDate;
+ (NSString *)getTypeOfDate:(NSDate *)date;
+ (NSString *) getWeekDay;

+(NSString*)remaningTime:(NSDate*)startDate endDate:(NSDate*)endDate;
+ (NSString *)getDateFromPicker:(NSDate *)givenDate;


+ (NSDate *)setDOBtoPicker:(NSString *)givenDate;
+ (NSString *)getTimeStampfromDate:(NSDate *)date;


@end
