//
//  CalenderListVC.m
//  Lodr
//  Created by c196 on 29/05/17.
//  Copyright © 2017 checkmate. All rights reserved.

#import "CalenderListVC.h"
#import "Equipments.h"
#import "Matches.h"
#import "UITableView+Placeholder.h"
#import "PostEquipmentVC.h"
#import "Orders.h"
#import "MyNetwork.h"
#import "MyEquipmentList.h"
#import "Loads.h"
#import "PostLoadVC.h" 
#import "AlernateEquimentListVC.h"
#import "DriverProfileVC.h"
#import "EquipmentDetailVC.h"
#import "LoadDetailVC.h"
#import "SubAssetDetailsVC.h"
#define constLimit 20

@interface CalenderListVC ()
{
    NSDate *_todayDate, *_minDate, *_maxDate, *_dateSelected;
    NSMutableArray *arrAllTime, *arrayForBool, *arrayForBool2, *arrayForBoolSupport, *arrayForBoolPower, *arrDriverList, *arrTruckDispatchList, *arrDriverDispatchList, *arrLoadList, *arrPowerList, *arrSupportList, *arrTrailerList, *arrSupportDispatchList, *arrPowerDispatchList, *arrTrailerDispatchList, *arrSubAssetList, *arrSupportAssetList, *arrdeepcopysunasset;
    NSMutableDictionary *timeSLotDic,*timeSLotDic2,*timeSLotDic3,*_eventsByDate;
    int limit1, limit2, totalRecords, powerlimit1, powerlimit2, totalPower, supportlimit1, supportlimit2, totalsupport, truckdispatchlimit1, truckdispatchlimit2, truckdispatchTotalRecord, driverlimit1, driverlimit2, drivertotalrecord, driverdispatchlimit1, driverdispatchlimit2, driverdispatchtotalrecord, loadlimit1, loadlimit2, subassetlimit1, subassetlimit2, totalLoadrecord, totalSubAssets, supportassetlimit1, supportassetlimit2, totalsupportasset;
    NSDateComponents *components;
    NSString *startdt, *enddt, *choosendate;
    User *objuser;
    UserAccount *objuserAccount;
    NSInteger year, prevyear;
    NSCalendar *gregorian;
}
@end

@implementation CalenderListVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    objuserAccount = [objuser.userAccount objectAtIndex:0];
    
    NavigationBarHidden(YES);
    
    [self initializeCalender];
    [self prepareArrayToLoadTable];
    
    if ([_redirectfrom isEqualToString:@"HOMEVC"])
    {
        [self.btnBack setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
        _btnRefresh.hidden = NO;
        self.btnBack.accessibilityLabel = @"BACK";
    }
    else
    {
        [self.btnBack setImage:imgNamed(@"refreshicon") forState:UIControlStateNormal];
        _btnRefresh.hidden = YES;
        self.btnBack.accessibilityLabel = @"REFRESH";
    }
    
    components = [[NSDateComponents alloc] init];
    choosendate = [GlobalFunction getDateStringFromDate:[NSDate date] withFormate:@"MM/dd/yy"];
}

#pragma mark - init methods

- (void)prepareArrayToLoadTable
{
    arrAllTime = [NSMutableArray new];
    NSString *strTimeAbbrevation = @"AM";
 
    int n = 24;
    
    for (int i = -12; i < 12; i++)
    {
        int j = i;
       
        if (i < 0)
        {
            j = n + i;
            
            if (j > 12)
            {
                j = j - 12;
            }
        }
        else
        {
            strTimeAbbrevation = @"PM";
            
            if (i == 0)
            {
                j = 12;
            }
            else
            {
                j = i;
            }
        }
        
//        if(i>12){
//            strTimeAbbrevation = @"PM";
//            j = i - 12;
//
//        }
        
        NSString *strtime = [NSString stringWithFormat:@"%d:00 %@", j, strTimeAbbrevation];
        [arrAllTime addObject:strtime];
    }
    
    [self registerTableNibs];
    [self refreshCalender:@"1"];
}

