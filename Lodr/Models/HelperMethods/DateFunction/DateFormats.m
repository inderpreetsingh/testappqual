//
//  DateFormats.m
//  mpa
//
//  Created by C218 on 25/08/16.
//  Copyright © 2016 C218. All rights reserved.
//

#import "DateFormats.h"

@implementation DateFormats

#pragma mark - Date Format

@synthesize dateFormat;

static DateFormats *sharedDateFormatInstance = nil;

#pragma mark - Shared Manager

+ (DateFormats *) sharedDateFormatInstance
{
    @synchronized(self)
    {
        if (sharedDateFormatInstance == nil)
        {
            sharedDateFormatInstance = [[super allocWithZone:NULL] init];
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [DateFormats sharedDateFormatInstance].dateFormat = [[NSDateFormatter alloc] init];
                [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
                
                //                 [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
                
                NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
                [[DateFormats sharedDateFormatInstance].dateFormat setLocale:enUSPOSIXLocale];
            });
        }
    }
    
    return sharedDateFormatInstance;
}

#pragma mark - Convert To Local TimeZone

+ (NSString *)convertDateToLocalTimeZone:(NSString *)givenDate
{
    NSString *final_date;
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];    //SET TIME ZONE FORMAT OF SERVER HERE
    
    NSDate* ts_utc = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:SERVER_DATE_FORMAT];
    
    final_date = [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:ts_utc];
    return final_date;
}

+ (NSDate *)convertDateToLocalTimeZoneForDate:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];    //SET TIME ZONE FORMAT OF SERVER HERE
    
    NSString *strDate = [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:strDate];
}

+ (NSDate *)convertDateToLocalTimeZoneForDateFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];    //SET TIME ZONE FORMAT OF SERVER HERE
    
    return [self toLocalTime:[[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate]];
}

+ (NSDate *)convertDateToLocalTimeForDateFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone localTimeZone]];    //SET TIME ZONE FORMAT OF SERVER HERE
    
    return [self toLocalTime:[[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate]];
}

+(NSDate *) toLocalTime:(NSDate *)ndate
{
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: ndate];
    return [NSDate dateWithTimeInterval: seconds sinceDate: ndate];
}


+ (NSString *)convertLocalDateTimeToServerTimeZone:(NSString *)givenDate
{
    NSString *final_date;
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate* ts_utc = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    final_date = [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:ts_utc];
    return final_date;
}

+ (NSString *)generateDateForGivenDateToServerTimeZone:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_TIME_FORMAT];
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];    //SET TIME ZONE FORMAT OF SERVER HERE
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
}

+ (NSString *)generateDefaultEndDateForGivenDateToServerTimeZone:(NSDate *)givenDate withDays:(int)days
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    NSDate *gameDate = [calendar dateByAddingComponents:components toDate:givenDate options:0];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_TIME_FORMAT];
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];    //SET TIME ZONE FORMAT OF SERVER HERE
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:gameDate];
}

#pragma mark - Common Formats

+ (NSString *)getStringFromDateString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:SIMPLE_DATE_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
}

+ (NSString *)getStringFromDate:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
}

+ (NSString *)getFullDateStringFromDate:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:FACEBOOK_FEED_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
}

+ (NSString *)getFullDateStringFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:FACEBOOK_FEED_DATE_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
    
}


+ (NSDate *)getDateFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:SIMPLE_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
}

+ (NSDate *)getDateFromDate:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSString *strDate = [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:SIMPLE_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:strDate];
}

+ (NSDate *)dateForCalenderResponse:(NSString*)givenDate{
    
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    //SERVER_DATE_FORMAT_TIMESLOT OLD
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:BIRTH_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
}

+ (NSString *)getStringDateStringCalenderResponse:(NSString*)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
    
}



#pragma mark - Timestamp Formats

+ (NSString *)getTimestampUTC:(NSString *)strDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:TIME_STAMP_DATE];
    
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:strDate];
}

+ (NSDate *)getTimestampFromGivenDate:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:SERVER_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
}

#pragma mark - Facebook Share Date Time

