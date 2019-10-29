//
//  MenuVC.m
//  Lodr
//
//  Created by Payal Umraliya on 16/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "MenuVC.h"
#import "CellMenu.h"
#import "PostLoadVC.h"
#import "PostEquipmentVC.h"
#import "HomeVC.h"
#import "LoginVC.h"
#import "MyLoadListVC.h"
#import "MyEquipmentList.h"
#import "RegistrationVC.h"
#import "ChooseLoadTrailers.h"
#import "DriverListVC.h"
#import "PostDriverVC.h"
#import "CalenderListVC.h"
#import "WebContentVC.h"
#import "ChooseEquiTypesVC.h"
#import "EditDotAccount.h"
#import "SettingsVC.h"
#import "DotWarning.h"
#import "DispatchListVC.h"
@interface MenuVC ()<DotWarningDelegate>
{
    NSArray *arrMenus;
    NSString *loggeduname,*selectedpopupname;
    UserAccount *objac;
    NSMutableArray *arrMiles;
    NSArray *arrAvailability;
    ZSYPopoverListView *listMiles;
     UIView *overlay,*overlayview;
    int milesvalue,availabilityvalue;
}
@end

@implementation MenuVC
#pragma mark -VC life cycle
- (void)viewDidLoad 
{
    [super viewDidLoad];
    arrMiles=[NSMutableArray new];
    UIView *footervw=[[UIView alloc]initWithFrame:CGRectZero];
    _tblMenu.tableFooterView=footervw;
    milesvalue=[DefaultsValues getIntegerValueFromUserDefaults_ForKey:SavedRadiusValue];
//    if([DefaultsValues getIntegerValueFromUserDefaults_ForKey:SavedAvailability] == 0)
//    {
//        [DefaultsValues setIntegerValueToUserDefaults:2 ForKey:SavedAvailability];
//    }
    availabilityvalue=[DefaultsValues getIntegerValueFromUserDefaults_ForKey:SavedAvailability];
}
-(void)createArrayOfMiles
{
    for(int i =50 ;i<=5000;i+=50)
    {
        [arrMiles addObject:[NSString stringWithFormat:@" %d",i]];
    }
    [arrMiles addObject:@""];
}
-(void)viewWillAppear:(BOOL)animated
{
    if([DefaultsValues getBooleanValueFromUserDefaults_ForKey:SavedSignedIn] == YES)
    {
        User *objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
        
        if(objuser.userAccount.count > 0)
        {
            objac=[objuser.userAccount objectAtIndex:0];
            //1 -d 3 -s 2 c
            if([objac.role containsString:@"2"] && [objac.role containsString:@"3"] )
            {
                arrMenus=[[NSArray alloc]initWithObjects:@"Home",@"Calendar",@"My Assets",@"Add New Asset",@"My Loads",@"Account",@"Change Radius",@"Dispatch",@"Notifications",@"Logout", @"Help", nil];
//                arrMenus=[[NSArray alloc]initWithObjects:@"Home",@"Calendar",@"My Assets",@"Add New Asset",@"My Loads",@"Create New Load",@"Account",@"Change Radius",@"Change Asset Availability",@"Dispatch",@"Logout", nil];
            }
            else if(([objac.role containsString:@"1"] && [objac.role containsString:@"2"]) || [objac.role containsString:@"2"])
            {
                arrMenus=[[NSArray alloc]initWithObjects:@"Home",@"Calendar",@"My Assets",@"Add New Asset",@"Account",@"Change Radius",@"Dispatch",@"Notifications",@"Logout", @"Help", nil];
            }
            else if(([objac.role containsString:@"1"] && [objac.role containsString:@"3"]) || [objac.role containsString:@"3"])
            {
//                arrMenus=[[NSArray alloc]initWithObjects:@"Home",@"Calendar",@"My Loads",@"Create New Load",@"Account",@"Change Radius",@"Dispatch",@"Logout", nil];
                  arrMenus=[[NSArray alloc]initWithObjects:@"Home",@"Calendar",@"My Loads",@"Account",@"Change Radius",@"Dispatch",@"Notifications",@"Logout", @"Help", nil];
            }
            else
            {
                arrMenus=[[NSArray alloc]initWithObjects:@"Home",@"Account",@"Notifications",@"Logout", @"Help", nil];
            }
            
            
            loggeduname=[NSString stringWithFormat:@"%@ %@",objuser.firstname,objuser.lastname];
        }
        else
        {
            arrMenus=[[NSArray alloc]initWithObjects:@"Help",@"Lodr.com",@"Logout", nil];
            loggeduname=[NSString stringWithFormat:@"%@ %@",objuser.firstname,objuser.lastname];
        }
    }
    else
    {
        arrMenus=[[NSArray alloc]initWithObjects:@"Forgot Password",@"Resend Verification Mail",@"Help",@"Lodr.com", nil];
        loggeduname=[NSString stringWithFormat:@""];
    }
    _lblLoggedUname.text=loggeduname;
    [self.tblMenu reloadData];
}
#pragma mark - tableview delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
    return arrMenus.count; 
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CellSideMenuSection *viewSection=[[CellSideMenuSection alloc] initWithFrame:CGRectMake(0, 0, self.tblMenu.frame.size.width, 45)];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellSideMenuSection" owner:self options:nil];
    viewSection = (CellSideMenuSection *)[nib objectAtIndex:0]; 
     [viewSection.btnMenuName setTitle:[arrMenus objectAtIndex:section] forState:UIControlStateNormal];
    viewSection.btnMenuName.tag=section;
    viewSection.btnMenuName.accessibilityIdentifier=[arrMenus objectAtIndex:section];
    viewSection.cellSideMenuSectionDelegate=self;
    return viewSection;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 45.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    static NSString *cellIdentifier = @"CellMenu";
    CellMenu *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) 
    { 
        cell = [[CellMenu alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
    }
    cell.lblMenuName.text=[arrMenus objectAtIndex:indexPath.row];
   
    return cell; 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}
-(void)requestForForgotPasswordWithEmail:(NSString *)emailid
{
    @try {
        if([[NetworkAvailability instance]isReachable])
        {
            NSDictionary *dicGetPwdViaEmail = @{
                                                Req_secret_key:GlobalSecretKey,
                                                Req_access_key:GlobalAccessKey,
                                                Req_email:emailid
                                                };
            [[WebServiceConnector alloc]
             init:URLForgotPassword
             withParameters:dicGetPwdViaEmail
             withObject:self
             withSelector:@selector(getForgotPwdResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Sending request for password recovery"
             showProgress:YES];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    } @catch (NSException *exception) {
        [self dismissHUD];
    } 
}
-(void)requestForVerficationEmail:(NSString *)emailid
{
    @try {
        
        if([[NetworkAvailability instance]isReachable])
        {
            NSDictionary *dicVerifyEmail = @{
                                             Req_secret_key:GlobalSecretKey,
                                             Req_access_key:GlobalAccessKey,
                                             Req_firstname:@"",
                                             Req_email:emailid
                                             };
            [[WebServiceConnector alloc]
             init:URLVerificationEmail
             withParameters:dicVerifyEmail
             withObject:self
             withSelector:@selector(getVerificationResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Requesting for verification email"
             showProgress:YES];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
        
    } @catch (NSException *exception) {
        [self dismissHUD];
    } 
}
-(IBAction)getVerificationResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:Msg101 controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:APPNAME
                                          message:APIResponseMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
-(IBAction)getForgotPwdResponse:(id)sender
{
     [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:Msg101 controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
- (void)btnMenuClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    NSString *menuName=btn.accessibilityIdentifier;
    if([menuName isEqualToString:@"Home"])
    {
        HomeVC *objHomeVC =initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
        AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objHomeVC];
        [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    }
    else if([menuName isEqualToString:@"Dispatch"])
    {
        DispatchListVC *objdispatchVC =initVCToRedirect(SBDISPATCHUI, DISPATCHLISTVC);
        AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objdispatchVC];
        [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    }
    else if([menuName isEqualToString:@"Calendar"])
    {
        if([objac.role containsString:@"2"]||[objac.role containsString:@"3"])
        {
            CalenderListVC *objEquiList=initVCToRedirect(SBCALENDERUI, CALENDERLISTVC);
            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objEquiList];
            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
            [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        }
        else
        {
            [AZNotification showNotificationWithTitle:PermissionForCalender controller:ROOTVIEW notificationType:AZNotificationTypeMessage];
        }
    }
    else if([menuName isEqualToString:@"My Loads"])
    {
        if([objac.role containsString:@"3"])
        {
            MyLoadListVC *objLoadList=initVCToRedirect(SBAFTERSIGNUP, MYLOADLIST);
            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objLoadList];
            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
            [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        }
        else
        {
            [AZNotification showNotificationWithTitle:PermissionForLoad controller:ROOTVIEW notificationType:AZNotificationTypeMessage];
        }
        
    }
    else if([menuName isEqualToString:@"Create New Load"])
    {
        if([objac.role containsString:@"3"])
        {
            PostLoadVC *objPostLoad=initVCToRedirect(SBAFTERSIGNUP, POSTLOADVC);
            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objPostLoad];
            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
            [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        }
        else
        {
            [AZNotification showNotificationWithTitle:PermissionForLoad controller:ROOTVIEW notificationType:AZNotificationTypeMessage];
        }
        
    }
    else if([menuName isEqualToString:@"My Assets"])
    {
        if([objac.role containsString:@"2"])
        {
            MyEquipmentList *objEquiList=initVCToRedirect(SBAFTERSIGNUP, MYEQUIPMENTLIST);
            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objEquiList];
            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
            [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        }
        else
        {
            [AZNotification showNotificationWithTitle:PermissionForAssets controller:ROOTVIEW notificationType:AZNotificationTypeMessage];
        }
    }
    else if ([menuName isEqualToString:@"Notifications"])
    {
        AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:initVCToRedirect(SBSEARCH, NOTIFICATIONSVC)];
        [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    }
    else if([menuName isEqualToString:@"Add New Asset"])
    {
        if([objac.role containsString:@"2"])
        {
            //PU COMMENTED UNCOMMENT WHEN LIVE
//            if([objac.dotnumStatus isEqualToString:@"0"])
//            {
//                DotWarning *objvw=[[[NSBundle mainBundle]loadNibNamed:@"DotWarning" owner:self options:nil] lastObject];
//                objvw.dotWarningDelegate=self;
//                [self.view.window addSubview:objvw];
//            }
//            else
//            {
                ChooseEquiTypesVC *objPostEqui=initVCToRedirect(SBAFTERSIGNUP, CHOOSEEQUITYPEVC);
                objPostEqui.redirectfrom=@"MENU";
                //            PostEquipmentVC *objPostEqui=initVCToRedirect(SBAFTERSIGNUP, POSTEQUIPMENTVC);
                AppInstance.firstnav= [[UINavigationController alloc] initWithRootViewController:objPostEqui];
                [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
                [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
          //  }
        }
        else
        {
            [AZNotification showNotificationWithTitle:PermissionForAssets controller:ROOTVIEW notificationType:AZNotificationTypeMessage];
        }
    }
    else if([menuName isEqualToString:@"Add New Driver"])
    {
        PostDriverVC *objPostdrv=initVCToRedirect(SBAFTERSIGNUP, POSTDRIVERVC);
        AppInstance.firstnav= [[UINavigationController alloc] initWithRootViewController:objPostdrv];
        [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    }
    else if([menuName isEqualToString:@"My Drivers"])
    {
        DriverListVC *obdriverList=initVCToRedirect(SBAFTERSIGNUP, DRIVERLISTVC);
        AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:obdriverList];
        [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    }
    else if([menuName isEqualToString:@"Account"])
    {
        EditDotAccount *obdriverList=initVCToRedirect(SBMAIN,EDITDOTACCOUNTVC);
        AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:obdriverList];
        [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    }
    else if([menuName isEqualToString:@"Change Radius"])
    {
        [self createArrayOfMiles];
        listMiles= [self showListView:listMiles withSelectiontext:MilesPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT-100];
        [listMiles show];
    }
    else if([menuName isEqualToString:@"Change Asset Availability"])
    {
        arrAvailability=[[NSArray alloc]initWithObjects:@"Unlimited (US/Mexico/Canada)",@"US/Canada (Can cross into Canada)",@"US Interstate (Can cross state lines)",@"US Intrastate (Same  state only)",nil];
        listMiles= [self showListView:listMiles withSelectiontext:AvailablilityTitle widthval:SCREEN_WIDTH - 20 heightval:280];
        [listMiles show];
    }
    else if([menuName isEqualToString:@"Forgot Password"])
    {
        [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:APPNAME
                                                                       message:@"Please enter your email.Your password will be sent to specified email. "
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) 
                                                            {
                                                                 UITextField *login = alert.textFields.firstObject;
                                                                if([self validateTxtFieldLength:login withMessage:RequiredEmail] && [self validateEmail:login withMessage:InvalidEmail])
                                                                {
                                                                    [self requestForForgotPasswordWithEmail:login.text];
                                                                } 
                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                               
                                                             }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) 
        {
            textField.keyboardAppearance=UIKeyboardAppearanceDark;
            textField.textAlignment=NSTextAlignmentCenter;
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            textField.placeholder = @"Email";
        }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if([menuName isEqualToString:@"Help"])
    {
        NSString *strHelp = @"https://lodrapp.com/help/";
        NSURL *urlHelp = [NSURL URLWithString:strHelp];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:urlHelp];
        });
    }
    else if([menuName isEqualToString:@"Lodr.com"])
    {
        [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        WebContentVC *objweb=initVCToRedirect(SBMAIN, WEBCONTENTVC);
        objweb.redirectfrom=@"MENUVC";
        NSString *weburl=[NSString stringWithFormat:@"%@",@"https://lodrapp.com/"];
        objweb.webURL=weburl;
        objweb.modalTransitionStyle   = UIModalTransitionStyleCrossDissolve;
        objweb.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:objweb animated:YES completion:nil];
     
    }
    else if([menuName isEqualToString:@"Resend Verification Mail"])
    {
         [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
       UIAlertController* alert = [UIAlertController alertControllerWithTitle:APPNAME
                                                                       message:@"Please enter your email.We will send you a verification link in this email."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) 
                                        {
                                            UITextField *login = alert.textFields.firstObject;
                                            if([self validateTxtFieldLength:login withMessage:RequiredEmail] && [self validateEmail:login withMessage:InvalidEmail])
                                            {
                                                [self requestForVerficationEmail:login.text];
                                            } 
                                        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                             }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) 
         {
             textField.keyboardAppearance=UIKeyboardAppearanceDark;
             textField.keyboardType = UIKeyboardTypeEmailAddress;
             textField.textAlignment=NSTextAlignmentCenter;
             textField.placeholder = @"Verification Email";
         }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if([menuName isEqualToString:@"Logout"])
    {
        [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:APPNAME
                                      message:@"Do you want to log out?"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Yes"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 AppInstance.arrAllEquipmentByUserId=nil;
                                 AppInstance.arrAllLoadByUserId=nil;
                                 AppInstance.countEquiByUid=@"0";
                                 AppInstance.countLodByUid=@"0";
                                 AppInstance.dicAllMatchByLoadId=nil;
                                  AppInstance.warningseen=@"No";
                                 [DefaultsValues removeObjectForKey:SavedUserData];
                                 [DefaultsValues removeObjectForKey:SavedUserId];
                                 [DefaultsValues removeObjectForKey:SavedUserEmail];
                                 [DefaultsValues removeObjectForKey:SavedSecretKey];
                                 [DefaultsValues removeObjectForKey:SavedAccessKey];
                                 [DefaultsValues setBooleanValueToUserDefaults:NO ForKey:SavedSignedIn];
                                 LoginVC *objLoginvc=initVCToRedirect(SBMAIN, LOGINVC);
                                 
                                 [AppInstance setDrawerWithCenterViewNamed:objLoginvc];
                                 [AppInstance.locationtimer invalidate];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        
        [alert addAction:ok];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"No"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
        
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark  - miles radious 
-(void)addOverlay
{
    overlayview = [[UIView alloc] initWithFrame:CGRectMake(0,  0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [overlayview setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    UITapGestureRecognizer *overlayTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(onOverlayTapped)];
    [overlayview addGestureRecognizer:overlayTap];
    [self.view.window addSubview:overlayview];
}
- (void)onOverlayTapped
{
    @try {
        [UIView animateWithDuration:0.2f animations:^{
            overlayview.alpha=0;
            [listMiles dismiss];
        }completion:^(BOOL finished) {
            [overlayview removeFromSuperview];
        }];
    } @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception.description);
    } 
    
}
-(ZSYPopoverListView *)showListView :(ZSYPopoverListView *)listviewname withSelectiontext :(NSString *)selectionm widthval:(CGFloat)w heightval :(CGFloat)h
{
    selectedpopupname=selectionm;
    listviewname.backgroundColor=[UIColor whiteColor];
    listviewname = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0,0, w, h)];
    listviewname.calledFor=selectionm;
    listviewname.center=self.view.center;
    listviewname.titleName.backgroundColor=[UIColor whiteColor];
    listviewname.titleName.text = [NSString stringWithFormat:@"%@",selectionm];
    listviewname.datasource = self;
    listviewname.delegate = self;
    listviewname.layer.cornerRadius=3.0f;
    listviewname.clipsToBounds=YES;
    
    [listviewname setDoneButtonWithTitle:@"" block:^{
        [overlayview removeFromSuperview];
    }];
    [listviewname setCancelButtonTitle:@"" block:^{
    }];
//  
   [self addOverlay];
    [self.view endEditing:YES];
    return listviewname;
}
#pragma mark - popup view delegates
- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(CGFloat)popoverListView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try
    {
        if([selectedpopupname isEqualToString:AvailablilityTitle])
        {
             return arrAvailability.count;
        }
        else
        {
             return arrMiles.count;
        }
    }
    @catch (NSException *exception) {
        
    }
}

- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        static NSString *customTableIdentifier = @"CellListWithCheckBox";
        
        CellListWithCheckBox *cell = (CellListWithCheckBox *)[tableView dequeueReusablePopoverCellWithIdentifier:customTableIdentifier];
        
        if (nil == cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellListWithCheckBox" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.vwCheckboxsubtext.hidden=YES;
        cell.lblsubtext.text=@"";
        [cell.lblsubtext sizeToFit];
        cell.btnCellClick.userInteractionEnabled=NO;
        if([selectedpopupname isEqualToString:AvailablilityTitle])
        {
            if(availabilityvalue == indexPath.row)
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth=0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth=1.0f;
            }
            cell.btnCheckbox.hidden=NO;
            cell.lblListName.text=[arrAvailability objectAtIndex:indexPath.row];
        }
        else
        {
            if(milesvalue == indexPath.row)
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth=0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth=1.0f;
            }
            if([[arrMiles objectAtIndex:indexPath.row] isEqualToString:@""])
            {
                cell.lblListName.text=@"";
                cell.btnCheckbox.hidden=YES;
            }
            else
            {
                cell.btnCheckbox.hidden=NO;
                cell.lblListName.text=[NSString stringWithFormat:@"%@ Miles",[arrMiles objectAtIndex:indexPath.row]];
            }
        }
        
       
       return cell;
    }
    @catch (NSException *exception) {
        
    }
    
}
- (IBAction)btnsettingsclciked:(id)sender
{
    EditDotAccount *obdriverList=initVCToRedirect(SBMAIN,EDITDOTACCOUNTVC);
    AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:obdriverList];
    [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([selectedpopupname isEqualToString:AvailablilityTitle])
    {
        availabilityvalue=(int)indexPath.row;
        [DefaultsValues setIntegerValueToUserDefaults:availabilityvalue ForKey:SavedAvailability];
        [DefaultsValues setStringValueToUserDefaults:[arrAvailability objectAtIndex:availabilityvalue] ForKey:SavedAvailabilityValue];
        [listMiles dismiss];
        [overlayview removeFromSuperview];
        NSString *usermessage = [NSString stringWithFormat:@"Availability of assets set to %@.",[arrAvailability objectAtIndex:availabilityvalue]];
        [AZNotification showNotificationWithTitle:usermessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
    }
    else
    {
        milesvalue=(int)indexPath.row;
        [DefaultsValues setIntegerValueToUserDefaults:milesvalue ForKey:SavedRadiusValue];
        [DefaultsValues setStringValueToUserDefaults:[arrMiles objectAtIndex:milesvalue] ForKey:SavedRadius];
        [listMiles dismiss];
        [overlayview removeFromSuperview];
        NSString *usermessage = [NSString stringWithFormat:@"You can see matches upto %@ Miles ",[arrMiles objectAtIndex:milesvalue]];
        [AZNotification showNotificationWithTitle:usermessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedRefreshAssetList object:self userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedRefreshLoadList object:self userInfo:nil];
    }
  
}
#pragma mark - Click events
#pragma mark - Custom Methods
#pragma mark - Layout Settings
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
