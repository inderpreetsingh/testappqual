//
//  AlernateEquimentListVC.m
//  Lodr
//
//  Created by c196 on 07/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "AlernateEquimentListVC.h"
#import "GlobalFunction.h"
#import "UITableView+Placeholder.h"
#import "WebServiceResponse.h"
#import <MapKit/MapKit.h>
#import "EquipmentDetailVC.h"
#import "LoadDetailVC.h"
@interface AlernateEquimentListVC ()
{
    NSArray *nib;
    NSMutableArray *arrAllEquipments;
    int selectedSection;
    NSString *successed;
    BOOL distancesort,statsussort;
    
}
@end
@implementation AlernateEquimentListVC
- (void)viewDidLoad 
{
    [super viewDidLoad];
    _lblloadname.text=[NSString stringWithFormat:@"%@-%@",_pickstatecode,_delieverystatecode];
    _lblloaddistance.text=_distnceval;
    _lblpickuplocation.text=_pickuptime;
    _lbldelieverylocation.text=_delieverytime;
    CGRect rect =CGRectMake(0, 164, self.view.frame.size.width, self.view.frame.size.height-164);
    NavigationBarHidden(YES);
    self.tblelist.redirectFrom=@"ALL_EQUIPMENTS_ALTERNATE";
    self.tblelist = [[TQMultistageTableView alloc] initWithFrame:rect];
    self.tblelist.dataSource = self;
    self.tblelist.delegate   = self;
    self.tblelist.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tblelist];
    self.tblelist.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.btnBACK setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
    UINib *nibcell = [UINib nibWithNibName:@"CellCalenderSchedule" bundle:nil];
    [self.tblelist.tableView registerNib:nibcell forCellReuseIdentifier:@"CellCalenderSchedule"];
    [self getAllEquiDetail:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    
}
-(void)getAllEquiDetail:(BOOL)showloader
{
//    if(showloader)
//    {
//        [_tblelist.tableView setLoaderWithString:@"Fetching Matched Equipments"];
//    }
//    else
//    {
//        self.tblelist.tableView.backgroundView=nil;
//    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_LoadId:_loadid,
                                Req_EquiId:_chooseneid,
                                
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAlternateEquipmentList
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getdicAllEquiResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Matched Equipments"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

-(IBAction)getdicAllEquiResponse:(id)sender
{
    ShowNetworkIndicator(NO);
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
       
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            
            arrAllEquipments=[NSMutableArray new];
            
            for (Equipments *equi in [sender responseArray])
            {
                [arrAllEquipments addObject:equi];
            }
            
           
            [self.tblelist reloadData];
            if(arrAllEquipments.count == 0)
            {
                [self.tblelist.tableView setBlankPlaceHolderWithString:NoEquipmentsFound];
                self.tblelist.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
            else
            {
              
                self.tblelist.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
                
                self.tblelist.tableView.backgroundView=nil;
                
            }
        }
        else
        {
            [self.tblelist reloadData];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
            [self.tblelist.tableView setBlankPlaceHolderWithString:APIResponseMessage];
            self.tblelist.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        }
    }
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 0;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return nil;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 70;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 0;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
- (NSInteger)mTableView:(TQMultistageTableView *)mTableView numberOfRowsInSection:(NSInteger)section
{
     Equipments *equips=[arrAllEquipments objectAtIndex:section];
    if(equips.matches.count>0)
    {
         return 0;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)mTableView:(TQMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        CellCalenderSchedule *cell = [mTableView dequeueReusableCellWithIdentifier:@"CellCalenderSchedule"];
        cell.cellCalenderScheduleDeleagate=self;
      
            cell.btnSchedule.tag=indexPath.section;
            cell.vwSchudeledbtn.hidden=NO;
            cell.originschedulebtn.constant=((self.view.frame.size.width / 2)-(cell.btnSchedule.frame.size.width/2));
            cell.btnAlternateEqui.hidden=YES;
        return cell;
        } 
    @catch (NSException *exception) {
        
    } 
    
}
- (IBAction)btnscheduledclicked:(id)sender
{
    
    
//    [AZNotification showNotificationWithTitle:@"In progress" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
    @try {
        UIButton *btn=(UIButton*)sender;
        Equipments *equi=[arrAllEquipments objectAtIndex:selectedSection];
        NSDictionary *dicLink=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_OrderFromId:_orderfromid,
                                Req_OrderToId:_ordertoid,
                                Req_LoadId:_loadid,
                                Req_EquiId:_equiid,
                                Req_New_EquiId:equi.internalBaseClassIdentifier,
                                Req_OrderType:@"3",
                                Req_identifier:_orderid}; 
        [self updateStatusValue:dicLink];
    } @catch (NSException *exception) {
        
    } 
}
#pragma mark - schedule truck
-(void)updateStatusValue:(NSDictionary *)dicLink
{
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLSelectAlternateEquipment
         withParameters:dicLink
         withObject:self
         withSelector:@selector(getLinkedResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Scheduling asset"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getLinkedResponse:(id)sender
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
            Equipments *equi=[arrAllEquipments objectAtIndex:selectedSection];
            [arrAllEquipments enumerateObjectsUsingBlock:^(Equipments *obj, NSUInteger idx, BOOL * _Nonnull stop) 
            {
                if([obj.internalBaseClassIdentifier isEqualToString:equi.internalBaseClassIdentifier])
                {
                    [arrAllEquipments removeObjectAtIndex:idx];
                }
            }];
            [self.tblelist reloadData];
            [self.navigationController popViewControllerAnimated:YES];
             [_alernateEquimentListVCProtocol refreshCalender:@"1"];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(TQMultistageTableView *)mTableView
{
    return arrAllEquipments.count;
}

#pragma mark - Table view delegate

- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForHeaderInSection:(NSInteger)section
{
    //    if(!maporlistselection)
    //    {
    //        return 40;
    //    }
    //    else
    //    {
    if(section==0)
    {
        return 140;
    }
    else
    {
        return 70; 
    }
    //  }
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
    static NSString *HeaderIdentifier = @"CellEquipmentListHeader";
    
    CellEquipmentListHeader *header = [mTableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if(!header) {
        header = [[CellEquipmentListHeader alloc] initWithReuseIdentifier:HeaderIdentifier];
        header.backgroundView = [[UIView alloc] init];   
    }
    header.btnEquiname.tag=section;
    header.cellEquipmentListHeaderDelegate=self;
    header.btnViewInMap.hidden=YES;
    header.btnViewInList.hidden=YES;
        [header.btnViewInMap setHighlighted:YES];
        [header.btnViewInList setHighlighted:NO];
        header.vwfieldsHeightHeader.constant=30.0;
        if(section > 0)
        {
            header.vwheaderviewheight.constant = 0.0;
        }
        else
        {
            header.vwheaderviewheight.constant = 70.0;
        }
        Equipments *equips=[arrAllEquipments objectAtIndex:section];
        header.lblEName.text=[NSString stringWithFormat:@"%@",equips.equiName];
        
        if(equips.equiLatitude ==nil)
        {
            header.lblDistance.text=@"0 mi";
            header.lbllocationname.text=@"N/A";
        }
        else
        {
            CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:[AppInstance.userCurrentLat floatValue] longitude:[AppInstance.userCurrentLon floatValue]];
            
            CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:[equips.equiLatitude floatValue] longitude:[equips.equiLongitude floatValue]];
            CLLocationDistance distance = [loc1 distanceFromLocation:loc2];
            header.lblDistance.text=[NSString stringWithFormat:@"%.1f mi",(distance/1609.344)];
            header.lbllocationname.text=equips.lastEquiStatecode;
            header.lbllocationname.text=@"N/A";
        }
    header.lblPrice.text=@"";
    header.lblBlackCount.hidden=YES;
    header.lblOrangeCount.hidden=YES;
    header.vwstatsnames.hidden=NO;
   if(equips.matches.count>0)
   {
       header.lbltextScheduled.text=@"SCHEDULED";
       header.lbltextScheduled.textColor=ScheduledLoadButtonColor;
       header.heightbtnloadname.constant=25;
       Matches *matches=[equips.matches objectAtIndex:0];
       NSString *str=[NSString stringWithFormat:@"%@-%@",matches.pickupStateCode,matches.delievryStateCode];
       [header.btnloadname setTitle:str forState:UIControlStateNormal];
       header.btnRedirectToLoaddetail.hidden=NO;
       header.btnRedirectToLoaddetail.tag=section;
   }
    else
    {
        header.lbltextScheduled.text=@"AVAILABLE";
        header.lbltextScheduled.textColor=ConfirmButtonColor;
         header.heightbtnloadname.constant=0;
        [header.btnloadname setTitle:@"" forState:UIControlStateNormal];
        header.btnRedirectToLoaddetail.hidden=YES;
        
    }
    return header;
}

- (void)mTableView:(TQMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)mscrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}
#pragma mark - Header Open Or Close