+ (NSString *)convertDateToFacebookFeed:(NSString *)givenDate
{
    NSString *final_date;
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];//SET TIME ZONE FORMAT OF SERVER HERE
    
    NSDate* ts_utc = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:FACEBOOK_FEED_DATE_FORMAT];
    
    final_date = [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:ts_utc];
    return final_date;
}



#pragma mark - Picker Display Format

+ (NSString *)getDateStringValueFromDate:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:SERVER_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
}

+ (NSString *)getTimeStringValueFromDate:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:PICKER_TIME_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
}

+ (NSString *)getDateTimeStringValueFromDate:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:PICKER_DATE_TIME_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
}

+ (NSString *)getDateMonthTimeStringValueFromDate:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:PICKER_DATE_MONTH_TIME_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
}

#pragma mark - Generate Date

+ (NSString *)generateDateForGivenDate:(NSDate *)strDate andTime:(NSDate *)strTime
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_FORMAT];
    NSString *dt = [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:strDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_TIME_FORMAT];
    NSString *tm = [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:strTime];
    
    return [NSString stringWithFormat:@"%@ %@", dt, tm];
}

+ (NSString *)generateDateForGivenDate:(NSDate *)strDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_TIME_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:strDate];
}

+ (NSString *)generateOnlyDateForGivenDate:(NSDate *)strDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:strDate];
}


#pragma mark - Birth Date

+ (NSDate *)getDateBirthdateFromFromGivenTimestamp:(NSString *)givenTimeStamp
{
    int64_t timeStamp = atoll([givenTimeStamp UTF8String]);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return date;
}


+ (NSDate *)getBirthDateFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:PICKER_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
}

//+ (NSDate *)birthdayConstraintForPlayer:(NSDate *)givenDate
//{
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//    [dateComponents setYear:kDefaultAgeOFUser];
//    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:givenDate options:0];
//}

+ (NSString *)generateBirthDateForGivenDate:(NSDate *)strDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:BIRTH_DATE_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:strDate];
}

+ (NSDate *)generateBirthDateForGivenFacebookDate:(NSString *)strDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:FB_BIRTH_DATE_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:strDate];
}

+ (NSInteger)calculateAgeForPlayer:(NSString *)DOB
{
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_FORMAT];
    
    NSDate* birthday = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:DOB];
    
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthday
                                       toDate:now
                                       options:0];
    NSInteger age = [ageComponents year];
    return age;
}


+(NSInteger)getYearFormDate:(NSDate*)givenDate{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:givenDate];
    
    return [components year]; // gives you year
}

+(NSInteger)getMonthFormDate:(NSDate*)givenDate{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:givenDate];
    
    return[components month]; //gives you month
}

+ (NSString *)getStringForCalenderFromDate:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:BIRTH_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
}



#pragma mark - Game Formats

+ (NSString *)getStringDateForBookFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:BIRTH_DATE_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
}

+ (NSString *)getStringDateFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:PICKER_DATE_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
}

+ (NSString *)getStringTimeFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:PICKER_TIME_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
}

+ (NSString *)getStringTimeFromStringUTC:(NSString *)givenDate DeliveryDate:(NSString *)deliveryDate
{
   //[[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
 //   [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
   [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *fromDate;
    NSDate *toDate;
    
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];

    NSDate *date1 = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:deliveryDate];
    
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:date];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:date1];
    
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    NSInteger differDays = [difference day];
    
    if(differDays > 0){
    
        return [NSString stringWithFormat:@"%d",differDays];
        
        [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_TIME_CUSTOM_FORMAT];
        return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
        
    }
    else{
        return [NSString stringWithFormat:@"%@",differDays];
        [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:PICKER_TIME_FORMAT];
        return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
        
    }
  
}

+ (NSString *)getStringDateTimeFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:PICKER_DATE_TIME_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
}

+(NSString *)GetDateAfterAddingmonth:(NSInteger)month givenDate:(NSDate *)givenDate{
    
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setMonth:month];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComp toDate:givenDate options:0];
    return [DateFormats generateOnlyDateForGivenDate:newDate];
}

+(NSString *)GetDateAfterAddingYear:(NSInteger)Years givenDate:(NSDate *)givenDate{
    
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setYear:Years];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComp toDate:givenDate options:0];
    return [DateFormats generateOnlyDateForGivenDate:newDate];
}