- (void)initializeCalender
{
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    [self createMinAndMaxDate];
    [_calendarManager setMenuView:_calenerMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:_todayDate];
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    year = [gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    prevyear = year;
    [self performSelectorInBackground:@selector(getAllEvent) withObject:nil];
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==_tblListOfResources || tableView==_tblListOfResources2 || tableView==_tblLoadCalender || tableView==_tblSupport || tableView==_tblPowerAsset)
    {
        return 1;
    }
//    else if(tableView==_tblLinkedList)
//    {
//        return arrTruckDispatchList.count;
//    }
//    else if(tableView==_tblLinkedList2)
//    {
//        return arrDriverDispatchList.count;
//    }
//    else if(tableView==_tblPowerDispatch)
//    {
//        return arrPowerDispatchList.count;
//    }
//    else if(tableView==_tblSupportDispatch)
//    {
//        return arrSupportDispatchList.count;
//    }
    else
    {
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    @try
    {
        if(tableView==_tblSupport ||tableView==_tblPowerAsset || tableView==_tblListOfResources || tableView==_tblListOfResources2 || tableView==_tblLoadCalender)
        {
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width, 30)];
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0,0,80, 30)];
            lbl.text=choosendate;
            lbl.font=[UIFont fontWithName:@"Arial" size:12.0f];
            lbl.backgroundColor=RGBColor(230, 230, 230, 1);
            lbl.textColor=[UIColor darkGrayColor];
            lbl.textAlignment = NSTextAlignmentCenter;
            [header addSubview:lbl];
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0,0);
            layout.minimumLineSpacing=0;
            layout.minimumInteritemSpacing=0;
            layout.itemSize = CGSizeMake(60, 30);
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            header.backgroundColor=RGBColor(230, 230, 230, 1);
            
            if(tableView==_tblListOfResources)
            {
                self.collEventTimeHeader =[[UICollectionView alloc]initWithFrame:CGRectMake(80, 0,self.tblListOfResources.frame.size.width - 80,30) collectionViewLayout:layout];
                self.collEventTimeHeader.backgroundColor=[UIColor clearColor];
                self.collEventTimeHeader.delegate=self;
                self.collEventTimeHeader.dataSource=self;
                 [header addSubview:self.collEventTimeHeader];
                return header;
            }
            else if(tableView==_tblSupport)
            {
                self.collEventTimeHeader4 =[[UICollectionView alloc]initWithFrame:CGRectMake(80, 0,self.tblSupport.frame.size.width - 80,30) collectionViewLayout:layout];
                self.collEventTimeHeader4.backgroundColor=[UIColor clearColor];
                self.collEventTimeHeader4.delegate=self;
                self.collEventTimeHeader4.dataSource=self;
                 [header addSubview:self.collEventTimeHeader4];
                return header;
            }
            else if(tableView==_tblPowerAsset)
            {
                self.collEventTimeHeader5 =[[UICollectionView alloc]initWithFrame:CGRectMake(80, 0,self.tblPowerAsset.frame.size.width - 80,30) collectionViewLayout:layout];
                self.collEventTimeHeader5.backgroundColor=[UIColor clearColor];
                self.collEventTimeHeader5.delegate=self;
                self.collEventTimeHeader5.dataSource=self;
                 [header addSubview:self.collEventTimeHeader5];
                return header;
            }
            else if(tableView==_tblListOfResources2)
            {
                self.collEventTimeHeader2 =[[UICollectionView alloc]initWithFrame:CGRectMake(80, 0,self.tblListOfResources2.frame.size.width - 80,30) collectionViewLayout:layout];
                self.collEventTimeHeader2.backgroundColor=[UIColor clearColor];
                self.collEventTimeHeader2.delegate=self;
                self.collEventTimeHeader2.dataSource=self;
                 [header addSubview:self.collEventTimeHeader2];
                return header;
            }
            else if(tableView==_tblLoadCalender)
            {
                self.collEventTimeHeader3 =[[UICollectionView alloc]initWithFrame:CGRectMake(80, 0,self.tblLoadCalender.frame.size.width - 80,30) collectionViewLayout:layout];
                self.collEventTimeHeader3.backgroundColor=[UIColor clearColor];
                self.collEventTimeHeader3.delegate=self;
                self.collEventTimeHeader3.dataSource=self;
                 [header addSubview:self.collEventTimeHeader3];
                return header;
            }
        }
        /*else
        {
            CellCalenderHeader *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CellCalenderHeader"];
            if(header==nil)
            {
                NSArray *nibhead= [[NSBundle mainBundle] loadNibNamed:@"CellCalenderHeader" owner:self options:nil];
                
                header = (CellCalenderHeader *)[nibhead objectAtIndex:0];
            }
                   header.cellCalenderHeaderDelegate=self;
            header.btnExpandColl.tag= section;
         
           if(tableView == _tblLinkedList2)
           {
               Loads *laods=[arrDriverDispatchList objectAtIndex:section];
               Equipments *match=[laods.equipments objectAtIndex:0];
               header.btnSection.tag= section;
               header.vwMainView.hidden=NO;
               header.vwTruckList.hidden=YES;
               header.btnSection.accessibilityValue=@"LIST2";
               header.lblResourceName.text=[NSString stringWithFormat:@"%@-%@",laods.pickupStateCode,laods.deliveryStateCode];
               header.lblResouceSubdetailName.text=laods.distance;
               header.lblDate1.text=[GlobalFunction stringDate:laods.pickupDate fromFormat:@"yyyy-MM-dd" toFormat:@"dd/MM"];
               header.lblDate2.text=[GlobalFunction stringDate:laods.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"dd/MM"];
               header.lblTime1.text=laods.pickupTime;
               header.lblTime2.text=laods.deliveryTime;
               header.btnRedirectToDetail.tag=section;
               header.lblAmountName.text=match.equiName;
               header.btnRedirectToDetail.accessibilityValue=@"LIST2";
               return header;
           }
           else if(tableView==_tblLinkedList)
           {
               //   [header.vwMainView removeFromSuperview];

               Equipments *equi=[arrTruckDispatchList objectAtIndex:section];
               header.btnExpandColl.accessibilityValue=@"LIST1";
              
               header.vwMainView.hidden=YES;
               header.vwTruckList.hidden=NO;
                header.lblTruckname.text=equi.equiName;
               if(equi.matches.count >0)
               {  
                   Matches *matches=[equi.matches objectAtIndex:0];
                   header.lblDestinationsName.text=[NSString stringWithFormat:@"%@-%@",matches.pickupStateCode,matches.delievryStateCode];
                   header.lblDistance.text=matches.distance;
                   
                }
               else
               {
                   header.lblDestinationsName.text=@"N/A";
                    header.lblDistance.text=@"0 mi";
               }
                header.btnViewTruckDetails.tag=section;
               return header;
           }
            else
           {
               Loads *laods;
               header.btnSection.tag= section;
               header.vwMainView.hidden=NO;
               header.vwTruckList.hidden=YES;
               if(tableView==_tblPowerDispatch )
                {
                    laods=[arrPowerDispatchList objectAtIndex:section];
                     Equipments *match=[laods.equipments objectAtIndex:0];
                    header.btnSection.accessibilityValue=@"LIST3";
                     header.btnRedirectToDetail.accessibilityValue=@"LIST3";
                    header.lblAmountName.text=match.equiName;
                }
                else
                {
                    laods=[arrSupportDispatchList objectAtIndex:section];
                    header.btnSection.accessibilityValue=@"LIST4";
                     header.btnRedirectToDetail.accessibilityValue=@"LIST4";
                    Equipments *match=[laods.equipments objectAtIndex:0];
                     header.lblAmountName.text=match.equiName;
                }
               header.lblResourceName.text=[NSString stringWithFormat:@"%@-%@",laods.pickupStateCode,laods.deliveryStateCode];
               header.lblResouceSubdetailName.text=laods.distance;
               header.lblDate1.text=[GlobalFunction stringDate:laods.pickupDate fromFormat:@"yyyy-MM-dd" toFormat:@"dd/MM"];
               header.lblDate2.text=[GlobalFunction stringDate:laods.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"dd/MM"];
               header.lblTime1.text=laods.pickupTime;
               header.lblTime2.text=laods.deliveryTime;
               header.btnRedirectToDetail.tag=section;
              return header;
            }
            
        }
         */
        return nil;

    } @catch (NSException *exception) {
        
    } 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_tblListOfResources)
    {
         return arrTrailerList.count;
    }
    else if(tableView==_tblSupport)
    {
        return arrSupportList.count;
    }
    else if(tableView==_tblPowerAsset)
    {
        return arrPowerList.count;
    }
    else if(tableView==_tblListOfResources2)
    {
        return arrDriverList.count;
    }
    else if(tableView==_tblLoadCalender)
    {
        return arrLoadList.count;
    }
    else
    {
        return  0;
    }
    /* else if(tableView==_tblLinkedList)
    {
        if([[arrayForBool objectAtIndex:section] boolValue]==1)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    else if(tableView==_tblSupportDispatch)
    {
        if([[arrayForBoolSupport objectAtIndex:section] boolValue]==1)
        {
            Loads *obj=[arrSupportDispatchList objectAtIndex:section];
            return obj.matches.count;
        }
        else
        {
            return 0;
        }
    }
    else if(tableView==_tblPowerDispatch)
    {
        if([[arrayForBoolPower objectAtIndex:section] boolValue]==1)
        {
            Loads *obj=[arrPowerDispatchList objectAtIndex:section];
            return obj.matches.count;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        if([[arrayForBool2 objectAtIndex:section] boolValue]==1)
        {
            Loads *obj=[arrDriverDispatchList objectAtIndex:section];
            if(obj.matches.count==0)
            {
                return 1;
            }
            else
            {
                return obj.matches.count;
            }
        }
        else
        {
            return 0;
        }
    } */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        if(tableView==_tblSupport ||tableView==_tblPowerAsset || tableView==_tblListOfResources || tableView==_tblListOfResources2 || tableView==_tblLoadCalender)
        {
            CellCalenderEvent *cell = [tableView dequeueReusableCellWithIdentifier:@"CellCalenderEvent"];
            
            for (id view in cell.subviews)
            {
                if ([view isKindOfClass:[UICollectionView class]])
                {
                    [view removeFromSuperview];
                }
            }
            
            cell.collAllEvents.delegate = self;
            cell.collAllEvents.dataSource = self;
            cell.collAllEvents.tag=indexPath.row;
            cell.btnResoutcedetail.tag=indexPath.row;
            
            if(tableView==_tblListOfResources2 )
            {
                cell.collAllEvents.accessibilityValue=[NSString stringWithFormat:@"DRIVER"];
                cell.btnResoutcedetail.accessibilityValue=[NSString stringWithFormat:@"DRIVER"];
                //cell.collAllEvents.contentOffset= CGPointMake(self.collEventTimeHeader2.contentOffset.x,0.0);
                MyNetwork *driver = [arrDriverList objectAtIndex:indexPath.row];
                cell.lblNameResoutce.text=driver.firstname;
            }
            else if(tableView==_tblLoadCalender)
            {
                cell.collAllEvents.accessibilityValue=[NSString stringWithFormat:@"LOAD"];
                cell.btnResoutcedetail.accessibilityValue=[NSString stringWithFormat:@"LOAD"];
              //  cell.collAllEvents.contentOffset= CGPointMake(self.collEventTimeHeader3.contentOffset.x,0.0);
                Loads *driver = [arrLoadList objectAtIndex:indexPath.row];
                cell.lblNameResoutce.text=[NSString stringWithFormat:@"%@-%@",driver.pickupStateCode,driver.deliveryStateCode];
                cell.lblmilesdata.text=[NSString stringWithFormat:@"%@",driver.distance];
            }
            else
            {
                Equipments *obje;
                if(tableView==_tblListOfResources)
                {
                    cell.collAllEvents.accessibilityValue=[NSString stringWithFormat:@"TRUCK"];
                     //cell.collAllEvents.contentOffset= CGPointMake(self.collEventTimeHeader.contentOffset.x,0.0);
                    cell.btnResoutcedetail.accessibilityValue=[NSString stringWithFormat:@"TRUCK"];
                    obje=[arrTrailerList objectAtIndex:indexPath.row];
                    cell.lblNameResoutce.text=obje.equiName;
                }
                else if(tableView==_tblSupport )
                {
                    cell.collAllEvents.accessibilityValue=[NSString stringWithFormat:@"SUPPORT"];
                    cell.collAllEvents.contentOffset= CGPointMake(self.collEventTimeHeader4.contentOffset.x,0.0);
                    cell.btnResoutcedetail.accessibilityValue=[NSString stringWithFormat:@"SUPPORT"];
                    obje=[arrSupportList objectAtIndex:indexPath.row];
                    cell.lblNameResoutce.text=obje.equiName;
                }
                else if(tableView==_tblPowerAsset )
                {
                    cell.collAllEvents.accessibilityValue=[NSString stringWithFormat:@"POWER"];
                    cell.collAllEvents.contentOffset= CGPointMake(self.collEventTimeHeader5.contentOffset.x,0.0);
                    cell.btnResoutcedetail.accessibilityValue=[NSString stringWithFormat:@"POWER"];
                    obje=[arrPowerList objectAtIndex:indexPath.row];
                    cell.lblNameResoutce.text=obje.equiName;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cellCalenderEventDelegate=self;
            [cell.collAllEvents reloadData];
            return cell;
        }
        return nil;
      /*  else
        {
            CellCalenderSchedule *cell = [tableView dequeueReusableCellWithIdentifier:@"CellCalenderSchedule"];
            cell.cellCalenderScheduleDeleagate=self;
            if(tableView==_tblLinkedList2)
            {
                Loads *objnetwork =[arrDriverDispatchList objectAtIndex:indexPath.section];
                if(objnetwork.matches.count==0)
                {
                    cell.lblNodriverAvailable.hidden=NO;
                    cell.vwMain.hidden=YES;
                }
                else
                {
                    cell.vwMain.hidden=NO;
                    cell.vwSchudeledbtn.hidden=YES;
                    cell.btnDriverSchedule.tag=indexPath.section;
                    cell.btnDriverSchedule.accessibilityValue=@"CELLDRIVER";
                    cell.btnVwDetails.tag=indexPath.section;
                    cell.btnVwDetails.accessibilityValue=@"DRIVER";
                    cell.btnVwDetails.accessibilityLabel=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                    cell.btnDriverSchedule.accessibilityLabel=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                    cell.lblNodriverAvailable.hidden=YES;
                    Matches *objmatch=[objnetwork.matches objectAtIndex:indexPath.row];
                    cell.lblResourcename.text=objmatch.firstname;
                }
            }
            else if( tableView==_tblSupportDispatch)
            {
                cell.lblNodriverAvailable.hidden=YES;
                cell.vwSchudeledbtn.hidden=YES;
                cell.btnDriverSchedule.tag=indexPath.section;
                cell.btnVwDetails.tag=indexPath.section;
                cell.btnVwDetails.accessibilityValue=@"SUPPORT";
                cell.btnDriverSchedule.accessibilityValue=@"CELLSUPPORT";
                cell.btnVwDetails.accessibilityLabel=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                cell.btnDriverSchedule.accessibilityLabel=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                Loads *objnetwork =[arrSupportDispatchList objectAtIndex:indexPath.section];
                Matches *objmatch=[objnetwork.matches objectAtIndex:indexPath.row];
                cell.lblResourcename.text=objmatch.equiName;
            }
            else if( tableView==_tblPowerDispatch)
            {
                cell.lblNodriverAvailable.hidden=YES;
                cell.vwSchudeledbtn.hidden=YES;
                cell.btnDriverSchedule.tag=indexPath.section;
                cell.btnVwDetails.tag=indexPath.section;
                cell.btnVwDetails.accessibilityValue=@"POWER";
                 cell.btnDriverSchedule.accessibilityValue=@"CELLPOWER";
                cell.btnVwDetails.accessibilityLabel=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                cell.btnDriverSchedule.accessibilityLabel=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                Loads *objnetwork =[arrPowerDispatchList objectAtIndex:indexPath.section];
                Matches *objmatch=[objnetwork.matches objectAtIndex:indexPath.row];
                cell.lblResourcename.text=objmatch.equiName;
            }
            else
            {
                cell.lblNodriverAvailable.hidden=YES;
                 cell.btnDriverSchedule.accessibilityValue=@"CELLTRUCK";
                cell.btnSchedule.tag=indexPath.section;
                cell.vwSchudeledbtn.hidden=NO;
                cell.btnAlternateEqui.tag=indexPath.section;
                cell.btnAlternateEqui.accessibilityLabel=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            }
            return cell;
        }*/
    }
    @catch (NSException *exception) {
        
    } 
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView==_tblListOfResources )
    {
        if(arrTrailerList.count>0)
        {
             return 30;
        }
       else
       {
           return 0;
       }
    }
    else if(tableView==_tblPowerAsset )
    {
        if(arrPowerList.count>0)
        {
            return 30;
        }
        else
        {
            return 0;
        }
    }
    else if(tableView==_tblSupport )
    {
        if(arrSupportList.count>0)
        {
            return 30;
        }
        else
        {
            return 0;
        }
    }
    else if(tableView==_tblListOfResources2)
    {
        if(arrDriverList.count>0)
        {
            return 30;
        }
        else
        {
            return 0;
        }
    }
    else if(tableView==_tblLoadCalender)
    {
        if(arrLoadList.count>0)
        {
            return 30;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 70;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - collectionview delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{   
    if(collectionView == self.collEventTimeHeader || collectionView == self.collEventTimeHeader2 || collectionView == self.collEventTimeHeader3 || collectionView == self.collEventTimeHeader4 || collectionView == self.collEventTimeHeader5 )
    {
        return CGSizeMake(60,30);
    }
    else
        return CGSizeMake(1440,70);
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    if(view == self.collEventTimeHeader || view == self.collEventTimeHeader2  || view == self.collEventTimeHeader3 || view == self.collEventTimeHeader4  || view == self.collEventTimeHeader5)
    {
        return arrAllTime.count;
    }
    else
    {
        return 1;
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section 
{
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
         if(cv == self.collEventTimeHeader || cv == self.collEventTimeHeader2 ||cv == self.collEventTimeHeader3 || cv == self.collEventTimeHeader4 || cv == self.collEventTimeHeader5)
         {
            [cv registerNib:[UINib nibWithNibName:@"CellAllTimes" bundle:nil] forCellWithReuseIdentifier:@"CellAllTimes"];
            cv.userInteractionEnabled=NO;
            CellAllTimes *cell = (CellAllTimes*)[cv dequeueReusableCellWithReuseIdentifier:@"CellAllTimes" forIndexPath:indexPath];
            cell.lblTimes.text=[arrAllTime objectAtIndex:indexPath.item];
            cell.tag=indexPath.item;
            if(indexPath.item==0)
            {
                cell.lblsepartor.hidden=YES;
            }
            else
            {
                cell.lblsepartor.hidden=NO;
            }
            
            return cell;
        }
        else
        {
            CellHorizontalScroll *hsc =[cv dequeueReusableCellWithReuseIdentifier:@"CellHorizontalScroll"
                                                                     forIndexPath:indexPath];
//            if(hsc==nil)
//            {
//                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellHorizontalScroll" owner:self options:nil];
//                hsc = [nib objectAtIndex:0];
//            }
            for(UIView *vw in hsc.scroll.subviews)
            {
                [vw removeFromSuperview];
            }
            hsc.cellDelegate=self;
            if([cv.accessibilityValue isEqualToString:@"LOAD"])
            {
                timeSLotDic3=[NSMutableDictionary new];
                Loads *equi=[arrLoadList objectAtIndex:cv.tag];
                if(equi.matches.count > 0)
                {
                    NSDate *selecteddt=[GlobalFunction dateStringUTC:choosendate fromFormat:@"MM/dd/yy" toFormat:@"MM/dd/yy"];
                    for(Matches *objmatch in equi.matches)
                    {
                        NSMutableArray *arr=[NSMutableArray new];
                        NSDate *pickupdate=[GlobalFunction dateStringUTC:equi.pickupDate fromFormat:@"YYYY-MM-dd" toFormat:@"YYYY-MM-dd"];
                        NSDate *dlieverydate=[GlobalFunction dateStringUTC:equi.delieveryDate fromFormat:@"YYYY-MM-dd" toFormat:@"YYYY-MM-dd"];
                        if([self isDate:selecteddt inRangeFirstDate:pickupdate lastDate:dlieverydate])
                        {
                            NSString *sd=[NSString stringWithFormat:@"%@",[objmatch.officeName capitalizedString]];
                            if(pickupdate == selecteddt)
                            {
                                [arr addObject:[GlobalFunction calenderstringDate:equi.pickupTime fromFormat:@"hh:mm a" toFormat:@"HH:mm"]];
                            }
                            else
                            {
                                [arr addObject:@"1:00"];
                            }
                            if(dlieverydate==selecteddt)
                            {
                                [arr addObject:[GlobalFunction calenderstringDate:equi.deliveryTime fromFormat:@"hh:mm a" toFormat:@"HH:mm"]];
                            }
                            else
                            {
                                [arr addObject:@"24:59"];
                            }
                            [arr addObject:sd];
                            [arr addObject:equi.loadStatus];
                            [arr addObject:equi.pickupTime];
                            [arr addObject:equi.deliveryTime];
                            [arr addObject:[NSString stringWithFormat:@"%ld",(long)cv.tag]];
                            [timeSLotDic3 setValue:arr forKey:[NSString stringWithFormat:@"%@",objmatch.orderLoadid]];
                        }
                    }
                    [hsc setUpCellWithDIcLoad:timeSLotDic3 :equi];
                    [hsc.scroll setFrame:CGRectMake(hsc.scroll.frame.origin.x, hsc.scroll.frame.origin.y, hsc.frame.size.width,70)];
                    hsc.scroll.contentOffset= CGPointMake(self.collEventTimeHeader3.contentOffset.x,0.0);
                }
            }
            else if([cv.accessibilityValue isEqualToString:@"DRIVER"])
            {
                timeSLotDic2=[NSMutableDictionary new];
                MyNetwork *driverrs=[arrDriverList objectAtIndex:cv.tag];
                if(driverrs.matches.count >0)
                {
                    NSDate *selecteddt=[GlobalFunction dateStringUTC:choosendate fromFormat:@"MM/dd/yy" toFormat:@"MM/dd/yy"];
                    for(Matches *objmatch in driverrs.matches)
                    {
                        NSMutableArray *arr=[NSMutableArray new];
                        NSDate *pickupdate=[GlobalFunction dateStringUTC:objmatch.pickupDate fromFormat:@"YYYY-MM-dd" toFormat:@"YYYY-MM-dd"];
                        NSDate *dlieverydate=[GlobalFunction dateStringUTC:objmatch.delieveryDate fromFormat:@"YYYY-MM-dd" toFormat:@"YYYY-MM-dd"];
                        if([self isDate:selecteddt inRangeFirstDate:pickupdate lastDate:dlieverydate])
                        {
                            NSString *sd=[NSString stringWithFormat:@"%@-%@\n%@",objmatch.pickupStateCode,objmatch.delievryStateCode,[objmatch.officeName capitalizedString]];
                            if(pickupdate == selecteddt)
                            {
                                [arr addObject:[GlobalFunction calenderstringDate:objmatch.pickupTime fromFormat:@"hh:mm a" toFormat:@"HH:mm"]];
                            }
                            else
                            {
                                [arr addObject:@"1:00"];
                            }
                            if(dlieverydate==selecteddt)
                            {
                                [arr addObject:[GlobalFunction calenderstringDate:objmatch.deliveryTime fromFormat:@"hh:mm a" toFormat:@"HH:mm"]];
                            }
                            else
                            {
                                [arr addObject:@"24:59"];
                            }
                            [arr addObject:sd];
                            [arr addObject:@"1"];
                            [arr addObject:objmatch.pickupTime];
                            [arr addObject:objmatch.deliveryTime];
                            [arr addObject:[NSString stringWithFormat:@"%ld",(long)cv.tag]];
                            [timeSLotDic2 setValue:arr forKey:[NSString stringWithFormat:@"%@",objmatch.orderLoadid]];
                        }
                    }
                    [hsc setUpCellWithDIcDriver:timeSLotDic2 :driverrs];
                }
                [hsc.scroll setFrame:CGRectMake(hsc.scroll.frame.origin.x, hsc.scroll.frame.origin.y, hsc.frame.size.width, 70 )];
                hsc.scroll.contentOffset= CGPointMake(self.collEventTimeHeader2.contentOffset.x,0.0);
            }
            else
            {
                Equipments *equi;
                timeSLotDic=[NSMutableDictionary new];
                
                if([cv.accessibilityValue isEqualToString:@"TRUCK"])
                {
                    equi=[arrTrailerList objectAtIndex:cv.tag];
                    hsc.scroll.contentOffset= CGPointMake(self.collEventTimeHeader.contentOffset.x,0.0);
                }
                else if([cv.accessibilityValue isEqualToString:@"POWER"])
                {
                    equi=[arrPowerList objectAtIndex:cv.tag];
                    hsc.scroll.contentOffset= CGPointMake(self.collEventTimeHeader5.contentOffset.x,0.0);
                }
                else
                {
                    equi=[arrSupportList objectAtIndex:cv.tag];
                    hsc.scroll.contentOffset= CGPointMake(self.collEventTimeHeader4.contentOffset.x,0.0);
                }
               
                if(equi.matches.count >0)
                {
                    NSDate *selecteddt=[GlobalFunction dateStringUTC:choosendate fromFormat:@"MM/dd/yy" toFormat:@"MM/dd/yy"];
                    for(Matches *objmatch in equi.matches)
                    {
                        NSMutableArray *arr=[NSMutableArray new];
                        NSDate *pickupdate=[GlobalFunction dateStringUTC:objmatch.pickupDate fromFormat:@"YYYY-MM-dd" toFormat:@"YYYY-MM-dd"];
                        NSDate *dlieverydate=[GlobalFunction dateStringUTC:objmatch.delieveryDate fromFormat:@"YYYY-MM-dd" toFormat:@"YYYY-MM-dd"];
                        if([self isDate:selecteddt inRangeFirstDate:pickupdate lastDate:dlieverydate])
                        {
                            NSString *sd=[NSString stringWithFormat:@"%@-%@\n%@",objmatch.pickupStateCode,objmatch.delievryStateCode,[objmatch.officeName capitalizedString]];
                            if(pickupdate == selecteddt)
                            {
                                [arr addObject:[GlobalFunction calenderstringDate:objmatch.pickupTime fromFormat:@"hh:mm a" toFormat:@"HH:mm"]];
                            }
                            else
                            {
                                [arr addObject:@"1:00"];
                            }
                            if(dlieverydate==selecteddt)
                            {
                                [arr addObject:[GlobalFunction calenderstringDate:objmatch.deliveryTime fromFormat:@"hh:mm a" toFormat:@"HH:mm"]];
                            }
                            else
                            {
                                [arr addObject:@"24:59"];
                            }
                            [arr addObject:sd];
                            [arr addObject:@"1"];
                            [arr addObject:objmatch.pickupTime];
                            [arr addObject:objmatch.deliveryTime];
                            [arr addObject:[NSString stringWithFormat:@"%ld",(long)cv.tag]];
                            [timeSLotDic setValue:arr forKey:[NSString stringWithFormat:@"%@",objmatch.orderLoadid]];
                        }
                    }
                //    hsc.scroll.backgroundColor=[UIColor redColor];
                    [hsc setUpCellWithDIc:timeSLotDic :equi:cv.accessibilityValue];
                     [hsc.scroll setFrame:CGRectMake(hsc.scroll.frame.origin.x, hsc.scroll.frame.origin.y, hsc.frame.size.width, 70 )];
                }
            }
            return hsc;
        }      
    }
    @catch (NSException *exception)
    {
    }
}
- (BOOL)isDate:(NSDate *)date inRangeFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate
{
    return ([date compare:firstDate] == NSOrderedDescending &&
    [date compare:lastDate]  == NSOrderedAscending) || ([date compare:lastDate]  == NSOrderedSame || [date compare:firstDate]  == NSOrderedSame);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    @try
    {
        if (![scrollView isKindOfClass:[UICollectionView class]]) return;
        id view = [scrollView superview];
        while (view && [view isKindOfClass:[UITableView class]] == NO)
        {
            view = [view superview];
        }
        UITableView *tbl = (UITableView *)view;
        NSInteger rows;
        if(tbl==_tblListOfResources)
        {
            self.collEventTimeHeader.contentOffset = scrollView.contentOffset;
            
            rows = [self.tblListOfResources numberOfRowsInSection:0];
            CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
            if(translation.y > 0 || translation.y < 0)
            {
                
            }
            else
            {
                for (int row = 0; row < rows; row++)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                    CellCalenderEvent *cell =  (CellCalenderEvent *)[self.tblListOfResources cellForRowAtIndexPath:indexPath];
                    cell.collAllEvents.contentOffset = CGPointMake(scrollView.contentOffset.x, 0.0);
                }
            }
        }
        else if(tbl==_tblSupport )
        {
            self.collEventTimeHeader4.contentOffset=scrollView.contentOffset;
            rows =  [self.tblSupport numberOfRowsInSection:0];
            CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
            if(translation.y > 0 || translation.y < 0)
            {
            }
            else
            {
                for (int row = 0; row < rows; row++)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                    CellCalenderEvent *cell =  (CellCalenderEvent *)[self.tblSupport cellForRowAtIndexPath:indexPath];
                    cell.collAllEvents.contentOffset = CGPointMake(scrollView.contentOffset.x, 0.0);
                }
            }
        }
        else if(tbl==_tblPowerAsset )
        {
             self.collEventTimeHeader5.contentOffset=scrollView.contentOffset;
            rows =  [self.tblPowerAsset numberOfRowsInSection:0];
            CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
            if(translation.y > 0 || translation.y < 0)
            {
            }
            else
            {
                for (int row = 0; row < rows; row++)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                    CellCalenderEvent *cell =  (CellCalenderEvent *)[self.tblPowerAsset cellForRowAtIndexPath:indexPath];
                    cell.collAllEvents.contentOffset = CGPointMake(scrollView.contentOffset.x, 0.0);
                }
            }
        }
        else if(tbl==_tblListOfResources2 )
        {
             self.collEventTimeHeader2.contentOffset=scrollView.contentOffset;
            rows =  [self.tblListOfResources2 numberOfRowsInSection:0];
            CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
            if(translation.y > 0 || translation.y < 0)
            {
            }
            else
            {
                for (int row = 0; row < rows; row++)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                    CellCalenderEvent *cell =  (CellCalenderEvent *)[self.tblListOfResources2 cellForRowAtIndexPath:indexPath];
                    cell.collAllEvents.contentOffset = CGPointMake(scrollView.contentOffset.x, 0.0);
                }
            }
        }
        else if(tbl==_tblLoadCalender )
        {
             self.collEventTimeHeader3.contentOffset=scrollView.contentOffset;
            rows =  [self.tblLoadCalender numberOfRowsInSection:0];
            CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
            if(translation.y > 0 || translation.y < 0)
            {
            }
            else
            {
                for (int row = 0; row < rows; row++)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                    CellCalenderEvent *cell =  (CellCalenderEvent *)[self.tblLoadCalender cellForRowAtIndexPath:indexPath];
                    cell.collAllEvents.contentOffset = CGPointMake(scrollView.contentOffset.x, 0.0);
                }
            }
        }
