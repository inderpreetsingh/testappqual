//
//  DispatchListVC.m
//  Lodr
//
//  Created by c196 on 28/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "DispatchListVC.h"
#import "Loads.h"
#import "DispatchDetailVC.h"
#define constLimit 10
@interface DispatchListVC ()
{
    int limit1,limit2,totalRecords;
    NSMutableArray *arrDispatchList;
}
@end

@implementation DispatchListVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
    limit1=0;
    limit2=constLimit;
    arrDispatchList = [NSMutableArray new];
    NavigationBarHidden(YES);
    self.tbldispatchlist.delegate = self;
    self.tbldispatchlist.dataSource = self;
    self.tbldispatchlist.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self getlinkedLoads:YES];
    [_btnBack setHidden:TRUE];
    
    if([_strRedirectFrom isEqualToString:@"HOME"])
    {
        [_btnBack setHidden:false];
    }
    
    //if([_strRedirectFrom isEqualToString:@"HOME"])
    //{
    //    [self.btnSettings setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
    //}
    //else
    //{
    //    [self.btnSettings setImage:imgNamed(@"") forState:UIControlStateNormal];
    //}
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (IBAction)btndrawerclicked:(id)sender 
{
    [self.view endEditing:YES];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrDispatchList.count;
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
        
        Loads *objload=[arrDispatchList objectAtIndex:section];
        [header.vwTruckList removeFromSuperview];
        header.vwMainView.hidden=NO;
        header.vwMainView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        header.vwMainView.layer.borderWidth=0.5f;
        header.vwTruckList.hidden=YES;
        header.cellCalenderHeaderDelegate=self;
        header.lblResourceName.text=[NSString stringWithFormat:@"%@-%@",objload.pickupStateCode,objload.deliveryStateCode];
        header.lblResouceSubdetailName.text=objload.distance;
        header.lblDate1.text=[GlobalFunction stringDate:objload.pickupDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
        header.lblDate2.text=[GlobalFunction stringDate:objload.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
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
    return  0;
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
//    DispatchDetailVC *objwebvc=initVCToRedirect(SBDISPATCHUI, DISPATCHDETAILVC);
//    [self.navigationController pushViewController:objwebvc animated:YES];
}

#pragma mark - websservice handling
- (void)getlinkedLoads:(BOOL)showloader
{
    NSDictionary *dicAllEqui=@{
                               Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                               Req_FromIndex:[NSString stringWithFormat:@"%d",limit1],
                               Req_ToIndex:[NSString stringWithFormat:@"%d",limit2],
                               Req_OrderType:@"2"
                               //Req_User_Id:@"2"
                               };   
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc] init:URLGetAllLinkedLoadData
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getLoadResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching linked loads"
         showProgress:showloader];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

-(IBAction)getLoadResponse:(id)sender
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
            if ([sender responseArray].count > 0)
            {
                for (Loads *objd in [sender responseArray])
                {
                    [arrDispatchList addObject:objd];
                }
                
                totalRecords = [APITotalRecord intValue];
                limit1 = limit1+limit2;
                limit2 = constLimit;
                [self.tbldispatchlist reloadData];
                self.tbldispatchlist.backgroundView = nil;
                if (limit1 < totalRecords)
                {
                    [self getlinkedLoads:NO];
                }
            }
            else
            {
                self.tbldispatchlist.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
                [self.tbldispatchlist setBlankPlaceHolderWithString:NoLoadFound];
            }
        }   
        else
        {
            self.tbldispatchlist.backgroundView=nil;
            self.tbldispatchlist.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            [self.tbldispatchlist setBlankPlaceHolderWithString:APIResponseMessage];
        }
    }
}
#pragma mark :- cell header delegate


- (IBAction)btnGotoDetailClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    DispatchDetailVC *objLoadDetail=initVCToRedirect(SBDISPATCHUI, DISPATCHDETAILVC);
    Loads *obj=[arrDispatchList objectAtIndex:btn.tag];
    objLoadDetail.selectedLoad=obj;
    [self.navigationController pushViewController:objLoadDetail animated:YES];
}
- (IBAction)btnSectionTapped:(id)sender
{
    
}
- (IBAction)btnTrcukDetailClicked:(id)sender
{
    
}
- (IBAction)btnSectionOpenClicked:(id)sender
{
    
}
- (IBAction)btnBackClicked:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}
@end