+(NSDate *)GetDateFormateAfterAddingYear:(NSInteger)Years givenDate:(NSDate *)givenDate{
    
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setYear:Years];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComp toDate:givenDate options:0];
    return newDate;
}

#pragma mark - Match Formate
+ (NSString *)getStringOnlyDateAndMonthFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:[self convertDateToLocalTimeZone:givenDate]];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_MONTH_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
}

+ (NSString *)getStringFullDateTimeFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:MATCH_DATE_TIME_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
}

+ (NSString *) getStringDateWithSuffix:(NSString *)givenDate
{
    //Convert EEE dd MMM yyyy formate
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:MATCH_DATE_FORMAT];
    
    NSString *strDate = [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
    
    //To get only date from string
    NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
    [monthDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [monthDayFormatter setDateFormat:@"d"];
    
    int date_day = [[monthDayFormatter stringFromDate:date] intValue];
    
    [monthDayFormatter setDateFormat:@"yyyy"];
    int date_year = [[monthDayFormatter stringFromDate:date] intValue];
    
    strDate = [strDate stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%tu",date_year] withString:@""];
    
    //Add suffix
    NSString *suffix;
    int ones = date_day % 10;
    int tens = (date_day/10) % 10;
    
    if (tens ==1)
        suffix = @"th";
    else if (ones ==1)
        suffix = @"st";
    else if (ones ==2)
        suffix = @"nd";
    else if (ones ==3)
        suffix = @"rd";
    else
        suffix = @"th";
    
    //Final Date
    
    strDate = [strDate stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%tu",date_day] withString:[NSString stringWithFormat:@"%d%@",date_day,suffix]];
    strDate = [NSString stringWithFormat:@"%@%tu",strDate,date_year];
    
    return strDate;
}

+(NSString *)getLocalMatchFinishedTime:(NSString *)givenDate AddTotalTime:(NSInteger )AddTotalTime
{
    NSString *final_date;
    
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate* ts_utc = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    NSTimeInterval secondsInEightHours = AddTotalTime;
    NSDate *dateEightHoursAhead = [ts_utc dateByAddingTimeInterval:secondsInEightHours];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    final_date = [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:dateEightHoursAhead];
    
    return final_date;
}

#pragma mark - Generate Date
+ (NSDate *)addYears:(NSInteger)years addDays:(NSInteger)days toDate:(NSDate *)originalDate
{
    NSDateComponents *components= [[NSDateComponents alloc] init];
    [components setYear:years];
    [components setDay:days];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:components toDate:originalDate options:0];
}



+ (bool)isCheckCurrentDateBetween:(NSString *)startDate endDate:(NSString *)endDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *StartDate = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:startDate];
    NSDate *EndDate = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:endDate];
    
    NSDate *date = [NSDate date];
    
    // use a function name that matches the convention...
    if ([date compare:StartDate] == NSOrderedAscending)
        return YES;
    
    if ([EndDate compare:date] == NSOrderedDescending)
        return YES;
    
    return NO;
    
}


#pragma mark - Is Upcoming / Past Verification

+ (bool)isUpcomingDate:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    NSDate *currentDate = [NSDate date];
    
    switch ([date compare:currentDate]) {
        case NSOrderedSame:
            return false;
            break;
            
        case NSOrderedAscending:
            return false;
            break;
            
        case NSOrderedDescending:
            return true;
            break;
            
        default:
            return true;
            break;
    }
}

