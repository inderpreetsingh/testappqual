//
//  MyEquipmentList.m
//  Lodr
//
//  Created by Payal Umraliya on 04/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//
#import "MyEquipmentList.h"
#import "CoreDataAdaptor.h"
#import "GlobalFunction.h"
#import "UITableView+Placeholder.h"
#import "Equipments.h"
#import "Matches.h"
#import "WebServiceResponse.h"
#import "FBAnnotation.h"
#import "LoadDetailVC.h"
#import "EquipmentDetailVC.h"
#import "CustomAnnotClass.h"
#import "SubAssetDetailsVC.h"
#define constLimit 10
#define kNUMBER_OF_LOCATIONS 1000
#define kFIRST_LOCATIONS_TO_REMOVE 50
@interface MyEquipmentList ()
{
    NSArray *nib;
    NSMutableArray *arrAllEquipments,*arrAllMatches,*arrAddAnnotation,*arrtrueDeepCopyEqui,*arrSupportList,*arrPowerlist,*arrTrailerList,*arrayForBool,*arrAddAnnotation1,*arrAddAnnotation2,*arrayForBool2;
    int webcallcount,limit1,limit2,totalRecords,selectedSection,indexpathrow;
    BOOL distancesort,subratesort,ratesort,statsussort,maporlistselection;
    CLLocationCoordinate2D coordinate;
    NSInteger selectedAnnotation;
    NSDate *today; 
}
@end

@implementation MyEquipmentList
- (void)viewDidLoad 
{
    [super viewDidLoad];
    maporlistselection=true;
    NavigationBarHidden(YES);
     today = [GlobalFunction dateString:[NSString stringWithFormat:@"%@ ",[NSDate date]] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"yyyy-MM-dd HH:mm:ss"]; 
    UINib *nibcell = [UINib nibWithNibName:@"CellMatchedLoadListForEquipment" bundle:nil];
    [self.tblList registerNib:nibcell forCellReuseIdentifier:@"CellMatchedLoadListForEquipment"];
    [self.tblList2 registerNib:nibcell forCellReuseIdentifier:@"CellMatchedLoadListForEquipment"];
    [self.tblList3 registerNib:nibcell forCellReuseIdentifier:@"CellMatchedLoadListForEquipment"];
    _heightmapdetails.constant=0;
    if([_strRedirectFrom isEqualToString:@"HOME"])
    {
        [self.btnSettings setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
    }
    else
    {
        [self.btnSettings setImage:imgNamed(@"") forState:UIControlStateNormal];
    }
    self.btnLoadmore.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.btnLoadmore.layer.borderWidth=0.5f;
    self.vwMaptruck.hidden=YES;
    self.numberOfLocations =0;
    self.clusteringManager.delegate = self;
    [self.view bringSubviewToFront:_vwMaptruck];
    _maptruckView.showsUserLocation=true;
    _vwMaptruck.frame=CGRectMake(self.vwMaptruck.frame.origin.x, self.vwMaptruck.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    [self.vwMaptruck layoutIfNeeded];
    
    UITapGestureRecognizer *mapviewtgr = [[UITapGestureRecognizer alloc] 
                  initWithTarget:self action:@selector(handleMapviewTapGesture:)];
    mapviewtgr.numberOfTapsRequired = 1;
    mapviewtgr.numberOfTouchesRequired = 1;
    [_maptruckView addGestureRecognizer:mapviewtgr];
    
    self.heightList1.constant=420;
    self.heightList2.constant=420;
    self.heightList3.constant=420;
    self.tblList2.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.tblList3.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.tblList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [_scrollData setContentSize:(CGSizeMake(CGRectGetWidth(_scrollData.frame),self.heightList1.constant+ self.heightList2.constant +self.heightList3.constant))];
    [self.view layoutIfNeeded];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedRefreshAssetList object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAssets) name:NCNamedRefreshAssetList object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedRefreshAssetList object:nil];
}
- (void)handleMapviewTapGesture:(UIGestureRecognizer *)gestureRecognizer
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
     {  
         _heightmapdetails.constant=0;
     }
  completion:^(BOOL finished)
     { 
         [_vwmapdetails layoutIfNeeded];
     }];
}
-(void)refreshAssets
{
    [self getAllEquiDetail:YES];
//    [self.tblList reloadData];
//    [self.tblList2 reloadData];
//    [self.tblList3 reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if(AppInstance.arrAllEquipmentByUserId.count == 0)
    {
        self.tblList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    }
    if(AppInstance.arrAllEquipmentByUserId.count == 0)
    {
        [self getAllEquiDetail:YES];
    }
    else
    {
        arrAllEquipments=AppInstance.arrAllEquipmentByUserId;
        if(arrAllEquipments.count != [AppInstance.countEquiByUid intValue])
        {
            limit1=(int)arrAllEquipments.count;
            limit2=constLimit;
            totalRecords=[AppInstance.countEquiByUid intValue];
            if(limit1<totalRecords)
            {
                [self performSelectorInBackground:@selector(callLoadMoreData)  withObject:nil];
            }
            else
            {
                self.tblList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }
        else
        {
            [self getAllEquiDetail:NO];
        }
    }
}
-(void)extractLinked
{
    @try {
        if(arrAllEquipments.count >0)
        {
            for(Equipments *obj in [arrAllEquipments copy])
            {
                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"matchOrderStatus == '2'"];
                NSArray *filterArray=[obj.matches filteredArrayUsingPredicate:bPredicate];
                if(filterArray.count >0)
                {
                    obj.matches = filterArray;
                    [arrAllEquipments enumerateObjectsUsingBlock:^(Equipments *objmatch, NSUInteger idx, BOOL * _Nonnull stop) 
                     {
                         if([objmatch.internalBaseClassIdentifier isEqualToString:obj.internalBaseClassIdentifier])
                         {
                             [arrAllEquipments replaceObjectAtIndex:idx withObject:obj];
                         }   
                     }];
                } 
            }
            [self.tblList reloadData];
        }
    } @catch (NSException *exception) {
        
    } 

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)showAlertForRetry:(NSString *)str
{
    NSString *msg=[NSString stringWithFormat:@"%@",str];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
                                [self getAllEquiDetail:YES];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}   
-(void)getAllEquiDetail:(BOOL)showloader
{
    limit1=0;
    limit2=constLimit;
//    if(showloader)
//    {
//        [self.tblList setLoaderWithString:@"Fetching Equipments"];
//    }
//    else
//    {
//        self.tblList.backgroundView=nil;
//    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_FromIndex:[NSString stringWithFormat:@"%d",limit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",limit2],
                                Req_Radius:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedRadius]
                                             };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllEquipmentByUserId
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getdicAllEquiResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Equipments"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

#pragma mark - Webservice Respons handling