//        CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
//        if(translation.y > 0 || translation.y < 0)
//        {
//        }
//        else
//        {
//            for (int row = 0; row < rows; row++)
//            {
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
//                CellCalenderEvent *cell =  (CellCalenderEvent *)[tbl cellForRowAtIndexPath:indexPath];
//                cell.collAllEvents.contentOffset = CGPointMake(scrollView.contentOffset.x, 0.0);
//            }
//        }
    } @catch (NSException *exception) {
        
    }
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        
    }
    @catch (NSException *exception) {
    }
}
#pragma mark- schedule delaget
- (IBAction)btnscheduledclicked:(id)sender
{
    
    @try
    {
        UIButton *btn=(UIButton*)sender;
        Equipments *equi=[arrTruckDispatchList objectAtIndex:[btn tag]];
        NSDictionary *dicLink=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_OrderFromId:equi.orderFromId,
                                Req_OrderToId:equi.orderToId,
                                Req_LoadId:equi.loadId,
                                Req_EquiId:equi.equiId,
                                Req_OrderType:@"3",
                                Req_identifier:equi.orderid,
                                Req_isLoadLink:@"0"}; 
        [self updateStatusValue:dicLink];
    } 
    @catch (NSException *exception) 
    {
        
    } 
}
- (IBAction)btnAlternateEquiclicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    Equipments *equi=[arrTruckDispatchList objectAtIndex:[btn tag]];
    if(equi.matches.count > 0)
    {
        Matches *objmatch=[equi.matches objectAtIndex:[equi.accessibilityLabel intValue]];
        AlernateEquimentListVC *objEquiList=initVCToRedirect(SBAFTERSIGNUP, ALERNATEQUIPMENTVC);
        objEquiList.chooseneid=equi.internalBaseClassIdentifier;
        objEquiList.pickuptime=objmatch.pickupTime;
        objEquiList.delieverytime=objmatch.deliveryTime;
        objEquiList.loadid=objmatch.matchesIdentifier;
        objEquiList.distnceval=objmatch.distance;
        objEquiList.pickstatecode=objmatch.pickupStateCode;
        objEquiList.delieverystatecode=objmatch.delievryStateCode;
        objEquiList.ordertoid=equi.orderToId;
        objEquiList.orderfromid=equi.orderFromId;
        objEquiList.orderid=equi.orderid;
        objEquiList.equiid=equi.internalBaseClassIdentifier;
        objEquiList.delieverystatecode=objmatch.delievryStateCode;
        objEquiList.alernateEquimentListVCProtocol=self;
        [self.navigationController pushViewController:objEquiList animated:YES];
    }
    
//    [AZNotification showNotificationWithTitle:@"In progress" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
}
- (IBAction)btnDriverScheduleclicked:(id)sender
{
    
    @try 
    {
        UIButton *btn=(UIButton*)sender;
          int btnhint=[btn.accessibilityLabel intValue];
        NSDictionary *dicLink;
        if([btn.accessibilityValue isEqualToString:@"CELLDRIVER"])
        {
          
            Loads *equi=[arrDriverDispatchList objectAtIndex:[btn tag]];
            Matches *match=[equi.matches objectAtIndex:btnhint];
            dicLink=@{
                                    Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                    Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                    Req_identifier:equi.orderId,
                                    Req_driver_id:match.driverId,
                                    Req_OrderFromId:equi.orderFromId,
                                    Req_OrderToId:equi.orderToId,
                                    Req_LoadId:equi.loadId,
                                    Req_EquiId:equi.equiId,
                                    Req_driver_user_id:match.userId,
                                    }; 
            if([[NetworkAvailability instance]isReachable])
            {
                [[WebServiceConnector alloc]
                 init:URLScheduleDriver
                 withParameters:dicLink
                 withObject:self
                 withSelector:@selector(getschduleddriverResponse:)
                 forServiceType:@"JSON"
                 showDisplayMsg:@"Scheduling Driver"
                 showProgress:YES];
            }
            else
            {
                [self dismissHUD];
                [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
            }
        }
        else
        {
            Loads *equi;
            Matches *match;
            if([btn.accessibilityValue isEqualToString:@"CELLPOWER"])
            {
                equi=[arrPowerDispatchList objectAtIndex:[btn tag]];
                match=[equi.matches objectAtIndex:btnhint];
                dicLink=@{
                          Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                          Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                          Req_identifier:equi.orderId,
                          Req_OrderFromId:equi.orderFromId,
                          Req_OrderToId:equi.orderToId,
                          Req_LoadId:equi.loadId,
                          Req_EquiId:match.matchesIdentifier
                          }; 
                if([[NetworkAvailability instance]isReachable])
                {
                    [[WebServiceConnector alloc]
                     init:URLScheduleSubAsset
                     withParameters:dicLink
                     withObject:self
                     withSelector:@selector(getschduledSubAssetResponse:)
                     forServiceType:@"JSON"
                     showDisplayMsg:@"Scheduling Power Asset"
                     showProgress:YES];
                }
                else
                {
                    [self dismissHUD];
                    [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
                }
            }
            else
            {
               equi=[arrSupportDispatchList objectAtIndex:[btn tag]];
                match=[equi.matches objectAtIndex:btnhint];
                dicLink=@{
                          Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                          Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                          Req_identifier:equi.orderId,
                          Req_OrderFromId:equi.orderFromId,
                          Req_OrderToId:equi.orderToId,
                          Req_LoadId:equi.loadId,
                          Req_EquiId:match.matchesIdentifier
                          }; 
                if([[NetworkAvailability instance]isReachable])
                {
                    [[WebServiceConnector alloc]
                     init:URLScheduleSupportAsset
                     withParameters:dicLink
                     withObject:self
                     withSelector:@selector(getschduledSupportAssetResponse:)
                     forServiceType:@"JSON"
                     showDisplayMsg:@"Scheduling Support Asset"
                     showProgress:YES];
                }
                else
                {
                    [self dismissHUD];
                    [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
                }
            }
     }
        
    } @catch (NSException *exception) {
        
    } 
}
-(IBAction)getschduledSupportAssetResponse:(id)sender
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
            [self getAllEvent];
            [self fetchSupportAssetDispatch:YES];
            [self fetchSupportCalender:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(IBAction)getschduledSubAssetResponse:(id)sender
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
            [self getAllEvent];
            [self fetchSubAssetDispatch:YES];
            [self fetchPowerCalender:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(IBAction)getschduleddriverResponse:(id)sender
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
            [self getAllEvent];
            [self fetchDriverCalender:YES];
            [self fetchDriverDispatch:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}

#pragma mark - truck dispatch section tapped
- (IBAction)btnSectionOpenClicked:(id)sender
{
    @try 
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:[sender tag]];
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
//        if(arrTruckDispatchList.count<=3)
//        {
//            if(collapsed==NO)
//            {
//                CGFloat height = 70;
//                height *= arrTruckDispatchList.count;
//                if(height<350)
//                {
//                    self.hrightTbl2.constant=height+70;
//                    self.heightVwList1.constant=self.hrightTbl2.constant+45;
//                }
//                else
//                {
//                    self.hrightTbl2.constant=350;
//                    self.heightVwList1.constant=395;
//                }
//                if(truckdispatchlimit1<truckdispatchTotalRecord)
//                {
//                    self.heighvwloadmore2.constant=45;
//                }
//                else
//                {
//                    self.heighvwloadmore2.constant=0;
//                }
//                
//                self.vwNodataFound2.hidden=YES;
//                [self.view layoutIfNeeded];
//            }
//            else
//            {
//                CGFloat height = 70;
//                height *= arrTruckDispatchList.count;
//                if(height<350)
//                {
//                    self.hrightTbl2.constant=height;
//                    self.heightVwList1.constant=self.hrightTbl2.constant+45;
//                }
//                else
//                {
//                    self.hrightTbl2.constant=350;
//                    self.heightVwList1.constant=395;
//                }
//                if(truckdispatchlimit1<truckdispatchTotalRecord)
//                {
//                    self.heighvwloadmore2.constant=45;
//                }
//                else
//                {
//                    self.heighvwloadmore2.constant=0;
//                }
//                self.vwNodataFound2.hidden=YES;
//                [self.view layoutIfNeeded];
//            }
//        }
        collapsed       = !collapsed;
        [arrayForBool enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(idx==indexPath.section)
            {
                [arrayForBool replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:collapsed]];
            }
            else
            {
                [arrayForBool replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:NO]];
            }
        }];
//        [_scrollMain setContentSize:(CGSizeMake(CGRectGetWidth(_scrollMain.frame),self.heightVwCalender0.constant+ self.heightVwList1.constant +self.heightVwList2.constant+ self.heightVwCalender1.constant+ self.heightVwCalende2.constant))];
     [_tblLinkedList reloadData];
    }
    @catch (NSException *exception) {
        
    } 
}

