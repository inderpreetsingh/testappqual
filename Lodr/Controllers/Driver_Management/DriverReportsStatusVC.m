//
//  DriverReportsStatusVC.m
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "DriverReportsStatusVC.h"

@interface DriverReportsStatusVC ()
{
    CellDriverStatusHeading *viewHeader;
    NSMutableArray *arrReportNames,*arrReportDetailNames;
}
@end

@implementation DriverReportsStatusVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
     NavigationBarHidden(YES);
    NSLog(@"%@",_equiid);
    
    arrReportNames=[NSMutableArray new];
    arrReportDetailNames=[NSMutableArray new];
    
    [arrReportNames addObject:@"ON TIME"];
    [arrReportNames addObject:@"DELAYED"];
    [arrReportNames addObject:@"PICKUP"];
    [arrReportNames addObject:@"DELIVERED"];
    
    [arrReportDetailNames addObject:@"MY LOAD IS ON SCHEDULE FOR DELIVERY"];
    [arrReportDetailNames addObject:@"LOAD IS BEHIND SCHEDULE FOR DELIVERY"];
    [arrReportDetailNames addObject:@"IN-ROUTE TO PICKUP OR PROCESSING PICKUP"];
    [arrReportDetailNames addObject:@"LOAD HAS BEEN DELIVERED"];
    
    self.tblReports.rowHeight = UITableViewAutomaticDimension;
    self.tblReports.estimatedRowHeight=110;
    [self layoutHeaderAndFooter];
}
-(void)viewWillDisappear:(BOOL)animated
{
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)layoutHeaderAndFooter
{
    @try {
        viewHeader = [[[NSBundle mainBundle] loadNibNamed:@"CellDriverStatusHeading"
                                                    owner:self
                                                  options:nil] objectAtIndex:0];
    } @catch (NSException *exception) {
        NSLog(@"Excepton :%@",exception.description);
    } 
   
}
#pragma mark - tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    return 1; 
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return arrReportNames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
//    static NSString *cellIdentifier = @"CellDriverStatus";
//    CellDriverStatus *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell) 
//    { 
//        cell = [[CellDriverStatus alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
//    }
//    [cell.btnStatusName setTitle:[arrReportNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//    return cell; 
    
    static NSString *CellIdentifier = @"CellDriverStatus";
    CellDriverStatus *cellDriverStatus = [_tblReports dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cellDriverStatus == nil)
    {
        NSArray *objCell = [[NSBundle mainBundle] loadNibNamed:@"CellDriverStatus" owner:self options:nil];
        cellDriverStatus = [objCell objectAtIndex:0];
    }
      cellDriverStatus.cellDriverStatusDelegate=self;
      [cellDriverStatus.btnStatusName setTitle:[arrReportNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
     cellDriverStatus.lblStatusDetail.text=[arrReportDetailNames objectAtIndex:indexPath.row];
    cellDriverStatus.btnStatusName.tag=indexPath.row;
    if([_strCurrentStatusValue isEqualToString:[arrReportNames objectAtIndex:indexPath.row]])
    {
          [cellDriverStatus.btnStatusName setTitleColor:GreenButtonColor forState:UIControlStateNormal];
   
    }
    else
    {
          [cellDriverStatus.btnStatusName setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateNormal];
    }
      return cellDriverStatus;
}

- (IBAction)btnStatusNameClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    _strCurrentStatusValue=[arrReportNames objectAtIndex:btn.tag];
    [btn setTitleColor:GreenButtonColor forState:UIControlStateNormal];
    [self.tblReports reloadData];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return viewHeader;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    NSArray *nibFooter = [[NSBundle mainBundle] loadNibNamed:@"welcomeFooter" owner:self options:nil];
   CellWelcomeFooter *tblFooter = (CellWelcomeFooter *)[nibFooter objectAtIndex:0]; 
    //tblFooter.cellWelcomeFooterDelegate=self;
    tblFooter.heightvwWelocmeFooter.constant=0;
    tblFooter.heightcmpnyFooter.constant=0;
    tblFooter.heightOfficeFooter.constant=0;
    tblFooter.heightSummaryFooter.constant=150;
    tblFooter.vwWelcomeFoooter.clipsToBounds=YES;
    tblFooter.vwFootercompany.clipsToBounds=YES;
    tblFooter.vwOfficeInfoFooter.clipsToBounds=YES;
    [tblFooter.btnSummaryback setTitle:@"REPORT STATUS" forState:UIControlStateNormal];
    [tblFooter.brnSummaryRegister setTitle:@"CANCEL" forState:UIControlStateNormal];
    tblFooter.cellWelcomeFooterDelegate=self;
    tblFooter.btnSummaryback.backgroundColor=[UIColor orangeColor];
     tblFooter.brnSummaryRegister.backgroundColor=[UIColor blackColor];
    return tblFooter;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{
    return 150;
}
- (IBAction)btnSummaryBackClicked:(id)sender
{
   [self updateLoadStatus];
 
}
- (IBAction)btnSummaryRegisterClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSettingsClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDrawerClicked:(id)sender {
     [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
#pragma mark webservice
-(void)updateLoadStatus
{
    if([_strCurrentStatusValue isEqualToString:@"ON TIME"])
    {
        _loadstatus=@"2";
    }
    else if([_strCurrentStatusValue isEqualToString:@"DELAYED"])
    {
         _loadstatus=@"3";
    }
    else if([_strCurrentStatusValue isEqualToString:@"PICKUP"])
    {
         _loadstatus=@"1";
    }
    else if([_strCurrentStatusValue isEqualToString:@"DELIVERED"])
    {
         _loadstatus=@"4";
    }
    else
    {
        _loadstatus=@"0";
    }
    
    if([_loadstatus isEqualToString:@"3"])
    {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"Please select the delay reason" preferredStyle:UIAlertControllerStyleActionSheet];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Tire issue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                                {
                                    [self selfcallupdateAPI:@"1"];
                                }]];       
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Mechanical issue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                                {
                                  [self selfcallupdateAPI:@"2"];
                                }]];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                                {
                                    [AZNotification showNotificationWithTitle:@"Please select the reason of delay" controller:ROOTVIEW notificationType:AZNotificationTypeError];
                                }]];
        [self presentViewController:actionSheet animated:YES completion:^{    }];
        
    }
    else
    {
         [self selfcallupdateAPI:@"0"];
    }
}