-(IBAction)getdicAllEquiResponse:(id)sender
{
     ShowNetworkIndicator(NO);
    [self dismissHUD];
      [self.tblList reloadData];
    if ([sender serviceResponseCode] != 100)
    {
        [self showAlertForRetry:[sender responseError]];
          [self.tblList reloadData];
//        if([sender serviceResponseCode] ==  -1005 || [sender serviceResponseCode] ==  -1001)
//        {
//            if(webcallcount !=2)
//            {
//                [self getAllEquiDetail:YES];
//                webcallcount=webcallcount+1;
//            }
//        }
//        else
//        {
//            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
//             self.tblList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
//        }    
    }
    else
    {
        arrAllEquipments=[NSMutableArray new];
        arrAllMatches=[NSMutableArray new];
        arrtrueDeepCopyEqui=[NSMutableArray new];
        arrPowerlist=[NSMutableArray new];
        arrTrailerList=[NSMutableArray new];
        arrSupportList=[NSMutableArray new];
        arrayForBool=[NSMutableArray new];
        arrayForBool2=[NSMutableArray new];
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            for (Equipments *equi in [sender responseArray])
            {
                [arrAllEquipments addObject:equi];
            }
            AppInstance.arrAllEquipmentByUserId=arrAllEquipments;
            totalRecords=[APITotalEquipmentsList intValue];
            AppInstance.countEquiByUid =  APITotalEquipmentsList;
           
            limit1=limit1+limit2;
            limit2=constLimit;
            if(arrAllEquipments.count == 0)
            {
                [self.tblList setBlankPlaceHolderWithString:NoEquipmentsFound];
                self.tblList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
                self.heightList1.constant=SCREEN_HEIGHT-64;
                self.heightList2.constant=0;
                self.heightList3.constant=0;
                [_scrollData setContentSize:(CGSizeMake(CGRectGetWidth(_scrollData.frame),self.heightList1.constant+ self.heightList2.constant + self.heightList3.constant))];
            }
            else
            {
                
                arrtrueDeepCopyEqui = [NSKeyedUnarchiver unarchiveObjectWithData:
                                       [NSKeyedArchiver archivedDataWithRootObject:arrAllEquipments]];
                [self extractLinked];
                
                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"assetTypeId == '1'"];
                arrPowerlist=[[arrAllEquipments filteredArrayUsingPredicate:bPredicate] mutableCopy];
             
                NSPredicate *bPredicate1 = [NSPredicate predicateWithFormat:@"assetTypeId == '2'"];
                arrTrailerList=[[arrAllEquipments filteredArrayUsingPredicate:bPredicate1] mutableCopy];
              
                NSPredicate *bPredicate2 = [NSPredicate predicateWithFormat:@"assetTypeId == '3'"];
                arrSupportList=[[arrAllEquipments filteredArrayUsingPredicate:bPredicate2] mutableCopy];
               
                for (int i = 0; i < arrTrailerList.count; i++)
                {
                    [arrayForBool addObject:[NSNumber numberWithBool:NO]];
                }
                for (int i = 0; i < arrPowerlist.count; i++)
                {
                    [arrayForBool2 addObject:[NSNumber numberWithBool:NO]];
                }
                [self.tblList reloadData];
                [self.tblList2 reloadData];
                 [self.tblList3 reloadData];
                if(arrTrailerList.count==0)
                {
                    self.heightList1.constant=0;
                }
                else
                {
                    CGFloat height = 70;
                    height *= arrTrailerList.count;
                    self.heightList1.constant=height+70;
                }
                if(arrSupportList.count==0)
                {
                    self.heightList2.constant=0;
                }
                else
                {
                    CGFloat height2 = 70;
                    height2 *= arrSupportList.count;
                    self.heightList2.constant=height2+40;
                }
                if(arrPowerlist.count==0)
                {
                    self.heightList3.constant=0;
                }
                else
                {
                    CGFloat height3 = 70;
                    height3 *= arrPowerlist.count;
                    self.heightList3.constant=height3+70;
                }
                self.tblList.backgroundView=nil;
                if(limit1<totalRecords)
                {
                    self.btnLoadmore.hidden=NO;
                    [_scrollData setContentSize:(CGSizeMake(CGRectGetWidth(_scrollData.frame),self.heightList1.constant+ self.heightList2.constant +self.heightList3.constant+35))];
                }
                else
                {
                    self.btnLoadmore.hidden=YES;
                    [_scrollData setContentSize:(CGSizeMake(CGRectGetWidth(_scrollData.frame),self.heightList1.constant+ self.heightList2.constant +self.heightList3.constant))];
                } 
                 [self.view layoutIfNeeded];
            }
        }
        else
        {
            if(arrAllEquipments.count == 0)
            {
                [self.tblList setBlankPlaceHolderWithString:NoEquipmentsFound];
                self.tblList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
                self.heightList1.constant=SCREEN_HEIGHT-64;
                self.heightList2.constant=0;
                self.heightList3.constant=0;
            }
            
            [self.tblList reloadData];
            [self.tblList2 reloadData];
            [self.tblList3 reloadData];
//            if(arrTrailerList.count==0)
//            {
//                self.heightList1.constant=0;
//            }
//            
//            if(arrSupportList.count==0)
//            {
//                self.heightList2.constant=0;
//            }
//            
//            if(arrPowerlist.count==0)
//            {
//                self.heightList3.constant=0;
//            }
//            
            [self.tblList reloadData];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
            [self.tblList setBlankPlaceHolderWithString:APIResponseMessage];
            self.tblList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        }
    }
}

#pragma mark - Webservice handling
- (IBAction)btnLoadMoreclicked:(id)sender
{
    [self callLoadMoreData];
}
-(void)callLoadMoreData
{
    NSLog(@"limit 1 :--> %d",limit1);
 
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_FromIndex:[NSString stringWithFormat:@"%d",limit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",limit2],
                                Req_Radius:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedRadius]
                                };
    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllEquipmentByUserId
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getdicAllEquiResponseLoadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Equipments"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
         self.tblList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    }
}
-(IBAction)getdicAllEquiResponseLoadmore:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        if([sender serviceResponseCode] ==  -1005 || [sender serviceResponseCode] ==  -1001)
        {
        }
        else
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
            
        }    
         self.tblList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
           
            for (Equipments *equi in [sender responseArray])
            {
                [arrAllEquipments addObject:equi];
            }
            
            AppInstance.arrAllEquipmentByUserId=arrAllEquipments;
            
          arrtrueDeepCopyEqui = [NSKeyedUnarchiver unarchiveObjectWithData:
                                          [NSKeyedArchiver archivedDataWithRootObject:arrAllEquipments]];
            [self extractLinked];

            [self.tblList reloadData];
            limit1=limit1+limit2;
            limit2=constLimit;
            
            arrPowerlist=[NSMutableArray new];
            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"assetTypeId == '1'"];
            arrPowerlist=[[arrAllEquipments filteredArrayUsingPredicate:bPredicate] mutableCopy];
            arrTrailerList=[NSMutableArray new];
            NSPredicate *bPredicate1 = [NSPredicate predicateWithFormat:@"assetTypeId == '2'"];
            arrTrailerList=[[arrAllEquipments filteredArrayUsingPredicate:bPredicate1] mutableCopy];
            arrSupportList=[NSMutableArray new];
            NSPredicate *bPredicate2 = [NSPredicate predicateWithFormat:@"assetTypeId == '3'"];
            arrSupportList=[[arrAllEquipments filteredArrayUsingPredicate:bPredicate2] mutableCopy];
            arrayForBool=[NSMutableArray new];
            for (int i = 0; i < arrTrailerList.count; i++)
            {
                [arrayForBool addObject:[NSNumber numberWithBool:NO]];
            }
            
            [self.tblList reloadData];
            [self.tblList2 reloadData];
            [self.tblList3 reloadData];
            if(arrTrailerList.count==0)
            {
                self.heightList1.constant=0;
            }
            else
            {
                CGFloat height = 70;
                height *= arrTrailerList.count;
                self.heightList1.constant=height+70;
            }
            if(arrSupportList.count==0)
            {
                self.heightList2.constant=0;
            }
            else
            {
                CGFloat height2 = 70;
                height2 *= arrSupportList.count;
                self.heightList2.constant=height2+40;
            }
            if(arrPowerlist.count==0)
            {
                self.heightList3.constant=0;
            }
            else
            {
                CGFloat height3 = 70;
                height3 *= arrPowerlist.count;
                self.heightList3.constant=height3+70;
            }
            if(limit1<totalRecords)
            {
                self.btnLoadmore.hidden=NO;
                [_scrollData setContentSize:(CGSizeMake(CGRectGetWidth(_scrollData.frame),self.heightList1.constant+ self.heightList2.constant +self.heightList3.constant+35))];
            }
            else
            {
                self.btnLoadmore.hidden=YES;
                [_scrollData setContentSize:(CGSizeMake(CGRectGetWidth(_scrollData.frame),self.heightList1.constant+ self.heightList2.constant +self.heightList3.constant))];
            } 
            
            [self.view layoutIfNeeded];
            self.tblList.backgroundView=nil;
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
             self.tblList.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        }
    }
}
-(NSString *)lbsToKg:(NSString *)lbsval
{
    double kgval= (0.45359237) * [lbsval doubleValue];
    return [NSString stringWithFormat:@"%.2f Kg",kgval];
}

