//
//  GlobalFunction.m
//  TabRabbit
//
//  Created by C174 on 08/02/17.
//  Copyright © 2017 C174. All rights reserved.
//

#import "GlobalFunction.h"
#import "NSDate+Utils.h"

@implementation GlobalFunction

+(void) cornerRadious:(CGFloat)radious toView:(UIView *)view
{
    view.layer.cornerRadius = radious;
    view.layer.masksToBounds = YES;
}

+(void) paddintoTextField:(UITextField *)textField withPadding:(int)width
{
UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
textField.leftView = paddingView;
textField.leftViewMode = UITextFieldViewModeAlways;
}


+ (UIImage*) drawImage:(UIImage*) drawImage
               inImage:(UIImage*)  image
               atPoint:(CGPoint)   point
                color :(UIColor *)colorname
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 2.0f);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    
    //  [drawImage drawAtPoint:CGPointMake((image.size.width/2 - drawImage.size.width/2) - 3, point.y)];
    [drawImage drawAtPoint:CGPointMake(point.x, point.y)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

+(NSString *) getRemaining: (NSDate *)endTime
{
    float timeInterval = [endTime timeIntervalSinceDate:[NSDate date]];
    if(timeInterval > 0)
    {
        //NSLog(@"%@",[self stringFromTimeInterval:[endTime timeIntervalSinceDate:[NSDate date]]]);
        return [self stringFromTimeInterval:[endTime timeIntervalSinceDate:[NSDate date]]] ;
    }
    else
    {
        return @"00:00:00";
    }
}


+(NSString *) getDateDifferance : (NSString *)endingTime
{
    NSDate *date2 = [self dateStringUTC:endingTime fromFormat:@"YYYY-MM-dd HH:mm:ss" toFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //NSLog(@"%@",[NSDate date]);
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:[NSDate date]];
    int numberOfDays = secondsBetween / 86400;
   // float numberOfHours = secondsBetween / 3600;
    //int numberOfMinutes = secondsBetween / 60;
    
    if(numberOfDays == 0)
    {
        //NSLog(@"%@",[NSString stringWithFormat:@"%@",[self getRemainingTime:startingTime valideHours:numberOfHours]]);
        return [NSString stringWithFormat:@"%@",[self getRemaining:date2]];
    }
    else
    {
        //NSLog(@"%@",[NSString stringWithFormat:@"%i",numberOfDays]);
        return [NSString stringWithFormat:@"%i Days",numberOfDays];
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
            durationString = [NSString stringWithFormat:@"%ld days", (long)days];
        }
        else {
            durationString = [NSString stringWithFormat:@"%ld day", (long)days];
        }
        //durationString=[NSString stringWithFormat:@"%ld",days*24];
        return durationString;
    }
    
    if (hour > 0) {
        
        if (hour > 1) {
            durationString = [NSString stringWithFormat:@"%ld hours", (long)hour];
        }
        else {
            durationString = [NSString stringWithFormat:@"%ld hour", (long)hour];
        }
        return durationString;
    }
    
    if (minutes > 0) {
        
        if (minutes > 1) {
            durationString = [NSString stringWithFormat:@"%ld minutes", (long)minutes];
        }
        else {
            durationString = [NSString stringWithFormat:@"%ld minute", (long)minutes];
        }
        return durationString;
    }
    
    return @"";
}
+ (NSString *)dateStringLocal:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat
{
    NSDate *localDate = [[self dateStringUTC:date fromFormat:fromFormat toFormat:fromFormat] toLocalTime];
    //NSLog(@"%@",[self getDateStringFromDate:localDate withFormate:toFormat]);
    return [self getDateStringFromDate:localDate withFormate:toFormat];
}