#pragma mark - Driver dispatch section Tapped
- (IBAction)btnSectionTapped:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:[btn tag]];
   
    if([btn.accessibilityValue isEqualToString:@"LIST3"])
    {
       
         BOOL collapsed  = [[arrayForBoolPower objectAtIndex:[sender tag]] boolValue];
//        if(arrPowerDispatchList.count<=3)
//        {
//             Loads *objnetwork =[arrPowerDispatchList objectAtIndex:indexPath.section];
//            if(collapsed==NO)
//            {
//                CGFloat height = 70;
//                height *= (arrPowerDispatchList.count+objnetwork.matches.count);
//                if(height<350)
//                {
//                    self.heightTblPowerDispatch.constant=height+70;
//                    self.heightPowerDispatch.constant=self.heightTblPowerDispatch.constant+45;
//                }
//                else
//                {
//                    self.heightTblSupportDispatch.constant=350;
//                    self.heightSupportdispatch.constant=395;
//                }
//                if(subassetlimit1<totalSubAssets)
//                {
//                    self.heightPowerDispatchLoadmore.constant=45;
//                }
//                else
//                {
//                    self.heightPowerDispatchLoadmore.constant=0;
//                }
//                
//                self.vwnoPowerDispatch.hidden=YES;
//                [self.view layoutIfNeeded];
//            }
//            else
//            {
//                CGFloat height = 70;
//                height *= arrPowerDispatchList.count;
//                if(height<350)
//                {
//                    self.heightTblPowerDispatch.constant=height;
//                    self.heightPowerDispatch.constant=self.heightTblPowerDispatch.constant+45;
//                }
//                else
//                {
//                    self.heightTblPowerDispatch.constant=350;
//                    self.heightPowerDispatch.constant=395;
//                }
//                if(subassetlimit1<totalSubAssets)
//                {
//                    self.heightPowerDispatchLoadmore.constant=45;
//                }
//                else
//                {
//                    self.heightPowerDispatchLoadmore.constant=0;
//                }
//                self.vwnoPowerDispatch.hidden=YES;
//                [self.view layoutIfNeeded];
//            }
//        }
        
        collapsed       = !collapsed;
        [arrayForBoolPower enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(idx==indexPath.section)
            {
                [arrayForBoolPower replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:collapsed]];
            }
            else
            {
                [arrayForBoolPower replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:NO]];
            }
        }];
         [_tblPowerDispatch reloadData];
    }
    else if([btn.accessibilityValue isEqualToString:@"LIST4"])
    {
        
         BOOL collapsed  = [[arrayForBoolSupport objectAtIndex:[sender tag]] boolValue];
//        if(arrSupportDispatchList.count<=3)
//        {
//              Loads *objnetwork =[arrSupportDispatchList objectAtIndex:indexPath.section];
//            if(collapsed==NO)
//            {
//                CGFloat height = 70;
//                height *=( arrSupportDispatchList.count+objnetwork.matches.count);
//                if(height<350)
//                {
//                    self.heightTblSupportDispatch.constant=height+70;
//                    self.heightSupportdispatch.constant=self.heightTblSupportDispatch.constant+45;
//                }
//                else
//                {
//                    self.heightTblSupportDispatch.constant=350;
//                    self.heightSupportdispatch.constant=395;
//                }
//                if(subassetlimit1<totalSubAssets)
//                {
//                    self.heightsuportdispatchloadmore.constant=45;
//                }
//                else
//                {
//                    self.heightsuportdispatchloadmore.constant=0;
//                }
//                
//                self.vwNoSupportdispatch.hidden=YES;
//                [self.view layoutIfNeeded];
//            }
//            else
//            {
//                CGFloat height = 70;
//                height *= arrSupportDispatchList.count;
//                if(height<350)
//                {
//                    self.heightTblSupportDispatch.constant=height;
//                    self.heightSupportdispatch.constant=self.heightTblSupportDispatch.constant+45;
//                }
//                else
//                {
//                    self.heightTblSupportDispatch.constant=350;
//                    self.heightSupportdispatch.constant=395;
//                }
//                if(subassetlimit1<totalSubAssets)
//                {
//                    self.heightsuportdispatchloadmore.constant=45;
//                }
//                else
//                {
//                    self.heightsuportdispatchloadmore.constant=0;
//                }
//                self.vwNoSupportdispatch.hidden=YES;
//                [self.view layoutIfNeeded];
//            }
//        }
        
        collapsed       = !collapsed;
        [arrayForBoolSupport enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(idx==indexPath.section)
            {
                [arrayForBoolSupport replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:collapsed]];
            }
            else
            {
                [arrayForBoolSupport replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:NO]];
            }
        }];
         [_tblSupportDispatch reloadData];
    }
    else
    {
        BOOL collapsed  = [[arrayForBool2 objectAtIndex:[sender tag]] boolValue];

//        if(arrDriverDispatchList.count<=3)
//        {
//            if(collapsed==NO)
//            {
//                Loads *objnetwork =[arrDriverDispatchList objectAtIndex:indexPath.section];
//                CGFloat height = 70;
//                height *= (arrDriverDispatchList.count  + objnetwork.matches.count);
//                
//                if(height<350)
//                {
//                    self.heightTbl4.constant=height+70;
//                    self.heightVwList2.constant=self.heightTbl4.constant+45;
//                }
//                else
//                {
//                    self.heightTbl4.constant=350;
//                    self.heightVwList2.constant=395;
//                }
//                if(driverdispatchlimit1<driverdispatchtotalrecord)
//                {
//                    self.heighvwloadmore4.constant=45;
//                }
//                else
//                {
//                    self.heighvwloadmore4.constant=0;
//                }
//                
//                self.vwNodataFound4.hidden=YES;
//                [self.view layoutIfNeeded];
//            }
//            else
//            {
//                CGFloat height = 70;
//                height *= arrDriverDispatchList.count;
//                if(height<350)
//                {
//                    self.heightTbl4.constant=height;
//                    self.heightVwList2.constant=self.heightTbl4.constant+45;
//                }
//                else
//                {
//                    self.heightTbl4.constant=350;
//                    self.heightVwList2.constant=395;
//                }
//                if(driverdispatchlimit1<driverdispatchtotalrecord)
//                {
//                    self.heighvwloadmore4.constant=45;
//                }
//                else
//                {
//                    self.heighvwloadmore4.constant=0;
//                }
//                self.vwNodataFound4.hidden=YES;
//                [self.view layoutIfNeeded];
//            }
//        }
        
        collapsed       = !collapsed;
        [arrayForBool2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(idx==[sender tag])
            {
                [arrayForBool2 replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:collapsed]];
            }
            else
            {
                [arrayForBool2 replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:NO]];
            }
        }];
         [_tblLinkedList2 reloadData];
    }
    
    
//      [_scrollMain setContentSize:(CGSizeMake(CGRectGetWidth(_scrollMain.frame),self.heightVwCalender0.constant+ self.heightVwList1.constant +self.heightVwList2.constant+ self.heightVwCalender1.constant+ self.heightVwCalende2.constant + self.heightPowerDispatch.constant+self.heightPowerAsset.constant+self.heightSupportAsset.constant+self.heightSupportdispatch.constant))];
   
    
}

