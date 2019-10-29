//
//  BaseVC.m
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "BaseVC.h"
#import "EquiEspecial.h"
#import "SubEquiEspecial.h"
#import "JTProgressHUD.h"
@interface BaseVC ()
{
    int webcallcount;
    
}
@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)leftViewPaddingForTextfield :(UITextField *)txtfield :(UIImage*)imgname withWidth:(CGFloat)w andHeight:(CGFloat)h withOriginY:(CGFloat)y
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,y, w, h)];
    imgView.image = imgname;
    [paddingView addSubview:imgView];
    [txtfield setLeftViewMode:UITextFieldViewModeAlways];
    [txtfield setLeftView:paddingView];
}
-(void)cornerRadiousSettingforView :(UIView *)vwnm withCornerNameOne:(UIRectCorner)corner1 withCornerNameTwo:(UIRectCorner)corner2 withsize:(CGFloat)sizeval
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:vwnm.bounds
                                     byRoundingCorners:(corner1|corner2)
                                           cornerRadii:CGSizeMake(sizeval, sizeval)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = vwnm.bounds;
    maskLayer.path = maskPath.CGPath;
    vwnm.layer.mask = maskLayer;
}
-(void)cornerRadiousSettingforView :(UIView *)vwnm withCornerNameOne:(UIRectCorner)corner1 withCornerNameTwo:(UIRectCorner)corner2 withsize:(CGFloat)sizeval withColor1:(UIColor*)colorone withColor2:(UIColor*)colortwo
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:vwnm.bounds
                                     byRoundingCorners:(corner1|corner2)
                                           cornerRadii:CGSizeMake(sizeval, sizeval)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = vwnm.bounds;
    maskLayer.path = maskPath.CGPath;
    vwnm.layer.mask = maskLayer;
    vwnm.layer.borderColor=colortwo.CGColor;
    vwnm.layer.borderWidth=1.0f;
}
-(void)changePlaceholderColor :(UIView *)vname :(UIColor *)cname
{
    [vname setValue:cname forKeyPath:@"_placeholderLabel.textColor"];
}
-(void)addBorderToView :(UIView *)vwname withColor :(UIColor*)cname withBorderWidth :(CGFloat)width withRadius :(CGFloat)radious
{
    vwname.layer.borderColor=cname.CGColor;
    vwname.layer.borderWidth=width;
    vwname.layer.cornerRadius=radious;
}
-(void)cornerRadiousSettingforView :(UIView *)vwnm withCornerNameOne:(UIRectCorner)corner1 withCornerNameTwo:(UIRectCorner)corner2 withCornerNameThree:(UIRectCorner)corner3 withsize:(CGFloat)sizeval
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:vwnm.bounds
                                     byRoundingCorners:(corner1|corner2)
                                           cornerRadii:CGSizeMake(sizeval, sizeval)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = vwnm.bounds;
    maskLayer.path = maskPath.CGPath;
    vwnm.layer.mask = maskLayer;
}
-(BOOL)validateTxtFieldLength :(UITextField*)txtVal withMessage :(NSString *)msg
{
    if(TRIM(txtVal.text).length==0)
    {
        [AZNotification showNotificationWithTitle:msg controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
        //        [self displyMessageWithText:@"Invalid Password" withBgColor:[UIColor colorWithRed:54.0f/255.0f green:54.0f/255.0f  blue:54.0f/255.0f  alpha:0.8f]
        //                        withFgColor:[UIColor whiteColor]  withFont:@"System" withFontSize:15.0f
        //                       withDuration:3.0f inview:self.view withposition:CSToastPositionCenter];
        return NO;
    }
    return YES;
}
-(BOOL)validateTxtLength :(NSString*)txtVal withMessage :(NSString *)msg
{
    if(TRIM(txtVal).length==0)
    {
        [AZNotification showNotificationWithTitle:msg controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
        //        [self displyMessageWithText:@"Invalid Password" withBgColor:[UIColor colorWithRed:54.0f/255.0f green:54.0f/255.0f  blue:54.0f/255.0f  alpha:0.8f]
        //                        withFgColor:[UIColor whiteColor]  withFont:@"System" withFontSize:15.0f
        //                       withDuration:3.0f inview:self.view withposition:CSToastPositionCenter];
        return NO;
    }
    return YES;
}
-(BOOL)validateEmailText :(NSString*)txtVal withMessage :(NSString *)msg
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if([emailTest evaluateWithObject:txtVal])
    {
        return YES;
    }
    else
    {
        [AZNotification showNotificationWithTitle:msg controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
        return NO;
    }
}
-(BOOL)validateEmail :(UITextField*)txtVal withMessage :(NSString *)msg
{
    
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if([emailTest evaluateWithObject:txtVal.text])
    {
        return YES;
    }
    else
    {
        [AZNotification showNotificationWithTitle:msg controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
        return NO;
    }
}
-(BOOL)validatePassword :(UITextField*)txtVal confirmpassword :(UITextField *)txtVal2 withMessage :(NSString *)msg
{
    if(![txtVal.text isEqualToString:txtVal2.text])
    {
        [AZNotification showNotificationWithTitle:msg controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
        return NO;
    }
    return YES;
}
-(BOOL)validateVerifyText :(NSString*)txtVal confirmpassword :(NSString *)txtVal2 withMessage :(NSString *)msg
{
    if(![txtVal isEqualToString:txtVal2])
    {
        [AZNotification showNotificationWithTitle:msg controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
        return NO;
    }
    return YES;
}

-(void)showHUD :(NSString *)str
{
//    [SVProgressHUD showWithStatus:str];
//    [SVProgressHUD setRingThickness:5.0f];
//    [SVProgressHUD setForegroundColor:ThemeOrangeColor];
//     [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [JTProgressHUD showWithStyle:JTProgressHUDStyleGradient andText:str];
}
-(void)dismissHUD
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
    
    [JTProgressHUD hide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)getAllEquipmentsBase
{
    NSDictionary *dicAllEqui=@{
                               Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                               Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey]};    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetEquipmentEspecial
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getEquiResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Loading Equipments"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getEquiResponse:(id)sender
{
    if ([sender serviceResponseCode] != 100)
    {
        if([sender serviceResponseCode] ==  -1005 || [sender serviceResponseCode] ==  -1001)
        {
            if(webcallcount !=2)
            {
                [self getAllEquipmentsBase];
                webcallcount=webcallcount+1;
            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }        
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            [self getEspecialEquipmentsBase];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
-(void)getEspecialEquipmentsBase
{
    NSDictionary *dicAllEqui=@{
                               Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                               Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey]};    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetEquipmentSubEspecial
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getEspeciaEquiResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Processing"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getEspeciaEquiResponse:(id)sender
{
    [JTProgressHUD hide];
    if ([sender serviceResponseCode] != 100)
    {
        if([sender serviceResponseCode] ==  -1005 || [sender serviceResponseCode] ==  -1001)
        {
            if(webcallcount!=2)
            {
                [self getEspecialEquipmentsBase];
                webcallcount=webcallcount+1;
            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }    
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
-(NSString *)checkDevToken
{
    NSString *devtoken;
    if([DefaultsValues getStringValueFromUserDefaults_ForKey:SavedDeviceToken] == nil)
    {
        devtoken=@"";
    }
    else
    {
        devtoken=[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedDeviceToken];
    }  
    return devtoken;
}
-(void)setbuttonimageRightSide:(UIButton *)btn
{
    btn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    btn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    btn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
}
- (NSArray*)splitTextToLines:(NSUInteger)maxLines Tolable:(UILabel *)lbl {
    float width = lbl.frame.size.width;
    
    NSArray* words = [lbl.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray* lines = [NSMutableArray array];
    
    NSMutableString* buffer = [NSMutableString string];    
    NSMutableString* currentLine = [NSMutableString string];
    
    for (NSString* word in words) {
        if ([buffer length] > 0) {
            [buffer appendString:@" "];
        }
        
        [buffer appendString:word];
        
        if (maxLines > 0 && [lines count] == maxLines - 1) {
            [currentLine setString:buffer];
            continue;
        }
        
        float bufferWidth = [buffer sizeWithFont:lbl.font].width;
        
        if (bufferWidth < width) {
            [currentLine setString:buffer];
        }
        else {
            [lines addObject:[NSString stringWithString:currentLine]];
            
            [buffer setString:word];
            [currentLine setString:buffer];
        }
    }
    
    if ([currentLine length] > 0) {
        [lines addObject:[NSString stringWithString:currentLine]];
    }
    
    return lines;
}

- (void)drawRect:(CGRect)rect :(UILabel *)textval
{
    if ([textval.text length] == 0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, textval.textColor.CGColor);
    CGContextSetShadowWithColor(context, textval.shadowOffset, 0.0f, textval.shadowColor.CGColor);
    
    NSArray* lines = [self splitTextToLines:textval.numberOfLines Tolable:textval];
    NSUInteger numLines = [lines count];
    
    CGSize size = textval.frame.size;
    CGPoint origin = CGPointMake(0.0f, 0.0f);
    
    for (NSUInteger i = 0; i < numLines; i++) {
        NSString* line = [lines objectAtIndex:i];
        
        if (i == numLines - 1) {
            [line drawAtPoint:origin forWidth:size.width withFont:textval.font lineBreakMode:NSLineBreakByTruncatingTail];            
        }
        else {
            [line drawAtPoint:origin forWidth:size.width withFont:textval.font lineBreakMode:NSLineBreakByClipping];
        }
        
        origin.y += textval.font.lineHeight;
        
        if (origin.y >= size.height) {
            return;
        }
    }
}
-(void)viewWithAnimationFormView:(UIView *)v1 Toview:(UIView *)v2 transitionType:(NSString *)typenm withAnimation:(BOOL)animationEnable
{
    CGFloat duration;
    if(animationEnable)
    {
        duration=0.3;
    }
    else
    {
        duration=0.0;
    }
    if([typenm isEqualToString:@"PUSHVIEW"])
    {
        CGRect basketTopFrame =  v1.frame;
        basketTopFrame.origin.x = 0;
        v1.frame=basketTopFrame; 
        CGRect basketTopFrame2 =  v2.frame;
        basketTopFrame2.origin.x = SCREEN_WIDTH;
        v2.frame=basketTopFrame2; 
        v2.alpha=1;
        
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
         {  
             CGRect basketTopFrame =  v1.frame;
             basketTopFrame.origin.x = -SCREEN_WIDTH;
             v1.frame=basketTopFrame; 
             CGRect basketTopFrame2 =  v2.frame;
             basketTopFrame2.origin.x = 0;
             v2.frame=basketTopFrame2; 
         }
        completion:^(BOOL finished)
         { 
             v1.alpha=0;
         }];
    }
    else
    {
        v1.alpha=1;
        v2.alpha=1;
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
         {  
             CGRect basketTopFrame =  v1.frame;
             basketTopFrame.origin.x = 0;
             v1.frame=basketTopFrame; 
             
             CGRect basketTopFrame2 =  v2.frame;
             basketTopFrame2.origin.x = SCREEN_WIDTH;
             v2.frame=basketTopFrame2; 
         } completion:^(BOOL finished)
         { 
             v2.alpha=0;
         }];
    }
}
- (NSString *)numberLabelText:(float)count {
    
    if (!count) {
        return nil;
    }
    
    if (count >= 1000) 
    {
        float rounded;
        if (count < 10000) {
            rounded = ceilf(count/100)/10;
            return [NSString stringWithFormat:@"%.1fk", rounded];
        }
        else {
            rounded = roundf(count/1000);
            return [NSString stringWithFormat:@"%luk", (unsigned long)rounded];
        }
    }
    
    return [NSString stringWithFormat:@"%lu", (unsigned long)count];
}

- (UIImage*) drawText:(NSString*) text
              inImage:(UIImage*)  image
              atPoint:(CGPoint)   point
               color :(UIColor *)colorname
{
    text = [self numberLabelText:text.floatValue];
    UIFont *font = [UIFont boldSystemFontOfSize:8.5];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 2.0f);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragraphStyle,NSForegroundColorAttributeName:colorname };
    CGRect rect = [text boundingRectWithSize:CGSizeZero
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    [text drawAtPoint:CGPointMake(image.size.width/2 - rect.size.width/2, point.y) withAttributes:attributes];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage*) drawTextStatus:(NSString*) text
              inImage:(UIImage*)  image
              atPoint:(CGPoint)   point
               color :(UIColor *)colorname
{
    UIFont *font;
    if([text isEqualToString:@"DELIVERED"])
    {
        font = [UIFont boldSystemFontOfSize:7];
    }
    else
    {
        font = [UIFont boldSystemFontOfSize:9];
    }
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 2.0f);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragraphStyle,NSForegroundColorAttributeName:colorname };
    CGRect rect = [text boundingRectWithSize:CGSizeZero
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    [text drawAtPoint:CGPointMake(image.size.width/2 - rect.size.width/2, point.y) withAttributes:attributes];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;    
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    if (result == MessageComposeResultCancelled)
    {
        
    }
    else if (result == MessageComposeResultSent)
    {
        
    }
    else 
    {
        
    }
}
-(NSMutableArray *)getUsStates
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    [arr addObject:@"Alaska"];
    [arr addObject:@"Alabama"];
    [arr addObject:@"Arkansas"];
    [arr addObject:@"American Samoa"];
    [arr addObject:@"Arizona"];
    [arr addObject:@"California"];
    [arr addObject:@"Colorado"];
    [arr addObject:@"Connecticut"];
    [arr addObject:@"District of Columbia"];
    [arr addObject:@"Delaware"];
    [arr addObject:@"Florida"];
    [arr addObject:@"Georgia"];
    [arr addObject:@"Guam"];
    [arr addObject:@"Hawaii"];
    [arr addObject:@"Iowa"];
    [arr addObject:@"Idaho"];
    [arr addObject:@"Illinois"];
    [arr addObject:@"Indiana"];
    [arr addObject:@"Kansas"];
    [arr addObject:@"Kentucky"];
    [arr addObject:@"Louisiana"];
    [arr addObject:@"Massachusetts"];
    [arr addObject:@"Maryland"];
    [arr addObject:@"Maine"];
    [arr addObject:@"Michigan"];
    [arr addObject:@"Minnesota"];
    [arr addObject:@"Missouri"];
    [arr addObject:@"Mississippi"];
    [arr addObject:@"Montana"];
    [arr addObject:@"North Carolina"];
    [arr addObject:@"North Dakota"];
    [arr addObject:@"Nebraska"];
    [arr addObject:@"New Hampshire"];
    [arr addObject:@"New Jersey"];
    [arr addObject:@"New Mexico"];
    [arr addObject:@"Nevada"];
    [arr addObject:@"New York"];
    [arr addObject:@"Ohio"];
    [arr addObject:@"Oklahoma"];
    [arr addObject:@"Oregon"];
    [arr addObject:@"Pennsylvania"];
    [arr addObject:@"Puerto Rico"];
    [arr addObject:@"Rhode Island"];
    [arr addObject:@"South Carolina"];
    [arr addObject:@"South Dakota"];
    [arr addObject:@"Tennessee"];
    [arr addObject:@"Texas"];
    [arr addObject:@"Utah"];
    [arr addObject:@"Virginia"];
    [arr addObject:@"Virgin Islands"];
    [arr addObject:@"Vermont"];
    [arr addObject:@"Washington"];
    [arr addObject:@"Wisconsin"];
    [arr addObject:@"West Virginia"];
    [arr addObject:@"Wyoming"];
    return arr;
}
-(void)updateUserLocation
{
    if([DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] !=nil || [DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId].length > 0)
    {
        NSDictionary *dicAllEqui=@{
                                   Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                   Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                   Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                   Req_UserLatitude:AppInstance.userCurrentLat,
                                   Req_UserLongitude:AppInstance.userCurrentLon
                                   };
        
        Drivers *objd=[DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDriverData];
        //0 - off duty 1- on duty
        if([objd.dutyStatus isEqualToString:@"0"]){
            
            NSLog(@"LOCATION NOT UPDATED AS DRIVER IS OFF DUTY");
//            [AZNotification showNotificationWithTitle:@"LOCATION NOT UPDATED AS DRIVER IS OFF DUTY" controller:self notificationType:AZNotificationTypeError];
            
            return;
            //dont call api if driver is off duty
            
        }
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLUpdateUserLocation
             withParameters:dicAllEqui
             withObject:self
             withSelector:@selector(getUpdateLocationResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Updating device location"
             showProgress:YES];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
    else
    {
        [AppInstance.locationtimer invalidate];
    }
    
}
-(IBAction)getUpdateLocationResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];   
        AppInstance.locationUpdated =@"NO";
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            AppInstance.locationUpdated =@"YES";
            
        }   
        else
        {
            AppInstance.locationUpdated =@"NO";
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
-(void)crashReporter:(NSString *)reportText
{
//    https://api.lodrapp.com/CrashReporting.php?errorMessage=%@
    NSString *str = [NSString stringWithFormat:@"https://app.lodrapp.com/narolaFTP/API/CrashReporting.php?errorMessage=%@",reportText];
    [[WebServiceConnector alloc]
     init:str
     withParameters:nil
     withObject:self
     withSelector:@selector(dummy:)
     forServiceType:@"GET"
     showDisplayMsg:@"Reporting"
     showProgress:YES];
   
}
-(IBAction)dummy:(id)sender
{
    [self dismissHUD];
}

@end
