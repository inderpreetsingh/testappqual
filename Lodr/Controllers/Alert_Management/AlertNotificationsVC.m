//
//  AlertNotificationsVC.m
//  Lodr
//
//  Created by c196 on 09/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "AlertNotificationsVC.h"
#import "UITableView+Placeholder.h"
#import "AlertDetails.h"
#import "MyLoadListVC.h"
#import "MyEquipmentList.h"
#define constAlertLimit 2
@interface AlertNotificationsVC ()
{
    NSString *loadCount,*assetCount;
    NSMutableArray *arrAllMatches,*arrAllLoads,*arrAllAssets;
    int limit1,limit2,totalRecords;
    NSInteger selectedSection;
    NSIndexPath *indexpathAtOpenedRow;
}
@end

@implementation AlertNotificationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationBarHidden(YES);
    CGRect rect =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    self.tblAllAlerts = [[TQMultistageTableView alloc] initWithFrame:rect];
    self.tblAllAlerts.dataSource = self;
    self.tblAllAlerts.delegate   = self;
    self.tblAllAlerts.redirectFrom=@"ALL_ALERTS";
    
    self.tblAllAlerts.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tblAllAlerts];
    self.tblAllAlerts.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tblAllAlerts.tableView.estimatedRowHeight=70;
     _tblAllAlerts.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    [self getAllAlerts:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - webservice handling
#pragma mark - Webservice handling
-(void)callLoadMoreData_Alerts
{
    NSLog(@"Limit 1 :------> %d",limit1);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_FromIndex:[NSString stringWithFormat:@"%d",limit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",limit2]
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllAlertsbyUserId
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getdicAlertResponseLoadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Alerts"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

-(IBAction)getdicAlertResponseLoadmore:(id)sender
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
            for (AlertDetails *allAlerts in [sender responseArray])
            {
                [arrAllMatches addObject:allAlerts];
            }
            arrAllAssets = [NSMutableArray new];
            arrAllLoads  = [NSMutableArray new];
            NSPredicate  *predicateLoad,*predicateAsset;
            predicateLoad = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(loadOwnerId ==  '%@')",[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]]];
            arrAllLoads=[[arrAllMatches filteredArrayUsingPredicate:predicateLoad] mutableCopy];
            predicateAsset = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(equiOwnerId ==  '%@')",[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]]];
            arrAllAssets=[[arrAllMatches filteredArrayUsingPredicate:predicateAsset] mutableCopy];
            [self groupArrayByLoadAndAsset];
            limit1=limit1+limit2;
            limit2=constAlertLimit;
            [_tblAllAlerts reloadData];
            if(limit1<totalRecords)
            {
                [self performSelectorInBackground:@selector(callLoadMoreData_Alerts)  withObject:nil];
            }
            else
            {
                self.tblAllAlerts.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }
        else
        {
            self.tblAllAlerts.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}

-(void)getAllAlerts:(BOOL)showloader
{
    limit1=0;
    limit2=constAlertLimit;
    if(showloader)
    {
        [_tblAllAlerts.tableView setLoaderWithString:@"Fetching Alerts"];
    }
    else
    {
        _tblAllAlerts.tableView.backgroundView=nil;
    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_FromIndex:[NSString stringWithFormat:@"%d",limit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",limit2]
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllAlertsbyUserId
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getAlertResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Alerts"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getAlertResponse:(id)sender
{
    @try {
        [self dismissHUD];
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];   
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                arrAllMatches=[NSMutableArray new];
                for (AlertDetails *allAlerts in [sender responseArray])
                {
                    [arrAllMatches addObject:allAlerts];
                }
                totalRecords=[APITotalAlerts intValue];
                arrAllAssets = [NSMutableArray new];
                arrAllLoads  = [NSMutableArray new];
                NSPredicate  *predicateLoad,*predicateAsset;
                predicateLoad = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(loadOwnerId ==  '%@')",[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]]];
                arrAllLoads=[[arrAllMatches filteredArrayUsingPredicate:predicateLoad] mutableCopy];
                predicateAsset = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(equiOwnerId ==  '%@')",[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]]];
                arrAllAssets=[[arrAllMatches filteredArrayUsingPredicate:predicateAsset] mutableCopy];
                [self groupArrayByLoadAndAsset];
                
                [_tblAllAlerts reloadData];
                limit1=limit1+limit2;
                limit2=constAlertLimit;
                if(arrAllMatches.count == 0)
                {
                    [_tblAllAlerts.tableView setBlankPlaceHolderWithString:NoAlertFound];
                    _tblAllAlerts.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
                }
                else
                {
                    _tblAllAlerts.tableView.backgroundView=nil;
                    if(limit1<totalRecords)
                    {
                        [self performSelectorInBackground:@selector(callLoadMoreData_Alerts)  withObject:nil];
                    }
                    else
                    {
                        _tblAllAlerts.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
                    }
                } }
            else
            {
                [_tblAllAlerts.tableView reloadData];
                [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
                [_tblAllAlerts.tableView setBlankPlaceHolderWithString:APIResponseMessage];
                _tblAllAlerts.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    } 
}
-(void)groupArrayByLoadAndAsset
{
    NSMutableArray *resultArray = [NSMutableArray new];
    for(AlertDetails *ad in arrAllAssets)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(equiId ==  '%@')",ad.equiId]];
        NSArray *arrtemp=[resultArray filteredArrayUsingPredicate:predicate];
        if([arrtemp count] == 0)
        {
            ad.alertCount=@"1";
            [resultArray addObject:ad];
        }
        else
        {
            [resultArray enumerateObjectsUsingBlock:^(AlertDetails *obj, NSUInteger idx, BOOL * _Nonnull stop)
             {
                 if ([obj.equiId isEqualToString:ad.equiId])
                 {
                     int adval=[obj.alertCount intValue]+1;
                     obj.alertCount=[NSString stringWithFormat:@"%d",adval];
                     [resultArray replaceObjectAtIndex:idx withObject:obj];
                 }
             }];
        }
    }
    [arrAllAssets removeAllObjects];
    arrAllAssets=resultArray;
    NSMutableArray *resultArray2 = [NSMutableArray new];
    for(AlertDetails *ad in arrAllLoads)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(loadId ==  '%@')",ad.loadId]];
        NSArray *arrtemp=[resultArray2 filteredArrayUsingPredicate:predicate];
        if([arrtemp count] == 0)
        {
            ad.alertCount=@"1";
            [resultArray2 addObject:ad];
        }
        else
        {
            [resultArray2 enumerateObjectsUsingBlock:^(AlertDetails *obj, NSUInteger idx, BOOL * _Nonnull stop)
             {
                 if ([obj.loadId isEqualToString:ad.loadId])
                 {
                     int adval=[obj.alertCount intValue]+1;
                     obj.alertCount=[NSString stringWithFormat:@"%d",adval];
                     [resultArray2 replaceObjectAtIndex:idx withObject:obj];
                 }
             }];
        }
    }
    [arrAllLoads removeAllObjects];
    arrAllLoads=resultArray2;
}
#pragma mark - tableview delegates
#pragma mark - Table view delegate
- (NSInteger)numberOfSectionsInTableView:(TQMultistageTableView *)mTableView
{
    return 2;
}
- (NSInteger)mTableView:(TQMultistageTableView *)mTableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return arrAllLoads.count;
    }
    else
    {
        return arrAllAssets.count;
    }
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 250;
    }
    else
    {
        return 210;
    }
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70; 
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForAtomAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
- (UITableViewHeaderFooterView *)mTableView:(TQMultistageTableView *)mTableView viewForHeaderInSection:(NSInteger)section
{
   CellAlertHeader *tblheader = [mTableView dequeueReusableHeaderFooterViewWithIdentifier:@"CellAlertHeader"];
    if(!tblheader) 
    {
        NSArray *nibhead= [[NSBundle mainBundle] loadNibNamed:@"CellAlertHeader" owner:self options:nil];
        tblheader = (CellAlertHeader *)[nibhead objectAtIndex:0]; 
    }
    tblheader.cellAlertHeaderDelegate=self;
    tblheader.layer.borderWidth=0.5f;
    tblheader.layer.borderColor=[UIColor lightGrayColor].CGColor;
    if(section==0)
    {
        tblheader.heightBackButtonView.constant=40;
        tblheader.lblTitle.text=@"LOADS";
        tblheader.lblcount.text=[NSString stringWithFormat:@"%lu",(unsigned long)arrAllLoads.count];
    }
    else
    {
        tblheader.heightBackButtonView.constant=0;
        tblheader.vwWithBack.clipsToBounds=YES;
        tblheader.btnTitle.clipsToBounds=YES;
        tblheader.lblTitle.text=@"ASSETS";
        tblheader.lblcount.text=[NSString stringWithFormat:@"%lu",(unsigned long)arrAllAssets.count];
    }
    
    return tblheader;
}
- (UITableViewCell *)mTableView:(TQMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellAlertDetails";
    CellAlertDetails *cellAlertDetails = [mTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cellAlertDetails == nil)
    {
        NSArray *objCell = [[NSBundle mainBundle] loadNibNamed:@"CellAlertDetails" owner:self options:nil];
        cellAlertDetails = [objCell objectAtIndex:0];
    }
    cellAlertDetails.cellAlertDetailsDelegate=self;
    
    cellAlertDetails.btnDeleteNotifications.tag=indexPath.row;
    cellAlertDetails.btnDeleteNotifications.accessibilityLabel=[NSString stringWithFormat:@"%ld",(long)indexPath.section];
    mTableView.tableView.separatorColor=[UIColor lightGrayColor];
    if(indexPath.section==0)
    {
        AlertDetails *objalert=[arrAllLoads objectAtIndex:indexPath.row];
        cellAlertDetails.lblmatchesnames.text=[NSString stringWithFormat:@"%@-%@",objalert.pickupStateCode,objalert.deliveryStateCode];
        if([objalert.alertCount intValue]>1)
        {
            cellAlertDetails.lblalertText.text=[NSString stringWithFormat:@"%@ NEW CARRIERS ARE INTERESTED",objalert.alertCount];
        }
        else
        {
            cellAlertDetails.lblalertText.text=[NSString stringWithFormat:@"%@ NEW CARRIER ARE INTERESTED",objalert.alertCount];
        }

        
    }
    else
    {
        AlertDetails *objalerts=[arrAllAssets objectAtIndex:indexPath.row];
        cellAlertDetails.lblmatchesnames.text=objalerts.equiName;
        if([objalerts.alertCount intValue]>1)
        {
             cellAlertDetails.lblalertText.text=[NSString stringWithFormat:@"%@ SHIPPERS ARE INTERESTED BASED ON THIS ASSET MATCH",objalerts.alertCount];
        }
        else
        {
             cellAlertDetails.lblalertText.text=[NSString stringWithFormat:@"%@ SHIPPER IS INTERESTED BASED ON THIS ASSET MATCH",objalerts.alertCount];
        }
    }
    return cellAlertDetails;
}
- (void)mTableView:(TQMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.section == 0)
   {
       MyLoadListVC *obLoadList=initVCToRedirect(SBAFTERSIGNUP, MYLOADLIST);
       obLoadList.strRedirectFrom = @"HOME";
       [self.navigationController pushViewController:obLoadList animated:YES];
   }
    else
    {
        MyEquipmentList *objEquiList=initVCToRedirect(SBAFTERSIGNUP, MYEQUIPMENTLIST);
        objEquiList.strRedirectFrom = @"HOME";
        [self.navigationController pushViewController:objEquiList animated:YES];
    }
}

#pragma mark - Header Open Or Close
- (void)mTableView:(TQMultistageTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section
{
    selectedSection=section;
}

- (void)mTableView:(TQMultistageTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section
{
}
#pragma mark - Row Open Or Close

- (void)mTableView:(TQMultistageTableView *)mTableView willOpenRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexpathAtOpenedRow=indexPath;
}

- (void)mTableView:(TQMultistageTableView *)mTableView willCloseRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)mscrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   // _tblAllAlerts.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}
- (IBAction)btnDltNotificationsClicked:(id)sender 
{
    UIButton *btn=(UIButton *)sender;
    NSString *idval,*checkisload;
    if([btn.accessibilityLabel isEqualToString:@"0"])
    {
        AlertDetails *objalert=[arrAllLoads objectAtIndex:btn.tag];
        idval=objalert.loadId;
        checkisload=@"1";
    }
    else
    {
        AlertDetails *objalert=[arrAllAssets objectAtIndex:btn.tag];
         idval=objalert.equiId;
        checkisload=@"0";
    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_identifier:idval,
                                Req_isLoadAlert:checkisload
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLDeleteAlertByUserId
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getDeletedResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Removing Alerts"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getDeletedResponse:(id)sender
{
    @try {
        [self dismissHUD];
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];   
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                NSString *isloadUpdate=APIIsLoad;
                if([isloadUpdate isEqualToString:@"1"])
                {
                    [arrAllLoads enumerateObjectsUsingBlock:^(AlertDetails *objmatch, NSUInteger idx, BOOL * _Nonnull stop) 
                    {
                        if ([objmatch.loadId isEqualToString:APIDeletedId])
                        {
                            [arrAllLoads removeObjectAtIndex:idx];
                        }
                      
                    }];
                    
                }
                else
                {
                    [arrAllAssets enumerateObjectsUsingBlock:^(AlertDetails *objmatch, NSUInteger idx, BOOL * _Nonnull stop) 
                     {
                         if ([objmatch.equiId isEqualToString:APIDeletedId])
                         {
                             [arrAllAssets removeObjectAtIndex:idx];
                         }
                     }];
                }
                  [_tblAllAlerts.tableView reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationNone];
            }
            else
            {
                [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
                _tblAllAlerts.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    } 
}
- (IBAction)btnBackClicked:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSettingsClicked:(id)sender {
}
- (IBAction)btnDrawerClicked:(id)sender {
     [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
@end