#pragma mark - evert in clender clicked
-(void)cellSelected_driver:(UITapGestureRecognizer *)recognizer
{
    UIView *selectedView = (UIView *)recognizer.view;
    NSString *tagval=[NSString stringWithFormat:@"%ld",(long)selectedView.tag];
    MyNetwork *driverrs=[arrDriverList objectAtIndex:[selectedView.accessibilityLabel intValue]];
    if(driverrs.matches.count >0)
    {
        for(Matches *objMatch in driverrs.matches)
        {
            if([objMatch.orderLoadid isEqualToString:tagval])
            {
                LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
                objLoadDetail.strRedirectFrom=@"CALENDERVC";
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
                objLoadDetail.matchorderid=objMatch.matchOrderId;
                objLoadDetail.equipmentid=driverrs.internalBaseClassIdentifier;
                objLoadDetail.matchId=objMatch.matchId;
                [self.navigationController pushViewController:objLoadDetail animated:YES];
            }
            break;
        }
    }
}
-(void)cellSelected_equi:(UITapGestureRecognizer *)recognizer
{
    UIView *selectedView = (UIView *)recognizer.view;
    Equipments *equi;
    if([recognizer.accessibilityLabel isEqualToString:@"TRUCK"])
    {
        equi=[arrTrailerList objectAtIndex:[selectedView.accessibilityLabel intValue]];
    }
    else if([recognizer.accessibilityLabel isEqualToString:@"POWER"])
    {
        equi=[arrPowerList objectAtIndex:[selectedView.accessibilityLabel intValue]];
    }
    else
    {
        equi=[arrSupportList objectAtIndex:[selectedView.accessibilityLabel intValue]];
    }
    NSString *tagval=[NSString stringWithFormat:@"%ld",(long)selectedView.tag];
    
    if(equi.matches.count >0)
    {
        for(Matches *objMatch in equi.matches)
        {
            if([objMatch.orderLoadid isEqualToString:tagval])
            {
                LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
                objLoadDetail.strRedirectFrom=@"CALENDERVC";
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
                objLoadDetail.equipname=equi.equiName;
                objLoadDetail.matchorderid=objMatch.matchOrderId;
                objLoadDetail.equipmentid=equi.internalBaseClassIdentifier;
                objLoadDetail.matchId=objMatch.matchId;
                [self.navigationController pushViewController:objLoadDetail animated:YES];
            }
            break;
        }
    }
}
-(void)cellSelected_load:(UITapGestureRecognizer *)recognizer
{
    UIView *selectedView = (UIView *)recognizer.view;
    Loads *equi=[arrLoadList objectAtIndex:[selectedView.accessibilityLabel intValue]];
    LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
    objLoadDetail.strRedirectFrom=@"CALENDERVC";
    objLoadDetail.selectedLoad=equi;
    [self.navigationController pushViewController:objLoadDetail animated:YES];
}
#pragma mark - schedule truck
-(void)updateStatusValue:(NSDictionary *)dicLink
{
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLUpdateOrderStatus
         withParameters:dicLink
         withObject:self
         withSelector:@selector(getLinkedResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Scheduling Trailer"
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
            [self getAllEvent];
            [self fetchDateTruckCalender:YES];
            [self fetchDateTruckDispatch:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
#pragma mark - get All events
-(void)getAllEvent
{
   
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_YearNum:[NSString stringWithFormat:@"%ld",(long)year],
                                Req_OrderType:@"3"
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetScheduledDatesAccordingToYear
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getAllEventResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled Dates"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getAllEventResponse:(id)sender
{
    @try 
    {
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                _eventsByDate = [NSMutableDictionary new];
                for(Orders *od in [sender responseArray])
                {
                    NSDate *startDate = [GlobalFunction dateStringUTC:od.pickupDate fromFormat:@"YYYY-MM-dd" toFormat:@"YYYY-MM-dd HH:mm:ss"];
                    NSDate *endDate = [GlobalFunction dateStringUTC:od.delieveryDate fromFormat:@"YYYY-MM-dd" toFormat:@"YYYY-MM-dd HH:mm:ss"];
                                    
                    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                    NSDateComponents *components1= [gregorianCalendar components:NSDayCalendarUnit
                                                                        fromDate:startDate
                                                                          toDate:endDate
                                                                         options:0];
                    
                    for (int i =0; i <= components1.day; i++)
                    {
                        NSDateComponents *newComponents = [NSDateComponents new];
                        newComponents.day = i;
                        
                        NSDate *date = [gregorianCalendar dateByAddingComponents:newComponents 
                                                                          toDate:startDate 
                                                                         options:0];
                        NSString *key = [[self dateFormatter] stringFromDate:date];
                        if(!_eventsByDate[key])
                        {
                            _eventsByDate[key] = [NSMutableArray new];
                        }
                        [_eventsByDate[key] addObject:date];
                        
                    }
                }
                [self.calendarManager reload];
            }
        }
    } @catch (NSException *exception) {
        
    } 
    
}

#pragma  mark - truck calender
-(void)fetchTruckCalender_loadmore
{
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] ,
                                Req_FromIndex:[NSString stringWithFormat:@"%d",limit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",limit2],
                                Req_OrderType:@"3"
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllAssetsSheduledByMonth
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getTruckCalenderResponseLoadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled Details"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

-(IBAction)getTruckCalenderResponseLoadmore:(id)sender
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
            
            for (Equipments *equi in [sender responseArray])
            {
                [arrTrailerList addObject:equi];
            }
            limit1=limit1+limit2;
            limit2=constLimit;
//            arrPowerList=[NSMutableArray new];
//            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"assetTypeId == '1'"];
//            arrPowerList=[[arrTruckList filteredArrayUsingPredicate:bPredicate] mutableCopy];
//            arrTrailerList=[NSMutableArray new];
//            NSPredicate *bPredicate1 = [NSPredicate predicateWithFormat:@"assetTypeId == '2'"];
//            arrTrailerList=[[arrTruckList filteredArrayUsingPredicate:bPredicate1] mutableCopy];
//            arrSupportList=[NSMutableArray new];
//            NSPredicate *bPredicate2 = [NSPredicate predicateWithFormat:@"assetTypeId == '3'"];
//            arrSupportList=[[arrTruckList filteredArrayUsingPredicate:bPredicate2] mutableCopy];
            [self.tblListOfResources reloadData];
//            [self.tblSupport reloadData];
//            [self.tblPowerAsset reloadData];   
        }
        else
        {
            if([APIResponseMessage isEqualToString:@"No Schedule found !!!"])
            {
                limit1=totalRecords;
                 [self manageTrucksConstants];
            }
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
       
    }
}
-(void)fetchDateTruckCalender:(BOOL)showloader
{
    limit1=0;
    limit2=constLimit;
    if(showloader)
    {
        [self.tblListOfResources setLoaderWithStringAccordingframe:@"Fetching Schedules":_vwCalander1.frame];
    }
    else
    {
        self.tblListOfResources.backgroundView=nil;
    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_FromIndex:[NSString stringWithFormat:@"%d",limit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",limit2],
                                Req_OrderType:@"3"
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllAssetsSheduledByMonth
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getTruckCalenderResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled details"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getTruckCalenderResponse:(id)sender
{
    @try {
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                totalRecords=[APITotalRecord intValue];
                arrTrailerList=[NSMutableArray new];
                for (Equipments *equi in [sender responseArray])
                {
                    [arrTrailerList  addObject:equi];
                } 
                limit1=limit1+limit2;
                limit2=constLimit;
//                arrPowerList=[NSMutableArray new];
//                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"assetTypeId == '1'"];
//                arrPowerList=[[arrTruckList filteredArrayUsingPredicate:bPredicate] mutableCopy];
//                arrTrailerList=[NSMutableArray new];
//                NSPredicate *bPredicate1 = [NSPredicate predicateWithFormat:@"assetTypeId == '2'"];
//                arrTrailerList=[[arrTruckList filteredArrayUsingPredicate:bPredicate1] mutableCopy];
//                arrSupportList=[NSMutableArray new];
//                NSPredicate *bPredicate2 = [NSPredicate predicateWithFormat:@"assetTypeId == '3'"];
//                arrSupportList=[[arrTruckList filteredArrayUsingPredicate:bPredicate2] mutableCopy];
            }
            else
            {
                
            }
            self.tblListOfResources.backgroundView=nil;
            [self.tblListOfResources reloadData];

        }
    } @catch (NSException *exception) {
        
    } 
}
#pragma  mark - load calender
-(void)fetchLoadCalender_loadmore
{
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] ,
                                Req_FromIndex:[NSString stringWithFormat:@"%d",loadlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",loadlimit2],
                                Req_OrderType:@"3"
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllLoadsSheduledByMonth
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getLoadCalenderResponseLoadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled Details"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getLoadCalenderResponseLoadmore:(id)sender
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
            
            for (Loads *equi in [sender responseArray])
            {
                [arrLoadList addObject:equi];
            }
            loadlimit1=loadlimit1+loadlimit2;
            loadlimit2=constLimit;
         
            [self.tblLoadCalender reloadData];
            [self manageLoadConstants];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
    }
}

-(void)fetchLoadCalender:(BOOL)showloader
{
    loadlimit1=0;
    loadlimit2=constLimit;
    if(showloader)
    {
        [self.tblLoadCalender setLoaderWithStringAccordingframe:@"Fetching Schedules":_vwCalander1.frame];
    }
    else
    {
        self.tblLoadCalender.backgroundView=nil;
    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                  Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_FromIndex:[NSString stringWithFormat:@"%d",loadlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",loadlimit2],
                                Req_OrderType:@"3"
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllLoadsSheduledByMonth
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getLoadCalenderResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled details"
         showProgress:showloader];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getLoadCalenderResponse:(id)sender
{
    @try {
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                totalLoadrecord=[APITotalRecord intValue];
                arrLoadList=[NSMutableArray new];
                for (Equipments *equi in [sender responseArray])
                {
                    [arrLoadList addObject:equi];
                } 
                loadlimit1=loadlimit1+loadlimit2;
                loadlimit2=constLimit;
            }
            else
            {
                
            }
            self.tblLoadCalender.backgroundView=nil;
            [self.tblLoadCalender reloadData];
        }
    } @catch (NSException *exception) {
        
    } 
}
#pragma mark - power calender
-(void)fetchPowerCalender_loadmore
{
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] ,
                                Req_FromIndex:[NSString stringWithFormat:@"%d",powerlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",powerlimit2],
                                Req_OrderType:@"3"
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetPoweredAssetsCalender
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getPowerCalenderResponseLoadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled Details"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getPowerCalenderResponseLoadmore:(id)sender
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
            
            for (Equipments *equi in [sender responseArray])
            {
                [arrPowerList addObject:equi];
            }
            powerlimit1=powerlimit1+powerlimit2;
            powerlimit2=constLimit;
            [self.tblPowerAsset reloadData];   
        }
        else
        {
            if([APIResponseMessage isEqualToString:@"No Schedule found !!!"])
            {
                powerlimit1=totalPower;
                [self managePowerConstants];
            }
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
        
    }
}
-(void)fetchPowerCalender:(BOOL)showloader
{
    powerlimit1=0;
    powerlimit2=constLimit;
    if(showloader)
    {
        [self.tblPowerAsset setLoaderWithStringAccordingframe:@"Fetching Schedules":_vwpowerAsset.frame];
    }
    else
    {
        self.tblPowerAsset.backgroundView=nil;
    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_FromIndex:[NSString stringWithFormat:@"%d",powerlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",powerlimit2],
                                Req_OrderType:@"3"
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetPoweredAssetsCalender
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getPowerCalenderResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled details"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getPowerCalenderResponse:(id)sender
{
    @try {
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                totalPower=[APITotalRecord intValue];
                arrPowerList=[NSMutableArray new];
                for (Equipments *equi in [sender responseArray])
                {
                    [arrPowerList addObject:equi];
                } 
                powerlimit1=powerlimit1+powerlimit2;
                powerlimit2=constLimit;
            }
            else
            {
                
            }
            self.tblPowerAsset.backgroundView=nil;
            [self.tblPowerAsset reloadData];
            
        }
    } @catch (NSException *exception) {
        
    } 
}
#pragma mark - support calender
-(void)fetchSupportCalender_loadmore
{
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] ,
                                Req_FromIndex:[NSString stringWithFormat:@"%d",supportlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",supportlimit2],
                                Req_OrderType:@"3"
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetSupportAssetsCalender
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getSupportCalenderResponseLoadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled Details"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getSupportCalenderResponseLoadmore:(id)sender
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
            
            for (Equipments *equi in [sender responseArray])
            {
                [arrSupportList addObject:equi];
            }
            supportlimit1=supportlimit1+supportlimit2;
            supportlimit2=constLimit;
            [self.tblSupport reloadData];   
        }
        else
        {
            if([APIResponseMessage isEqualToString:@"No Schedule found !!!"])
            {
                supportlimit1=totalsupport;
                [self manageSupportConstants];
            }
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
        
    }
}
-(void)fetchSupportCalender:(BOOL)showloader
{
    supportlimit1=0;
    supportlimit2=constLimit;
    if(showloader)
    {
        [self.tblSupport setLoaderWithStringAccordingframe:@"Fetching Schedules":_vwSupport.frame];
    }
    else
    {
        self.tblSupport.backgroundView=nil;
    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_FromIndex:[NSString stringWithFormat:@"%d",supportlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",supportlimit2],
                                Req_OrderType:@"3"
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetSupportAssetsCalender
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getSupportCalenderResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled details"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getSupportCalenderResponse:(id)sender
{
    @try {
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                totalsupport=[APITotalRecord intValue];
                arrSupportList=[NSMutableArray new];
                for (Equipments *equi in [sender responseArray])
                {
                    [arrSupportList addObject:equi];
                } 
                supportlimit1=supportlimit1+supportlimit2;
                supportlimit2=constLimit;
            }
            else
            {
                
            }
            self.tblSupport.backgroundView=nil;
            [self.tblSupport reloadData];
            
        }
    } @catch (NSException *exception) {
        
    } 
}
#pragma mark - truck dispatch caleneder
-(void)fetchDateTruckDispatch:(BOOL)showloader
{
    return;    
        truckdispatchlimit1=0;
        truckdispatchlimit2=constLimit;
        if(showloader)
        {
            [self.tblLinkedList setLoaderWithStringAccordingframe:@"Fetching Linked Assets":_tblLinkedList.frame];
        }
        else
        {
            self.tblLinkedList.backgroundView=nil;
        }
        ShowNetworkIndicator(YES);
        NSDictionary *dicAllLoads=@{
                                    Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                    Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                    Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                    Req_FromIndex:[NSString stringWithFormat:@"%d",truckdispatchlimit1],
                                    Req_ToIndex:[NSString stringWithFormat:@"%d",truckdispatchlimit2],
                                    Req_OrderType:@"2"
                                    };    
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLGetAllLinkedAssetList
             withParameters:dicAllLoads
             withObject:self
             withSelector:@selector(getTruckDispatchResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Fetching Linked Assets"
             showProgress:showloader];
        }
        else
        {
            [self dismissHUD];
            self.tblLinkedList.backgroundView=nil;
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
}
-(IBAction)getTruckDispatchResponse:(id)sender
{
    @try {

    [self dismissHUD];
    ShowNetworkIndicator(NO);
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
    }
    else
    {
          arrTruckDispatchList=[NSMutableArray new];
        if([APIResponseStatus isEqualToString:APISuccess])
        {
          
            for (Equipments *equi in [sender responseArray])
            {
                [arrTruckDispatchList addObject:equi];
            }
            truckdispatchTotalRecord=[APITotalRecord intValue];
            if(arrTruckDispatchList.count == 0)
            {
                self.vwNodataFound2.hidden=NO;
                self.heightVwList2.constant=395;
                self.heighvwloadmore1.constant=0;
             [_scrollMain setContentSize:(CGSizeMake(CGRectGetWidth(_scrollMain.frame),self.heightVwCalender0.constant+ self.heightVwList1.constant +self.heightVwList2.constant+ self.heightVwCalender1.constant+ self.heightVwCalende2.constant + self.heightPowerDispatch.constant+self.heightPowerAsset.constant+self.heightSupportAsset.constant+self.heightSupportdispatch.constant))];
            }
            else
            {
                truckdispatchlimit1=truckdispatchlimit1+truckdispatchlimit2;
                truckdispatchlimit2=constLimit;
                arrayForBool=[NSMutableArray new];
                for (int i = 0; i < arrTruckDispatchList.count; i++) 
                {
                    [arrayForBool addObject:[NSNumber numberWithBool:NO]];
                }
            }
        }
        else
        {                                  
        }
        self.tblLinkedList.backgroundView=nil;
        [self.tblLinkedList reloadData];
    }
    } @catch (NSException *exception) {
        
    } 
}
-(void)fetchDateTruckDispatch_loadmore
{
       return;    
        ShowNetworkIndicator(YES);
        NSDictionary *dicAllLoads=@{
                                    Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                    Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                    Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                    Req_FromIndex:[NSString stringWithFormat:@"%d",truckdispatchlimit1],
                                    Req_ToIndex:[NSString stringWithFormat:@"%d",truckdispatchlimit2],
                                    Req_OrderType:@"2"
                                    };    
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLGetAllLinkedAssetList
             withParameters:dicAllLoads
             withObject:self
             withSelector:@selector(getTruckDispatchResponseloadmore:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Fetching Linked Assets"
             showProgress:NO];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
}
-(IBAction)getTruckDispatchResponseloadmore:(id)sender
{
    @try
    {
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                for (Equipments *equi in [sender responseArray])
                {
                    [arrTruckDispatchList addObject:equi];
                }
                truckdispatchlimit1=truckdispatchlimit1+truckdispatchlimit2;
                truckdispatchlimit2=constLimit;
                for (int i = 0; i < arrTruckDispatchList.count; i++) 
                {
                    [arrayForBool addObject:[NSNumber numberWithBool:NO]];
                }
            }
            else
            {
                self.heighvwloadmore2.constant=0;
                [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
            self.tblLinkedList.backgroundView=nil;
            [self.tblLinkedList reloadData];
        }

    } @catch (NSException *exception) {
        
    } 
}
#pragma  mark - driver calender
-(void)fetchDriverCalender_loadmore
{
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] ,
                                Req_FromIndex:[NSString stringWithFormat:@"%d",driverlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",driverlimit2],
                                Req_OrderType:@"3",
                                Req_DotNumber:objuserAccount.dotNumber,
                                Req_CmpnyPhoneNo:objuserAccount.cmpnyPhoneNo
                                
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetDriversByCompany
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getDriverCalenderResponseLoadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled Drivers"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        self.tblListOfResources2.backgroundView=nil;
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getDriverCalenderResponseLoadmore:(id)sender
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
            
            for (MyNetwork *equi in [sender responseArray])
            {
                [arrDriverList addObject:equi];
            }
            driverlimit1=driverlimit1+driverlimit2;
            driverlimit2=constLimit;
            [self.tblListOfResources2 reloadData];
            [self manageDriverConstants];

        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
    }
}
-(void)fetchDriverCalender:(BOOL)showloader
{
    driverlimit1=0;
    driverlimit2=constLimit;
    if(showloader)
    {
        [self.tblListOfResources2 setLoaderWithStringAccordingframe:@"Fetching Schedules":self.tblListOfResources2.frame];
    }
    else
    {
        self.tblListOfResources2.backgroundView=nil;
    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_FromIndex:[NSString stringWithFormat:@"%d",driverlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",driverlimit2],
                                Req_OrderType:@"3",
                                Req_DotNumber:objuserAccount.dotNumber,
                                Req_CmpnyPhoneNo:objuserAccount.cmpnyPhoneNo
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetDriversByCompany
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getDriverCalenderResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Scheduled details"
         showProgress:showloader];
    }
    else
    {
        [self dismissHUD];
          self.tblListOfResources2.backgroundView=nil;
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getDriverCalenderResponse:(id)sender
{
    [self dismissHUD];
    ShowNetworkIndicator(NO);
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            arrDriverList=[NSMutableArray new];
            for (MyNetwork *equi in [sender responseArray])
            {
                [arrDriverList addObject:equi];
            }
            drivertotalrecord=[APITotalRecord intValue];
            driverlimit1=driverlimit1+driverlimit2;
            driverlimit2=constLimit;
        }
        else
        {
          
        }
        self.tblListOfResources2.backgroundView=nil;
        [self.tblListOfResources2 reloadData];
    }
}
#pragma mark - driver dispatch caleneder
-(void)fetchDriverDispatch:(BOOL)showloader
{
   return;    
        driverdispatchlimit1=0;
        driverdispatchlimit2=constLimit;
        if(showloader)
        {
            [self.tblLinkedList2 setLoaderWithStringAccordingframe:@"Fetching Available Drivers":self.tblLinkedList2.frame];
        }
        else
        {
            self.tblLinkedList2.backgroundView=nil;
        }
        ShowNetworkIndicator(YES);
        NSDictionary *dicAllLoads=@{
                                    Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                    Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                    Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                    Req_OrderType:@"2",
                                    Req_FromIndex:[NSString stringWithFormat:@"%d",driverdispatchlimit1],
                                    Req_ToIndex:[NSString stringWithFormat:@"%d",driverdispatchlimit2],
                                    Req_DotNumber:objuserAccount.dotNumber,
                                    Req_CmpnyPhoneNo:objuserAccount.cmpnyPhoneNo
                                    };    
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLGetAllLinkedLoadList
             withParameters:dicAllLoads
             withObject:self
             withSelector:@selector(getDriverDispatchResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Fetching Available Drivers"
             showProgress:showloader];
        }
        else
        {
            [self dismissHUD];
            self.tblLinkedList2.backgroundView=nil;
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
}
-(IBAction)getDriverDispatchResponse:(id)sender
{
    @try {
        
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            arrDriverDispatchList=[NSMutableArray new];
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                for (Loads *equi in [sender responseArray])
                {
                    [arrDriverDispatchList addObject:equi];
                }
                driverdispatchtotalrecord=[APITotalRecord intValue];
                
                if(arrDriverDispatchList.count == 0)
                {
                    self.tblLinkedList2.backgroundView=nil;
                    self.vwNodataFound4.hidden=NO;
                    self.heightVwList2.constant=395;
                    self.heighvwloadmore4.constant=0;
                   [_scrollMain setContentSize:(CGSizeMake(CGRectGetWidth(_scrollMain.frame),self.heightVwCalender0.constant+ self.heightVwList1.constant +self.heightVwList2.constant+ self.heightVwCalender1.constant+ self.heightVwCalende2.constant + self.heightPowerDispatch.constant+self.heightPowerAsset.constant+self.heightSupportAsset.constant+self.heightSupportdispatch.constant))];
                }
                else
                {
                    arrayForBool2=[NSMutableArray new];
                    for (int i = 0; i < arrDriverDispatchList.count; i++) 
                    {
                        [arrayForBool2 addObject:[NSNumber numberWithBool:NO]];
                    }
                    driverdispatchlimit1=driverdispatchlimit1+driverdispatchlimit2;
                    driverdispatchlimit2=constLimit;
                }
            }
            else
            {
            }
            self.tblLinkedList2.backgroundView=nil;
            [self.tblLinkedList2 reloadData];
        }
    } @catch (NSException *exception) {
        
    } 
}
-(void)fetchDriverDispatch_loadmore
{
     return;    
    ShowNetworkIndicator(YES);
    
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_OrderType:@"2",
                                Req_FromIndex:[NSString stringWithFormat:@"%d",driverdispatchlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",driverdispatchlimit2],
                                Req_DotNumber:objuserAccount.dotNumber,
                                Req_CmpnyPhoneNo:objuserAccount.cmpnyPhoneNo
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllLinkedLoadList
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getDriverDispatchResponseloadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Available Drivers"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        self.tblLinkedList2.backgroundView=nil;
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getDriverDispatchResponseloadmore:(id)sender
{
    @try
    {
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                for (Loads *equi in [sender responseArray])
                {
                    [arrDriverDispatchList addObject:equi];
                }
                driverdispatchlimit1=driverdispatchlimit1+driverdispatchlimit2;
                driverdispatchlimit2=constLimit;
                for (int i = 0; i < arrDriverDispatchList.count; i++) 
                {
                    [arrayForBool2 addObject:[NSNumber numberWithBool:NO]];
                }
                self.vwNodataFound4.hidden=YES;
                [self.tblLinkedList2 reloadData];
            }
            else
            {
               
                self.tblLinkedList2.backgroundView=nil;
                [self.tblLinkedList2 reloadData];
                self.heighvwloadmore4.constant=0;
                [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }
        
    } @catch (NSException *exception) {
        
    } 
}

#pragma mark - SubAsset dispatch caleneder
-(void)fetchSubAssetDispatch:(BOOL)showloader
{
     return;    
    subassetlimit1=0;
    subassetlimit2=constLimit;
    if(showloader)
    {
        [self.tblPowerDispatch setLoaderWithStringAccordingframe:@"Fetching Available Assets":self.tblLinkedList2.frame];
    
    }
    else
    {
        self.tblPowerDispatch.backgroundView=nil;
   
    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_OrderType:@"2",
                                Req_FromIndex:[NSString stringWithFormat:@"%d",subassetlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",subassetlimit2],
                                Req_DotNumber:objuserAccount.dotNumber,
                                Req_CmpnyPhoneNo:objuserAccount.cmpnyPhoneNo
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllLinkedLoadForSubAssets
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getSubAssetDispatchResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Available Assets"
         showProgress:showloader];
    }
    else
    {
        [self dismissHUD];
        self.tblPowerDispatch.backgroundView=nil;
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getSubAssetDispatchResponse:(id)sender
{
    @try {
        
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            arrPowerDispatchList=[NSMutableArray new];
            arrayForBoolPower=[NSMutableArray new];
            arrSubAssetList=[NSMutableArray new];
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                
                for (Loads *equi in [sender responseArray])
                {
                    [arrSubAssetList addObject:equi];
                }
               
                totalSubAssets=[APITotalRecord intValue];
                for(Loads *objload in arrSubAssetList )
                {
                    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"assetTypeId == '1'"];
                    NSArray *objarr=objload.matches;
                    NSMutableArray *filter=[[objarr filteredArrayUsingPredicate:bPredicate] mutableCopy];
                    if(filter.count >0)
                    {
                        objload.matches=filter;
                        [arrPowerDispatchList addObject:objload];
                    }
                }
                    for (int i = 0; i < arrPowerDispatchList.count; i++) 
                    {
                        [arrayForBoolPower addObject:[NSNumber numberWithBool:NO]];
                    }
                    subassetlimit1=subassetlimit1+subassetlimit2;
                    subassetlimit2=constLimit;
            }
            else
            {
                
            }
            self.tblPowerDispatch.backgroundView=nil;
            [self.tblPowerDispatch reloadData];
    }
    } @catch (NSException *exception) {
        
    } 
}
-(void)fetchSubAssetDispatch_loadmore
{ return;    
    ShowNetworkIndicator(YES);
    
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_OrderType:@"2",
                                Req_FromIndex:[NSString stringWithFormat:@"%d",subassetlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",subassetlimit2],
                                Req_DotNumber:objuserAccount.dotNumber,
                                Req_CmpnyPhoneNo:objuserAccount.cmpnyPhoneNo
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllLinkedLoadForSubAssets
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getSubAssetDispatchResponse_loadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Available Assets"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        self.tblPowerDispatch.backgroundView=nil;
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getSubAssetDispatchResponse_loadmore:(id)sender
{
    @try
    {
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                for (Loads *equi in [sender responseArray])
                {
                    [arrSubAssetList addObject:equi];
                }
                subassetlimit1=subassetlimit1+subassetlimit2;
                subassetlimit2=constLimit;
                arrPowerDispatchList=[NSMutableArray new];
                
                arrayForBoolPower=[NSMutableArray new];
                for(Loads *objload in arrSubAssetList )
                {
                    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"assetTypeId == '1'"];
                    NSArray *objarr=objload.matches;
                    NSMutableArray *filter=[[objarr filteredArrayUsingPredicate:bPredicate] mutableCopy];
                    if(filter.count >0)
                    {
                        objload.matches=filter;
                        [arrayForBoolPower addObject:[NSNumber numberWithBool:NO]];
                        [arrPowerDispatchList addObject:objload];
                    }
                }
                 [self.tblPowerDispatch reloadData];
            }
            else
            {
                self.tblPowerDispatch.backgroundView=nil;
                [self.tblPowerDispatch reloadData];
                self.heightPowerDispatchLoadmore.constant=0;
                [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }
        
    } @catch (NSException *exception) {
        
    } 
}

#pragma mark - Support Asset dispatch caleneder
-(void)fetchSupportAssetDispatch:(BOOL)showloader
{
     return;    
    supportassetlimit1=0;
    supportassetlimit2=constLimit;
    if(showloader)
    {
        [self.tblSupportDispatch setLoaderWithStringAccordingframe:@"Fetching Available Assets":self.tblLinkedList2.frame];
    }
    else
    {
        self.tblSupportDispatch.backgroundView=nil;
    }
    ShowNetworkIndicator(YES);
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_OrderType:@"2",
                                Req_FromIndex:[NSString stringWithFormat:@"%d",supportassetlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",supportassetlimit2],
                                Req_DotNumber:objuserAccount.dotNumber,
                                Req_CmpnyPhoneNo:objuserAccount.cmpnyPhoneNo
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllLinkedLoadListForSupportAsset
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getSupportAssetDispatchResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Available Assets"
         showProgress:showloader];
    }
    else
    {
        [self dismissHUD];
        self.tblSupportDispatch.backgroundView=nil;
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getSupportAssetDispatchResponse:(id)sender
{
    @try {
        
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            arrSupportDispatchList=[NSMutableArray new];
            arrayForBoolSupport=[NSMutableArray new];
            arrSupportAssetList=[NSMutableArray new];
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                
                for (Loads *equi in [sender responseArray])
                {
                    [arrSupportAssetList addObject:equi];
                }
                totalsupportasset=[APITotalRecord intValue];
                for(Loads *objload in arrSupportAssetList )
                {
                    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"assetTypeId == '3'"];
                    NSArray *objarr=objload.matches;
                    NSMutableArray *filter=[[objarr filteredArrayUsingPredicate:bPredicate] mutableCopy];
                    if(filter.count >0)
                    {
                        objload.matches=filter;
                        [arrSupportDispatchList addObject:objload];
                    }
                }
                for (int i = 0; i < arrSupportDispatchList.count; i++) 
                {
                    [arrayForBoolSupport addObject:[NSNumber numberWithBool:NO]];
                }
                supportassetlimit1=supportassetlimit1+supportassetlimit2;
                supportassetlimit2=constLimit;
            }
            else
            {
                
            }
            self.tblSupportDispatch.backgroundView=nil;
            [self.tblSupportDispatch reloadData];
        }
    } @catch (NSException *exception) {
        
    } 
}
-(void)fetchSupportAssetDispatch_loadmore
{
     return;    
    ShowNetworkIndicator(YES);
    
    NSDictionary *dicAllLoads=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_OrderType:@"2",
                                Req_FromIndex:[NSString stringWithFormat:@"%d",supportassetlimit1],
                                Req_ToIndex:[NSString stringWithFormat:@"%d",supportassetlimit2],
                                Req_DotNumber:objuserAccount.dotNumber,
                                Req_CmpnyPhoneNo:objuserAccount.cmpnyPhoneNo
                                };    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllLinkedLoadListForSupportAsset
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getSupportAssetDispatchResponse_loadmore:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Fetching Available Assets"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        self.tblSupportDispatch.backgroundView=nil;
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getSupportAssetDispatchResponse_loadmore:(id)sender
{
    @try
    {
        [self dismissHUD];
        ShowNetworkIndicator(NO);
        if ([sender serviceResponseCode] != 100)
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
        }
        else
        {
            if([APIResponseStatus isEqualToString:APISuccess])
            {
                for (Loads *equi in [sender responseArray])
                {
                    [arrSupportAssetList addObject:equi];
                }
                supportassetlimit1=supportassetlimit1+supportassetlimit2;
                supportassetlimit2=constLimit;
                arrSupportDispatchList=[NSMutableArray new];
                arrayForBoolSupport=[NSMutableArray new];
              
                for(Loads *objload in arrSupportAssetList )
                {
                    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"assetTypeId == '3'"];
                    NSArray *objarr=objload.matches;
                    NSMutableArray *filter=[[objarr filteredArrayUsingPredicate:bPredicate] mutableCopy];
                    if(filter.count >0)
                    {
                        objload.matches=filter;
                        [arrSupportDispatchList addObject:objload];
                    }
                }
                [self.tblSupportDispatch reloadData];
            }
            else
            {             
                self.tblSupportDispatch.backgroundView=nil;
                [self.tblSupportDispatch reloadData];
                self.heightsuportdispatchloadmore.constant=0;
                [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }
        
    } @catch (NSException *exception) {
        
    } 
}
#pragma mark - Expand collapse
-(void)manageDriverConstants
{
    if(arrDriverList.count==0)
    {
        self.vwNoDatafound3.hidden=NO;
        self.heighvwloadmore3.constant=0;
        self.tblListOfResources2.backgroundView=nil;
    }
    else
    {
        CGFloat height = 70;
        height *= arrDriverList.count;
        if(height<350)
        {
            self.heightTbl3.constant=height+30;
            self.heightVwCalende2.constant=self.heightTbl3.constant+45;
        }
        else
        {
            self.heightTbl3.constant=350;
            self.heightVwCalende2.constant=395;
        }
        if(driverlimit1<drivertotalrecord)
        {
            self.heighvwloadmore3.constant=45;
        }
        else
        {
            self.heighvwloadmore3.constant=0;
        }
        self.vwNoDatafound3.hidden=YES;
    }
}
-(void)manageLoadConstants
{
    if(arrLoadList.count==0)
    {
        self.vwNodatafound0.hidden=NO;
        self.heighvwloadmore0.constant=0;
        self.tblLoadCalender.backgroundView=nil;
    }
    else
    {
        CGFloat height = 70;
        height *= arrLoadList.count;
        if(height<350)
        {
            self.heightTbl0.constant=height+30;
            self.heightVwCalender0.constant=self.heightTbl0.constant+45;
        }
        else
        {
            if(![objuserAccount.role containsString:@"2"] && [objuserAccount.role containsString:@"3"])
            {
                self.heightVwCalender0.constant=SCREEN_HEIGHT-64-130;
                self.heightTbl0.constant=SCREEN_HEIGHT-64-130-45;
            }
            else
            {
                self.heightTbl0.constant=350;
                self.heightVwCalender0.constant=395;
            }
            
        }
        if(loadlimit1<totalLoadrecord)
        {
            self.heighvwloadmore0.constant=45;
        }
        else
        {
            self.heighvwloadmore0.constant=0;
        }
        self.vwNodatafound0.hidden=YES;
    }
}
-(void)managePowerConstants
{
    [self.btnPowerAsset setTitle:@"-" forState:UIControlStateNormal];
        if(arrPowerList.count==0)
    {
        self.vwnoPowerAsset.hidden=NO;
        self.heightPowerLoadmore.constant=0;
        self.tblPowerAsset.backgroundView=nil;
    }
    else
    {
        CGFloat height = 70;
        height *= arrPowerList.count;
        if(height<350)
        {
            self.heightTblPower.constant=height+30;
            self.heightPowerAsset.constant=self.heightTblPower.constant+45;
        }
        else
        {
            self.heightTblPower.constant=350;
            self.heightPowerAsset.constant=395;
        }
        if(limit1<totalRecords)
        {
            self.heightPowerLoadmore.constant=45;
        }
        else
        {
            self.heightPowerLoadmore.constant=0;
        }
        self.vwnoPowerAsset.hidden=YES;
    }
}
-(void)manageSupportConstants
{
    [self.btnSupport setTitle:@"-" forState:UIControlStateNormal];
    if(arrSupportList.count==0)
    {
        self.vwNoSupport.hidden=NO;
        self.heightSupportLoadmore.constant=0;
        self.tblSupport.backgroundView=nil;
    }
    else
    {
        CGFloat height = 70;
        height *= arrSupportList.count;
        if(height<350)
        {
            self.heightTblSupport.constant=height+30;
            self.heightSupportAsset.constant=self.heightTblSupport.constant+45;
        }
        else
        {
            self.heightTblSupport.constant=350;
            self.heightSupportAsset.constant=395;
        }
        if(limit1<totalRecords)
        {
            self.heightSupportLoadmore.constant=45;
        }
        else
        {
            self.heightSupportLoadmore.constant=0;
        }
        self.vwNoSupport.hidden=YES;
    }
    
}
-(void)manageTrucksConstants
{
    [self.btnHeading1 setTitle:@"-" forState:UIControlStateNormal];
    if(arrTrailerList.count==0)
    {
        self.vwNodataFound1.hidden=NO;
        self.heighvwloadmore1.constant=0;
        self.tblListOfResources.backgroundView=nil;
    }
    else
    {
        CGFloat height = 70;
        height *= arrTrailerList.count;
        if(height<350)
        {
            self.heightTbl1.constant=height+30;
            self.heightVwCalender1.constant=self.heightTbl1.constant+45;
        }
        else
        {
            self.heightTbl1.constant=350;
            self.heightVwCalender1.constant=395;
        }
        if(limit1<totalRecords)
        {
            self.heighvwloadmore1.constant=45;
        }
        else
        {
            self.heighvwloadmore1.constant=0;
        }
        self.vwNodataFound1.hidden=YES;
    }
}

