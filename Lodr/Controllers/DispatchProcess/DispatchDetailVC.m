//
//  DispatchDetailVC.m
//  Lodr
//
//  Created by c196 on 28/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "DispatchDetailVC.h"
#import "User.h"
#import "Matches.h"
#import "Equipments.h"
#import "Medialist.h"
#import "HomeVC.h"

@interface DispatchDetailVC ()
{
    CellLoadDetailHeader *headerview;
    CellFooterDispatchvw *footer;
    NSString *estimatedpickup,*estimateddelievery,*remaining;
    User *objuser;
    UserAccount *objuac;
    UIView *overlay,*overlayview;
    ZSYPopoverListView *listView;
    NSMutableArray *arrTrailerlist,*arrPowerlist,*arrSupportlist,*arrDriverlist,*arrTotalTrailers,*arrChooseType,*arrTotalDriver,*arrTotalSupport,*arrTotalPower;
    NSString *selectedPopupName,*choosendriverindex,*choosentrailerindex,*choosenpowerindex,*choosesupportindex,*drivernm,*powernm,*supportname,*trailernm,*driverpic,*trailerpic,*powerpic,*supportpic,*driverid,*supportid,*powerid,*trailerid,*startdt,*endtdt,*starttm,*endtm,*choosentype;
    bool btntapped;
    NSDateFormatter *dateFormatter;
    NSDate *choosenPickUpdate;
    NSInteger slectedtag;
    int i;
}
@end

@implementation DispatchDetailVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    
    arrTrailerlist = [NSMutableArray new];
    arrPowerlist = [NSMutableArray new];
    arrSupportlist = [NSMutableArray new];
    arrDriverlist = [NSMutableArray new];
    arrTotalTrailers = [NSMutableArray new];
    arrChooseType =[NSMutableArray new];
    arrTotalDriver =[NSMutableArray new];
    arrTotalSupport =[NSMutableArray new];
    arrTotalPower =[NSMutableArray new];
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    objuac = [objuser.userAccount objectAtIndex:0];
    [self getAlldrivers:YES];
    [self getAllTrailers:YES];
    [self getAllpowerdasset:YES];
    [self getAllsupportasset:YES];
    [self registerCustomNibForAllcell];
   
    drivernm = @"Select Driver";
    supportname = @"Select Support Asset";
    trailernm = @"Select Trailer";
    powernm = @"Select Power Asset";
    
    choosendriverindex = @"1000000";
    choosentrailerindex = @"1000000";
    choosenpowerindex = @"1000000";
    choosesupportindex = @"1000000";
    choosentype =@"1000000";
    
    NSLog(@"%@",_selectedLoad);
  
    if(_selectedLoad.supportAsset.count > 0){
        
        NSArray *arrSupportAsset = _selectedLoad.supportAsset;
        SupportAsset *objAssets = [arrSupportAsset objectAtIndex:0];
        supportname = objAssets.equiName;
        supportid = [NSString stringWithFormat:@"%.0f",objAssets.supportAssetIdentifier];
    }
    if(_selectedLoad.powerAsset.count > 0){
        
        NSArray *arrPowerAsset = _selectedLoad.powerAsset;
        PowerAsset *objAssets = [arrPowerAsset objectAtIndex:0];
        powernm = objAssets.equiName;
        powerid = [NSString stringWithFormat:@"%.0f",objAssets.powerAssetIdentifier];
    }
    
    if(_selectedLoad.driver.count > 0){
        
        NSArray *arrDriver = _selectedLoad.driver;
        Driver *objDriver = [arrDriver objectAtIndex:0];
        drivernm = objDriver.firstname;
        driverid = [NSString stringWithFormat:@"%.0f",objDriver.driverId];
        
    }
    