+ (bool)isUpcomingDateForDate:(NSDate *)givenDate currentDate:(NSDate*)currentServerDate
{
    if(currentServerDate == nil){
        currentServerDate = [NSDate date];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger comps = (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear);
    
    NSDateComponents *date1Components = [calendar components:comps
                                                    fromDate: currentServerDate];
    NSDateComponents *date2Components = [calendar components:comps
                                                    fromDate: givenDate];
    
    currentServerDate = [calendar dateFromComponents:date1Components];
    givenDate = [calendar dateFromComponents:date2Components];
    NSComparisonResult result = [currentServerDate compare:givenDate];
    
    switch (result) {
        case NSOrderedSame:
            return false;
            break;
            
        case NSOrderedAscending:
            return false;
            break;
            
        case NSOrderedDescending:
            return true;
            break;
            
        default:
            return true;
            break;
    }
}

+ (bool)isPastDate:(NSString *)givenDate
{
    //      [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    givenDate = [DateFormats getStringDateStringCalenderResponse:givenDate];
    NSString *currentstrDate = [DateFormats getStringFromDate:[NSDate date]];
    currentstrDate = [DateFormats getStringDateStringCalenderResponse:currentstrDate];

    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    NSDate *currentDate = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:currentstrDate];
    
    switch ([date compare:currentDate]) {
        case NSOrderedSame:
            return true;
            break;
            
        case NSOrderedAscending:
            return false;
            break;
            
        case NSOrderedDescending:
            return true;
            break;
            
        default:
            return true;
            break;
    }
}

+ (bool)isUpcomingTimeForDate:(NSDate *)givenDate currentDate:(NSDate*)currentServerDate
{
    if(currentServerDate == nil){
        currentServerDate = [NSDate date];
    }
    
    NSTimeInterval secondsInEightHours = 0.5 * 60 * 60;
    NSDate *newcurrentDate = [NSDate dateWithTimeInterval:secondsInEightHours sinceDate:currentServerDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger comps = (NSCalendarUnitHour | NSCalendarUnitMinute);
    
    NSDateComponents *date1Components = [calendar components:comps fromDate: newcurrentDate];
    NSDateComponents *date2Components = [calendar components:comps fromDate: givenDate];
    
    newcurrentDate = [calendar dateFromComponents:date1Components];
    givenDate = [calendar dateFromComponents:date2Components];
    NSComparisonResult result = [newcurrentDate compare:givenDate];
    
    switch (result) {
        case NSOrderedSame:
            return false;
            break;
            
        case NSOrderedAscending:
            return true;
            break;
            
        case NSOrderedDescending:
            return false;
            break;
            
        default:
            return false;
            break;
    }
}

+ (bool)isUpcomingDateAndTimeForDate:(NSDate *)givenDate currentDate:(NSDate*)currentServerDate
{
    if(currentServerDate == nil){
        currentServerDate = [NSDate date];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger comps = (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    
    NSDateComponents *date1Components = [calendar components:comps fromDate: currentServerDate];
    NSDateComponents *date2Components = [calendar components:comps fromDate: givenDate];
    
    currentServerDate = [calendar dateFromComponents:date1Components];
    givenDate = [calendar dateFromComponents:date2Components];
    NSComparisonResult result = [givenDate compare:currentServerDate];
    
    switch (result) {
        case NSOrderedSame:
            return false;
            break;
            
        case NSOrderedAscending:
            return false;
            break;
            
        case NSOrderedDescending:
            return true;
            break;
            
        default:
            return true;
            break;
    }
}


#pragma mark - Is Date Latest

+ (bool)isDateLatest:(NSDate *)endDate fromStartDate:(NSDate *)startDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:1];
    
    NSDate *date = [calendar dateByAddingComponents:components toDate:startDate options:0];
    
    switch ([endDate compare:date]) {
        case NSOrderedSame:
            return false;
            break;
            
        case NSOrderedAscending:
            return false;
            break;
            
        case NSOrderedDescending:
            return true;
            break;
            
        default:
            return true;
            break;
    }
}

+ (NSDate *)getLatestDateAddedByHour:(NSDate *)startDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:1];
    return [calendar dateByAddingComponents:components toDate:startDate options:0];
}

+ (NSDate *)getLatestDateAddedByDay:(NSDate *)startDate addDay:(NSInteger)addDay
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:addDay];
    return [calendar dateByAddingComponents:components toDate:startDate options:0];
}

#pragma mark - Calender End Date

+ (NSDate *)getCalenderEndDateFromString:(NSString *)givenDate withDuration:(int)duration
{
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:SIMPLE_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    date = [date dateByAddingTimeInterval:duration];
    return date;
}