- (void)mTableView:(TQMultistageTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section
{
    selectedSection=(int)section;
    
}

- (void)mTableView:(TQMultistageTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section
{
    
    //NSLog(@"Close Header ---%ld",(long)section);
}

#pragma mark - Row Open Or Close

- (void)mTableView:(TQMultistageTableView *)mTableView willOpenRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Open Row ----%ld",(long)indexPath.row);
}

- (void)mTableView:(TQMultistageTableView *)mTableView willCloseRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"Close Row ----%ld",(long)indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)btnBackclicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnDrawerclicked:(id)sender {
     [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
- (IBAction)btnLocationSortClciekd:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"equiLatitude" ascending:distancesort],[NSSortDescriptor sortDescriptorWithKey:@"equiLongitude" ascending:distancesort]];
    arrAllEquipments= [[arrAllEquipments sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    distancesort=!distancesort;
    [self.tblelist reloadData];
}
- (IBAction)btnStatusSortClicked:(id)sender
{
    NSArray *sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"matches.@count" ascending:statsussort]];
    arrAllEquipments= [[arrAllEquipments sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    statsussort=!statsussort;
      [self.tblelist reloadData];
}
- (IBAction)btnEquiNameClicked:(id)sender
{
    Equipments *obj=[arrAllEquipments objectAtIndex:[sender tag]];
    EquipmentDetailVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, EQUIPMENTDETAILVC);
    objeDetail.strRedirectFrom=@"CALENDERVC";
    objeDetail.selectedEqui=obj;
    [self.navigationController pushViewController:objeDetail animated:YES];
}
- (IBAction)btnloadnameclicked:(id)sender
{
    @try
    {
        NSString *matchlist=@"0";
        LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
        Equipments *obj=[arrAllEquipments objectAtIndex:[sender tag]];
        Matches *objMatch=(Matches*)[obj.matches objectAtIndex:0];
        for(Matches *om in obj.matches)
        {
            if(![om.matchId isEqualToString:objMatch.matchId])
            {
                NSString *str=[NSString stringWithFormat:@",%@",om.matchId];
                matchlist=[matchlist stringByAppendingString:str];
            }
        }
        objLoadDetail.allothermatchesIdList=matchlist;
        objLoadDetail.strRedirectFrom=@"ASSETSCHEDULED";
        Loads *loadvalue=[Loads new];
        loadvalue.isDelete=objMatch.isDelete;
        loadvalue.createdDate=objMatch.createdDate;
        loadvalue.internalBaseClassIdentifier=objMatch.matchLoadid;
        loadvalue.loadWidth=objMatch.loadWidth;
        loadvalue.pickupLatitude=objMatch.pickupLatitude;
        loadvalue.modifiedDate=objMatch.modifiedDate;
        loadvalue.deliveryLongitude=objMatch.deliveryLongitude;
        loadvalue.deliveryCountry=objMatch.deliveryCountry;
        loadvalue.deliveryTime=objMatch.deliveryTime;
        loadvalue.offerRate=objMatch.offerRate;
        loadvalue.isTest=objMatch.isTest;
        loadvalue.isPublish=objMatch.isPublish;
        loadvalue.esId=objMatch.esId;
        loadvalue.deliveryState=objMatch.deliveryState;
        loadvalue.pickupState=objMatch.pickupState;
        loadvalue.pickupCity=objMatch.pickupCity;
        loadvalue.pickupAddress=objMatch.pickupAddress;
        loadvalue.loadLength=objMatch.loadLength;
        loadvalue.pickupStateCode=objMatch.pickupStateCode;
        loadvalue.eId=objMatch.esId;
        loadvalue.distance=objMatch.distance;
        loadvalue.isAllowComment=objMatch.isAllowComment;
        loadvalue.loadHeight=objMatch.loadHeight;
        loadvalue.pickupCountry=objMatch.pickupCountry;
        loadvalue.userId=objMatch.userId;
        loadvalue.deliveryLatitude=objMatch.deliveryLatitude;
        loadvalue.pickupLongitude=objMatch.pickupLongitude;
        loadvalue.delieveryDate=objMatch.delieveryDate;
        loadvalue.loadDescription=objMatch.loadDescription;
        loadvalue.deliveryStateCode=objMatch.delievryStateCode;
        loadvalue.isBestoffer=objMatch.isBestoffer;
        loadvalue.deliveryAddress=objMatch.deliveryAddress;
        loadvalue.visiableTo=objMatch.visiableTo;
        loadvalue.loadCode=objMatch.loadCode;
        loadvalue.loadWeight=objMatch.loadWeight;
        loadvalue.deliveryCity=objMatch.deliveryCity;
        loadvalue.notes=objMatch.notes;
        loadvalue.pickupDate=objMatch.pickupDate;
        loadvalue.pickupTime=objMatch.pickupTime;
        loadvalue.medialist=objMatch.medialist;
        objLoadDetail.cmpnyphno=objMatch.cmpnyPhoneNo;
        objLoadDetail.myphono=objMatch.phoneNo;
        objLoadDetail.officephno=objMatch.officePhoneNo;
        objLoadDetail.selectedLoad=loadvalue;
        objLoadDetail.loadStatus=objMatch.matchOrderStatus;
        objLoadDetail.equipname=obj.equiName;
        objLoadDetail.matchorderid=objMatch.matchOrderId;
        objLoadDetail.equipmentid=obj.internalBaseClassIdentifier;
        objLoadDetail.matchId=objMatch.matchId;
        [self.navigationController pushViewController:objLoadDetail animated:YES];
    } @catch (NSException *exception) {
        
    } 
}
@end