#pragma mark - cell delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == _tblList)
    {
         return arrTrailerList.count;
    }
    else if(tableView == _tblList2)
    {
        return arrSupportList.count;
    }
    else
    {
        return arrPowerlist.count;
    }
     
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{  
   
    static NSString *HeaderIdentifier = @"CellEquipmentListHeader";
    
    CellEquipmentListHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if(!header) {
        header = [[CellEquipmentListHeader alloc] initWithReuseIdentifier:HeaderIdentifier];
        header.backgroundView = [[UIView alloc] init];   
    }
    header.btnEquiname.tag=section;
    header.cellEquipmentListHeaderDelegate=self;
    Equipments *equips;
    header.lblOrangeCount.layer.borderColor = ThemeOrangeColor.CGColor;
    
    header.btnCollapseHeader.tag=section;
        if(tableView == _tblList)
        {
            header.btnEquiname.accessibilityLabel=@"Trailers";
            equips =[arrTrailerList objectAtIndex:section];
            header.btnLocationSort.tag=2685;
            header.btnstatussort.tag=2686;
            header.lblAssettype.text=@"Trailers";
            header.vwfieldsHeightHeader.constant=30.0;
            if(section > 0)
            {
                header.vwheaderviewheight.constant = 0.0;
                
            }
            else
            {
                header.vwheaderviewheight.constant = 70.0;
            }
            header.btnViewInMap.accessibilityLabel=@"Trailers";
            header.btnCollapseHeader.accessibilityLabel=@"Trailers";
        }
        else if(tableView == _tblList2)
        {
           
            header.btnEquiname.accessibilityLabel=@"Support";
            equips =[arrSupportList objectAtIndex:section];
            header.lblAssettype.text=@"Supporting Assets";
            header.vwfieldsHeightHeader.constant=0.0;
            
            if(section > 0)
            {
                header.vwheaderviewheight.constant = 0.0;
                
            }
            else
            {
                header.vwheaderviewheight.constant = 40.0;
            }
             header.btnCollapseHeader.accessibilityLabel=@"Support";
             header.btnViewInMap.accessibilityLabel=@"Support";
        }
        else
        {
            header.btnLocationSort.tag=3183;
            header.btnstatussort.tag=3184;
            header.btnEquiname.accessibilityLabel=@"Powered";
            header.vwfieldsHeightHeader.constant=0.0;
            equips =[arrPowerlist objectAtIndex:section];
            header.lblAssettype.text=@"Trucks/Powered Assets";
            header.vwfieldsHeightHeader.constant=30.0;
            if(section > 0)
            {
                header.vwheaderviewheight.constant = 0.0;
                
            }
            else
            {
                header.vwheaderviewheight.constant = 70.0;
            }
            header.btnCollapseHeader.accessibilityLabel=@"Powered";
             header.btnViewInMap.accessibilityLabel=@"Powered";
        }
        
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
            NSLog(@"%@", [NSString stringWithFormat:@"%.1f mi",(distance/1609.344)]);
            header.lblDistance.text=[NSString stringWithFormat:@"%.1f mi",(distance/1609.344)];
            header.lbllocationname.text=equips.lastEquiStatecode;
        }
        if(equips.lastEquiStatecode.length==0)
        {
             header.lbllocationname.text=@"N/A";
             header.lblDistance.text=@"0 mi";
        }
        header.lblPrice.text=@"";
        
        int linkcount,matchcount;
        linkcount=0;
        matchcount=0;
        NSString *scheduled;
        header.btnRedirectToLoaddetail.tag=section;
        if([equips.assetTypeId isEqualToString:@"2"] || ([equips.assetAbilityId isEqualToString:@"1"] || [equips.assetAbilityId isEqualToString:@"3"]))
        {
            if(equips.matches.count >0)
            {
                for (Matches *matches in equips.matches) 
                {
                    if([matches.matchOrderStatus intValue]>2)
                    {
                        linkcount = 0;
                        matchcount = 0;
                        scheduled = @"yes";
                        header.btnRedirectToLoaddetail.accessibilityValue = @"SCHEDULEDTRAILER";
                        header.btnRedirectToLoaddetail.accessibilityLabel = @"SHOWDETAILSCREEN";
                        [header.btnloadname setTitle:[NSString stringWithFormat:@"%@-%@", matches.pickupStateCode, matches.delievryStateCode] forState:UIControlStateNormal];
                    }
                    else
                    {
                        scheduled=@"no";
                        if(tableView == _tblList)
                        {
                            header.btnRedirectToLoaddetail.accessibilityLabel=@"EXPANDCOLLAPSE1";
                        }
                        else if(tableView == _tblList3)
                        {
                            header.btnRedirectToLoaddetail.accessibilityLabel=@"EXPANDCOLLAPSE3";
                        }
                        NSInteger matchOrderStatus = matches.matchOrderStatus.integerValue;
                       
                        if(matchOrderStatus >= 1){
                            
                            linkcount = linkcount + 1;
                            
                        }
                        else{
                            
                            matchcount = matchcount + 1;
                            
                        }
                        //if([matches.matchOrderStatus isEqualToString:@"0"])
//                        {
//                            matchcount=matchcount+1;
//                        }
//                        else
//                        {
//                            linkcount=linkcount+1;
//                        }
                    }
                }
            }
            else
            {
                scheduled=@"no";
                if(tableView == _tblList)
                {
                    header.btnRedirectToLoaddetail.accessibilityLabel=@"EXPANDCOLLAPSE_0MATCH";
                }
                else if(tableView == _tblList2)
                {
                    header.btnRedirectToLoaddetail.accessibilityLabel=@"EXPANDCOLLAPSE2";
                }
                else if(tableView == _tblList3)
                {
                    header.btnRedirectToLoaddetail.accessibilityLabel=@"EXPANDCOLLAPSE3";
                }
                matchcount=0;
                linkcount=0;
            }
        }
        else
        {
            matchcount=0;
            linkcount=0;
            scheduled=@"yes";
            if([equips.equiStatus isEqualToString:@"0"])
            {
                if(tableView == _tblList2)
                {
                    header.btnRedirectToLoaddetail.accessibilityLabel=@"EXPANDCOLLAPSE2";
                }
                else if(tableView == _tblList3)
                {
                    header.btnRedirectToLoaddetail.accessibilityLabel=@"EXPANDCOLLAPSE3";
                }
                header.lbltextScheduled.text=@"AVAILABLE";
                header.lbltextScheduled.textColor=ConfirmButtonColor;
                header.heightbtnloadname.constant=0;
                [header.btnloadname setTitle:@"" forState:UIControlStateNormal];
            }
            else
            {
              
                header.lbltextScheduled.text=@"SCHEDULED";
                header.lbltextScheduled.textColor=ScheduledLoadButtonColor;
                
                if(equips.matches.count>0)
                {
                    Matches *matches=[equips.matches objectAtIndex:0];
                    NSString *str=[NSString stringWithFormat:@"%@-%@",matches.pickupStateCode,matches.delievryStateCode];
                    [header.btnloadname setTitle:str forState:UIControlStateNormal];
                    header.heightbtnloadname.constant=25;
                     header.btnRedirectToLoaddetail.accessibilityLabel=@"SHOWDETAILSCREEN";
                    if(tableView == _tblList2)
                    {
                       header.btnRedirectToLoaddetail.accessibilityValue=@"SCHEDULEDSUPPORT";
                    }
                    else if(tableView == _tblList3)
                    {
                        header.btnRedirectToLoaddetail.accessibilityValue=@"SCHEDULEDPOWER";
                    }
                }
                else
                {
                     header.heightbtnloadname.constant=0;
                }               
            }
        }
      
        if([scheduled isEqualToString:@"yes"])
        {
            header.vwstatsnames.hidden=NO;
        }
        else
        {
            header.vwstatsnames.hidden=YES;
        }
        header.lblBlackCount.text=[NSString stringWithFormat:@"%d",linkcount];
        header.lblOrangeCount.text=[NSString stringWithFormat:@"%d",matchcount];
        [header.btnViewInMap setHighlighted:NO];
        [header.btnViewInList setHighlighted:NO];
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _tblList)
    {
        if([[arrayForBool objectAtIndex:section] boolValue]==1)
        {
            Equipments *obj = [arrTrailerList objectAtIndex:section];
            if(obj.matches.count >0)
            {
                return obj.matches.count; 
            }
            else
            {
                return 0;
            } 
        }
        else
        {
            return 0;
        }
    }
    else if(tableView == _tblList2)
    {
        return 0;
    }
    else
    {
        if([[arrayForBool2 objectAtIndex:section] boolValue]==1)
        {
            Equipments *obj = [arrPowerlist objectAtIndex:section];
            if(obj.matches.count >0)
            {
                return obj.matches.count; 
            }
            else
            {
                return 0;
            } 
        }
        else
        {
            return 0;
        }
    }       
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        Equipments *obj;
                if(tableView == self.tblList)
                {
                    obj=[arrTrailerList objectAtIndex:indexPath.section];
                }
                else if(tableView == self.tblList2)
                {
                    obj=[arrSupportList objectAtIndex:indexPath.section];
                }
                else
                {
                    obj=[arrPowerlist objectAtIndex:indexPath.section];
                }
        Matches *objmatch=(Matches *)[obj.matches objectAtIndex:indexPath.row];
        NSLog(@"objMatches == > %@",objmatch.matchOrderStatus);
        
        static NSString *cellIdentifier = @"CellMatchedLoadListForEquipment";
        CellMatchedLoadListForEquipment *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[CellMatchedLoadListForEquipment alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        if(indexPath.row > 0)
        {
            cell.vwCellHeaderHeight.constant = 0.0;
        }
        else
        {
            cell.vwCellHeaderHeight.constant = 35.0;
        }
        cell.cellMatchedLoadListForEquipmentDelegate=self;
        cell.btnMatchedCompnyname.text=[NSString stringWithFormat:@"%@",[[objmatch.companyName stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"] capitalizedString]];
        
        if ([objmatch.isBestoffer isEqualToString:@"1"])
        {
            cell.lblRate.text=[NSString stringWithFormat:@"Best offer"];
        }
        else
        {
            cell.lblRate.text=[NSString stringWithFormat:@"$%@",objmatch.offerRate];
        }
        
        cell.lblLength.text=[NSString stringWithFormat:@"%@ FT",objmatch.loadLength];
//        cell.lblWeight.text=[NSString stringWithFormat:@"%@",[self lbsToKg:objmatch.loadWeight]];
        cell.lblWeight.text=[NSString stringWithFormat:@"%@ lbs",objmatch.loadWeight];
        cell.lblPickupTime.text=[NSString stringWithFormat:@"%@",objmatch.pickupTime];
        cell.lblDelieveryTime.text=[NSString stringWithFormat:@"%@",objmatch.deliveryTime];
        cell.lblPickupLocation.text=[NSString stringWithFormat:@"%@",objmatch.pickupStateCode];
        cell.lblDelieveryLocation.text=[NSString stringWithFormat:@"%@",objmatch.delievryStateCode];
        //cell.lblRate.text=objmatch.matchId;
        if([objmatch.isContacted isEqualToString:@"0"])
        {
            cell.btnIsContactd.hidden=YES;
        }
        else
        {
            cell.btnIsContactd.hidden=NO;
        }
        if([objmatch.isFavourite isEqualToString:@""] || [objmatch.isFavourite isEqualToString:@"0"] || objmatch.isFavourite.length == 0)
        {
            cell.btnisFav.hidden=YES;
        }
        else
        {
            cell.btnisFav.hidden=NO;
        }
        if([objmatch.matchOrderStatus isEqualToString:@"0"] || [objmatch.matchOrderStatus isKindOfClass:[NSNull class]] || objmatch.matchOrderStatus.length == 0){
            
            cell.vwLoadDetails.backgroundColor=[UIColor orangeColor];
            cell.btnOutOfDate.backgroundColor=RGBColor(255.0, 165.0, 0.0, 0.7);
            
            //NEW
            cell.btnMatchedCompnyname.textColor = [UIColor orangeColor];
            [cell.btnArrow setTintColor:[UIColor orangeColor]];
            
            cell.vwLoadDetails.backgroundColor=[UIColor whiteColor];
            cell.btnOutOfDate.backgroundColor=RGBColor(0.0, 0.0, 0.0, 0.7);
            cell.lblLength.textColor = [UIColor orangeColor];
            cell.lblWeight.textColor = [UIColor orangeColor];
            cell.lblRate.textColor = [UIColor orangeColor];
            //cell.btnisFav.textColor = [UIColor orangeColor];
            cell.lblPickupTime.textColor = [UIColor orangeColor];
            cell.lblPickupLocation.textColor = [UIColor orangeColor];
            cell.lblDelieveryTime.textColor = [UIColor orangeColor];
            cell.lblDelieveryLocation.textColor = [UIColor orangeColor];
        }
        else
        {
            cell.vwLoadDetails.backgroundColor=[UIColor blackColor];
            cell.btnOutOfDate.backgroundColor=RGBColor(0.0, 0.0, 0.0, 0.7);
            
            //new
            [cell.btnArrow setTintColor:[UIColor lightGrayColor]];
            cell.vwLoadDetails.backgroundColor=[UIColor orangeColor];
            cell.btnOutOfDate.backgroundColor=RGBColor(255.0, 165.0, 0.0, 0.7);
            cell.btnMatchedCompnyname.textColor = [UIColor whiteColor];
            cell.lblLength.textColor = [UIColor whiteColor];
            cell.lblWeight.textColor = [UIColor whiteColor];
            cell.lblRate.textColor = [UIColor whiteColor];
           //cell.btnisFav.textColor = [UIColor whiteColor];
            cell.lblPickupTime.textColor = [UIColor whiteColor];
            cell.lblPickupLocation.textColor = [UIColor whiteColor];
            cell.lblDelieveryTime.textColor = [UIColor whiteColor];
            cell.lblDelieveryLocation.textColor = [UIColor whiteColor];
        }
        NSDate *newDate = [GlobalFunction dateString:[NSString stringWithFormat:@"%@ %@",objmatch.delieveryDate,objmatch.deliveryTime] fromFormat:@"yyyy-MM-dd hh:mm a" toFormat:@"yyyy-MM-dd hh:mm a"]; 
        NSComparisonResult result; 
        result = [today compare:newDate];
        if(result==NSOrderedDescending)
        {
            cell.btnOutOfDate.hidden=NO;
            
        }
        else
        {
            cell.btnOutOfDate.hidden=YES;
        }
        
        NSString *strPickUpDate = objmatch.pickupDate == nil ? @"" : objmatch.pickupDate;
        NSString *strDeliveryDate = objmatch.delieveryDate == nil ? @"" : objmatch.delieveryDate;
        
        NSArray *arrPickUpDateComponents = [strPickUpDate componentsSeparatedByString:@"-"];
        NSArray *arrDeliveryDateComponents = [strDeliveryDate componentsSeparatedByString:@"-"];
        
        if (arrPickUpDateComponents.count == 3)
        {
            cell.lblPickupDate.text = [NSString stringWithFormat:@"%@/%@", arrPickUpDateComponents[1], arrPickUpDateComponents[2]];
        }
        else
        {
            cell.lblPickupDate.text = @"";
        }
        
        if (arrDeliveryDateComponents.count == 3)
        {
            cell.lblDeliveryDate.text = [NSString stringWithFormat:@"%@/%@", arrDeliveryDateComponents[1], arrDeliveryDateComponents[2]];
        }
        else
        {
            cell.lblDeliveryDate.text = @"";
        }

        cell.lblPickupDate.hidden = arrPickUpDateComponents.count != 3;
        cell.lblDeliveryDate.hidden = arrDeliveryDateComponents.count != 3;
        
        //cell.lblRate.text=[NSString stringWithFormat:@"%@ and %@",objmatch.matchOrderStatus,objmatch.matchId];
        cell.separatorInset=UIEdgeInsetsZero;
        return cell;
    } 
    @catch (NSException *exception) {  
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tblList)
    {
        if(section==0)
        {
            return 140;
        }
        else
        {
            return 70; 
        }
    }
    else if(tableView == self.tblList2)
    {
        if(section==0)
        {
            return 110;
        }
        else
        {
            return 70; 
        }
    }
    else
    {
        if(section==0)
        {
            return 140;
        }
        else
        {
            return 70; 
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        if(indexPath.row==0)
        {
            return 106;
        }
        else
        {
            return 71;
        }  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        NSString *matchlist=@"0";
        
        LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
        
        Equipments *obj;
        
        if (tableView == _tblList3)
        {
            obj = [arrPowerlist objectAtIndex:indexPath.section];
        }
        else
        {
            obj = [arrTrailerList objectAtIndex:indexPath.section];
        }
        
        if (obj.matches.count == 0)
        {
            return;
        }
        
        Matches *objMatch = (Matches*)[obj.matches objectAtIndex:indexPath.row];
        Equipments *ob2j = [arrtrueDeepCopyEqui objectAtIndex:indexPath.section];
        
        for(Matches *om in ob2j.matches)
        {
            if(![om.matchId isEqualToString:objMatch.matchId])
            {
                NSString *str=[NSString stringWithFormat:@",%@",om.matchId];
                matchlist=[matchlist stringByAppendingString:str];
            }
        }
        
        objLoadDetail.allothermatchesIdList=matchlist;
        objLoadDetail.strRedirectFrom=@"MATCHESLIST";
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
        loadvalue.isAssetInterested = objMatch.isAssetInterested;
        loadvalue.isLoadInterested = objMatch.isLoadInterested;
        
        objLoadDetail.cmpnyphno=objMatch.cmpnyPhoneNo;
        objLoadDetail.strCompanyName = objMatch.companyName;
        objLoadDetail.myphono=objMatch.phoneNo;
        objLoadDetail.officephno=objMatch.officePhoneNo;
        objLoadDetail.selectedLoad=loadvalue;
        NSLog(@"MATCH ORDER STATUS === > %@",objMatch.matchOrderStatus);
        
        objLoadDetail.loadStatus=objMatch.matchOrderStatus;
        
        objLoadDetail.equipname=obj.equiName;
        objLoadDetail.matchorderid=objMatch.matchOrderId;
        objLoadDetail.equipmentid=obj.internalBaseClassIdentifier;
        objLoadDetail.matchId=objMatch.matchId;
        [self.navigationController pushViewController:objLoadDetail animated:YES];
    } @catch (NSException *exception) {
        
    } 
}



- (IBAction)btnDrawerClicked:(id)sender 
{
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
- (IBAction)btnSettingsClicked:(id)sender {
    if([_strRedirectFrom isEqualToString:@"HOME"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        
    }
}

#pragma mark - cell equipment header delegate
- (IBAction)btnCollapseHeaderClicked:(id)sender 
{
    UIButton *btn=(UIButton *)sender;
   
    if([[sender accessibilityLabel]isEqualToString:@"Trailers"])
    {
        [arrayForBool removeAllObjects];
        for(int i=0;i<arrTrailerList.count;i++)
        {
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
        }
        if([btn.titleLabel.text isEqualToString:@"+"])
        {
            [btn setTitle:@"-" forState:UIControlStateNormal];
            CGFloat height = 70;
            height *= arrTrailerList.count;
            self.heightList1.constant=height+70;
        }
        else
        {
            self.heightList1.constant=40;
            [btn setTitle:@"+" forState:UIControlStateNormal];
            
        }
        [self.tblList reloadData];
        
    }
    else if([[sender accessibilityLabel]isEqualToString:@"Support"])
    {
        if([btn.titleLabel.text isEqualToString:@"+"])
        {
            [btn setTitle:@"-" forState:UIControlStateNormal];
            CGFloat height2 = 70;
            height2 *= arrSupportList.count;
            self.heightList2.constant=height2+40;
            
        }
        else
        {
            self.heightList2.constant=40;
            [btn setTitle:@"+" forState:UIControlStateNormal];
        }
    }
    else
    {
        [arrayForBool2 removeAllObjects];
        for(int i=0;i<arrPowerlist.count;i++)
        {
            [arrayForBool2 addObject:[NSNumber numberWithBool:NO]];
        }
        if([btn.titleLabel.text isEqualToString:@"+"])
        {
            CGFloat height3 = 70;
            height3 *= arrPowerlist.count;
            self.heightList3.constant=height3+40;
            [btn setTitle:@"-" forState:UIControlStateNormal];
            
        }
        else
        {
            self.heightList3.constant=40;
            [btn setTitle:@"+" forState:UIControlStateNormal];
        }
    }
    [_scrollData setContentSize:(CGSizeMake(CGRectGetWidth(_scrollData.frame),self.heightList1.constant+ self.heightList2.constant +self.heightList3.constant))];
    [self.view layoutIfNeeded];
    
}
- (IBAction)btnViewInMapClicked:(id)sender 
{
    _heightmapdetails.constant=0;
    maporlistselection=!maporlistselection;
     if([[sender accessibilityLabel] isEqualToString:@"Trailers"])
     {
         self.lblmapviewtext.text=@"Trailers";
          [self addTrailerAnnoationAll];
        //  [self.tblList reloadData];
     }
    else if([[sender accessibilityLabel] isEqualToString:@"Support"])
    {
         self.lblmapviewtext.text=@"Supporting Assets";
         [self addSupportAnnoationAll];
       //  [self.tblList reloadData];
    }
    else
    {
         self.lblmapviewtext.text=@"Trucks/Powered Assets";
         [self addPowerAnnoationAll];
        // [self.tblList reloadData];
    }
    _maptruckView.showsUserLocation=YES;
    self.vwMaptruck.hidden=NO;
}
- (IBAction)btnViewInListClicked:(id)sender 
{
    maporlistselection=!maporlistselection;
     self.vwMaptruck.hidden=YES;
}
- (IBAction)btnloadnameclicked:(id)sender
{
    @try
    {
        if([[sender accessibilityLabel] isEqualToString:@"SHOWDETAILSCREEN"])
        {
            NSString *matchlist=@"0";
            LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
            Equipments *obj;
            if([[sender accessibilityValue] isEqualToString:@"SCHEDULEDPOWER"])
            {
                obj=[arrPowerlist objectAtIndex:[sender tag]];
            }
            else if([[sender accessibilityValue] isEqualToString:@"SCHEDULEDSUPPORT"])
            {
                obj=[arrSupportList objectAtIndex:[sender tag]];
            }
            else
            {
                obj=[arrTrailerList objectAtIndex:[sender tag]];
            }
            if(obj.matches.count >0)
            {
                Matches *objMatch=(Matches*)[obj.matches objectAtIndex:0];
                Equipments *ob2j=[arrtrueDeepCopyEqui objectAtIndex:[sender tag]];
                for(Matches *om in ob2j.matches)
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
            }
        }
        else if([[sender accessibilityLabel] isEqualToString:@"EXPANDCOLLAPSE1"])
        {
            Equipments *obj  = [arrTrailerList objectAtIndex:[sender tag]];
            selectedSection=(int)[sender tag];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:[sender tag]];
            BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
            if(collapsed==NO)
            {
                if(obj.matches.count >0)
                {
                    CGFloat height = 70;
                    height=height*(arrTrailerList.count+obj.matches.count);
                    self.heightList1.constant=height+35+70;
                }
                else
                {
                    CGFloat height = 70;
                     height=height*(arrTrailerList.count+obj.matches.count);
                    self.heightList1.constant=height+70;
                }
                [self.view layoutIfNeeded];
            }
            else
            {
                CGFloat height = 70;
                height=height*arrTrailerList.count;
                self.heightList1.constant=height+70;
                [self.view layoutIfNeeded];
            }
            [_scrollData setContentSize:(CGSizeMake(CGRectGetWidth(_scrollData.frame),self.heightList1.constant+ self.heightList2.constant +self.heightList3.constant))];
            [self.view layoutIfNeeded];
            collapsed       = !collapsed;
            [arrayForBool enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) 
            {
                if(idx==indexPath.section)
                {
                    [arrayForBool replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:collapsed]];
                }
                else
                {
                    [arrayForBool replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:NO]];
                }
               
            }];
             [self.tblList reloadData];
        }
        else if([[sender accessibilityLabel] isEqualToString:@"EXPANDCOLLAPSE2"])
        {
           Equipments *obj=[arrSupportList objectAtIndex:[sender tag]];
            SubAssetDetailsVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, SUBDETAILVC);
            objeDetail.strRedirectFrom=@"";
            objeDetail.selectedEqui=obj;
            [self.navigationController pushViewController:objeDetail animated:YES];
        }
        else if([[sender accessibilityLabel] isEqualToString:@"EXPANDCOLLAPSE3"])
        {
           Equipments *obj=[arrPowerlist objectAtIndex:[sender tag]];
            if([obj.assetAbilityId isEqualToString:@"1"] || [obj.assetAbilityId isEqualToString:@"3"])
            {
                selectedSection=(int)[sender tag];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:[sender tag]];
                BOOL collapsed  = [[arrayForBool2 objectAtIndex:indexPath.section] boolValue];
                if(collapsed==NO)
                {
                    if(obj.matches.count >0)
                    {
                         CGFloat height = 70;
                        height=height*(arrPowerlist.count+obj.matches.count);
                        self.heightList3.constant=height+35+70;
                    }
                    else
                    {
                         CGFloat height = 70;
                        height=height*arrPowerlist.count;
                        self.heightList3.constant=height+70;
                    }
                    
                    [self.view layoutIfNeeded];
                }
                else
                {
                    CGFloat height = 70;
                    height=height*arrPowerlist.count;
                    self.heightList3.constant=height+70;
                    [self.view layoutIfNeeded];
                }
                [_scrollData setContentSize:(CGSizeMake(CGRectGetWidth(_scrollData.frame),self.heightList1.constant+ self.heightList2.constant +self.heightList3.constant))];
                [self.view layoutIfNeeded];
                collapsed       = !collapsed;
                [arrayForBool2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) 
                 {
                     if(idx==indexPath.section)
                     {
                         [arrayForBool2 replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:collapsed]];
                     }
                     else
                     {
                         [arrayForBool2 replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:NO]];
                     }
                     
                 }];
                [self.tblList3 reloadData];
            }
            else
            {
                SubAssetDetailsVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, SUBDETAILVC);
                objeDetail.strRedirectFrom=@"";
                objeDetail.selectedEqui=obj;
                [self.navigationController pushViewController:objeDetail animated:YES];
            }
          
        }
        else
        {
            NSLog(@"acce :%@",[sender accessibilityLabel]);
        }
    } @catch (NSException *exception) {
        
    } 
}
- (IBAction)btnLocationSortClciekd:(id)sender
{
     NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"equiLatitude" ascending:distancesort],[NSSortDescriptor sortDescriptorWithKey:@"equiLongitude" ascending:distancesort]];
    if([sender tag] == 2685)
    {
        arrTrailerList= [[arrTrailerList sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
        distancesort=!distancesort;
        [self.tblList reloadData];
    }
    else
    {
        arrPowerlist= [[arrPowerlist sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
        distancesort=!distancesort;
        [self.tblList3 reloadData];
    }
   
   
}
- (IBAction)btnStatusSortClicked:(id)sender
{
     NSArray *sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"matches.@count" ascending:statsussort]];
    if([sender tag] == 2686)
    {
        arrTrailerList= [[arrTrailerList sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
        statsussort=!statsussort;
        [self.tblList reloadData];
    }
    else
    {
        arrPowerlist= [[arrPowerlist sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
        statsussort=!statsussort;
        [self.tblList3 reloadData];
    }
}
- (IBAction)btnRateSortClicked:(id)sender
{
}
- (IBAction)btnEquiNameClicked:(id)sender
{
    Equipments *obj;
    if([[sender accessibilityLabel] isEqualToString:@"Trailers"])
    {
        obj=[arrTrailerList objectAtIndex:[sender tag]];
    }
    else if([[sender accessibilityLabel] isEqualToString:@"Support"])
    {
        obj=[arrSupportList objectAtIndex:[sender tag]];
    }
    else
    {
        obj=[arrPowerlist objectAtIndex:[sender tag]];
    }
    if([obj.assetTypeId isEqualToString:@"2"])
    {
        EquipmentDetailVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, EQUIPMENTDETAILVC);
        objeDetail.strRedirectFrom=@"";
        objeDetail.selectedEqui=obj;
        [self.navigationController pushViewController:objeDetail animated:YES];
    }
    else
    {
        if([obj.assetTypeId isEqualToString:@"1"] && ([obj.assetAbilityId isEqualToString:@"1"] ||  [obj.assetAbilityId isEqualToString:@"3"]))
        {
            EquipmentDetailVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, EQUIPMENTDETAILVC);
            objeDetail.strRedirectFrom=@"";
            objeDetail.selectedEqui=obj;
            [self.navigationController pushViewController:objeDetail animated:YES];
        }
        else
        {
            SubAssetDetailsVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, SUBDETAILVC);
            objeDetail.strRedirectFrom=@"";
            objeDetail.selectedEqui=obj;
            [self.navigationController pushViewController:objeDetail animated:YES];
        }
    }
}
#pragma mark - cell Matches loads list delegate
- (IBAction)btnsortpickupclicked:(id)sender
{
    
}
- (IBAction)btnsortdelieverclicked:(id)sender
{
    
}
- (IBAction)btnsortlenghtclicked:(id)sender
{
    
}
- (IBAction)btnsortweightclicked:(id)sender
{
    
}
- (IBAction)btnsortrateclciked:(id)sender
{
    Equipments *obj=[arrPowerlist objectAtIndex:selectedSection];
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"offerRate" ascending:subratesort]];
    obj.matches= [[obj.matches sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    [arrPowerlist replaceObjectAtIndex:selectedSection withObject:obj];
    subratesort=!subratesort;
    [self.tblList3 reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - ----------------------MAPVIEW PROCESS
#pragma mark - MKMapViewDelegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion mapRegion;   
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    [mapView setRegion:mapRegion animated: YES];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [[NSOperationQueue new] addOperationWithBlock:^{
        double scale = mapView.bounds.size.width / mapView.visibleMapRect.size.width;
        NSArray *annotations = [self.clusteringManager clusteredAnnotationsWithinMapRect:mapView.visibleMapRect withZoomScale:scale];
        [self.clusteringManager displayAnnotations:annotations onMapView:_maptruckView];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation == mapView.userLocation)
    {
        return nil;
    }
    else
    {
    static NSString *const AnnotatioViewReuseID = @"AnnotatioViewReuseID";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotatioViewReuseID];
    
    if (!annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotatioViewReuseID];
    }
    
    if ([annotation isKindOfClass:[FBAnnotationCluster class]]) 
    {
        FBAnnotationCluster *cluster = (FBAnnotationCluster *)annotation;
        cluster.title = [NSString stringWithFormat:@"%lu", (unsigned long)cluster.annotations.count];
        UIImage *actualimg= [UIImage imageNamed:@"clustermapmarker"];
        UIImage *img = [self drawText:[NSString stringWithFormat:@"%lu", (unsigned long)cluster.annotations.count]
                              inImage:actualimg
                              atPoint: CGPointMake(0, 10)
                                color:[UIColor blackColor]];
        annotationView.image = img;
        annotationView.canShowCallout = NO;
        annotationView.frame = CGRectMake(0, 0, annotationView.image.size.width, annotationView.image.size.height);
        return annotationView;
    } 
    else 
    {
        CustomAnnotClass *point = (CustomAnnotClass*)annotation;
        UIImage *actualimg= [UIImage imageNamed:@"mapMarker"];
        annotationView.image = actualimg;
        annotationView.tag = [point.accessibilityHint intValue];
               [annotationView setAccessibilityLabel:point.accessibilityHint];
        annotationView.userInteractionEnabled=YES;
        UITapGestureRecognizer *pinTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pinTapped:)];
        [annotationView addGestureRecognizer:pinTap];
        annotationView.frame = CGRectMake(0, 0, annotationView.image.size.width, annotationView.image.size.height);
        return annotationView;
    }
    }
    
}
-(IBAction)pinTapped:(UITapGestureRecognizer *)sender 
{
    @try 
    {
    MKAnnotationView *view = (MKAnnotationView *)sender.view;
        Equipments *equi;
        if(_maptruckView .tag ==1000)
        {
            equi=[arrTrailerList objectAtIndex:view.tag];
        }
        else if(_maptruckView .tag ==2000)
        {
             equi=[arrSupportList objectAtIndex:view.tag];
        }
        else
        {
             equi=[arrPowerlist objectAtIndex:view.tag];
        }
    selectedAnnotation=view.tag;
    _lbltruckdata.text=[NSString stringWithFormat:@"Name: %@",equi.equiName];
    _lbltruckAddress.text=[NSString stringWithFormat:@"Last Location: %@",equi.lastEquiAddress];
        if(equi.lastEquiAddress.length!=0)
        {
            _lbltruckAddress.text=[NSString stringWithFormat:@"Last Location: %@",equi.lastEquiAddress];
        }
        else
        {
            CLGeocoder *ceo = [[CLGeocoder alloc]init];
            CLLocation *loc = [[CLLocation alloc]initWithLatitude:[equi.equiLatitude floatValue] longitude:[equi.equiLongitude floatValue]];
            
            [ceo reverseGeocodeLocation: loc completionHandler:
             ^(NSArray *placemarks, NSError *error) 
             {
                 CLPlacemark *placemark = [placemarks objectAtIndex:0];
                 
                 NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                 if(locatedAt.length==0 || locatedAt==nil)
                 {
                     locatedAt=@"";
                 }
                 _lbltruckAddress.text=[NSString stringWithFormat:@"Last Location: %@",locatedAt];
             }];
        }
        if(![view isKindOfClass:[FBAnnotationCluster class]])
        {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
             {  
                 _heightmapdetails.constant=80;
                  
             }
           completion:^(BOOL finished)
             { 
                [_vwmapdetails layoutIfNeeded];
             }];
        }
    } 
    @catch (NSException *exception) {
        
    }
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view 
{
   
}
#pragma mark - FBClusterManager delegate - optional