+ (NSString *)getDifferenceFromStartDate:(NSDate *)startDate
                                 endDate:(NSDate *)endDate
{
    long num_seconds = fabs([endDate timeIntervalSinceDate:startDate]);
    
    NSInteger days, hours, minutes;
    
    days = num_seconds / (60 * 60 * 24);
    num_seconds -= days * (60 * 60 * 24);
    hours = num_seconds / (60 * 60);
    num_seconds -= hours * (60 * 60);
    minutes = num_seconds / 60;
    num_seconds -= minutes * 60;

    return [NSString stringWithFormat:@"%ld %ld %ld %ld", (long)days, hours, minutes, num_seconds];
}

+ (NSString *)getTimeStampForChat:(NSString *)date
{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[self convertDateToLocalTimeZoneForDateFromString:date]];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    if([today isEqualToDate:otherDate])
    {
        //do stuff
        [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
        
        NSDate *date1 = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:[self convertDateToLocalTimeZone:date]];
        
        [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_TIME_CUSTOM_FORMAT];
        return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date1];
    }
    else
    {
        [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
        
        NSDate *date1 = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:[self convertDateToLocalTimeZone:date]];
        
        [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_TIME_CUSTOM_FORMAT];
        return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date1];
    }
    
    return nil;
}

+ (NSString *)getStringCustomTimeFromString:(NSString *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
    NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:[self convertDateToLocalTimeZone:givenDate]];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_TIME_CUSTOM_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
}

+ (NSString *)getUniqueDateString:(NSString *)strDateType
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
   // NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:[self convertDateToLocalTimeZone:givenDate]];
    
    NSDate *date = [NSDate date];
    
    if([strDateType isEqualToString:@"1"]){
        
        [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
        
    }
    else{
        
        [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:UNIQUE_DATE_FORMAT];
        
        
    }
   return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
}

+ (NSString *)getHourAndMinuteFromGivenDate:(NSString *)strDateType
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
    
     NSDate *date = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:[self convertDateToLocalTimeZone:strDateType]];
    
    //NSDate *date = [NSDate date];
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:PICKER_TIME_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:date];
}
//+ (InteractionType)getInteractionTypeForStartDate:(NSDate *)startDate
//                                          endDate:(NSDate *)endDate
//{
//    long num_seconds = fabs([endDate timeIntervalSinceDate:startDate]);
//    
//    if (num_seconds < (15 * 60))
//    {
//        return BUMP;
//    }
//    else if (num_seconds < (60 * 60 * 3))
//    {
//        return BRIDGE;
//    }
//    else
//    {
//        return BOND;
//    }
//}
+ (NSString *) getWeekDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    
    NSDate *currentDate = [NSDate date];
    
    NSLog(@"%@", [dateFormatter stringFromDate:currentDate]);
    return [dateFormatter stringFromDate:currentDate];
    
}

+ (NSString *)getTypeOfDate:(NSDate *)date
{
    NSCalendarUnit units = NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:date
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.year > 0)
    {
        return [NSString stringWithFormat:@"%ld years ago", (long)components.year];
    }
    else if (components.month > 0)
    {
        return [NSString stringWithFormat:@"%ld months ago", (long)components.month];
    }