+ (NSString *)getDateStringFromDate :(NSDate *)date withFormate:(NSString *)format
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSDate *)getDateFromDateString :(NSString *)dateString withFormate:(NSString *)format{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

+(NSString *)changeformate_string24hr:(NSString *)date
{
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    [df setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate* wakeTime = [df dateFromString:date];
    [df setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    return [df stringFromDate:wakeTime];
}

+(NSString *)changeformate_string12hr:(NSString *)date
{
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    
    [df setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSDate* wakeTime = [df dateFromString:date];
    
    
    [df setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    
    return [df stringFromDate:wakeTime];
    
}

+ (NSDate *)dateStringUTC:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //[formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    formatter.dateFormat = fromFormat;
    NSDate *originalDate=[formatter dateFromString:date];
    formatter.dateFormat = toFormat;
    NSLog(@"%@",[formatter dateFromString:[formatter stringFromDate:originalDate]]);
    
    return [formatter dateFromString:[formatter stringFromDate:originalDate]];
}


+ (NSDate *)dateString:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    formatter.dateFormat = fromFormat;
    NSDate *originalDate=[formatter dateFromString:date];
    formatter.dateFormat = toFormat;
    return [formatter dateFromString:[formatter stringFromDate:originalDate]];
}

+ (NSString *)stringDate:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    formatter.dateFormat = fromFormat;
    NSDate *originalDate=[formatter dateFromString:date];
    formatter.dateFormat = toFormat;
    return [formatter stringFromDate:originalDate];
}

+ (NSString *)calenderstringDate:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    formatter.dateFormat = fromFormat;
    NSDate *originalDate=[formatter dateFromString:date];
  //  originalDate=[originalDate dateByAddingTimeInterval:1*60*60];
    formatter.dateFormat = toFormat;
    return [formatter stringFromDate:originalDate];
}
+ (NSString *)dateAfter1Hour:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    formatter.dateFormat = fromFormat;
    NSDate *originalDate=[formatter dateFromString:date];
    originalDate=[originalDate dateByAddingTimeInterval:1*60*60];
    formatter.dateFormat = toFormat;
    return [formatter stringFromDate:originalDate];
}
+ (NSDate *)endTimeFromDate:(NSDate *)date withHours:(int)hours 
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
    components.hour =components.hour + hours;
    components.minute = 0;
    components.second = 0;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

+(NSString *)getRemainingTime:(NSString *)currentTime
{
    if([currentTime isEqualToString:@"00:00:00"])
    {
        return @"00:00:00";
    }
    
    NSDate *time = [self dateString:currentTime fromFormat:@"HH:mm:ss" toFormat:@"HH:mm:ss"];
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:time];
    components.hour =components.hour;
    components.minute = components.minute;
    components.second = components.second - 1;
    
    NSDate *date =[CURRENT_CALENDAR dateFromComponents:components];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"YYYY-mm-dd HH:mm:ss"]; 
    NSString *strDate = [dateformate stringFromDate:date];
    
    return [self stringDate:strDate fromFormat:@"YYYY-mm-dd HH:mm:ss" toFormat:@"HH:mm:ss"];
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

//To Give Corner Radious Specific corner only

+ (UIView *)roundCornersOnView:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius
{
    if (tl || tr || bl || br) {
        UIRectCorner corner = 0;
        if (tl) corner = corner | UIRectCornerTopLeft;
        if (tr) corner = corner | UIRectCornerTopRight;
        if (bl) corner = corner | UIRectCornerBottomLeft;
        if (br) corner = corner | UIRectCornerBottomRight;
        
        UIView *roundedView = view;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:roundedView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = roundedView.bounds;
        maskLayer.path = maskPath.CGPath;
        roundedView.layer.mask = maskLayer;
        // view.layer.masksToBounds = YES;
        view.clipsToBounds = YES;
        return roundedView;
    }
    return view;
}

+(void)drawInnerShadowOnView:(UIView *)view
{
    UIImageView *innerShadowView = [[UIImageView alloc] initWithFrame:view.bounds];
    
    innerShadowView.contentMode = UIViewContentModeScaleToFill;
    innerShadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [view addSubview:innerShadowView];
    
    [innerShadowView.layer setMasksToBounds:YES];
    
    [innerShadowView.layer setBorderColor:[UIColor blackColor].CGColor];
    [innerShadowView.layer setShadowColor:[UIColor blackColor].CGColor];
    [innerShadowView.layer setBorderWidth:1.0f];
    
    [innerShadowView.layer setShadowOffset:CGSizeMake(0, 0)];
    [innerShadowView.layer setShadowOpacity:1.0];
    
    // this is the inner shadow thickness
    [innerShadowView.layer setShadowRadius:1.5];
}


+(void) ShowAlert:(NSString *) title Message:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:alertAction];
    
    //UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(errorAlert, animated: true, completion: nil
    
    [[GlobalFunction topMostController] presentViewController:alertController animated:true completion:nil];
    
}


+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

- (void)GetCurrentTimeStamp:(NSString *)date
{
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
  //  NSString    *strTime = [objDateformat stringFromDate:date];
    NSString    *strUTCTime = [self GetUTCDateTimeFromLocalTime:date];//You can pass your date but be carefull about your date format of NSDateFormatter.
    NSDate *objUTCDate  = [objDateformat dateFromString:strUTCTime];
  
    long long milliseconds = (long long)([objUTCDate timeIntervalSince1970] * 1000.0);
    
    NSString *strTimeStamp = [NSString stringWithFormat:@"%lld",milliseconds];
    NSLog(@"The Timestamp is = %@",strTimeStamp);
}

- (NSString *) GetUTCDateTimeFromLocalTime:(NSString *)IN_strLocalTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy hh:mm a"];
    NSDate  *objDate    = [dateFormatter dateFromString:IN_strLocalTime];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *strDateTime   = [dateFormatter stringFromDate:objDate];
    return strDateTime;
}
@end