- (CGFloat)cellSizeFactorForCoordinator:(FBClusteringManager *)coordinator
{
    return 1.5;
}

#pragma mark - Add annotations button action handler
- (void)addBounceAnnimationToView:(UIView *)view
{
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    bounceAnimation.values = @[@(0.05), @(1.1), @(0.9), @(1)];
    
    bounceAnimation.duration = 0.6;
    NSMutableArray *timingFunctions = [[NSMutableArray alloc] initWithCapacity:bounceAnimation.values.count];
    for (NSUInteger i = 0; i < bounceAnimation.values.count; i++) {
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    }
    [bounceAnimation setTimingFunctions:timingFunctions.copy];
    bounceAnimation.removedOnCompletion = NO;
    
    [view.layer addAnimation:bounceAnimation forKey:@"bounce"];
    
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (MKAnnotationView *view in views)
    {
        if(![view isKindOfClass:[CustomAnnotClass class]])
        {
            [self addBounceAnnimationToView:view];
        }
    }
}
- (void)addTrailerAnnoationAll
{
    if(arrAddAnnotation.count==0)
    {
        arrAddAnnotation = [[NSMutableArray alloc]init];
        CustomAnnotClass *annotation;
        for (int i=0;i<arrTrailerList.count;i++)
        {
            Equipments *ec =[arrTrailerList objectAtIndex:i];
            if(ec.equiLatitude==nil)
            {
                coordinate.latitude= [AppInstance.userCurrentLat floatValue];
                coordinate.longitude=[AppInstance.userCurrentLon floatValue];
            }
            else
            {
                coordinate.latitude= [ec.equiLatitude floatValue];
                coordinate.longitude=[ec.equiLongitude floatValue];
            }
            
            annotation = nil;
            annotation = [[CustomAnnotClass alloc] initWithCoordinate:coordinate andMarkTitle:ec.equiName andMarkSubTitle:@""];
            [annotation setAccessibilityHint:[NSString stringWithFormat:@"%d",i]];
            [arrAddAnnotation addObject:annotation];
            
        }
        _maptruckView.tag=1000;
        self.clusteringManager = [[FBClusteringManager alloc] initWithAnnotations:arrAddAnnotation];
        [self mapView:_maptruckView regionDidChangeAnimated:NO];
    }
    else
    {
        _maptruckView.tag=1000;
        self.clusteringManager = [[FBClusteringManager alloc] initWithAnnotations:arrAddAnnotation];
        [self mapView:_maptruckView regionDidChangeAnimated:NO];
    }
}
- (void)addSupportAnnoationAll
{
    if(arrAddAnnotation1.count==0)
    {
        arrAddAnnotation1 = [[NSMutableArray alloc]init];
        CustomAnnotClass *annotation;
        for (int i=0;i<arrSupportList.count;i++)
        {
            Equipments *ec =[arrSupportList objectAtIndex:i];
            if(ec.equiLatitude==nil)
            {
                coordinate.latitude= [AppInstance.userCurrentLat floatValue];
                coordinate.longitude=[AppInstance.userCurrentLon floatValue];
            }
            else
            {
                coordinate.latitude= [ec.equiLatitude floatValue];
                coordinate.longitude=[ec.equiLongitude floatValue];
            }
            
            annotation = nil;
            annotation = [[CustomAnnotClass alloc] initWithCoordinate:coordinate andMarkTitle:ec.equiName andMarkSubTitle:@""];
            [annotation setAccessibilityHint:[NSString stringWithFormat:@"%d",i]];
            [arrAddAnnotation1 addObject:annotation];
        }
        _maptruckView.tag=2000;
        self.clusteringManager = [[FBClusteringManager alloc] initWithAnnotations:arrAddAnnotation1];
        [self mapView:_maptruckView regionDidChangeAnimated:NO];
    }
    else
    {
        _maptruckView.tag=2000;
        self.clusteringManager = [[FBClusteringManager alloc] initWithAnnotations:arrAddAnnotation1];
        [self mapView:_maptruckView regionDidChangeAnimated:NO];
    }
}
- (void)addPowerAnnoationAll
{
    if(arrAddAnnotation2.count==0)
    {
        arrAddAnnotation2 = [[NSMutableArray alloc]init];
        CustomAnnotClass *annotation;
        for (int i=0;i<arrPowerlist.count;i++)
        {
            Equipments *ec =[arrPowerlist objectAtIndex:i];
            if(ec.equiLatitude==nil)
            {
                coordinate.latitude= [AppInstance.userCurrentLat floatValue];
                coordinate.longitude=[AppInstance.userCurrentLon floatValue];
            }
            else
            {
                coordinate.latitude= [ec.equiLatitude floatValue];
                coordinate.longitude=[ec.equiLongitude floatValue];
            }
            
            annotation = nil;
            annotation = [[CustomAnnotClass alloc] initWithCoordinate:coordinate andMarkTitle:ec.equiName andMarkSubTitle:@""];
            [annotation setAccessibilityHint:[NSString stringWithFormat:@"%d",i]];
            [arrAddAnnotation2 addObject:annotation];
        }
        _maptruckView.tag=3000;
        self.clusteringManager = [[FBClusteringManager alloc] initWithAnnotations:arrAddAnnotation2];
        [self mapView:_maptruckView regionDidChangeAnimated:NO];
    }
    else
    {
        _maptruckView.tag=3000;
        self.clusteringManager = [[FBClusteringManager alloc] initWithAnnotations:arrAddAnnotation2];
        [self mapView:_maptruckView regionDidChangeAnimated:NO];
    }
}

- (IBAction)btnMapPinDetailClciked:(id)sender 
{
    Equipments *obj;
    if(_maptruckView.tag==1000)
    {
        obj=[arrTrailerList objectAtIndex:selectedAnnotation];
    }
    else if(_maptruckView.tag==2000)
    {
        obj=[arrSupportList objectAtIndex:selectedAnnotation];
    }
    else
    {
        obj=[arrPowerlist objectAtIndex:selectedAnnotation];
    }
        EquipmentDetailVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, EQUIPMENTDETAILVC);
        objeDetail.strRedirectFrom=@"";
        objeDetail.selectedEqui=obj;
        [self.navigationController pushViewController:objeDetail animated:YES];
}


@end