-(void)manageAssetDispatchConstants
{
    [_btnPowerDispatch setTitle:@"-" forState:UIControlStateNormal];
    if(arrPowerDispatchList.count==0)
    {
        self.vwnoPowerDispatch.hidden=NO;
        self.heightPowerDispatchLoadmore.constant=0;
        self.tblPowerDispatch.backgroundView=nil;
    }
    else
    {
        CGFloat height = 70;
        height *= arrPowerDispatchList.count;
        if(height<350)
        {
            self.heightTblPowerDispatch.constant=height;
            self.heightPowerDispatch.constant=self.heightTblPowerDispatch.constant+45;
        }
        else
        {
            self.heightTblPowerDispatch.constant=350;
            self.heightPowerDispatch.constant=395;
        }
        if(truckdispatchlimit1<truckdispatchTotalRecord)
        {
            self.heightPowerDispatchLoadmore.constant=45;
        }
        else
        {
            self.heightPowerDispatchLoadmore.constant=0;
        }
        self.vwnoPowerDispatch.hidden=YES;
    }
    [_btnSupportDispatch setTitle:@"-" forState:UIControlStateNormal];
    if(arrSupportDispatchList.count==0)
    {
        self.vwNoSupportdispatch.hidden=NO;
        self.heightsuportdispatchloadmore.constant=0;
        self.tblSupportDispatch.backgroundView=nil;
    }
    else
    {
        CGFloat height = 70;
        height *= arrSupportDispatchList.count;
        if(height<350)
        {
            self.heightTblSupportDispatch.constant=height;
            self.heightSupportdispatch.constant=self.heightTblSupportDispatch.constant+45;
        }
        else
        {
            self.heightTblSupportDispatch.constant=350;
            self.heightSupportdispatch.constant=395;
        }
        if(truckdispatchlimit1<truckdispatchTotalRecord)
        {
            self.heightsuportdispatchloadmore.constant=45;
        }
        else
        {
            self.heightsuportdispatchloadmore.constant=0;
        }
        self.vwNoSupportdispatch.hidden=YES;
    }
    
}
- (IBAction)btnExpandCollClicked:(id)sender 
{
//    for (int i = 0; i < arrTrailerDispatchList.count; i++)
//    {
//        [arrayForBool addObject:[NSNumber numberWithBool:NO]];
//    }
//    for (int i = 0; i < arrDriverDispatchList.count; i++) 
//    {
//        [arrayForBool2 addObject:[NSNumber numberWithBool:NO]];
//    }
//    for (int i = 0; i < arrPowerDispatchList.count; i++)
//    {
//        [arrayForBoolPower addObject:[NSNumber numberWithBool:NO]];
//    }
//    for (int i = 0; i < arrSupportDispatchList.count; i++)
//    {
//        [arrayForBoolSupport addObject:[NSNumber numberWithBool:NO]];
//    }
    UIButton *btn=(UIButton *)sender;
    [UIView animateWithDuration:0.3 animations:^{
        switch ([btn tag])
        {
            case 9:
            {
                [_tblLoadCalender setContentOffset:CGPointZero animated:YES];
                if([btn.titleLabel.text isEqualToString:@"-"])
                {
                    [_btnHeading0 setTitle:@"+" forState:UIControlStateNormal];
                    self.heightVwCalender0.constant=45;
                    self.heighvwloadmore0.constant=0;
                    self.vwNodatafound0.hidden=YES;
                }
                else
                {
                  
                    [_btnHeading0 setTitle:@"-" forState:UIControlStateNormal];
                    if(![objuserAccount.role containsString:@"2"] && [objuserAccount.role containsString:@"3"])
                    {
                        self.heightVwCalender0.constant=SCREEN_HEIGHT-64-130;
                    }
                    else
                    {
                        self.heightVwCalender0.constant=395;
                    }
                    
                    if(arrLoadList.count==0)
                    {
                        self.vwNodatafound0.hidden=NO;
                        self.heighvwloadmore0.constant=0;
                        self.tblLoadCalender.backgroundView=nil;
                    }
                    else
                    {
                        CGFloat height = 70;
                        height *= arrLoadList.count;
                        if(height<350)
                        {
                            self.heightTbl0.constant=height+30;
                            self.heightVwCalender0.constant=self.heightTbl0.constant+45;
                        }
                        else
                        {
                            self.heightTbl0.constant=SCREEN_HEIGHT-64-130-45;
                            self.heightVwCalender0.constant=SCREEN_HEIGHT-64-130;
                        }
                        if(loadlimit1<totalLoadrecord)
                        {
                            self.heighvwloadmore0.constant=45;
                        }
                        else
                        {
                            self.heighvwloadmore0.constant=0;
                        }
                        self.vwNodatafound0.hidden=YES;
                    }
                } 
            }
            break;
            case 10:
            {
                [_tblListOfResources setContentOffset:CGPointZero animated:YES];
                if([btn.titleLabel.text isEqualToString:@"-"])
                {
                    [_btnHeading1 setTitle:@"+" forState:UIControlStateNormal];
                    self.heightVwCalender1.constant=45;
                    self.heighvwloadmore1.constant=0;
                    self.vwNodataFound1.hidden=YES;
                    [_btnHeading2 setTitle:@"+" forState:UIControlStateNormal];
                    self.heightVwList1.constant=0;
                    self.heighvwloadmore2.constant=0;
                    self.vwNodataFound2.hidden=YES;
                }
                else
                {
                    self.heightVwCalender1.constant=395;
                    [_btnHeading1 setTitle:@"-" forState:UIControlStateNormal];
                    [_btnHeading2 setTitle:@"-" forState:UIControlStateNormal];
                    self.heightVwList1.constant=395;
                  
                    if(arrTrailerList.count==0)
                    {
                        self.vwNodataFound1.hidden=NO;
                        self.heighvwloadmore1.constant=0;
                         self.tblListOfResources.backgroundView=nil;
                    }
                    else
                    {
                        CGFloat height = 70;
                        height *= arrTrailerList.count;
                        if(height<350)
                        {
                            self.heightTbl1.constant=height+30;
                            self.heightVwCalender1.constant=self.heightTbl1.constant+45;
                        }
                        else
                        {
                            self.heightTbl1.constant=350;
                            self.heightVwCalender1.constant=395;
                        }
                        if(limit1<totalRecords)
                        {
                            self.heighvwloadmore1.constant=45;
                        }
                        else
                        {
                            self.heighvwloadmore1.constant=0;
                        }
                        self.vwNodataFound1.hidden=YES;
                    }
                  /*  if(arrTruckDispatchList.count==0)
                    {
                        self.vwNodataFound2.hidden=NO;
                        self.heighvwloadmore2.constant=0;
                        self.tblLinkedList.backgroundView=nil;
                    }
                    else
                    {
//                        CGFloat height = 70;
//                        height *= arrTruckDispatchList.count;
//                        if(height<350)
//                        {
//                            self.hrightTbl2.constant=height;
//                            self.heightVwList1.constant=self.hrightTbl2.constant+45;
//                        }
//                        else
                       // {
                            self.hrightTbl2.constant=350;
                            self.heightVwList1.constant=395;
                        //}
                        if(truckdispatchlimit1<truckdispatchTotalRecord)
                        {
                            self.heighvwloadmore2.constant=45;
                        }
                        else
                        {
                            self.heighvwloadmore2.constant=0;
                        }
                       
                        self.vwNodataFound2.hidden=YES;
                    }*/
                    self.heighvwloadmore2.constant=0;
                    self.hrightTbl2.constant=0;
                    self.heightVwList1.constant=0;
                    self.vwNodataFound2.hidden=YES;

                } 
            }
            break;
            case 30:
            {
                [_tblListOfResources2 setContentOffset:CGPointZero animated:YES];
                if([btn.titleLabel.text isEqualToString:@"-"])
                {
                    [_btnHeading3 setTitle:@"+" forState:UIControlStateNormal];
                    self.heightVwCalende2.constant=45;
                    self.heighvwloadmore3.constant=0;
                    self.vwNoDatafound3.hidden=YES;
                    [_btnHeading4 setTitle:@"+" forState:UIControlStateNormal];
                    self.heightVwList2.constant=0;
                    self.heighvwloadmore4.constant=0;
                    self.vwNodataFound4.hidden=YES;
                }
                else
                {
                    self.heightVwCalende2.constant=395;
                    [_btnHeading3 setTitle:@"-" forState:UIControlStateNormal];
                    if(arrDriverList.count==0)
                    {
                        self.vwNoDatafound3.hidden=NO;
                        self.heighvwloadmore3.constant=0;
                        self.tblListOfResources2.backgroundView=nil;
                    }
                    else
                    {
                        CGFloat height = 70;
                        height *= arrDriverList.count;
                        if(height<350)
                        {
                            self.heightTbl3.constant=height+30;
                            self.heightVwCalende2.constant=self.heightTbl3.constant+45;
                        }
                        else
                        {
                            self.heightTbl3.constant=350;
                            self.heightVwCalende2.constant=395;
                        }
                        if(driverlimit1<drivertotalrecord)
                        {
                            self.heighvwloadmore3.constant=45;
                        }
                        else
                        {
                            self.heighvwloadmore3.constant=0;
                        }
                        self.vwNoDatafound3.hidden=YES;
                    }
                    [_btnHeading4 setTitle:@"-" forState:UIControlStateNormal];
                  /*      self.heightVwList2.constant=395;
                 if(arrDriverDispatchList.count==0)
                    {
                        self.vwNodataFound4.hidden=NO;
                        self.heighvwloadmore4.constant=0;
                        self.tblLinkedList2.backgroundView=nil;
                    }
                   else
                    {
//                        CGFloat height = 70;
//                        height *= arrDriverDispatchList.count;
//                        if(height<350)
//                        {
//                            self.heightTbl4.constant=height;
//                            self.heightVwList2.constant=self.heightTbl4.constant+45;
//                        }
//                        else
//                        {
                            self.heightTbl4.constant=350;
                            self.heightVwList2.constant=395;
                        //}
                        if(driverdispatchlimit1<driverdispatchtotalrecord)
                        {
                            self.heighvwloadmore4.constant=45;
                        }
                        else
                        {
                            self.heighvwloadmore4.constant=0;
                        }
                        self.vwNodataFound4.hidden=YES;
                    }*/
                    self.heightTbl4.constant=0;
                    self.heightVwList2.constant=0;
                    self.heighvwloadmore4.constant=0;
                    self.vwNodataFound4.hidden=YES;
                }
            }
            break;
            case 50:
            {
                [_tblPowerAsset setContentOffset:CGPointZero animated:YES];
                if([btn.titleLabel.text isEqualToString:@"-"])
                {
                    [_btnPowerAsset setTitle:@"+" forState:UIControlStateNormal];
                    self.heightPowerAsset.constant=45;
                    self.heightPowerLoadmore.constant=0;
                    self.vwnoPowerAsset.hidden=YES;
                    [_btnPowerDispatch setTitle:@"+" forState:UIControlStateNormal];
                    self.heightPowerDispatch.constant=0;
                    self.heightPowerDispatchLoadmore.constant=0;
                    self.vwnoPowerDispatch.hidden=YES;
                }
                else
                {
                    self.heightPowerAsset.constant=395;
                    [_btnPowerDispatch setTitle:@"-" forState:UIControlStateNormal];
                    [_btnPowerAsset setTitle:@"-" forState:UIControlStateNormal];
                    self.heightPowerDispatch.constant=395;
                   
                    if(arrPowerList.count==0)
                    {
                        self.vwnoPowerAsset.hidden=NO;
                        self.heightPowerLoadmore.constant=0;
                        self.tblPowerAsset.backgroundView=nil;
                    }
                    else
                    {
                        CGFloat height = 70;
                        height *= arrPowerList.count;
                        if(height<350)
                        {
                            self.heightTblPower.constant=height+30;
                            self.heightPowerAsset.constant=self.heightTblPower.constant+45;
                        }
                        else
                        {
                            self.heightTblPower.constant=350;
                            self.heightPowerAsset.constant=395;
                        }
                        if(limit1<totalRecords)
                        {
                            self.heightPowerLoadmore.constant=45;
                        }
                        else
                        {
                            self.heightPowerLoadmore.constant=0;
                        }
                        self.vwnoPowerAsset.hidden=YES;
                    }
                /*      if(arrPowerDispatchList.count==0)
                    {
                        self.vwnoPowerDispatch.hidden=NO;
                        self.heightPowerDispatchLoadmore.constant=0;
                        self.tblPowerDispatch.backgroundView=nil;
                    }
                    else
                    {
                        self.heightTblPowerDispatch.constant=350;
                        self.heightPowerDispatch.constant=395;
                        if(subassetlimit1<totalSubAssets)
                        {
                            self.heightPowerDispatchLoadmore.constant=45;
                        }
                        else
                        {
                            self.heightPowerDispatchLoadmore.constant=0;
                        }
                        self.vwnoPowerDispatch.hidden=YES;
                    }*/
                    self.heightTblPowerDispatch.constant=0;
                    self.heightPowerDispatch.constant=0;
                    self.heightPowerDispatchLoadmore.constant=0;
                    self.vwnoPowerDispatch.hidden=YES;
                } 
            }
                break;
            case 70:
            {
                [_tblSupport setContentOffset:CGPointZero animated:YES];
                if([btn.titleLabel.text isEqualToString:@"-"])
                {
                    [_btnSupport setTitle:@"+" forState:UIControlStateNormal];
                    self.heightSupportAsset.constant=45;
                    self.heightSupportLoadmore.constant=0;
                    self.vwNoSupport.hidden=YES;
                    [_btnSupportDispatch setTitle:@"+" forState:UIControlStateNormal];
                    self.heightSupportdispatch.constant=0;
                    self.heightsuportdispatchloadmore.constant=0;
                    self.vwNoSupportdispatch.hidden=YES;
                }
                else
                {
                    self.heightSupportAsset.constant=395;
                    [_btnSupportDispatch setTitle:@"-" forState:UIControlStateNormal];
                    [_btnSupport setTitle:@"-" forState:UIControlStateNormal];
                    self.heightSupportdispatch.constant=395;
                    if(arrSupportList.count==0)
                    {
                        self.vwNoSupport.hidden=NO;
                        self.heightSupportLoadmore.constant=0;
                        self.tblSupport.backgroundView=nil;
                    }
                    else
                    {
                        CGFloat height = 70;
                        height *= arrSupportList.count;
                        if(height<350)
                        {
                            self.heightTblSupport.constant=height+30;
                            self.heightSupportAsset.constant=self.heightTblSupport.constant+45;
                        }
                        else
                        {
                            self.heightTblSupport.constant=350;
                            self.heightSupportAsset.constant=395;
                        }
                        if(limit1<totalRecords)
                        {
                            self.heightSupportLoadmore.constant=45;
                        }
                        else
                        {
                            self.heightSupportLoadmore.constant=0;
                        }
                        self.vwNoSupport.hidden=YES;
                    }
                    /* if(arrSupportDispatchList.count==0)
                    {
                        self.vwNoSupportdispatch.hidden=NO;
                        self.heightsuportdispatchloadmore.constant=0;
                        self.tblSupportDispatch.backgroundView=nil;
                    }
                    else
                    {
//                        CGFloat height = 70;
//                        height *= arrSupportDispatchList.count;
//                        if(height<350)
//                        {
//                            self.heightTblSupportDispatch.constant=height;
//                            self.heightSupportdispatch.constant=self.heightTblSupportDispatch.constant+45;
//                        }
//                        else
//                        {
                            self.heightTblSupportDispatch.constant=350;
                            self.heightSupportdispatch.constant=395;
                      //  }
                        if(supportassetlimit1<totalsupportasset)
                        {
                            self.heightsuportdispatchloadmore.constant=45;
                        }
                        else
                        {
                            self.heightsuportdispatchloadmore.constant=0;
                        }
                        self.vwNoSupportdispatch.hidden=YES;
                    } */
                    self.heightTblSupportDispatch.constant=0;
                    self.heightSupportdispatch.constant=0;
                    self.heightsuportdispatchloadmore.constant=0;
                    self.vwNoSupportdispatch.hidden=YES;
                } 
            }
                break;
            default:
                break;
        }
        [_scrollMain setContentSize:(CGSizeMake(CGRectGetWidth(_scrollMain.frame),self.heightVwCalender0.constant+ self.heightVwList1.constant +self.heightVwList2.constant+ self.heightVwCalender1.constant+ self.heightVwCalende2.constant + self.heightPowerDispatch.constant+self.heightPowerAsset.constant+self.heightSupportAsset.constant+self.heightSupportdispatch.constant))];
        //[self.view layoutIfNeeded];
     }
     completion:^(BOOL finished)
     {
     }];
}
#pragma mark - 
#pragma mark - load more button 
- (IBAction)btnLoadMoreClciked:(id)sender {
    UIButton *btn=(UIButton *)sender;
    switch ([btn tag]) 
    {
        case 111:
        {
            [self fetchLoadCalender_loadmore];
        }
            break;
        case 11:
        {
            [self fetchTruckCalender_loadmore];
        }
            break;
        case 22:
        {
            [self fetchDateTruckDispatch_loadmore];
        }
            break;
        case 33:
        {
            [self fetchDriverCalender_loadmore];
        }
            break;
        case 44:
        {
            [self fetchDriverDispatch_loadmore];
        }
            break;
        case 55:
        {
            [self fetchTruckCalender_loadmore];
        }
            break;
        case 66:
        {
            [self fetchSubAssetDispatch_loadmore];
        }
            break;
        case 77:
        {
            [self fetchTruckCalender_loadmore];
        }
            break;
        case 88:
        {
              [self fetchSupportAssetDispatch_loadmore];
        }
            break;
        default:
            break;
    }
}
- (IBAction)btnClicktoAddClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    switch ([btn tag]) 
    {
        case 28:
        {
            PostLoadVC *objEquiList=initVCToRedirect(SBAFTERSIGNUP, POSTLOADVC);
            objEquiList.strRedirectFrom=@"CALENDER";
            [self.navigationController pushViewController:objEquiList animated:YES];
        }
            break;
        case 19:
        case 29:
        {
            PostEquipmentVC *objEquiList=initVCToRedirect(SBAFTERSIGNUP, POSTEQUIPMENTVC);
            objEquiList.strRedirectFrom=@"CALENDER";
            [self.navigationController pushViewController:objEquiList animated:YES];
        }
            break;
        default:
            break;
    }
}
- (IBAction)btnrefreshclicked:(id)sender 
{
     [self dismissHUD];
    [self getAllEvent];
    [self refreshCalender:@"1"];
}