-(void)selfcallupdateAPI:(NSString *)delayreson
{
    
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
    
    [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey] forKey:SavedAccessKey];
    
    [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey] forKey:SavedSecretKey];
     [dicParam setValue:_loadid forKey:Req_LoadId];
     [dicParam setValue:_loadstatus forKey:Req_Load_Status];
     [dicParam setValue:delayreson forKey:Req_Delay_Reason];
     [dicParam setValue:AppInstance.userCurrentLat forKey:Req_UserLatitude];
     [dicParam setValue:AppInstance.userCurrentLon forKey:Req_UserLongitude];
     [dicParam setValue:_equiid forKey:Req_EquiId];
     [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:_equiid];
    
    /*
     
     
     [dicParam setValue:Req_LoadId forKey:_loadid];
     [dicParam setValue:Req_Load_Status forKey:_loadstatus];
     [dicParam setValue:Req_Delay_Reason forKey:delayreson];
     [dicParam setValue:Req_UserLatitude forKey:];
     [dicParam setValue:Req_UserLongitude forKey:AppInstance.userCurrentLon];
     [dicParam setValue:Req_EquiId forKey:_equiid];
     [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:_equiid];
     
     
     */
    if([_strCurrentStatusValue isEqualToString:@"ON TIME"])
    {
        _loadstatus=@"2";
    }
    else if([_strCurrentStatusValue isEqualToString:@"DELAYED"])
    {
        _loadstatus=@"3";
    }
    else if([_strCurrentStatusValue isEqualToString:@"PICKUP"])
    {
        _loadstatus=@"1";
    }
    else if([_strCurrentStatusValue isEqualToString:@"DELIVERED"])
    {
        _loadstatus=@"4";
    }
    
    @try{
        NSDictionary *dicAllEqui=@{
                                   Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                   Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                   Req_LoadId:_loadid,
                                   Req_Load_Status:_loadstatus,
                                   Req_Delay_Reason:delayreson,
                                   Req_UserLatitude:AppInstance.userCurrentLat,
                                   Req_UserLongitude:AppInstance.userCurrentLon,
                                   Req_EquiId:_equiid,
                                   Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                  // Req_isPickup :_loadstatus
                                   };
 
        Drivers *objd=[DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDriverData];
        //0 - off duty 1- on duty
        if([objd.dutyStatus isEqualToString:@"0"]){
            
            NSLog(@"LOCATION NOT UPDATED AS DRIVER IS OFF DUTY");
         
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"You must be on duty to update the load status" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
            
            UIAlertAction *alertChangeDuty = [UIAlertAction actionWithTitle:@"On Duty" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //call url update duty api from here
                
                [self UpdateDriverDuty:@"1"];

                
            }];
            
            [alertController addAction:alertCancel];
            [alertController addAction:alertChangeDuty];
            
            [self presentViewController:alertController animated:true completion:nil];
            
            
            return;
            //dont call api if driver is off duty
            
        }
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLUpdateLoadStatus
             withParameters:dicAllEqui
             withObject:self
             withSelector:@selector(getUpdateLoadStatusResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Reporting load status"
             showProgress:YES];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
        
    }
    @catch (NSException *exception)
    {
        [GlobalFunction ShowAlert:@"Alert !!!" Message:[NSString stringWithFormat:@"%@ %@",@"Please take a snap and forward it if you are seeing it",[exception reason]]];
        
        NSLog(@"ERROR %@",[exception reason]);
    }
  
   
}

-(void)UpdateDriverDuty:(NSString *)tp
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
         withSelector:@selector(UpdatedDutyResponse:)
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

-(IBAction)getUpdateLoadStatusResponse:(id)sender
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
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            [self.driverReportsStatusProtocol sendDataToDetailvc:_loadstatus];
            [self.navigationController popViewControllerAnimated:YES];
            
        }   
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

-(IBAction)UpdatedDutyResponse:(id)sender
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
