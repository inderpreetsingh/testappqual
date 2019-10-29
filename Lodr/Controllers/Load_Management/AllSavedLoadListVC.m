//
//  AllSavedLoadListVC.m
//  Lodr
//
//  Created by Payal Umraliya on 14/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "AllSavedLoadListVC.h"
#import "Loads.h"
#import "UITableView+Placeholder.h"
#import "LoadDetailVC.h"
#define constLimit 10
@interface AllSavedLoadListVC ()
{
    NSArray *nib;
    NSMutableArray *arrAllSavedLoads;
    int webcallcount,limit1,limit2,totalRecords;
    NSIndexPath *indexpathAtOpenedRow;
    NSInteger selectedSection;
    BOOL distancesort,pickupsort,delieverysort,statussort,ratesort;
}
@end

@implementation AllSavedLoadListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    NavigationBarHidden(YES);
//    self.mTableView = [[TQMultistageTableView alloc] initWithFrame:rect];
//    UINib *nibcell = [UINib nibWithNibName:@"CellMatchesContainer" bundle:nil];
//    [self.mTableView.tableView registerNib:nibcell forCellReuseIdentifier:@"CellMatchesContainer"];
//    self.mTableView.dataSource = self;
//    self.mTableView.delegate   = self;
//    self.mTableView.redirectFrom=@"ALL_LOADS";
//    self.mTableView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.mTableView];
    
    if(AppInstance.arrAllSavedLoadByUserId.count == 0)
    {
        [self getAllSavedLoadDetail:YES];
    }
    else
    {
        arrAllSavedLoads=AppInstance.arrAllSavedLoadByUserId;
        if(arrAllSavedLoads.count != [AppInstance.countSavedLodByUid intValue])
        {
            limit1=(int)arrAllSavedLoads.count;
            limit2=constLimit;
            totalRecords=[AppInstance.countSavedLodByUid intValue];
            if(limit1<totalRecords)
            {
                [self performSelectorInBackground:@selector(callLoadMoreData_SavedLoads)  withObject:nil];
            }
            else
            {
                self.mTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }
        else
        {
            [self getAllSavedLoadDetail:NO];
        }
    }
}
-(void)viewDidAppear:(BOOL)animated
{
   arrAllSavedLoads=AppInstance.arrAllSavedLoadByUserId;
 //   [_mTableView.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view delegate SK

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return 1;
//
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrAllSavedLoads.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //static NSString *HeaderIdentifier = @"ResourceContainerView";
    SavedLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellSavedLoads"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Loads *loads=[arrAllSavedLoads objectAtIndex:indexPath.row];
   // header.resourceContainerViewDelegate=self;
    cell.lblDistance.text=[NSString stringWithFormat:@"%@-%@",loads.pickupStateCode,loads.deliveryStateCode];
    //cell.btnLoadDetail.userInteractionEnabled=NO;
    if([loads.isBestoffer isEqualToString:@"1"])
    {
        cell.lblRate.text=[NSString stringWithFormat:@"Best Offer"];
        [cell.lblRate setFont:[UIFont fontWithName:@"Arial" size:12]];
    }
    else
    {
        cell.lblRate.text=[NSString stringWithFormat:@"$%@",loads.offerRate];
        [cell.lblRate setFont:[UIFont fontWithName:@"Arial" size:14]];
    }
    
    cell.lblMiles.text=loads.distance;
    if([loads.isPublish isEqualToString:@"1"])
    {
        cell.lblStatusText.text=ListPublishedButtonText;
        cell.lblStatusText.textColor=ListPublishedButtonColor;
    }
    else
    {
        cell.lblStatusText.text=ListSavedButtonText;
        cell.lblStatusText.textColor=ListSavedButtonColor;
    }
    cell.lblFromDate.text=[GlobalFunction stringDate:loads.pickupDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
    cell.lblToDate.text=[GlobalFunction stringDate:loads.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
    cell.lblFromTime.text=loads.pickupTime;
    cell.lblToTime.text=loads.deliveryTime;
    
    return cell;
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    Loads *loads=[arrAllSavedLoads objectAtIndex:indexPath.row];
    LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
    objLoadDetail.strRedirectFrom=@"SAVEDLOADLIST";
    objLoadDetail.cmpnyphno=@"";
    objLoadDetail.myphono=@"";
    objLoadDetail.officephno=@"";
    objLoadDetail.selectedLoad=loads;
    [self.navigationController pushViewController:objLoadDetail animated:YES];
}
    


//- (ResourceContainerView *)createCellforSavedLoads:(ResourceContainerView *)cell forTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
//
//    static NSString *HeaderIdentifier = @"ResourceContainerView";
//    if (!cell)
//    {
//
//        [tableView registerNib:[UINib nibWithNibName:@"ResourceContainerView" bundle:nil] forCellReuseIdentifier:HeaderIdentifier];
//
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ResourceContainerView" owner:self options:nil];
//
//        return [nib objectAtIndex:0];
////        cell = [self registerCell:cell inTableView:tableView forClassName:NSStringFromClass([ResourceContainerView class]) identifier:HeaderIdentifier];
//    }
//
//    return cell;
//
//}
/*
#pragma mark - Table view delegate
- (NSInteger)numberOfSectionsInTableView:(TQMultistageTableView *)mTableView
{
    return arrAllSavedLoads.count;
}
- (NSInteger)mTableView:(TQMultistageTableView *)mTableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForHeaderInSection:(NSInteger)section
{
    if(section > 0)
    {
        return 70;
    }
    else
    {
        return 100;
    }
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0; 
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForAtomAtIndexPath:(NSIndexPath *)indexPath
{
    return 1000;
}
- (UITableViewHeaderFooterView *)mTableView:(TQMultistageTableView *)mTableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderIdentifier = @"ResourceContainerView";
    ResourceContainerView *header = [mTableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if(!header) {
        header = [[ResourceContainerView alloc] initWithReuseIdentifier:HeaderIdentifier];
        header.backgroundView = [[UIView alloc] init];   
    }
    if(section > 0)
    {
        header.vwheaderhight.constant=0;
    }
    else
    {
        header.vwheaderhight.constant=30;
    }
    [self.view layoutIfNeeded];
    
    Loads *loads=[arrAllSavedLoads objectAtIndex:section]; 
    header.resourceContainerViewDelegate=self;
    header.lblReourceName.text=[NSString stringWithFormat:@"%@-%@",loads.pickupStateCode,loads.deliveryStateCode];
    header.btnLoadDetail.userInteractionEnabled=NO;
    if([loads.isBestoffer isEqualToString:@"1"])
    {
         header.lblRate.text=[NSString stringWithFormat:@"Best Offer"];
        [header.lblRate setFont:[UIFont fontWithName:@"Arial" size:12]];
    }
    else
    {
         header.lblRate.text=[NSString stringWithFormat:@"$%@",loads.offerRate];
        [header.lblRate setFont:[UIFont fontWithName:@"Arial" size:14]];
    }
   
    header.lblMiles.text=loads.distance;
    if([loads.isPublish isEqualToString:@"1"])
    {
        header.lblStatusText.text=ListPublishedButtonText;
        header.lblStatusText.textColor=ListPublishedButtonColor;
    }
    else
    {
        header.lblStatusText.text=ListSavedButtonText;
        header.lblStatusText.textColor=ListSavedButtonColor;
    }
    header.lblFromDate.text=[GlobalFunction stringDate:loads.pickupDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
    header.lblToDate.text=[GlobalFunction stringDate:loads.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
    header.lblFromTime.text=loads.pickupTime;
    header.lblToTime.text=loads.deliveryTime;
    header.vwStatus.hidden=YES;
    return header;
}
- (UITableViewCell *)mTableView:(TQMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    return cell;
}
- (void)mTableView:(TQMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark - Header Open Or Close
- (void)tableViewHeaderTouchUpInside:(UITapGestureRecognizer *)gesture
{
    NSInteger section = gesture.view.tag;
    Loads *loads=[arrAllSavedLoads objectAtIndex:section]; 
    LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
    objLoadDetail.strRedirectFrom=@"SAVEDLOADLIST";
    objLoadDetail.cmpnyphno=@"";
    objLoadDetail.myphono=@"";
    objLoadDetail.officephno=@"";
    objLoadDetail.selectedLoad=loads;
    [self.navigationController pushViewController:objLoadDetail animated:YES];
}
- (void)mTableView:(TQMultistageTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section
{
    selectedSection=section;
}

- (void)mTableView:(TQMultistageTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section
{
}
*/
#pragma mark - Row Open Or Close

//- (void)mTableView:(TQMultistageTableView *)mTableView willOpenRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    indexpathAtOpenedRow=indexPath;
//}
//
//- (void)mTableView:(TQMultistageTableView *)mTableView willCloseRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}
//-(void)mscrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//}
#pragma mark header view delegate

- (void)btnLoadDetailClicked:(id)sender
{
}
- (void)btnDistanceSortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:distancesort]];
    arrAllSavedLoads= [[arrAllSavedLoads sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    distancesort=!distancesort;
    [_mTableView reloadData];
}
- (void)btnPickupSortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"pickupDate" ascending:pickupsort]];
    arrAllSavedLoads= [[arrAllSavedLoads sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    pickupsort=!pickupsort;
    [_mTableView reloadData];
}
- (void)btnDelievrySortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"delieveryDate" ascending:delieverysort]];
    arrAllSavedLoads= [[arrAllSavedLoads sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    delieverysort=!delieverysort;
    [_mTableView reloadData];
}
- (void)btnRateSortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"offerRate" ascending:ratesort]];
    arrAllSavedLoads= [[arrAllSavedLoads sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    ratesort=!ratesort;
    [_mTableView reloadData];
}
- (void)btnStatusSortClicked:(id)sender
{
    NSArray *sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"matches.@count" ascending:statussort]];
    arrAllSavedLoads= [[arrAllSavedLoads sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    statussort=!statussort;
    [_mTableView reloadData];
}
#pragma mark - Webservice handling
-(void)callLoadMoreData_SavedLoads
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
         init:URLFetchAllLoadByUserId
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getdicAllSavedLoadsResponseLoadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Loads"
         showProgress:NO];
    }
    else
    {
//        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getdicAllSavedLoadsResponseLoadmore:(id)sender
{
    
    //[self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            
            for (Loads *loads in [sender responseArray])
            {
                [arrAllSavedLoads addObject:loads];
            }
            AppInstance.arrAllSavedLoadByUserId=arrAllSavedLoads;
            [_mTableView reloadData];
            limit1=limit1+limit2;
            limit2=constLimit;
            if(limit1<totalRecords)
            {
                [self performSelectorInBackground:@selector(callLoadMoreData_SavedLoads)  withObject:nil];
            }
            else
            {
                self.mTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(void)getAllSavedLoadDetail:(BOOL)showloader
{
    limit1=0;
    limit2=constLimit;
    if(showloader)
    {
        [_mTableView setLoaderWithString:@"Fetching Loads"];
    }
    else
    {
        self.mTableView.backgroundView=nil;
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
         init:URLFetchAllLoadByUserId
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getdicAllSavedLoadsResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Loads"
         showProgress:NO];
    }
    else
    {
       // [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getdicAllSavedLoadsResponse:(id)sender
{
   // [self dismissHUD];
    ShowNetworkIndicator(NO);
    if ([sender serviceResponseCode] != 100)
    {
        if([sender serviceResponseCode] ==  -1005 || [sender serviceResponseCode] ==  -1001)
        {
            if(webcallcount !=2)
            {
                [self getAllSavedLoadDetail:YES];
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
            arrAllSavedLoads=[NSMutableArray new];
            for (Loads *loads in [sender responseArray])
            {
                [arrAllSavedLoads addObject:loads];
            }
            totalRecords=[APITotalLoad intValue];
            AppInstance.countSavedLodByUid=APITotalLoad;
            AppInstance.arrAllSavedLoadByUserId=arrAllSavedLoads;
            [self.mTableView reloadData];
            limit1=limit1+limit2;
            limit2=constLimit;
            if(arrAllSavedLoads.count == 0)
            {
                [self.mTableView setBlankPlaceHolderWithString:NoLoadFound];
                self.mTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
            else
            {
                self.mTableView.backgroundView=nil;
                if(limit1<totalRecords)
                {
                    [self performSelectorInBackground:@selector(callLoadMoreData_SavedLoads)  withObject:nil];
                }
                else
                {
                    self.mTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
                }
            } }
        else
        {
            AppInstance.countSavedLodByUid=@"0";
            AppInstance.arrAllSavedLoadByUserId=nil;
            arrAllSavedLoads=AppInstance.arrAllSavedLoadByUserId;
            [self.mTableView reloadData];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
            [self.mTableView setBlankPlaceHolderWithString:APIResponseMessage];
            self.mTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        }
    }
}

#pragma mark click events

- (IBAction)btnSavedLoadbackClicked:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnsavedloaddrawerClicked:(id)sender
{
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
- (IBAction)buttonSortDistanceAction:(UIButton *)sender {
    
    [self btnDelievrySortClicked:sender];
    
}
- (IBAction)buttonSortStatusAction:(UIButton *)sender {

    [self btnStatusSortClicked:sender];
}

- (IBAction)buttonSortRateAction:(UIButton *)sender {
    
    [self btnRateSortClicked:sender];
}

- (IBAction)buttonSortPickupAction:(UIButton *)sender {
    
        [self btnPickupSortClicked:sender];
}

- (IBAction)buttonSortDeliveryAction:(UIButton *)sender {
    [self btnDelievrySortClicked:sender];
}
@end