-(void)refreshCalender:(NSString *)str
{
    if([str isEqualToString:@"1"])
    {
        [_btnHeading0 setTitle:@"+" forState:UIControlStateNormal];
        [_btnHeading1 setTitle:@"+" forState:UIControlStateNormal];
        [_btnHeading2 setTitle:@"+" forState:UIControlStateNormal];
        [_btnHeading3 setTitle:@"+" forState:UIControlStateNormal];
        [_btnHeading4 setTitle:@"+" forState:UIControlStateNormal];
        [_btnSupport setTitle:@"+" forState:UIControlStateNormal];
        [_btnPowerAsset setTitle:@"+" forState:UIControlStateNormal];
        [_btnSupportDispatch setTitle:@"+" forState:UIControlStateNormal];
        [_btnPowerDispatch setTitle:@"+" forState:UIControlStateNormal];
        if([objuserAccount.role containsString:@"2"] && [objuserAccount.role containsString:@"3"])
        {
            //shipper amd carrier
            self.heightVwCalender0.constant=45;
            self.heightVwList1.constant=0;
            self.heightVwList2.constant=0;
            self.heightVwCalender1.constant=45;
            self.heightVwCalende2.constant=45;
            self.heighvwloadmore1.constant=0;
            self.heighvwloadmore2.constant=0;
            self.heighvwloadmore3.constant=0;
            self.heighvwloadmore4.constant=0;
            self.heighvwloadmore0.constant=0;
            self.heightSupportAsset.constant=45;
            self.heightPowerAsset.constant=45;
            self.heightSupportdispatch.constant=0;
            self.heightPowerDispatch.constant=0;
            self.heightSupportLoadmore.constant=0;
            self.heightPowerDispatchLoadmore.constant=0;
            self.heightPowerLoadmore.constant=0;
            self.heightsuportdispatchloadmore.constant=0;
            [self fetchLoadCalender:YES];
            [self fetchDateTruckCalender:YES];
            [self fetchDateTruckDispatch:YES];
            [self fetchDriverCalender:YES];
            [self fetchDriverDispatch:YES];
            [self fetchPowerCalender:YES];
            [self fetchSubAssetDispatch:YES];
            [self fetchSupportCalender:YES];
             [self fetchSupportAssetDispatch:YES];
        }
        if([objuserAccount.role containsString:@"2"] && ![objuserAccount.role containsString:@"3"])
        {
            //carrier
            self.heightVwList1.constant=0;
            self.heightVwList2.constant=0;
            self.heightVwCalender0.constant=0;
            self.heightVwCalender1.constant=45;
            self.heightVwCalende2.constant=45;
            self.heighvwloadmore1.constant=0;
            self.heighvwloadmore2.constant=0;
            self.heighvwloadmore3.constant=0;
            self.heighvwloadmore4.constant=0;
            self.heighvwloadmore0.constant=0;
            self.heightSupportAsset.constant=45;
            self.heightPowerAsset.constant=45;
            self.heightSupportdispatch.constant=0;
            self.heightPowerDispatch.constant=0;
            self.heightSupportLoadmore.constant=0;
            self.heightPowerDispatchLoadmore.constant=0;
            self.heightPowerLoadmore.constant=0;
            self.heightsuportdispatchloadmore.constant=0;
            self.vwLoadCalender.hidden=YES;
            [self fetchDateTruckCalender:YES];
            [self fetchDateTruckDispatch:YES];
            [self fetchDriverCalender:YES];
            [self fetchDriverDispatch:YES];
            [self fetchPowerCalender:YES];
            [self fetchSubAssetDispatch:YES];
            [self fetchSupportCalender:YES]; 
            [self fetchSupportAssetDispatch:YES];
        }
        if(![objuserAccount.role containsString:@"2"] && [objuserAccount.role containsString:@"3"])
        {
            //shipper
            self.heightVwCalender0.constant=45;
            self.heightVwList1.constant=0;
            self.heightVwList2.constant=0;
            self.heightVwCalender1.constant=0;
            self.heightVwCalende2.constant=0;
            self.heighvwloadmore1.constant=0;
            self.heighvwloadmore2.constant=0;
            self.heighvwloadmore3.constant=0;
            self.heighvwloadmore4.constant=0;
            self.heighvwloadmore0.constant=0;
            self.heightSupportAsset.constant=0;
            self.heightPowerAsset.constant=0;
            self.heightSupportdispatch.constant=0;
            self.heightPowerDispatch.constant=0;
            self.heightSupportLoadmore.constant=0;
            self.heightPowerDispatchLoadmore.constant=0;
            self.heightPowerLoadmore.constant=0;
            self.heightsuportdispatchloadmore.constant=0;
            self.vwSupport.hidden=YES;
            self.vwpowerAsset.hidden=YES;
            self.vwCalander1.hidden=YES;
            self.vwCalander2.hidden=YES;
            [self fetchLoadCalender:YES];
         //   [self fetchDateTruckCalender:YES];
          //  [self fetchDriverCalender:YES];
        }
         self.vwnoPowerAsset.hidden=YES;
         self.vwnoPowerDispatch.hidden=YES;
         self.vwNodatafound0.hidden=YES;
         self.vwNoDatafound3.hidden=YES;
         self.vwNodataFound4.hidden=YES;
         self.vwNodataFound1.hidden=YES;
         self.vwNodataFound2.hidden=YES;
         self.vwNoSupport.hidden=YES;
         self.vwNoSupportdispatch.hidden=YES;
       [_scrollMain setContentSize:(CGSizeMake(CGRectGetWidth(_scrollMain.frame),self.heightVwCalender0.constant+ self.heightVwList1.constant +self.heightVwList2.constant+ self.heightVwCalender1.constant+ self.heightVwCalende2.constant + self.heightPowerDispatch.constant+self.heightPowerAsset.constant+self.heightSupportAsset.constant+self.heightSupportdispatch.constant))];
        [self.view layoutIfNeeded];
    }
}
- (IBAction)goRightClicked:(id)sender
{
    [_calendarContentView loadNextPageWithAnimation];
}
- (IBAction)goLeftClicked:(id)sender
{
    [_calendarContentView loadPreviousPageWithAnimation];
}
- (IBAction)btnBackClciked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if([btn.accessibilityLabel isEqualToString:@"REFRESH"])
    {
        [self btnrefreshclicked:_btnRefresh];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)btnDrawerClciked:(id)sender
{
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
#pragma mark - detail screen redirection
- (IBAction)btnResourceDetailClicked:(id)sender 
{
    UIButton *btn=(UIButton *)sender;
    
    if([btn.accessibilityValue isEqualToString:@"LOAD"])
    {
        LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
        Loads *driver = [arrLoadList objectAtIndex:[sender tag]];
        
        objLoadDetail.cmpnyphno=@"";
        objLoadDetail.myphono=@"";
        objLoadDetail.officephno=@"";
        objLoadDetail.strRedirectFrom=@"CALENDERVC";
        objLoadDetail.selectedLoad=driver;
        [self.navigationController pushViewController:objLoadDetail animated:YES];
        
    }
    else if([btn.accessibilityValue isEqualToString:@"DRIVER"])
    {
        MyNetwork *driverrs=[arrDriverList objectAtIndex:[sender tag]];
        DriverProfileVC *objdrivers=initVCToRedirect(SBAFTERSIGNUP, DRIVERPROFILEVC);
        objdrivers.objeuaccount=driverrs;
        objdrivers.redrirectfrom=@"DriverLIST";
        [self.navigationController pushViewController:objdrivers animated:YES];
    }
    else if([btn.accessibilityValue isEqualToString:@"TRUCK"])
    {
        Equipments *obje=[arrTrailerList objectAtIndex:[sender tag]];
        EquipmentDetailVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, EQUIPMENTDETAILVC);
        objeDetail.strRedirectFrom=@"CALENDERVC";
        objeDetail.selectedEqui=obje;
        [self.navigationController pushViewController:objeDetail animated:YES];
    }
    else if([btn.accessibilityValue isEqualToString:@"POWER"])
    {
        Equipments *obje=[arrPowerList objectAtIndex:[sender tag]];
        SubAssetDetailsVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, SUBDETAILVC);
        objeDetail.strRedirectFrom=@"";
        objeDetail.selectedEqui=obje;
        [self.navigationController pushViewController:objeDetail animated:YES];
    }
    else if([btn.accessibilityValue isEqualToString:@"SUPPORT"])
    {
        Equipments *obje=[arrSupportList objectAtIndex:[sender tag]];
        SubAssetDetailsVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, SUBDETAILVC);
        objeDetail.strRedirectFrom=@"";
        objeDetail.selectedEqui=obje;
        [self.navigationController pushViewController:objeDetail animated:YES];
    }


}
- (IBAction)btnVwDetailsClciked:(id)sender // CELL LOAD NAME CLICK
{
   
    UIButton *btn=(UIButton*)sender;
      int btnhint=[btn.accessibilityLabel intValue];
    if([btn.accessibilityValue isEqualToString:@"DRIVER"])
    {
        Loads *equi=[arrDriverDispatchList objectAtIndex:[btn tag]];
        Matches *match=[equi.matches objectAtIndex:btnhint];
        DriverProfileVC *objdrivers=initVCToRedirect(SBAFTERSIGNUP, DRIVERPROFILEVC);
        objdrivers.objmatch=match;
        objdrivers.redrirectfrom=@"DriverDispatchLIST";
        [self.navigationController pushViewController:objdrivers animated:YES];

    }
    else
    {
        Loads *equi;
       
         if([btn.accessibilityValue isEqualToString:@"POWER"])
        {
            equi=[arrPowerDispatchList objectAtIndex:[btn tag]];
        }
        else
        {
            equi=[arrSupportDispatchList objectAtIndex:[btn tag]];
           
        }
        Matches *match=[equi.matches objectAtIndex:btnhint];
        Equipments *obj=[Equipments new];
        obj.equiName=match.equiName;
        obj.eId=match.eId;
        obj.esId=match.esId;
        obj.equiNotes=match.equiNotes;
        obj.equiLatitude=match.equiLatitude;
        obj.equiLongitude=match.equiLongitude;
        obj.lastEquiAddress=match.lastEquiAddress;
        obj.lastEquiStatecode=match.lastEquiStatecode;
        obj.equiAvailablity=match.equiAvailablity;
        obj.medialist=match.medialist;
        obj.internalBaseClassIdentifier=match.matchesIdentifier;
            SubAssetDetailsVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, SUBDETAILVC);
            objeDetail.strRedirectFrom=@"";
            objeDetail.selectedEqui=obj;
            [self.navigationController pushViewController:objeDetail animated:YES];
        
    }
  
   }