//     [arrTotalTrailers addObject:@"Title"];
//     [arrTotalTrailers addObject:@"Description"];
    
    i = 2;
    endtdt=  [NSString stringWithFormat:@"%@",[GlobalFunction stringDate:_selectedLoad.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd/yyyy"]];
    startdt=  [NSString stringWithFormat:@"%@",[GlobalFunction stringDate:_selectedLoad.pickupDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd/yyyy"]];
    
    starttm = _selectedLoad.pickupTime;
    endtm = _selectedLoad.deliveryTime;
    [arrChooseType addObject:@"Driver"];
    [arrChooseType addObject:@"Power Asset"];
    [arrChooseType addObject:@"Support Asset"];
    [arrChooseType addObject:@"Trailer"];
    [arrTotalTrailers addObject:@"Trailer1"];
    [arrTotalDriver addObject:@"Driver1"];
    [arrTotalPower addObject:@"Power1"];
    [arrTotalSupport addObject:@"Support1"];
    dateFormatter = [[NSDateFormatter alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - custom methods

-(void)registerCustomNibForAllcell
{
    UINib *nibcell = [UINib nibWithNibName:@"CellLoadDetailTop" bundle:nil];
    [[self tbldispatchdetail] registerNib:nibcell forCellReuseIdentifier:@"CellLoadDetailTop"];
  
    UINib *nibcell2 = [UINib nibWithNibName:@"CellDispatchTop" bundle:nil];
    [[self tbldispatchdetail]  registerNib:nibcell2 forCellReuseIdentifier:@"CellDispatchTop"];
    
    UINib *nibcell3 = [UINib nibWithNibName:@"CellDisptachDateTime" bundle:nil];
    [[self tbldispatchdetail]  registerNib:nibcell3 forCellReuseIdentifier:@"CellDisptachDateTime"];
    
    UINib *nibcell4 = [UINib nibWithNibName:@"CellDispatchChooseAsset" bundle:nil];
    [[self tbldispatchdetail]  registerNib:nibcell4 forCellReuseIdentifier:@"CellDispatchChooseAsset"];

    _tbldispatchdetail.estimatedRowHeight = 335;
    _tbldispatchdetail.rowHeight = UITableViewAutomaticDimension;
    [self setHeaderFooter];
}

-(void)setHeaderFooter
{
    NSArray *nibheader = [[NSBundle mainBundle] loadNibNamed:@"CellLoadDetailHeader" owner:self options:nil];
    headerview = (CellLoadDetailHeader *)[nibheader objectAtIndex:0]; 
    
    NSArray *nibfooter = [[NSBundle mainBundle] loadNibNamed:@"CellFooterDispatchvw" owner:self options:nil];
      footer = (CellFooterDispatchvw *)[nibfooter objectAtIndex:0];
    footer.cellFooterDispatchvwDelegate = self;
    
    estimatedpickup= [GlobalFunction dateAfter1Hour:[NSString stringWithFormat:@"%@ %@",_selectedLoad.pickupDate,_selectedLoad.pickupTime] fromFormat:@"yyyy-MM-dd hh:mm a" toFormat:@"hh:mm a"];
    estimateddelievery = [GlobalFunction dateAfter1Hour:[NSString stringWithFormat:@"%@ %@",_selectedLoad.delieveryDate,_selectedLoad.deliveryTime] fromFormat:@"yyyy-MM-dd hh:mm a" toFormat:@"hh:mm a"];
    NSString *tm1 = [NSString stringWithFormat:@"%@ %@",_selectedLoad.pickupDate,_selectedLoad.pickupTime];
    NSString *tm2 = [NSString stringWithFormat:@"%@ %@",_selectedLoad.delieveryDate,_selectedLoad.deliveryTime];
    NSDate *dt = [GlobalFunction getDateFromDateString: [GlobalFunction dateAfter1Hour:tm1 fromFormat:@"yyyy-MM-dd hh:mm a" toFormat:@"yyyy-MM-dd hh:mm a"] withFormate:@"yyyy-MM-dd hh:mm a"];
    NSDate *dt2 = [GlobalFunction getDateFromDateString: [GlobalFunction dateAfter1Hour:tm2 fromFormat:@"yyyy-MM-dd hh:mm a" toFormat:@"yyyy-MM-dd hh:mm a"] withFormate:@"yyyy-MM-dd hh:mm a"];
    
   remaining =[GlobalFunction remaningTime:dt endDate:dt2];
    
}

#pragma mark - tableview delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{ 
    return 5; 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    if(section == 0)
    {
        return 3;
    }
    else if(section == 1)
    {
        return arrTotalDriver.count;
    }
    else if(section == 2)
    {
        return arrTotalPower.count;
    }
    else if(section == 3)
    {
        return arrTotalSupport.count;
    }
    else
    {
        return arrTotalTrailers.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    @try
    {
        if(indexPath.section == 0)
        {
            if(indexPath.row==1)
            {
                static NSString *cellIdentifier = @"CellLoadDetailTop";
                CellLoadDetailTop *cell = (CellLoadDetailTop*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (!cell) 
                { 
                    cell = [[CellLoadDetailTop alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
                }
                cell.topCode.constant = 0;
                cell.topcodeval.constant = 0;
                cell.heightcodelbl.constant = 0;
                cell.heightvaluecode.constant = 0;
                
                cell.lblLoadCode.text=_selectedLoad.loadCode;
                
                cell.lblfromstatecode.text=_selectedLoad.pickupStateCode;
                cell.lbltostatecode.text=_selectedLoad.deliveryStateCode;
                
                cell.heightlblFromcompnyname.constant=0;
                cell.heightlbltocompnyname.constant=0;
                
                cell.lblfromtextvw.text=_selectedLoad.pickupAddress;
                [cell.lblfromtextvw sizeToFit];
                
                cell.lbltotextvw.text=_selectedLoad.deliveryAddress;
                [cell.lbltotextvw sizeToFit];
                
                cell.lblfromphone.text=@"";
                cell.lbltophone.text=@"";
                
                cell.heightlblfromphone.constant=0;
                cell.heightlbltophone.constant=0;
                
                cell.lblfromopentime.text=@"";
                cell.lbltoopentime.text=@"";
                
                cell.lblpickuptime.text=_selectedLoad.pickupTime;
                cell.lbldelieveytime.text=_selectedLoad.deliveryTime;
                
                cell.lblfromdate.text=[NSString stringWithFormat:@"%@",[GlobalFunction stringDate:_selectedLoad.pickupDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd/yy"]];
                cell.lbltodate.text=[NSString stringWithFormat:@"%@",[GlobalFunction stringDate:_selectedLoad.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd/yy"]];
                
                return cell; 
            }
            else if(indexPath.row==0)
            {
                static NSString *cellIdentifier = @"CellDispatchTop";
                CellDispatchTop *cell = (CellDispatchTop*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (!cell) 
                { 
                    cell = [[CellDispatchTop alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
                }   
                cell.lblbolpod.text = _selectedLoad.bolPod;
                cell.lblcode.text = _selectedLoad.loadCode;
                cell.lbldescr.text = _selectedLoad.loadDescription;
                return cell;
            }
            else
            {
                static NSString *cellIdentifier = @"CellDisptachDateTime";
                CellDisptachDateTime *cell = (CellDisptachDateTime*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (!cell) 
                { 
                    cell = [[CellDisptachDateTime alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
                }
                cell.cellDisptachDateTimeDelegate= self;
                cell.lblestimatedtpickup.text = estimatedpickup;
                cell.lblestimateddelievery.text = estimateddelievery;
                cell.lbldutarion.text = remaining;
                
                [cell.btnstartdate setTitle:startdt forState:UIControlStateNormal];
                [cell.btnenddate setTitle:endtdt forState:UIControlStateNormal];
                [cell.btnstarttime setTitle:starttm forState:UIControlStateNormal];
                [cell.btnendtime setTitle:endtm forState:UIControlStateNormal];
                return cell;
            }
        }
        else if(indexPath.section ==1 )
        {
            static NSString *cellIdentifier = @"CellDispatchChooseAsset";
            CellDispatchChooseAsset *cell = (CellDispatchChooseAsset*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                cell = [[CellDispatchChooseAsset alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
            }
            cell.lblnoasset.hidden = YES;
            cell.cellCellDispatchChooseAssetDelegate = self;
            cell.btnclose.accessibilityLabel = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
            cell.lblnameofproperty.text = @"Driver:";
            cell.btndroplist.accessibilityLabel = @"Driver";
            cell.btnclose.hidden = NO;
            cell.btnclose.tag = indexPath.row;
            
            [cell.btndroplist setTitle:drivernm forState:UIControlStateNormal];
            
            NSString *urlval= [NSString stringWithFormat:@"%@%@",URLProfileImage,driverpic];
            NSURL *url = [NSURL URLWithString:urlval];
            [cell.imgofasset sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
            cell.btnredirect.tag = indexPath.row;
            cell.btndroplist.tag = indexPath.row;
            return cell;
        }
        else if(indexPath.section ==2 )
        {
            static NSString *cellIdentifier = @"CellDispatchChooseAsset";
            CellDispatchChooseAsset *cell = (CellDispatchChooseAsset*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                cell = [[CellDispatchChooseAsset alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
            }
            cell.lblnoasset.hidden = YES;
            cell.cellCellDispatchChooseAssetDelegate = self;
            cell.btnclose.accessibilityLabel = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
            cell.lblnameofproperty.text = @"Powered Asset:";
            cell.btndroplist.accessibilityLabel = @"Power";
            cell.btnclose.hidden = NO;
            cell.btnclose.tag = indexPath.row;
            [cell.btndroplist setTitle:powernm forState:UIControlStateNormal];
            NSString *urlval= [NSString stringWithFormat:@"%@%@",URLEquipmentImage,powerpic];
            NSURL *url = [NSURL URLWithString:urlval];
            [cell.imgofasset sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
            cell.btnredirect.tag = indexPath.row;
            cell.btndroplist.tag = indexPath.row;
            return cell;
        }
        else if(indexPath.section ==3 )
        {
            static NSString *cellIdentifier = @"CellDispatchChooseAsset";
            CellDispatchChooseAsset *cell = (CellDispatchChooseAsset*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                cell = [[CellDispatchChooseAsset alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
            }
            cell.lblnoasset.hidden = YES;
            cell.cellCellDispatchChooseAssetDelegate = self;
            cell.btnclose.accessibilityLabel = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
            cell.btnredirect.tag = indexPath.row;
            cell.btndroplist.tag = indexPath.row;
            cell.lblnameofproperty.text = @"Support Asset:";
            cell.btndroplist.accessibilityLabel = @"Support";
            cell.btnclose.hidden = NO;
            cell.btnclose.tag = indexPath.row;
            [cell.btndroplist setTitle:supportname forState:UIControlStateNormal];
            NSString *urlval= [NSString stringWithFormat:@"%@%@",URLEquipmentImage,supportpic];
            NSURL *url = [NSURL URLWithString:urlval];
        
            [cell.imgofasset sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
            return cell;
            
        }
        else
        {
            static NSString *cellIdentifier = @"CellDispatchChooseAsset";
            CellDispatchChooseAsset *cell = (CellDispatchChooseAsset*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                cell = [[CellDispatchChooseAsset alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
            }
           
            cell.lblnoasset.hidden = YES;
             cell.btnclose.accessibilityLabel = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
            cell.cellCellDispatchChooseAssetDelegate = self;
            //    cell.heightlbl.constant = 0;
                cell.lblnameofproperty.text = @"Trailer:";
                cell.btndroplist.accessibilityLabel = @"Trailer";
                [cell.btndroplist setTitle:trailernm forState:UIControlStateNormal];
                NSString *urlval= [NSString stringWithFormat:@"%@%@",URLEquipmentImage,trailerpic];
                NSURL *url = [NSURL URLWithString:urlval];
                cell.btnclose.tag = indexPath.row;
                [cell.imgofasset sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noimage"]];
            cell.btnredirect.tag = indexPath.row;
            cell.btndroplist.tag = indexPath.row;
            [self.tbldispatchdetail layoutIfNeeded];
            
            if(indexPath.row == 0)
            {
                cell.btnclose.hidden = NO;
            }
            else
            {
                 cell.btnclose.hidden = NO;
            }
            return cell;
        }
    } 
    @catch (NSException *exception) {
        NSLog(@"exception :%@",exception.description);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
    //NSString *strEqui=[NSString stringWithFormat:@"This load is a MATCH to %@",@"PU"];
    headerview.lblLoadStatus.text = @"";
    headerview.vwbacklabelheight.constant = 0;
    headerview.vwstatusheight.constant = 0;
    headerview.vwStatus.hidden = YES;
    headerview.vwWithBackbutton.backgroundColor = [UIColor orangeColor];
    return headerview;
    }
    else
    {
        return [[UIView alloc]initWithFrame:CGRectZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row==0)
        {
            return UITableViewAutomaticDimension;
        }
        else if(indexPath.row==1)
        {
            return  UITableViewAutomaticDimension; //105
        }
        else if(indexPath.row==2)
        {
            return 340;
        }
        else
        {
            return 145;
        }
    }
    else
    {
        return 145;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{  
    if(section == 0)
    {
        return [[UIView alloc]initWithFrame:CGRectZero];
    }
    else if(section == 1)
    {
       return [[UIView alloc]initWithFrame:CGRectZero];
    }
    else if(section == 2)
    {
        return [[UIView alloc]initWithFrame:CGRectZero];
    }
    else if(section == 3)
    {
        return [[UIView alloc]initWithFrame:CGRectZero];
    }
    else 
    {
        footer.btnaddmoreasset.hidden = false;
        footer.lblseparator.hidden = false;
        footer.btnnotschedle.hidden = YES;
        return footer;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    if(section == 0)
    {
       return 60;
    }
    else
    {
        return 0;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{ 
    if(section == 0)
    {
        return 0;
    }
   else if(section == 1)
    {
        return 0;
    }
   else if(section == 2)
   {
       return 0;
   }
   else if(section == 3)
   {
       return 0;
   }
   else
    {
        return 180;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)btndrawerclicked:(id)sender 
{
    [self.view endEditing:YES];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
- (IBAction)btnbackclicked:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - websservice handling
- (void)getAlldrivers:(BOOL)showloader
{
    NSDictionary *dicAllEqui=@{
                               Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                               Req_CmpnyPhoneNo:objuac.cmpnyPhoneNo,
                               Req_DotNumber:objuac.dotNumber
                               };   
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllDriver
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getdrverResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Loading drivers"
         showProgress:showloader];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getdrverResponse:(id)sender
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
                for(Matches *objd in [sender responseArray])
                {
                    [arrDriverlist addObject:objd];
                }
                if(btntapped == true)
                {
                    CGFloat height = (40*arrDriverlist.count) + 120;
                     if(height  < (SCREEN_HEIGHT - 100))
                    {
                        listView= [self showListView:listView withSelectiontext:DriverPopUp widthval:SCREEN_WIDTH - 100 heightval:height];
                    }
                    else
                    {
                        listView= [self showListView:listView withSelectiontext:DriverPopUp widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT - 100];
                    }
                   
                    btntapped = false;
                }
            }
            else
            {
                [AZNotification showNotificationWithTitle:@"No driver avilable." controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }   
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
    }
}
- (void)getAllTrailers:(BOOL)showloader
{
    NSDictionary *dicAllEqui=@{
                               Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]
                               };   
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllTrailers
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getTrailerResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Loading Trailers"
         showProgress:showloader];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getTrailerResponse:(id)sender
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
                for(Equipments *objd in [sender responseArray])
                {
                    [arrTrailerlist addObject:objd];
                }
                if(btntapped == true)
                {
                    CGFloat height = (40*arrTrailerlist.count) + 120;
                     if(height  < (SCREEN_HEIGHT - 100))
                    {
                        listView= [self showListView:listView withSelectiontext:TrailerPopUp widthval:SCREEN_WIDTH - 100 heightval:height];
                    }
                    else
                    {
                        listView= [self showListView:listView withSelectiontext:TrailerPopUp widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT - 100];
                    }
                    btntapped = false;
                }
            }
            else
            {
                [AZNotification showNotificationWithTitle:@"No trailer available." controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }   
        else
        {
              [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
    }
}
- (void)getAllpowerdasset:(BOOL)showloader
{
    NSDictionary *dicAllEqui=@{
                               Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]
                               };   
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllPowerAsset
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getPoweredassetResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Loading Powered Assets"
         showProgress:showloader];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getPoweredassetResponse:(id)sender
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
                for(Equipments *objd in [sender responseArray])
                {
                    [arrPowerlist addObject:objd];
                }
                if(btntapped == true)
                {
                    CGFloat height = (40*arrPowerlist.count) + 120;
                     if(height  < (SCREEN_HEIGHT - 100))
                    {
                        listView= [self showListView:listView withSelectiontext:PoweredPopUp widthval:SCREEN_WIDTH - 100 heightval:height];
                    }
                    else
                    {
                        listView= [self showListView:listView withSelectiontext:PoweredPopUp widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT - 100];
                    }
                    btntapped = false;
                }
            }
            else
            {
                [AZNotification showNotificationWithTitle:@"No powered asset found" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }   
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
    }
}
- (void)getAllsupportasset:(BOOL)showloader
{
    NSDictionary *dicAllEqui=@{
                               Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]
                               };   
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllSupportAsset
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getsupportassetResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Loading Support Assets"
         showProgress:showloader];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getsupportassetResponse:(id)sender
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
                for(Equipments *objd in [sender responseArray])
                {
                    [arrSupportlist addObject:objd];
                }
                if(btntapped == true)
                {
                    [listView dismiss];
                    [overlayview removeFromSuperview];
                    CGFloat height = (40*arrSupportlist.count) + 120;
                     if(height  < (SCREEN_HEIGHT - 100))
                    {
                        listView= [self showListView:listView withSelectiontext:SupportPopUp widthval:SCREEN_WIDTH - 100 heightval:height];
                    }
                    else
                    {
                        listView= [self showListView:listView withSelectiontext:SupportPopUp widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT - 100];
                    }
                    btntapped = false;
                }
            }
            else
            {
                [AZNotification showNotificationWithTitle:@"No support asset found" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
                [listView dismiss];
                [overlayview removeFromSuperview];
            }
        }   
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            [listView dismiss];
            [overlayview removeFromSuperview];
        }
        
    }
}
- (void)ScheduleAllAsset:(BOOL)showloader
{
    if(supportid == nil)
    {
        supportid = @"0";
    }
    if(powerid == nil)
    {
        powerid = @"0";
    }
    if(trailerid == nil){
        
        trailerid = @"0";
        
        
    }
    @try
    {
        
        NSLog(@"POWER ID == > %@",powerid);
        
        NSDictionary *dicAllEqui=@{
                                   Req_OrderToId:_selectedLoad.orderToId,
                                   Req_identifier:_selectedLoad.orderId,
                                   Req_EquiId:trailerid,
                                   Req_SupportId:supportid,
                                   Req_PowerId:powerid,
                                   Req_DriverId:driverid,
                                   Req_LoadId:_selectedLoad.loadId
                                   };
        
        NSLog(@"POWER ID123 == >");
        
        
        NSLog(@"POWER ID == > %@",powerid);
        
        NSLog(@"%@",dicAllEqui);
        
        NSLog(@"POWER ID == > %@",powerid);
        
        
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLScheduleAllAsset
             withParameters:dicAllEqui
             withObject:self
             withSelector:@selector(scheduleAllresponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Scheduling"
             showProgress:showloader];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        } 
    } 
    @catch (NSException *exception) 
    {
        NSLog(@"ERROR %@",[exception reason]);
    }
    
}
-(IBAction)scheduleAllresponse:(id)sender
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
            HomeVC *objvc = initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
            [self.navigationController pushViewController:objvc animated:YES];
        }
        else
        {
             [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
    }
}
- (IBAction)btnstarttimeclciked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
   // [picker setDatePickerMode:UIDatePickerModeTime];
    picker.timeZone = [NSTimeZone localTimeZone];
    picker.calendar = [NSCalendar currentCalendar];
    [picker setMinimumDate: [NSDate date]];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n\n\n" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    picker.frame=CGRectMake(actionSheet.view.frame.origin.x, actionSheet.view.frame.origin.y+30, actionSheet.view.frame.size.width, 300);
    [actionSheet.view addSubview:picker];
     [dateFormatter setDateFormat:@"hh:mm a"];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
//                                NSString *dateString = [dateFormatter stringFromDate:picker.date];
//                               [btn setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                NSString *dateString = [dateFormatter stringFromDate:picker.date];
                                choosenPickUpdate=picker.date;
                                starttm = dateString;
                                [btn setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}
- (IBAction)btnstartdateclicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    [picker setDatePickerMode:UIDatePickerModeDate];
    picker.timeZone = [NSTimeZone localTimeZone];
    picker.calendar = [NSCalendar currentCalendar];
    [picker setMinimumDate: [NSDate date]];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Pickup Date\n\n\n\n\n\n\n\n\n\n\n\n\n" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    picker.frame=CGRectMake(actionSheet.view.frame.origin.x, actionSheet.view.frame.origin.y+30, actionSheet.view.frame.size.width, 300);
    [actionSheet.view addSubview:picker];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
//                                NSString *dateString = [dateFormatter stringFromDate:picker.date];
//                                [btn setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                NSString *dateString = [dateFormatter stringFromDate:picker.date];
                                choosenPickUpdate=picker.date;
                                startdt = dateString;
                                [btn setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}
- (IBAction)btnendtimeclicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    [picker setDatePickerMode:UIDatePickerModeTime];
    picker.timeZone = [NSTimeZone localTimeZone];
    picker.calendar = [NSCalendar currentCalendar];
    [picker setMinimumDate: [NSDate date]];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Delivery Time\n\n\n\n\n\n\n\n\n\n\n\n\n" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    picker.frame=CGRectMake(actionSheet.view.frame.origin.x, actionSheet.view.frame.origin.y+30, actionSheet.view.frame.size.width, 300);
    [actionSheet.view addSubview:picker];
     [dateFormatter setDateFormat:@"hh:mm a"];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
//                                NSString *dateString = [dateFormatter stringFromDate:picker.date];
//                                [btn setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                NSString *dateString = [dateFormatter stringFromDate:picker.date];
                                choosenPickUpdate=picker.date;
                                 endtm = dateString;
                                [btn setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}
- (IBAction)btnenddateclicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    [picker setDatePickerMode:UIDatePickerModeDate];
    picker.timeZone = [NSTimeZone localTimeZone];
    picker.calendar = [NSCalendar currentCalendar];
    [picker setMinimumDate: [NSDate date]];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Delivery Date\n\n\n\n\n\n\n\n\n\n\n\n\n" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    picker.frame=CGRectMake(actionSheet.view.frame.origin.x, actionSheet.view.frame.origin.y+30, actionSheet.view.frame.size.width, 300);
    [actionSheet.view addSubview:picker];
     [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
//                                NSString *dateString = [dateFormatter stringFromDate:picker.date];
//                                [btn setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                NSString *dateString = [dateFormatter stringFromDate:picker.date];
                                choosenPickUpdate=picker.date;
                                endtdt = dateString;
                                [btn setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}
- (IBAction)btnnotscheduleclicekd:(id)sender
{
    
}
- (IBAction)btnscheduledclciekd:(id)sender
{
    if([drivernm isEqualToString: @"Select Driver"] || [drivernm isEqualToString:@""] || drivernm.length == 0)
    {
        [AZNotification showNotificationWithTitle:@"Please select driver." controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
//    else if([powernm isEqualToString: @"Select Power Asset"] || [powernm isEqualToString:@""] || powernm.length == 0)
//    {
//        [AZNotification showNotificationWithTitle:@"Please select power asset." controller:ROOTVIEW notificationType:AZNotificationTypeError];
//    }
//    else if([supportname isEqualToString: @"Select Support Asset"] || [supportname isEqualToString:@""] || supportname.length == 0)
//    {
//        [AZNotification showNotificationWithTitle:@"Please select support asset." controller:ROOTVIEW notificationType:AZNotificationTypeError];
//    }
//    else if([trailernm isEqualToString: @"Select Trailer"] || [trailernm isEqualToString:@""] || trailernm.length == 0)
//    {
//        [AZNotification showNotificationWithTitle:@"Please select trailer." controller:ROOTVIEW notificationType:AZNotificationTypeError];
//    }
    else
    {
        [self ScheduleAllAsset:YES];
    }
}
-(void)addnewRow:(NSString *)str andtag :(int)tagval
{
    @try {
        if([str isEqualToString:@"Power Asset"])
        {
            if(arrTotalPower.count < arrPowerlist.count)
            {
                NSLog(@"PowerAsset");
                [arrTotalPower addObject:@"Power2"];
                [_tbldispatchdetail reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            }
            else
            {
                [AZNotification showNotificationWithTitle:@"You do not have more power asset available to add." controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }
        else if([str isEqualToString:@"Driver"])
        {
            NSLog(@"Driver");
            if(arrTotalDriver.count < arrDriverlist.count)
            {
                [arrTotalDriver addObject:@"Driver2"];
                [_tbldispatchdetail reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }
            else
            {
                [AZNotification showNotificationWithTitle:@"You do not have more driver available to add." controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
            
        }
        else if([str isEqualToString:@"Support Asset"])
        {
            NSLog(@"Driver");
            if(arrTotalSupport.count < arrSupportlist.count)
            {
                [arrTotalSupport addObject:@"Support2"];
                [_tbldispatchdetail reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
            }
            else
            {
                [AZNotification showNotificationWithTitle:@"You do not have more support asset available to add." controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
            
        }
        else
        {
            NSLog(@"Driver");
            if(arrTotalTrailers.count < arrTrailerlist.count)
            {
                [arrTotalTrailers addObject:@"Trailer2"];
                [_tbldispatchdetail reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
            }
            else
            {
                [AZNotification showNotificationWithTitle:@"You do not have more trailer available to add." controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }
    } @catch (NSException *exception) {
        
    } 
}
- (IBAction)btnaddmoreassetclicked:(id)sender
{
     listView= [self showListView:listView withSelectiontext:AssetTypePopUp widthval:SCREEN_WIDTH - 100 heightval:300];
    [listView show];
   // return;
    
}
- (IBAction)btncloseclicked:(id)sender
{
    @try {
        UIButton *bnt = (UIButton *)sender;
        int sec = [NSString stringWithFormat:@"%@",bnt.accessibilityLabel].intValue;
        if(sec == 1)
        {
            [arrTotalDriver removeObjectAtIndex:bnt.tag];
            
        }
        else if(sec == 2)
        {
            [arrTotalPower removeObjectAtIndex:bnt.tag];
        }
        else if(sec == 3)
        {
            [arrTotalSupport removeObjectAtIndex:bnt.tag];
        }
        else
        {
            [arrTotalTrailers removeObjectAtIndex:bnt.tag];
        }
        [_tbldispatchdetail reloadData];
    } @catch (NSException *exception) {
        
    } 
    
}
- (IBAction)btndroplistclicked:(id)sender
{
    @try {
        [listView dismiss];
        [overlayview removeFromSuperview];
        UIButton *btn =(UIButton *)sender;
        listView.tag = btn.tag;
        slectedtag = btn.tag;
        NSLog(@"---------->%ld",(long)btn.tag);
        if([btn.accessibilityLabel isEqualToString:@"Trailer"])
        {
            if(arrTrailerlist.count > 0)
            {
                CGFloat height = (40*arrTrailerlist.count) + 120;
                
                if(height  < (SCREEN_HEIGHT - 100))
                {
                    listView= [self showListView:listView withSelectiontext:TrailerPopUp widthval:SCREEN_WIDTH - 80 heightval:height];
                }
                else
                {
                    listView= [self showListView:listView withSelectiontext:TrailerPopUp widthval:SCREEN_WIDTH - 80 heightval:SCREEN_HEIGHT - 100];
                }
                btntapped = false;
            }
            else
            {
                btntapped = true;
                [self getAllTrailers:YES];
            }
        }
        if([btn.accessibilityLabel isEqualToString:@"Support"])
        {
            if(arrSupportlist.count > 0)
            {
                CGFloat height = (40*arrSupportlist.count) + 120;
                if(height  < (SCREEN_HEIGHT - 100))
                {
                    listView= [self showListView:listView withSelectiontext:SupportPopUp widthval:SCREEN_WIDTH - 80 heightval:height];
                }
                else
                {
                    listView= [self showListView:listView withSelectiontext:SupportPopUp widthval:SCREEN_WIDTH - 80 heightval:SCREEN_HEIGHT - 100];
                }
                btntapped = false;
            }
            else
            {
                btntapped = true;
                [self getAllsupportasset:YES];
            }
        }
        if([btn.accessibilityLabel isEqualToString:@"Power"])
        {
            if(arrPowerlist.count > 0)
            {
                CGFloat height = (40*arrPowerlist.count) + 120;
                if(height  < (SCREEN_HEIGHT - 100))
                {
                    listView= [self showListView:listView withSelectiontext:PoweredPopUp widthval:SCREEN_WIDTH - 80 heightval:height];
                }
                else
                {
                    listView= [self showListView:listView withSelectiontext:PoweredPopUp widthval:SCREEN_WIDTH - 80 heightval:SCREEN_HEIGHT - 100];
                }
                btntapped = false;
            }
            else
            {
                btntapped = true;
                [self getAllpowerdasset:YES];
            }
        }
        if([btn.accessibilityLabel isEqualToString:@"Driver"])
        {
            if(arrDriverlist.count > 0)
            {
                CGFloat height = (40*arrDriverlist.count) + 120;
                if(height  < (SCREEN_HEIGHT - 100))
                {
                    listView= [self showListView:listView withSelectiontext:DriverPopUp widthval:SCREEN_WIDTH - 80 heightval:height];
                }
                else
                {
                    listView= [self showListView:listView withSelectiontext:DriverPopUp widthval:SCREEN_WIDTH - 80 heightval:SCREEN_HEIGHT - 100];
                }
                btntapped = false;
            }
            else
            {
                btntapped = true;
                [self getAlldrivers:YES];
            }
            
        }
        [listView show];
    } @catch (NSException *exception) 
    {
        
    } 
  
}

#pragma mark - popup view delegates
-(void)addOverlay
{
    overlayview = [[UIView alloc] initWithFrame:CGRectMake(0,  0,self.view.frame.size.width, SCREEN_HEIGHT)];
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
            [listView dismiss];
        }completion:^(BOOL finished) {
            [overlayview removeFromSuperview];
        }];
    } @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception.description);
    } 
    
}
-(ZSYPopoverListView *)showListView :(ZSYPopoverListView *)listviewname withSelectiontext :(NSString *)selectionm widthval:(CGFloat)w heightval :(CGFloat)h
{
    selectedPopupName=selectionm;
    listviewname.backgroundColor=[UIColor whiteColor];
    listviewname = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0,0, w, h)];
    listviewname.calledFor=selectedPopupName;
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
    [self addOverlay];
    [self.view endEditing:YES];
    return listviewname;
}
-(CGFloat)popoverListView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
    
}
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try {
        
        if([selectedPopupName isEqualToString:DriverPopUp])
        {
            return arrDriverlist.count;
        }
        else if([selectedPopupName isEqualToString:TrailerPopUp])
        {
            return arrTrailerlist.count;
        }
        else if([selectedPopupName isEqualToString:PoweredPopUp])
        {
            return arrPowerlist.count;
        }
        else if([selectedPopupName isEqualToString:AssetTypePopUp])
        {
            return arrChooseType.count;
        }
        else
        {
            return arrSupportlist.count;
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
        if([selectedPopupName isEqualToString:DriverPopUp])
        {
            if([choosendriverindex intValue] == indexPath.row)
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
            Matches *objmatch = [arrDriverlist objectAtIndex:indexPath.row];
            cell.lblListName.text = [NSString stringWithFormat:@"%@ %@",objmatch.firstname,objmatch.lastname];
        }
        else if([selectedPopupName isEqualToString:TrailerPopUp])
        {
            if([choosentrailerindex intValue] == indexPath.row)
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
            Equipments *onje = [arrTrailerlist objectAtIndex:indexPath.row];
            cell.lblListName.text=onje.equiName;
            cell.lblListName.textColor = [UIColor blackColor];
        }
        else if([selectedPopupName isEqualToString:PoweredPopUp])
        {
            if([choosenpowerindex intValue] == indexPath.row)
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
            Equipments *onje = [arrPowerlist objectAtIndex:indexPath.row];
            cell.lblListName.text=onje.equiName;   
           cell.lblListName.textColor = [UIColor blackColor];
        }
        else if([selectedPopupName isEqualToString:AssetTypePopUp])
        {
//            if([choosentype intValue] == indexPath.row)
//            {
//                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
//                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
//                cell.btnCheckbox.layer.borderWidth=0.0f;
//            }
//            else
//            {
//                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
//                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
//                cell.btnCheckbox.layer.borderWidth=1.0f;
//            }
            
           
            cell.lblListName.text=[arrChooseType objectAtIndex:indexPath.row];
        }
        else
        {
            if([choosesupportindex intValue] == indexPath.row)
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
            Equipments *onje = [arrSupportlist objectAtIndex:indexPath.row];
            cell.lblListName.text=onje.equiName;     
            cell.lblListName.textColor = [UIColor blackColor];
        }
        return cell;
    }
    @catch (NSException *exception) {
        
    }
    
}
- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        if([selectedPopupName isEqualToString:DriverPopUp])
        {
            Matches *objdrver = [arrDriverlist objectAtIndex:indexPath.row];
            choosendriverindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            drivernm = [NSString stringWithFormat:@"%@ %@",objdrver.firstname,objdrver.lastname];
           
            driverpic = objdrver.profilePicture;
            driverid = objdrver.driverId;
            
            [self.tbldispatchdetail reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:slectedtag inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        }
        else if([selectedPopupName isEqualToString:TrailerPopUp])
        {
            Equipments *obje = [arrTrailerlist objectAtIndex:indexPath.row];
           
            if([obje.isavailable isEqualToString:@"1"])
             {
                 trailerid = obje.internalBaseClassIdentifier;
                 choosentrailerindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                 trailernm = obje.equiName;
                 if(obje.medialist.count > 0)
                 {
                     Medialist *objmedia = [obje.medialist objectAtIndex:0];
                     trailerpic = objmedia.mediaName;
                 }
                 [self.tbldispatchdetail reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:slectedtag inSection:4]] withRowAnimation:UITableViewRowAnimationNone];
             }
           else
           {
               NSString *loadweight = _selectedLoad.loadWeight;
               NSString *assEmptyWeight = obje.equiEmptyWeight;
               NSString *scheduledLoadWeight = obje.scheduledLoadWeight;
               int combinedweight = assEmptyWeight.intValue + scheduledLoadWeight.intValue;
               if(combinedweight < 80000)
               {
                   int availablespace = 80000 - combinedweight;
                   if(availablespace > loadweight.intValue)
                   {
                       trailerid = obje.internalBaseClassIdentifier;
                       choosentrailerindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                       trailernm = obje.equiName;
                       if(obje.medialist.count > 0)
                       {
                           Medialist *objmedia = [obje.medialist objectAtIndex:0];
                           trailerpic = objmedia.mediaName;
                       }
                       [self.tbldispatchdetail reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:slectedtag inSection:4]] withRowAnimation:UITableViewRowAnimationNone];
                   }
                   else
                   {
                       [AZNotification showNotificationWithTitle:@"This trailer weight is less than your load weight." controller:ROOTVIEW notificationType:AZNotificationTypeError];
                   }
               }
               else
               {
                      [AZNotification showNotificationWithTitle:@"This trailer asset already scheduled." controller:ROOTVIEW notificationType:AZNotificationTypeError];
               }
           }
        }
        else if([selectedPopupName isEqualToString:PoweredPopUp])
        {
            Equipments *obje = [arrPowerlist objectAtIndex:indexPath.row];
            if([obje.isavailable isEqualToString:@"1"])
            {
                choosenpowerindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                powerid = obje.internalBaseClassIdentifier;
                if(obje.medialist.count > 0)
                {
                    Medialist *objmedia = [obje.medialist objectAtIndex:0];
                    powerpic = objmedia.mediaName;
                }
                powernm = obje.equiName;
                [self.tbldispatchdetail reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:slectedtag inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
            }
            else
            {
                if([_selectedLoad.loadId isEqualToString:obje.allocatedLoadId]){
                    choosenpowerindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                    powerid = obje.internalBaseClassIdentifier;
                    powernm = obje.equiName;
                    if(obje.medialist.count > 0)
                    {
                        Medialist *objmedia = [obje.medialist objectAtIndex:0];
                        powerpic = objmedia.mediaName;
                    }
                    [self.tbldispatchdetail reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:slectedtag inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
                }
                else{
                   
                    NSString *loadweight = _selectedLoad.loadWeight;
                    NSString *assEmptyWeight = obje.equiEmptyWeight;
                    NSString *scheduledLoadWeight = obje.scheduledLoadWeight;
                    int combinedweight = assEmptyWeight.intValue + scheduledLoadWeight.intValue;
                    if(combinedweight < 80000)
                    {
                        int availablespace = 80000 - combinedweight;
                        if(availablespace > loadweight.intValue)
                        {
                            powerid = obje.internalBaseClassIdentifier;
                            powernm = obje.equiName;
                            choosenpowerindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                       //     trailernm = obje.equiName;  changed as client added bug for this in trello 
                            
                            //
                            
                            if(obje.medialist.count > 0)
                            {
                                Medialist *objmedia = [obje.medialist objectAtIndex:0];
                                powerpic = objmedia.mediaName;
                            }
                            [self.tbldispatchdetail reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:slectedtag inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
                        }
                        else
                        {
                            [AZNotification showNotificationWithTitle:@"This power asset weight is less than your load weight." controller:ROOTVIEW notificationType:AZNotificationTypeError];
                        }
                    }
                    else
                    {
                        [AZNotification showNotificationWithTitle:@"This power asset already scheduled." controller:ROOTVIEW notificationType:AZNotificationTypeError];
                    }
                }
                    
                }
           
        }
        else if([selectedPopupName isEqualToString:AssetTypePopUp])
        {
            choosentype=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            if(indexPath.row == 0)
            {
                [self addnewRow:[arrChooseType objectAtIndex:indexPath.row] andtag:3];
            }
            else if(indexPath.row == 1)
            {
                [self addnewRow:[arrChooseType objectAtIndex:indexPath.row]andtag:4];
            }
            else if( indexPath.row == 2)
            {
                [self addnewRow:[arrChooseType objectAtIndex:indexPath.row]andtag:5];
            }
            else
            {
                [self addnewRow:[arrChooseType objectAtIndex:indexPath.row]andtag:0];
            }
            
        }
        else
        {
            Equipments *obje = [arrSupportlist objectAtIndex:indexPath.row];
            if([obje.isavailable isEqualToString:@"1"])
            {
                choosesupportindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                supportid = obje.internalBaseClassIdentifier;
              
                if(obje.medialist.count > 0)
                {
                    Medialist *objmedia = [obje.medialist objectAtIndex:0];
                    supportpic = objmedia.mediaName;
                }
                
                supportname = obje.equiName;
                [self.tbldispatchdetail reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:slectedtag inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
            }
            else
            {
                NSString *loadweight = _selectedLoad.loadWeight;
                NSString *assEmptyWeight = obje.equiEmptyWeight;
                NSString *scheduledLoadWeight = obje.scheduledLoadWeight;
                int combinedweight = assEmptyWeight.intValue + scheduledLoadWeight.intValue;
                if(combinedweight < 80000)
                {
                    int availablespace = 80000 - combinedweight;
                    if(availablespace > loadweight.intValue)
                    {
                        trailerid = obje.internalBaseClassIdentifier;
                        choosentrailerindex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                        trailernm = obje.equiName;
                        if(obje.medialist.count > 0)
                        {
                            Medialist *objmedia = [obje.medialist objectAtIndex:0];
                            trailerpic = objmedia.mediaName;
                        }
                        [self.tbldispatchdetail reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:slectedtag inSection:4]] withRowAnimation:UITableViewRowAnimationNone];
                    }
                    else
                    {
                        [AZNotification showNotificationWithTitle:@"This support asset weight is less than your load weight." controller:ROOTVIEW notificationType:AZNotificationTypeError];
                    }
                }
                else
                {
                    [AZNotification showNotificationWithTitle:@"This support asset already scheduled." controller:ROOTVIEW notificationType:AZNotificationTypeError];
                }
            }
            
        }
        
        [listView dismiss];
        [overlayview removeFromSuperview];   
    } @catch (NSException *exception) {
        
    }
}
@end
