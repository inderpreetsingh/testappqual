//
//  HomeVC.m
//  Lodr
//
//  Created by Payal Umraliya on 15/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "HomeVC.h"
#import "EquiEspecial.h"
#import "SubEquiEspecial.h"
#import "MyEquipmentList.h"
#import "MyLoadListVC.h"
#import "JTProgressHUD.h"
#import "CoreDataAdaptor.h"
#import "DriverListVC.h"
#import "DriverHomeVC.h"
#import "CalenderListVC.h"
#import "AlertNotificationsVC.h"
#import "INTULocationManager.h"
#import "Drivers.h"
#import "DotWarning.h"
#import "EditDotAccount.h"
@interface HomeVC ()<DotWarningDelegate>
{
    NSArray *arrHomeOptions,*arrCvTitles,*arrCvSubtitles,*arrCvCountval;
    NSTimer *timer;
    NSDateFormatter *dateformatter,*dateFormatterForDate;
    CellHomeScreenHeader *viewHeader;
    UserAccount *objac;
    int allequiwscallcount,alleequicallcount,allhomecounterswscount;
    NSString *userlat,*userlon;
}
@end

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSLog(@"%@",[GlobalFunction calenderstringDate:@"11:00 AM" fromFormat:@"hh:mm a" toFormat:@"HH:mm"]);
//
//    NSLog(@"%@",[GlobalFunction calenderstringDate:@"04:00 PM" fromFormat:@"hh:mm a" toFormat:@"HH:mm"]);
    

    NavigationBarHidden(YES);
    dateformatter=[[NSDateFormatter alloc]init];
    dateFormatterForDate=[[NSDateFormatter alloc]init];
    [AppInstance.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    [dateformatter setDateFormat:@"hh:mm"];
     [dateFormatterForDate setDateFormat:@"EEEE, MMM dd"];
    if([DefaultsValues getBooleanValueFromUserDefaults_ForKey:SavedSignedIn] == YES)
    {
        User *objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
        
        objac=[objuser.userAccount objectAtIndex:0];
        if([objac.role containsString:@"1"])
        {
               arrHomeOptions=[[NSArray alloc]initWithObjects:@"CALENDAR",@"ASSETS",@"LOADS",@"DISPATCH",@"DRIVER",nil];
        }
        else
        {
             arrHomeOptions=[[NSArray alloc]initWithObjects:@"CALENDAR",@"ASSETS",@"LOADS", @"DISPATCH",nil];
        }
    }
    if(![AppInstance.locationUpdated isEqualToString:@"YES"] )
    {
        [self startSingleLocationRequest];
        NSMutableArray *checkEqui=[NSMutableArray new];
        checkEqui =[[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:EquiEspecialEntity]mutableCopy];
        if(checkEqui.count == 0)
        {
            [self getAllEquipments];
        }
        [self getAllCounts];
    }
    else
    {
        NSMutableArray *checkEqui=[NSMutableArray new];
        checkEqui =[[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:EquiEspecialEntity]mutableCopy];
        if(checkEqui.count == 0)
        {
            [self getAllEquipments];
        }
        [self getAllCounts];
    }
    
    arrCvTitles=[[NSArray alloc]initWithObjects:@"CONTACT",@"ASSETS",@"LOADS",@"ALERTS", nil];
    arrCvSubtitles=[[NSArray alloc]initWithObjects:@"MESSAGES",@"MATCHES",@"MATCHES",@"NOTIFICATIONS", nil];
    arrCvCountval=[[NSArray alloc]initWithObjects:@"0",@"0",@"0",@"0", nil];
    [self.btnDrawer setImage:imgNamed(iconDrawer2) forState:UIControlStateNormal];
    [self layoutHeaderAndFooter];
    if([[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedRadius] isEqualToString:@""] || [DefaultsValues getStringValueFromUserDefaults_ForKey:SavedRadius]  == nil )
    {
        [DefaultsValues setStringValueToUserDefaults:@"50" ForKey:SavedRadius];
        [DefaultsValues setIntegerValueToUserDefaults:0 ForKey:SavedRadiusValue];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(timer.isValid)
    {
        [timer invalidate];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    AppInstance.locationtimer=[NSTimer scheduledTimerWithTimeInterval:60*30 target:self selector:@selector(startSingleLocationRequest) userInfo:nil repeats:YES];
    [self.tblHomeScreen reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)layoutHeaderAndFooter
{
    viewHeader=[[CellHomeScreenHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblHomeScreen.frame.size.width, 250)];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellHomeScreenHeader" owner:self options:nil];
    viewHeader = (CellHomeScreenHeader *)[nib objectAtIndex:0];
    viewHeader.cellHomeScreenHeaderDelegate=self;
    [viewHeader.cvCounters registerNib:[UINib nibWithNibName:@"CellCvHomeCounter" bundle:nil] forCellWithReuseIdentifier:@"CellCvHomeCounter"];
    NSString *timeInStringFormated=[dateformatter stringFromDate:[NSDate date]];
    NSString *dateInStringFormated=[dateFormatterForDate stringFromDate:[NSDate date]];
    viewHeader.lblTime.text=timeInStringFormated;
    viewHeader.lblDate.text=[dateInStringFormated uppercaseString];
}
-(void)updateTimer
{
    NSString *timeInStringFormated=[dateformatter stringFromDate:[NSDate date]];
    viewHeader.lblTime.text=timeInStringFormated;
    NSString *dateInStringFormated=[dateFormatterForDate stringFromDate:[NSDate date]];
    viewHeader.lblDate.text=[dateInStringFormated uppercaseString];
}
#pragma mark - tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
    return 1; 
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return arrHomeOptions.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    static NSString *cellIdentifier = @"CellHomeScreenOptions";
    CellHomeScreenOptions *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) 
    { 
        cell = [[CellHomeScreenOptions alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
    }
    cell.btnHomeScreenOption.tag=indexPath.row;
    cell.cellHomeScreenOptionsDelegate=self;
    if([[arrHomeOptions objectAtIndex:indexPath.row] isEqualToString:@"DRIVER"])
    {
        [cell.btnHomeScreenOption setBackgroundColor:[UIColor blackColor]];
    }
    else
    {
         [cell.btnHomeScreenOption setBackgroundColor:[UIColor orangeColor]];
    }
    [cell.btnHomeScreenOption setTitle:[arrHomeOptions objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    return cell; 
}
- (void)btnHomeScreenOptionClicked:(id)sender 
{
    @try {
        switch ([sender tag])
        {
            case 0:
            {
//                 [AZNotification showNotificationWithTitle:@"In progress" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
                if([objac.role containsString:@"2"]||[objac.role containsString:@"3"])
                {
                    CalenderListVC *objEquiList=initVCToRedirect(SBCALENDERUI, CALENDERLISTVC);
                    objEquiList.redirectfrom=@"HOMEVC";
                    [self.navigationController pushViewController:objEquiList animated:YES];
                }
                else
                {
                    [AZNotification showNotificationWithTitle:PermissionForCalender controller:ROOTVIEW notificationType:AZNotificationTypeMessage];
                }
               
            }
                break;
            case 1:
            {
                if([objac.role containsString:@"2"])
                {
                    MyEquipmentList *objEquiList=initVCToRedirect(SBAFTERSIGNUP, MYEQUIPMENTLIST);
                    objEquiList.strRedirectFrom = @"HOME";
                    [self.navigationController pushViewController:objEquiList animated:YES];
                }
                else
                {
                    [AZNotification showNotificationWithTitle:PermissionForAssets controller:ROOTVIEW notificationType:AZNotificationTypeMessage];
                }
                
                //            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objEquiList];
                //            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
                // [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
            }
                break;
            case 2:
            {
                if([objac.role containsString:@"3"])
                {
                    MyLoadListVC *obLoadList=initVCToRedirect(SBAFTERSIGNUP, MYLOADLIST);
                    obLoadList.strRedirectFrom = @"HOME";
                    [self.navigationController pushViewController:obLoadList animated:YES];
                }
                else
                {
                    [AZNotification showNotificationWithTitle:PermissionForLoad controller:ROOTVIEW notificationType:AZNotificationTypeMessage];
                }
                
                //            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:obLoadList];
                //            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
                // [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
            }
                break;

            case 3:
            {
                NSLog(@"DISPATCH CLICKED");
//                [self.navigationController pushViewController:initVCToRedirect(SBSEARCH, NOTIFICATIONSVC) animated:YES];

                DispatchListVC *objdispatchVC =initVCToRedirect(SBDISPATCHUI, DISPATCHLISTVC);
                objdispatchVC.strRedirectFrom = @"HOME";
                [self.navigationController pushViewController:objdispatchVC animated:YES];
            }
                break;
            case 4:
            {
               
                DriverHomeVC *obLoadList=initVCToRedirect(SBAFTERSIGNUP, DRIVERHOMELISTVC);
                obLoadList.strRedirectFrom = @"HOME";
                CellHomeSwitchOnOff *tblfootervw=(CellHomeSwitchOnOff*)[_tblHomeScreen footerViewForSection:0];
                obLoadList.driverstatus=tblfootervw.btnOnDuty.titleLabel.text;
                [self.navigationController pushViewController:obLoadList animated:YES];
                //            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:obLoadList];
                //            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
            }
                break;
            default:
                break;
        }
    } @catch (NSException *exception) { 
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:1 inSection:section];
    [viewHeader.cvCounters scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    viewHeader.cellHomeScreenHeaderDelegate=self;
    
    viewHeader.lblCompanyName.text = objac.companyName;
    viewHeader.lblOfficeName.text = objac.officeName;
    
    return viewHeader;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    if([objac.role containsString:@"1"])
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellHomeSwitchOnOff" owner:self options:nil];
        CellHomeSwitchOnOff *tblfootervw = (CellHomeSwitchOnOff *)[nib objectAtIndex:0];
        return tblfootervw;
    }
    else
    {
        return [[UIView alloc]initWithFrame:CGRectZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{  
    if([objac.role containsString:@"1"])
    {
         return 100;
    }
    else
    {
         return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 275.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(SCREEN_WIDTH > 320)
    {
        return 65;
    }
    else
    {
        return 55;
    }
}
- (void)btnNextClicked:(id)sender
{
    
}
- (void)btnPrevClicked:(id)sender
{
    
}
- (IBAction)btnDrawerClicked:(id)sender
{
     [self.view endEditing:YES];
     [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (void)btnCounterClicked:(id)sender 
{
    UIButton *btn=(UIButton *)sender;
    switch (btn.tag) {
        case 0:
        {
            
        }
        break;
        case 1:
        {
            MyEquipmentList *objEquiList=initVCToRedirect(SBAFTERSIGNUP, MYEQUIPMENTLIST);
            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objEquiList];
            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        }
            break;
        case 2:
        {
            MyLoadListVC *obLoadList=initVCToRedirect(SBAFTERSIGNUP, MYLOADLIST);
            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:obLoadList];
            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
}

- (NSInteger)cvHome_numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)cvHome_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrCvTitles.count;
}
- (UICollectionViewCell *)cvHome_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellCvHomeCounter *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCvHomeCounter" forIndexPath:indexPath];
    cell.lblTitle.text=[arrCvTitles objectAtIndex:indexPath.item];
    cell.lblSubTitle.text=[arrCvSubtitles objectAtIndex:indexPath.item];
    [cell.btnCounter setTitle:[NSString stringWithFormat:@"%@",[arrCvCountval objectAtIndex:indexPath.item]] forState:UIControlStateNormal];
    cell.btnCounter.tag=indexPath.item;
    cell.cellCvHomeCounterDelegate=self;
    return cell;
}
- (void)cvHome_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cnt=[NSString stringWithFormat:@"%@",[arrCvCountval objectAtIndex:indexPath.item]];
    switch (indexPath.item) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
//            if([cnt isEqualToString:@"0"])
//            {
//                [AZNotification showNotificationWithTitle:ZeroEquiFound  controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
//            }
//            else
//            {
            MyEquipmentList *objEquiList=initVCToRedirect(SBAFTERSIGNUP, MYEQUIPMENTLIST);
             objEquiList.strRedirectFrom = @"HOME";
              [self.navigationController pushViewController:objEquiList animated:YES];
           // }
//            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objEquiList];
//            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        }
            break;
        case 2:
        {
//            if([cnt isEqualToString:@"0"])
//            {
//                [AZNotification showNotificationWithTitle:ZeroLoadFound  controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
//            }
//            else
//            {
            MyLoadListVC *obLoadList=initVCToRedirect(SBAFTERSIGNUP, MYLOADLIST);
            obLoadList.strRedirectFrom = @"HOME";
            [self.navigationController pushViewController:obLoadList animated:YES];
            //}
//            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:obLoadList];
//            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        }
            break;
        case 3:
        {
            
            if([cnt isEqualToString:@"0"])
            {
                [AZNotification showNotificationWithTitle:ZeroAlertFound  controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
            else
            {
                AlertNotificationsVC *objNote=initVCToRedirect(SBAFTERSIGNUP, ALERTNOTIFICATIONVC);
                [self.navigationController pushViewController:objNote animated:YES];
            }
            
//            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objNote];
//            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
//            
        }
            break;
        default:
            break;
    }
}
- (CGSize)cvHome_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width/2)-30, 100);
}
#pragma mark - custom method

-(void)getAllEquipments
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
         showDisplayMsg:@"Processing"
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
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        if([sender serviceResponseCode] ==  -1005 || [sender serviceResponseCode] ==  -1001)
        {
            if(allequiwscallcount !=2)
            {
                [self getAllEquipments];
                allequiwscallcount=allequiwscallcount+1;
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
            //            AppInstance.arrAllEquipments=[NSMutableArray new];
            //            for ( EquiEspecial *objAllEqui in [sender responseArray]) 
            //            {
            //                [AppInstance.arrAllEquipments addObject:objAllEqui];
            //            }
            [self getEspecialEquipments];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
-(void)getEspecialEquipments
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
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        if([sender serviceResponseCode] ==  -1005 || [sender serviceResponseCode] ==  -1001)
        {
            if(alleequicallcount !=2)
            {
                [self getEspecialEquipments];
                alleequicallcount=alleequicallcount+1;
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
            //            AppInstance.arrAllEspecialEquipments=[NSMutableArray new];
            //            for ( SubEquiEspecial *objAllsubEqui in [sender responseArray]) 
            //            {
            //                [AppInstance.arrAllEspecialEquipments addObject:objAllsubEqui];
            //            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

-(void)getAllCounts
{
    if([DefaultsValues getStringValueFromUserDefaults_ForKey:SavedRadius] == nil)
    {
        [DefaultsValues setStringValueToUserDefaults:@"100" ForKey:SavedRadius];
    }
    
    NSDictionary *dicAllEqui = @{
                                 Req_access_key : [DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                 Req_secret_key : [DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                 Req_User_Id : [DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                 Req_DotNumber : objac.dotNumber,
                                 Req_Radius : [DefaultsValues getStringValueFromUserDefaults_ForKey:SavedRadius]
                                 };
    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLTotalServay
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getAllCountResponse:)
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
-(IBAction)getAllCountResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        if([sender serviceResponseCode] ==  -1005 || [sender serviceResponseCode] ==  -1001)
        {
            if(allhomecounterswscount !=2)
            {
                [self getAllCounts];
                allhomecounterswscount=allhomecounterswscount+1;
            }
            else
            {
                [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];
                
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
            int alercounter=[APITotalLoadAlerts intValue];
            arrCvCountval=[[NSArray alloc]initWithObjects: [NSString stringWithFormat:@"%@",APITotalContacted], [NSString stringWithFormat:@"%@",APITotalEquipments], [NSString stringWithFormat:@"%@",APITotalLoads], [NSString stringWithFormat:@"%d",alercounter], nil];
            [viewHeader.cvCounters reloadData];
            
            if([objac.role containsString:@"1"])
            {
                [self performSelectorInBackground:@selector(getDriverDetails) withObject:nil];
            }
            User *objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
            UserAccount *upobjac=[objuser.userAccount objectAtIndex:0];
            upobjac.dotnumStatus = APICurrent_DOT_status;
            [DefaultsValues removeObjectForKey:SavedUserData];
            [DefaultsValues setCustomObjToUserDefaults:objuser ForKey:SavedUserData];
            objuser =  [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
            upobjac=[objuser.userAccount objectAtIndex:0];
            //PU COMMENTED TEMP UNCOMMENT WHEN LIVE
//            if([upobjac.dotnumStatus isEqualToString:@"0"])
//            {
//                if([AppInstance.warningseen isEqualToString:@"No"] || AppInstance.warningseen.length == 0 || AppInstance.warningseen == nil)
//                {
//                    DotWarning *objvw=[[[NSBundle mainBundle]loadNibNamed:@"DotWarning" owner:self options:nil] lastObject];
//                    objvw.dotWarningDelegate=self;
//                    [self.view.window addSubview:objvw];
//                    AppInstance.warningseen = @"yes";
//                }
//            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
- (IBAction)btnsettingsclciked:(id)sender
{
    EditDotAccount *obdriverList=initVCToRedirect(SBMAIN,EDITDOTACCOUNTVC);
    AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:obdriverList];
    [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
}
- (void)startSingleLocationRequest
{
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyNeighborhood
                                                                timeout:10.0
                                                   delayUntilAuthorized:YES
                                                                  block:
                              ^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                 
                                  if (status == INTULocationStatusSuccess) 
                                  {
                                      
                                      AppInstance.userCurrentLat= [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
                                      AppInstance.userCurrentLon=[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
                                      [self updateUserLocation];
            
                                  }
                                  else if (status == INTULocationStatusTimedOut) 
                                  {
                                      AppInstance.userCurrentLat= [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
                                      AppInstance.userCurrentLon=[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
                                       [self updateUserLocation];
                                  }
                                  else 
                                  {
                                      if (status == INTULocationStatusServicesNotDetermined) 
                                      {
                                          [AZNotification showNotificationWithTitle: @"Error: User has not responded to the permissions alert." controller:ROOTVIEW notificationType:AZNotificationTypeError];
                                      }
                                      if (status == INTULocationStatusServicesDenied)
                                      {
                                          [AZNotification showNotificationWithTitle: @"Error: User has denied this app permissions to access device location." controller:ROOTVIEW notificationType:AZNotificationTypeError];
                                      }
                                      if (status == INTULocationStatusServicesRestricted)
                                      {
                                          [AZNotification showNotificationWithTitle: @"Error: User is restricted from using location services by a usage policy." controller:ROOTVIEW notificationType:AZNotificationTypeError];
                                      }
                                      if (status == INTULocationStatusServicesDisabled)
                                      {
                                          [AZNotification showNotificationWithTitle: @"Error: Location services are turned off for all apps on this device." controller:ROOTVIEW notificationType:AZNotificationTypeError];
                                      }
                                  }
                              }];
}



- (void)getDriverDetails
{
    @try
    {
        [self dismissHUD];
        NSDictionary *dicAllEqui=@{
                                   Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                   Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                   Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]
                                   };    
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLGetDriverDetail
             withParameters:dicAllEqui
             withObject:self
             withSelector:@selector(getDriverDetailResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Checking driver status"
             showProgress:NO];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }

    } @catch (NSException *exception) {
    } 
}
-(IBAction)getDriverDetailResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];  
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            if([sender responseArray].count >0)
            {
                Drivers *objd = [[sender responseArray] objectAtIndex:0];
                [DefaultsValues setCustomObjToUserDefaults:objd ForKey:SavedDriverData];
             //   [self.tblHomeScreen reloadData];
            }
        }   
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
@end
