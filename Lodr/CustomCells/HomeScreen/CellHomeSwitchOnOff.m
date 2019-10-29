//
//  CellHomeSwitchOnOff.m
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellHomeSwitchOnOff.h"
#import "JTProgressHUD.h"
#import "Drivers.h"
@implementation CellHomeSwitchOnOff
- (void)awakeFromNib
{
    [super awakeFromNib];
    if([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDriverData]!=nil)
    {
        Drivers *objd=[DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDriverData];
        if([objd.dutyStatus isEqualToString:@"0"])
        {
            if(SCREEN_WIDTH > 320 && SCREEN_WIDTH <= 375 )
            {
                self.leadingBtnDuty.constant = 184;
            }
            else if(SCREEN_WIDTH > 375)
            {
                self.leadingBtnDuty.constant = 201;
            }
            else
            {
                self.leadingBtnDuty.constant = CGRectGetWidth(self.frame) - CGRectGetWidth(_btnOnDuty.frame) - 3;
            }
            
            [self.btnOnDuty setBackgroundColor:[UIColor blackColor]];
            [self.btnOnDuty setTitle:@"OFF DUTY" forState:UIControlStateNormal];
             [self layoutIfNeeded];
        }
        else
        {
            self.leadingBtnDuty.constant = 3;
            [self.btnOnDuty setBackgroundColor:[UIColor colorWithRed:0/255.0 green:168/255.0 blue:1/255.0 alpha:1]];
            [self.btnOnDuty setTitle:@"ON DUTY" forState:UIControlStateNormal];
            [self layoutIfNeeded];
        }
    }
//    self.centerLayoutbtn.constant=-((SCREEN_WIDTH/2)-(self.btnOnDuty.frame.size.width+5)/2);
}


- (IBAction)btnOnDutyClicked:(id)sender
{
   
   if([self.btnOnDuty.titleLabel.text isEqualToString:@"ON DUTY"])
   {
      
       [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
        {  
            self.leadingBtnDuty.constant = CGRectGetWidth(self.frame) - CGRectGetWidth(_btnOnDuty.frame) - 3;
            
//            self.centerLayoutbtn.constant=(SCREEN_WIDTH/2) - (self.btnOnDuty.frame.size.width+5)/2;
            [self layoutIfNeeded];
        }
        completion:^(BOOL finished)
        { 
            [self.btnOnDuty setBackgroundColor:[UIColor blackColor]];
            [self.btnOnDuty setTitle:@"OFF DUTY" forState:UIControlStateNormal];
             [self UpdateDuty:@"0"];
        }];
   }
   else
   {
      
       [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
        {  
            self.leadingBtnDuty.constant = 3;
            [self layoutIfNeeded];
        }
        completion:^(BOOL finished)
        { 
            [self.btnOnDuty setBackgroundColor:[UIColor colorWithRed:0/255.0 green:168/255.0 blue:1/255.0 alpha:1]];
            [self.btnOnDuty setTitle:@"ON DUTY" forState:UIControlStateNormal];
             [self UpdateDuty:@"1"];
        }];
   }
}
-(void)UpdateDuty:(NSString *)tp
{
    NSDictionary *dicAllEqui=@{
                               Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                               Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                               Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                               Req_DutyType:tp
                               };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLUpdateDriverDuty
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getUpdatedDutyResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Updating driver duty"
         showProgress:YES];
    }
    else
    {
        [JTProgressHUD hide];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getUpdatedDutyResponse:(id)sender
{
    [JTProgressHUD hide];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];    
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            NSString *st=APIResponseMessage;
            Drivers *objd=[DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDriverData];
            if([st containsString:@"ON"])
            {
                objd.dutyStatus=@"1";
            }
            else
            {
                objd.dutyStatus=@"0";
            }
            [DefaultsValues setCustomObjToUserDefaults:objd ForKey:SavedDriverData];
            
              [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
        else
        {
              [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

@end