//    else if (components.weekOfYear > 0)
//    {
//        return [NSString stringWithFormat:@"%ld weeks ago", (long)components.weekOfYear];
//    }
    else if (components.day > 0)
    {
        if (components.day >= 2 && components.day <= 9)
        {
            return [NSString stringWithFormat:@"Last Week"];
        }
        else
        {
            return @"Yesterday";
        }
    }
    else
    {
        return @"Today";
    }
}
+(NSString*)remaningTime:(NSDate*)startDate endDate:(NSDate*)endDate {
    
    NSDateComponents *components;
    NSInteger days;
    NSInteger hour;
    NSInteger minutes;
    NSString *durationString;
    
    components = [[NSCalendar currentCalendar] components: NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute
                                                 fromDate: startDate toDate: endDate options: 0];
    days = [components day];
    hour = [components hour];
    minutes = [components minute];
    
    if (days > 0) {
        
        if (days > 1)
        {
            durationString = [NSString stringWithFormat:@"%ld", (long)days];
            //generateBirthDateForGivenDate
            NSString *strDate = [self generateBirthDateForGivenDate:endDate];
            
            durationString = [NSString stringWithFormat:@"Expires On %@",strDate];
            
        }
        else {
            durationString = [NSString stringWithFormat:@"Expires Today"];
        }
        
        //durationString=[NSString stringWithFormat:@"%ld",days*24];
        return durationString;
    }
    
    if (hour > 0) {

        durationString = [NSString stringWithFormat:@"Expires Today"];
//        if (hour > 1) {
//            durationString = [NSString stringWithFormat:@"%ld hours", (long)hour];
//        }
//        else {
//            durationString = [NSString stringWithFormat:@"%ld hour", (long)hour];
//        }
        return durationString;
    }
    
    if (minutes > 0) {
        
        durationString = [NSString stringWithFormat:@"Expires Today"];
        
//        if (minutes > 1) {
//            durationString = [NSString stringWithFormat:@"%ld minutes", (long)minutes];
//        }
//        else {
//            durationString = [NSString stringWithFormat:@"%ld minute", (long)minutes];
//        }
//        return durationString;
    }
    if(days <= 0 && hour <= 0 && minutes <= 0){
    
        return @"Expired";
        
    }
    
    return @"";
}

//+(NSString *)GetRemainingRateHours : (NSString*)givenDate
//{
//    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
//    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:GLOBAL_DATE_FORMAT];
//    
//    NSDate *startDate = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString: [DateFormats getStringFromDate:[DateFormats addYears:0 addDays:-1 toDate:[NSDate date]]]];
//    NSDate *endDate = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
//    
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *components = [gregorianCalendar
//                                    components: NSCalendarUnitDay|NSHourCalendarUnit|NSMinuteCalendarUnit
//                                    fromDate:startDate
//                                    toDate:endDate
//                                    options:0];
//    
//    NSLog(@"Day ---%ld  hour ---%ld   minute ---%ld       minuteHii ---%0.2f", [components day],[components hour],[components minute],(float)[components minute]/60);
//    float totalHours = [components day]* 24  + [components hour] + (float)[components minute]/60 ;
//    //    float remainingHours = kDefaultRateGameDays*24 - (float)[components minute]/60;
//    
//    /*if ([components day] > 3) {
//     return [NSString stringWithFormat:@"%tu days",[components day]];
//     }*/
//    if (totalHours > 72) {
//        return [NSString stringWithFormat:@"%tu days",[components day]];
//    }
//    if (totalHours < 0) {
//        return nil;
//    }
//    if (totalHours >= 48 && totalHours <= 72) {
//        return @"2 days";
//    }
//    else if (totalHours >= 24 && totalHours < 48) {
//        return @"1 day";
//    }
//    else if (totalHours > 1 && totalHours < 24)
//    {
//        return [NSString stringWithFormat:@"%.0f hrs",totalHours];
//    }
//    else if (totalHours == 1)
//    {
//        return [NSString stringWithFormat:@"%.0f hr",totalHours];
//    }
//    else {
//        return [NSString stringWithFormat:@"%ld min", 60- [components minute] ];
//    }
//    
//}

+ (NSString *)getTimeStampfromDate:(NSDate *)date
{
    
    NSTimeInterval timeStamp = [date timeIntervalSince1970];
    // NSTimeInterval is defined as double
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    
    return [NSString stringWithFormat:@"%@",timeStampObj];
    
}
+ (NSString *)getDateFromPicker:(NSDate *)givenDate
{
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_FORMAT];
    
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
}

+ (NSDate *)setDOBtoPicker:(NSString *)givenDate
{
//    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
//    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:PICKER_DATE];
//    return [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:ONLY_DATE_FORMAT];
    [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
  //  [[DateFormats sharedDateFormatInstance].dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate* ts_utc = [[DateFormats sharedDateFormatInstance].dateFormat dateFromString:givenDate];
    return ts_utc;
    
    [[DateFormats sharedDateFormatInstance].dateFormat setDateFormat:BIRTH_DATE_FORMAT];
    return [[DateFormats sharedDateFormatInstance].dateFormat stringFromDate:givenDate];
    
}

@end