- (IBAction)btnGotoDetailClicked:(id)sender
{
    @try
    {
        UIButton *btn=(UIButton *)sender;
        if([btn.accessibilityValue isEqualToString:@"LIST2"])
        {
            //driver
            Loads *obj=[arrDriverDispatchList objectAtIndex:btn.tag];
            LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
            objLoadDetail.cmpnyphno=@"";
            objLoadDetail.myphono=@"";
            objLoadDetail.officephno=@"";
            objLoadDetail.strRedirectFrom=@"CALENDERVC";
            objLoadDetail.selectedLoad=obj;
            [self.navigationController pushViewController:objLoadDetail animated:YES];
        }
        else if([btn.accessibilityValue isEqualToString:@"LIST3"])
        {
         //power   
            Loads *obj=[arrPowerDispatchList objectAtIndex:btn.tag];
            LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
            objLoadDetail.cmpnyphno=@"";
            objLoadDetail.myphono=@"";
            objLoadDetail.officephno=@"";
            objLoadDetail.strRedirectFrom=@"CALENDERVC";
            objLoadDetail.selectedLoad=obj;
            [self.navigationController pushViewController:objLoadDetail animated:YES];
        }
        else if([btn.accessibilityValue isEqualToString:@"LIST4"])
        {
            //support
            Loads *obj=[arrSupportDispatchList objectAtIndex:btn.tag];
            LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
            objLoadDetail.cmpnyphno=@"";
            objLoadDetail.myphono=@"";
            objLoadDetail.officephno=@"";
            objLoadDetail.strRedirectFrom=@"CALENDERVC";
            objLoadDetail.selectedLoad=obj;
            [self.navigationController pushViewController:objLoadDetail animated:YES];
        }
        else
        {
            Loads *obj=[arrLoadList objectAtIndex:btn.tag];
            LoadDetailVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADDETAIL);
            objLoadDetail.cmpnyphno=@"";
            objLoadDetail.myphono=@"";
            objLoadDetail.officephno=@"";
            objLoadDetail.strRedirectFrom=@"CALENDERVC";
            objLoadDetail.selectedLoad=obj;
            [self.navigationController pushViewController:objLoadDetail animated:YES];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
   
}
- (IBAction)btnTrcukDetailClicked:(id)sender
{
    Equipments *obj=[arrTruckDispatchList objectAtIndex:[sender tag]];
    EquipmentDetailVC *objeDetail=initVCToRedirect(SBAFTERSIGNUP, EQUIPMENTDETAILVC);
    objeDetail.strRedirectFrom=@"CALENDERVC";
    objeDetail.selectedEqui=obj;
    [self.navigationController pushViewController:objeDetail animated:YES];
}
#pragma mark - CalendarManager delegate
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date])
    {
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blackColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date])
    {
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor orangeColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date])
    {
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor orangeColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor orangeColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    if([self haveEventForDay:dayView.date])
    {
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
    
    dayView.dotView.hidden = YES;
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    @try
    {
        _dateSelected = dayView.date;
        choosendate=[GlobalFunction getDateStringFromDate:_dateSelected withFormate:@"MM/dd/yy"];
        
        self.collEventTimeHeader.contentOffset=CGPointMake(0.0,0.0);
        [_tblListOfResources reloadData];
        self.collEventTimeHeader2.contentOffset=CGPointMake(0.0,0.0);
        [_tblListOfResources2 reloadData];
        self.collEventTimeHeader3.contentOffset=CGPointMake(0.0,0.0);
        [_tblLoadCalender reloadData];
        self.collEventTimeHeader4.contentOffset=CGPointMake(0.0,0.0);
        [_tblSupport reloadData];
        self.collEventTimeHeader5.contentOffset=CGPointMake(0.0,0.0);
        [_tblPowerAsset reloadData];
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            dayView.circleView.transform = CGAffineTransformIdentity;
                            [_calendarManager reload];
                        } completion:nil];
        if(_calendarManager.settings.weekModeEnabled){
            return;
        }
        if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date])
        {
            if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
                [_calendarContentView loadNextPageWithAnimation];
            }
            else{
                [_calendarContentView loadPreviousPageWithAnimation];
            }
        }
    } @catch (NSException *exception) {
        
    }
}
#pragma mark - CalendarManager delegate - Page mangement
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return YES;
}
- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    year = [gregorian component:NSCalendarUnitYear fromDate:calendar.date];
    if(year > prevyear || year < prevyear)
    {
        prevyear=year;
        [self performSelectorInBackground:@selector(getAllEvent) withObject:nil];
    }
}
- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    year = [gregorian component:NSCalendarUnitYear fromDate:calendar.date];
    if(year > prevyear || year < prevyear)
    {
        prevyear=year;
        [self performSelectorInBackground:@selector(getAllEvent) withObject:nil];
    }
}
#pragma mark - manage dates data
- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
    _dateSelected=[NSDate date];
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-2];
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:2];
}
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    return dateFormatter;
}
- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}

- (void)registerTableNibs
{
    UINib *nib = [UINib nibWithNibName:@"CellCalenderEvent" bundle:nil];
    [[self tblListOfResources] registerNib:nib forCellReuseIdentifier:@"CellCalenderEvent"];
    [self.tblListOfResources2 registerNib:nib forCellReuseIdentifier:@"CellCalenderEvent"];
    [self.tblLoadCalender registerNib:nib forCellReuseIdentifier:@"CellCalenderEvent"];
    [self.tblSupport registerNib:nib forCellReuseIdentifier:@"CellCalenderEvent"];
    [self.tblPowerAsset registerNib:nib forCellReuseIdentifier:@"CellCalenderEvent"];
    
    UINib *nibcell3 = [UINib nibWithNibName:@"CellCalenderSchedule" bundle:nil];
    [self.tblLinkedList registerNib:nibcell3 forCellReuseIdentifier:@"CellCalenderSchedule"];
    [self.tblLinkedList2 registerNib:nibcell3 forCellReuseIdentifier:@"CellCalenderSchedule"];
    [self.tblPowerDispatch registerNib:nibcell3 forCellReuseIdentifier:@"CellCalenderSchedule"];
    [self.tblSupportDispatch registerNib:nibcell3 forCellReuseIdentifier:@"CellCalenderSchedule"];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.tblLinkedList.frame.size.width, 0)];
    self.tblLinkedList.tableFooterView = footer;
    self.tblLinkedList2.tableFooterView = footer;
    self.tblListOfResources.tableFooterView = footer;
    self.tblListOfResources2.tableFooterView = footer;
    self.tblLoadCalender.tableFooterView = footer;
    self.tblSupport.tableFooterView = footer;
    self.tblSupportDispatch.tableFooterView = footer;
    self.tblPowerAsset.tableFooterView = footer;
    self.tblPowerDispatch.tableFooterView = footer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
