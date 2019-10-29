//
//  DriverLoadListVC.m
//  Lodr
//
//  Created by c196 on 05/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "DriverLoadListVC.h"
#import "Loads.h"
#import "LoadDetailVC.h"
#import "UITableView+Placeholder.h"
#import "Matches.h"
#define constLimit 10
@interface DriverLoadListVC ()
{
    NSMutableArray *arrdriverloadlist;
    NSString *updatestatus;
    int limit1,limit2,totalRecords;
    
    BOOL distancesort;
}
@end

@implementation DriverLoadListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationBarHidden(YES);
    
    NSArray *arr=[NSArray arrayWithObjects:_btnpickup,_btnstatys,_btnDistance,_btndelievery, nil];
    for (UIButton *btn in arr) 
    {
        btn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        btn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        btn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    }
    self.vwTableheader.hidden=YES;
    [self.tblDriversLoad registerNib:[UINib nibWithNibName:@"CellCalenderHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"CellCalenderHeader"];
    [self getDriverLoads];
}
#pragma mark - Table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrdriverloadlist.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    @try
    {
        CellCalenderHeader *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CellCalenderHeader"];
        if(header==nil)
        {
            NSArray *nibhead= [[NSBundle mainBundle] loadNibNamed:@"CellCalenderHeader" owner:self options:nil];
            header = (CellCalenderHeader *)[nibhead objectAtIndex:0];
        }
        
        Loads *objload=[arrdriverloadlist objectAtIndex:section];
        [header.vwTruckList removeFromSuperview];
        header.vwMainView.hidden=NO;
        header.vwMainView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        header.vwMainView.layer.borderWidth=0.5f;
        header.vwTruckList.hidden=YES;
        header.cellCalenderHeaderDelegate=self;
        header.lblResourceName.text=[NSString stringWithFormat:@"%@-%@",objload.pickupStateCode,objload.deliveryStateCode];
        header.lblResouceSubdetailName.text=objload.loadName;//objload.distance;
        header.lblDate1.text=[GlobalFunction stringDate:objload.pickupDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
        header.lblDate2.text=[GlobalFunction  stringDate:objload.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
        header.lblTime1.text=objload.pickupTime;
        header.lblTime2.text=objload.deliveryTime;
        header.btnRedirectToDetail.tag=section;
        header.btnSection.tag=section;
        switch ([objload.loadStatus intValue])
        {
            case 0:
            {
                header.lblAmountName.text=@"SCHEDULED";
                header.lblAmountName.textColor=ScheduledLoadButtonColor;
            }
                break;
            case 1:
            {
                header.lblAmountName.text=@"PICKUP";
                header.lblAmountName.textColor=GreenButtonColor;
            }
                break;
            case 2:
            {
                header.lblAmountName.text=@"ON TIME";
                header.lblAmountName.textColor=GreenButtonColor;
            }
                break;
            case 3:
            {
                header.lblAmountName.text=@"DELAYED";
                header.lblAmountName.textColor=CancelLoadButtonColor;
            }
                break;
            case 4:
            {
                header.lblAmountName.text=@"DELIVERED";
                header.lblAmountName.textColor=GreenButtonColor;
            }
                break;
            case 5:
            {
                header.lblAmountName.text=@"SCHEDULED";
                header.lblAmountName.textColor=ScheduledLoadButtonColor;
            }
                break;
            default:
                break;
        }
        return header;
    } @catch (NSException *exception) {
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - cell header delegate
- (IBAction)btnGotoDetailClicked:(id)sender 
{
    UIButton *btn=(UIButton *)sender;
    Loads *obj=[arrdriverloadlist objectAtIndex:btn.tag];
    Matches *objmatch=[obj.matches objectAtIndex:0];
    DriverLoadDetailsVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYDRIVERLOADDETAILS);
    objLoadDetail.strRedirectFrom=@"DRIVERLIST";
    objLoadDetail.myphono=objmatch.phoneNo;
    objLoadDetail.cmpnyphno=objmatch.cmpnyPhoneNo;
    objLoadDetail.officephno=objmatch.officePhoneNo;
    objLoadDetail.selectedLoad=obj;
    objLoadDetail.equipmentid=obj.equiId;
    objLoadDetail.loadDetailVCProtocol=self;
    objLoadDetail.loadStatus = @"2";  //SK Changes for client requirement

    [self.navigationController pushViewController:objLoadDetail animated:YES];
}
- (IBAction)btnSectionTapped:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    Loads *obj=[arrdriverloadlist objectAtIndex:btn.tag];
    Matches *objmatch=[obj.matches objectAtIndex:0];
    DriverLoadDetailsVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYDRIVERLOADDETAILS);
    objLoadDetail.myphono=objmatch.phoneNo;
    objLoadDetail.cmpnyphno=objmatch.cmpnyPhoneNo;
    objLoadDetail.officephno=objmatch.officePhoneNo;
    objLoadDetail.strRedirectFrom=@"DRIVERLIST";
    objLoadDetail.selectedLoad=obj;
    objLoadDetail.loadDetailVCProtocol=self;
    objLoadDetail.loadStatus = @"2";   //SK Changes for client requirement
    [self.navigationController pushViewController:objLoadDetail animated:YES];
}

#pragma mark - clicke events
- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnDrawerClicked:(id)sender
{
    [self.view endEditing:YES];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (IBAction)btnDistanceSortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:distancesort]];
    arrdriverloadlist = [[arrdriverloadlist sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    distancesort = !distancesort;
    [_tblDriversLoad reloadData];
}

- (IBAction)btnPickupSortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"pickupDate" ascending:distancesort]];
    arrdriverloadlist = [[arrdriverloadlist sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    distancesort = !distancesort;
    [_tblDriversLoad reloadData];
}

- (IBAction)btnDelieverySortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"delieveryDate" ascending:distancesort]];
    arrdriverloadlist = [[arrdriverloadlist sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    distancesort = !distancesort;
    [_tblDriversLoad reloadData];
}

- (IBAction)btnStatusSortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"matches.@count" ascending:distancesort]];
    arrdriverloadlist = [[arrdriverloadlist sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    distancesort = !distancesort;
    [_tblDriversLoad reloadData];
}

#pragma mark - websservice handling
-(void)getDriverLoads
{
    limit1=0;
    limit2=constLimit;
    [_tblDriversLoad setLoaderWithStringAccordingframe:@"Fetching Driver's assigned loads" :self.view.frame];
    NSDictionary *dicAllEqui=@{
                               Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                               Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                               Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                               Req_FromIndex:[NSString stringWithFormat:@"%d",limit1],
                               Req_ToIndex:[NSString stringWithFormat:@"%d",limit2]
                               };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetDriverAssignedLoads
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getDriverLoadResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Driver's assigned loads"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getDriverLoadResponse:(id)sender
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
                arrdriverloadlist=[NSMutableArray new];
                for(Loads *objd in [sender responseArray])
                {
                    [arrdriverloadlist addObject:objd];
                }
                totalRecords=[APITotalRecord intValue];
                limit1=limit1+limit2;
                limit2=constLimit;
                  self.vwTableheader.hidden=NO;
                [self.tblDriversLoad reloadData];
                self.tblDriversLoad.backgroundView=nil;
            }
            else
            {
                [self.tblDriversLoad setBlankPlaceHolderWithString:NoLoadFound];
                self.heightHeader.constant=0;
                self.tblDriversLoad.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }   
        else
        {
            self.tblDriversLoad.backgroundView=nil;
            self.heightHeader.constant=0;
            [self.tblDriversLoad setBlankPlaceHolderWithString:NoLoadFound];
            self.tblDriversLoad.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
-(void)getDriverLoads_loadmore
{
    NSDictionary *dicAllEqui=@{
                               Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                               Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                               Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                               Req_FromIndex:[NSString stringWithFormat:@"%d",limit1],
                               Req_ToIndex:[NSString stringWithFormat:@"%d",limit2]
                               };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetDriverAssignedLoads
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getDriverLoadResponse_loadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Driver's assigned loads"
         showProgress:NO];
    }
    else
    {
        self.tblDriversLoad.backgroundView=nil;
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        self.tblDriversLoad.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    }
}
-(IBAction)getDriverLoadResponse_loadmore:(id)sender
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
                for(Loads *objd in [sender responseArray])
                {
                    [arrdriverloadlist addObject:objd];
                }
                limit1=limit1+limit2;
                limit2=constLimit;
                self.vwTableheader.hidden=NO;
                [self.tblDriversLoad reloadData];
                if(limit1<totalRecords)
                {
                    [self performSelectorInBackground:@selector(getDriverLoads_loadmore)  withObject:nil];
                }
                else
                {
                    self.tblDriversLoad.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
                }  
                  self.tblDriversLoad.backgroundView=nil;
            }
        }   
        else
        {
            self.tblDriversLoad.backgroundView=nil;
            self.tblDriversLoad.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
-(void)sendDataToLDriveroadListvc:(NSArray *)str
{
    [arrdriverloadlist enumerateObjectsUsingBlock:^(Loads *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.internalBaseClassIdentifier ==[str objectAtIndex:0] )
        {
            obj.loadStatus=[str objectAtIndex:1];
            [arrdriverloadlist replaceObjectAtIndex:idx withObject:obj];
        }
    }];
    [self.tblDriversLoad reloadData];
}
@end
