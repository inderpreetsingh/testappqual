//
//  MyLoadListVC.m
//  Lodr
//
//  Created by Payal Umraliya on 20/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "MyLoadListVC.h"
#import "GlobalFunction.h"
#import "Loads.h"
#import "Matches.h"
#import "UITableView+Placeholder.h"
#import "FTPopOverMenu.h"
#import "WebContentVC.h"
#import "DOTDetails.h"
#import "UserAccount.h"
#define constLimit 5

@interface MyLoadListVC ()
{
    NSArray *nib;
    NSMutableArray *arrAllLoads,*arrAllMatches,*arrScheduledLoad,*arrComments;
    int webcallcount,limit1,limit2,totalRecords;
    NSMutableDictionary *dicMatches,*dicmatchClone;
    NSIndexPath *indexpathAtOpenedRow;
    NSInteger selectedSection;
    BOOL distancesort,pickupsort,delieverysort,statussort,ratesort,isRowOpend,closestsort;
    NSArray *menuNameArray,*menuImageArray;
    NSString *iscancelled;
    NSDate *today; 
}
@end

@implementation MyLoadListVC

- (void)viewDidLoad 
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushVCtoCreateorOpenSavedLoad:) name:kPushCreateORSavedLoad object:nil];
    _mTableView.tableView.separatorColor = [UIColor clearColor];
    
    _mTableView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [super viewDidLoad];
    iscancelled=@"NO";
    CGRect rect =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64);
    NavigationBarHidden(YES);
    today = [GlobalFunction dateString:[NSString stringWithFormat:@"%@ ",[NSDate date]] fromFormat:@"yyyy-MM-dd HH:mm:ss Z" toFormat:@"yyyy-MM-dd HH:mm:ss"]; 
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
    self.mTableView = [[TQMultistageTableView alloc] initWithFrame:rect];
    UINib *nibcell = [UINib nibWithNibName:@"CellMatchesContainer" bundle:nil];
    [self.mTableView.tableView registerNib:nibcell forCellReuseIdentifier:@"CellMatchesContainer"];
    self.mTableView.dataSource = self;
    self.mTableView.delegate   = self;
    self.mTableView.redirectFrom=@"ALL_LOADS";
    
    self.mTableView.backgroundColor = [UIColor clearColor];
    CGRect rect1 =CGRectMake(0, self.mTableView.frame.size.height, self.view.frame.size.width,self.tblScheduledList.frame.size.height);
    self.tblScheduledList = [[TQMultistageTableView alloc] initWithFrame:rect1];
    [self.tblScheduledList.tableView registerNib:nibcell forCellReuseIdentifier:@"CellMatchesContainer"];
    self.tblScheduledList.dataSource = self;
    self.tblScheduledList.delegate   = self;
    self.tblScheduledList.redirectFrom=@"ALL_LOADS";
    
    self.tblScheduledList.backgroundColor = [UIColor clearColor];
    [self.scrollContent addSubview:self.mTableView];
    [self.scrollContent addSubview:self.tblScheduledList];
    [self.scrollContent setContentSize:CGSizeMake(SCREEN_WIDTH, 1070)];
    [self.scrollContent layoutIfNeeded];
    [self.view bringSubviewToFront:self.btnLoadmore];
    nib = [[NSBundle mainBundle] loadNibNamed:@"MatchDetailView" owner:self options:nil];  
    dicmatchClone=[NSMutableDictionary new];
    
    [self getAllLoadDetail:YES:NO];
    
//    if(AppInstance.arrAllLoadByUserId.count == 0)
//    {
//           [self getAllLoadDetail:YES:NO];
//    }
//    else
//    {
//        arrAllLoads=AppInstance.arrAllLoadByUserId;
//        arrScheduledLoad = AppInstance.arrAllScheduledLoadByUserId;
//        dicMatches=AppInstance.dicAllMatchByLoadId;
//        if(arrAllLoads.count != [AppInstance.countLodByUid intValue])
//        {
//            limit1=(int)arrAllLoads.count;
//            limit2=constLimit;
//            totalRecords=[AppInstance.countLodByUid intValue];
//            if(limit1<totalRecords)
//            {
//                 self.btnLoadmore.hidden=NO;
//                [self performSelectorInBackground:@selector(callLoadMoreData_Loads)  withObject:nil];
//            }
//            else
//            {
//                 self.btnLoadmore.hidden=YES;
//                self.mTableView.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
//            }
//        }
//        else
//        {
//            [self getAllLoadDetail:YES:NO];
//        }
//    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedRefreshLoadList object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshLoads) name:NCNamedRefreshLoadList object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedRefreshLoadList object:nil];
}
-(void)refreshLoads
{
    [self getAllLoadDetail:YES:NO];
}
-(void)callWsAgain_FetchLoad
{
    if(AppInstance.arrAllLoadByUserId.count == 0)
    {
        [self getAllLoadDetail:YES:NO];
    }
    else
    {
        arrAllLoads=AppInstance.arrAllLoadByUserId;
        dicMatches=AppInstance.dicAllMatchByLoadId;
        if(arrAllLoads.count != [AppInstance.countLodByUid intValue])
        {
            limit1=(int)arrAllLoads.count;
            limit2=constLimit;
            totalRecords=[AppInstance.countLodByUid intValue];
            if(limit1<totalRecords)
            {
                [self performSelectorInBackground:@selector(callLoadMoreData_Loads)  withObject:nil];
            }
            else
            {
                self.mTableView.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }
        else
        {
            [self getAllLoadDetail:NO:NO];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)reloadLoadTable
{
     [FTPopOverMenu dismiss];
    
    [self.mTableView.tableView reloadData];
    [_mTableView sendCellTouchActionWithIndexPath:indexpathAtOpenedRow];
}
#pragma mark - Table view delegate
- (NSInteger)numberOfSectionsInTableView:(TQMultistageTableView *)mTableView
{
    if(mTableView != _tblScheduledList)
    {
        return arrAllLoads.count;
    }
    else
    {
        return arrScheduledLoad.count;
    }
    
}
- (NSInteger)mTableView:(TQMultistageTableView *)mTableView numberOfRowsInSection:(NSInteger)section
{
    if(mTableView != _tblScheduledList)
    {
        Loads *obj=[arrAllLoads objectAtIndex:section];
        NSDate *newDate = [GlobalFunction dateString:[NSString stringWithFormat:@"%@ %@",obj.delieveryDate,obj.deliveryTime] fromFormat:@"yyyy-MM-dd hh:mm a" toFormat:@"yyyy-MM-dd hh:mm a"];
        NSComparisonResult result;
        result = [today compare:newDate];
        if(result==NSOrderedDescending)
        {
            return 0;
        }
        else
        {
            if(obj.matches.count >0)
            {
                if([obj.loadStatus intValue]  > 0)
                {
                    return 0;
                }
                else
                {
                    NSArray *valcount=[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
//                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"matchOrderStatus == %@",@"2"];
//                    NSArray *arrRes = [valcount filteredArrayUsingPredicate:predicate];
//                    if(arrRes.count > 0){
//                        return arrRes.count
//                    }
                    return valcount.count;
                }
            }
            else
            {
                return 0;
            }
        }
    }
    else
    {
        return 0;
    }
    
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForHeaderInSection:(NSInteger)section
{
    if(mTableView != _tblScheduledList)
    {
        if(section > 0)
        {
            return 90;
        }
        else
        {
            return 180;
        }
    }
    else
    {
        if(section > 0)
        {
            return 70;
        }
        else
        {
            return 130; // hide titles bar
        }
    }
    
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 100;
    }
    else
    {
        return 60;
    }
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForAtomAtIndexPath:(NSIndexPath *)indexPath
{
    return 410;
}
- (UITableViewHeaderFooterView *)mTableView:(TQMultistageTableView *)mTableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderIdentifier = @"ResourceContainerView";
    
    ResourceContainerView *header = [mTableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if(!header) {
        header = [[ResourceContainerView alloc] initWithReuseIdentifier:HeaderIdentifier];
        header.backgroundView = [[UIView alloc] init];
        header.lblTitlename.text = @"LOADS FROM MY LOCATION";
        header.lbltitleDesc.text = @"VIEW MATCHES AND INTEREST BELOW";
    }
  
//    header.viewLoadHeader.hidden = false;
//    [header.btnAddLoad addTarget:self action:@selector(btnAddLoadClicked:) forControlEvents:UIControlEventTouchUpInside];
//
    Loads *loads;
    header.lblOrangeBubble.layer.borderColor = ThemeOrangeColor.CGColor;
    
    
    
    if(mTableView != _tblScheduledList)
    {
        loads=[arrAllLoads objectAtIndex:section];
        if(section > 0)
        {
            header.vwheaderhight.constant = 0;
            header.heightSection.constant = 0;
        }
        else
        {
            header.vwheaderhight.constant=30;
            header.heightSection.constant = 60;
        }
    }
    else
    {
        
        NSLog(@"MY LOADS ELSE EXECUTION");
        loads=[arrScheduledLoad objectAtIndex:section];
        if(section > 0)
        {
            header.vwheaderhight.constant=0;
            header.heightSection.constant = 0;
        }
        else
        {
            header.vwheaderhight.constant=0;
            header.heightSection.constant = 60;
        }
    }
   
    
    if([loads.loadPickedupTime isEqualToString:@""] || loads.loadPickedupDate == nil || [loads.loadPickedupTime isKindOfClass:[NSNull class]]){
        
        header.lblPickedUpDate.hidden = YES;
        header.lblPickedUpTime.hidden = YES;
        
    }
    else{
        header.lblPickedUpDate.hidden = NO;
        header.lblPickedUpTime.hidden = NO;
        header.lblPickedUpDate.text=[GlobalFunction stringDate:loads.loadPickedupDate fromFormat:@"yyyy-MM-dd" toFormat:@"YYYY/MM/dd"];
//        header.lblPickedUpDate.text = loads.loadPickedupDate;
        header.lblPickedUpTime.text = loads.loadPickedupTime;
        
        
    }
    
    if([loads.visiableTo isEqualToString:@"0"])
    {
        header.vwBelowHeader.backgroundColor=PrivateColor;
    }
    else
    {
        header.vwBelowHeader.backgroundColor=[UIColor whiteColor];
    }
    header.resourceContainerViewDelegate=self;
    header.lblReourceName.text=[NSString stringWithFormat:@"%@-%@",loads.pickupStateCode,loads.deliveryStateCode];
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
    
//    header.lblLoadNumber.text = [NSString stringWithFormat:@"%ld",section];
    header.lblLoadNumber.text = loads.loadNumber;
    if([loads.loadNumber isEqualToString:@""]){
        
        header.lblLoadNumber.text = @"--";
    }
   

    header.lblMiles.text=loads.distance;
    if([loads.loadPickedupTime isEqualToString:@""] || loads.loadPickedupTime == nil){
         NSLog(@"Show User ");
    }
    else{
         NSLog(@"Show Driver");
    }
    
    header.lblFromDate.text=[GlobalFunction stringDate:loads.pickupDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
    header.lblToDate.text=[GlobalFunction stringDate:loads.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
      header.lblToDate.text=[GlobalFunction stringDate:loads.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd"];
    header.lblFromTime.text=loads.pickupTime;
    header.lblToTime.text=loads.deliveryTime;
    NSDate *newDate = [GlobalFunction dateString:[NSString stringWithFormat:@"%@ %@",loads.delieveryDate,loads.deliveryTime] fromFormat:@"yyyy-MM-dd hh:mm a" toFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSComparisonResult result;
    result = [today compare:newDate];
    if([loads.loadStatus isEqualToString:@"0"])
    {
        int linkcount,matchcount;
        linkcount=0;
        matchcount=0;
        NSArray *valcount=[dicMatches valueForKey:[NSString stringWithFormat:@"%@",loads.internalBaseClassIdentifier]];
        for (Matches *matches in valcount)
        {
            NSInteger matchOrderStatus = matches.matchOrderStatus.integerValue;
         
            if(matchOrderStatus >= 1){
                
                linkcount = linkcount + 1;
                
            }
            else{
                
                matchcount = matchcount + 1;
                
            }
            if(matchOrderStatus == 2){
                break;
            }
//            
//       //      if([matches.matchOrderStatus isEqualToString:@"0"])
//            if([matches.matchOrderStatus isEqualToString:@"0"])
//            {
//                matchcount=matchcount+1;
//            }
//            else
//            {
//                linkcount=linkcount+1;
//            }
        }
        header.lblBlackBubble.text=[NSString stringWithFormat:@"%d",linkcount];
        header.lblOrangeBubble.text=[NSString stringWithFormat:@"%d",matchcount];
        header.vwonlylabel.hidden=YES;
        header.vwStatus.hidden=NO;
        if(result==NSOrderedDescending)
        {
            header.vwonlylabel.hidden=NO;
            header.vwStatus.hidden=YES;
            header.lblStatusText.font=[UIFont boldSystemFontOfSize:10];
            header.lblStatusText.text=@"OUT OF DATE";
            header.lblStatusText.textColor=CancelLoadButtonColor;
        }
    }
    else
    {
        
        if(result==NSOrderedDescending)
        {
            header.vwonlylabel.hidden=NO;
            header.vwStatus.hidden=YES;
            header.lblStatusText.font=[UIFont boldSystemFontOfSize:10];
            header.lblStatusText.text=@"OUT OF DATE";
            header.lblStatusText.textColor=CancelLoadButtonColor;
        }
        if([loads.visiableTo isEqualToString:@"0"])
        {
            header.vwonlylabel.backgroundColor=PrivateColor;
        }
        else
        {
            header.vwonlylabel.backgroundColor=[UIColor whiteColor];
        }
        header.vwonlylabel.hidden = NO;
        header.vwStatus.hidden = YES;
        header.lblStatusText.font=[UIFont boldSystemFontOfSize:10];
        switch ([loads.loadStatus intValue])
        {
            case 1:
            {
                header.lblStatusText.text=@"PICK UP";
                header.lblStatusText.textColor=ScheduledLoadButtonColor;
                
            }
                break;
            case 2:
            {
                header.lblStatusText.text=@"ON TIME";
                header.lblStatusText.textColor=GreenButtonColor;
            }
                break;
            case 3:
            {
                header.lblStatusText.text=@"DELAYED";
                header.lblStatusText.textColor=CancelLoadButtonColor;
            }
                break;
            case 4:
            {
                header.lblStatusText.text=@"DELIVERED";
                header.lblStatusText.textColor=GreenButtonColor;
            }
                break;
            case 5:
            {
                header.lblStatusText.text=@"SCHEDULED";
                header.lblStatusText.textColor=ScheduledLoadButtonColor;
            }
                break;
            default:
                break;
        }
    }
    header.btnLoadDetail.tag=section;
        
    return header;
}

- (UITableViewCell *)mTableView:(TQMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Loads *obj = [arrAllLoads objectAtIndex:indexPath.section];
    
    NSMutableArray *arrMatches = [dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
    
    Matches *objmatch=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"CellMatchesContainer";
    
   
    CellMatchesContainer *cell = [mTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[CellMatchesContainer alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.cellMatchesContainerDelegate=self;
    
    if(indexPath.row > 0)
    {
        cell.topViewHeight.constant = 0.0;
    }
    else
    {
        cell.topViewHeight.constant = 40.0;
       
    }
    NSArray *valcount=[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
    if(valcount.count > 1)
    {
        cell.btnMenuFilter.hidden=NO;
    }
    else
    {
        cell.btnMenuFilter.hidden=YES;
    }
    cell.lblMatchName.text=[[objmatch.companyName stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"] capitalizedString];
    
    if([objmatch.isContacted isEqualToString:@"0"])
    {
        cell.btnMail.hidden=YES;
    }
    else
    {
        cell.btnMail.hidden=NO;
    }
    if([objmatch.isFavourite isEqualToString:@""] || [objmatch.isFavourite isEqualToString:@"0"] || objmatch.isFavourite.length == 0)
    {
        cell.btnFav.hidden=YES;
    }
    else
    {
        cell.btnFav.hidden=NO;
    }
   
    if([objmatch.matchOrderStatus isEqualToString:@"0"])
    {
        cell.vwCellBg.backgroundColor=[UIColor whiteColor];
        cell.separatorInset = UIEdgeInsetsMake(0.f, 500.0, 0.f, 0.f);
        
        cell.lblSeperator.backgroundColor = ThemeOrangeColor;
        cell.lblMiles.textColor = ThemeOrangeColor;
        cell.lblMatchName.textColor = ThemeOrangeColor;
        
    }
    else
    {
        cell.vwCellBg.backgroundColor=[UIColor orangeColor];
        cell.separatorInset = UIEdgeInsetsMake(0.f, 500.0, 0.f, 0.f);
        cell.lblSeperator.backgroundColor = [UIColor whiteColor];
        cell.lblMiles.textColor = [UIColor whiteColor];
        cell.lblMatchName.textColor = [UIColor whiteColor];
        
        
    }
    
    if(indexPath.row == arrMatches.count - 1){
           cell.lblSeperator.backgroundColor = [UIColor clearColor];
    }
    
    cell.lblMiles.text=objmatch.matchDistance;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  //  cell.lblMatchName.textColor=[UIColor whiteColor];
    return cell;
    // }
}
- (void)mTableView:(TQMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [self didSelectTableEvent:indexPath];
    
    NSLog(@"---------------> Indexpath row :%ld",(long)indexPath.row);
       /* MatchDetailView *view=[[MatchDetailView alloc] initWithFrame:CGRectMake(0, 0, self.mTableView.bounds.size.width, 445)];
        view = (MatchDetailView *)[nib objectAtIndex:0]; 
        view = (MatchDetailView *)[[[NSBundle mainBundle] loadNibNamed:@"MatchDetailView" owner:self options:nil] objectAtIndex:0];
        view.frame = CGRectMake(0, 0, self.mTableView.bounds.size.width, 445);
        Loads *obj=[arrAllLoads objectAtIndex:indexPath.section];
        Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexPath.row];
        view.matchDetailViewDelegate=self;
        view.lblcname.text=[[objmatches.companyName stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"] capitalizedString];
        view.lblcaddress.text=objmatches.companyAddress;
        view.lblownername.text=[NSString stringWithFormat:@"%@ %@",objmatches.firstname,objmatches.lastname];
        view.lblonwerphone.text=objmatches.phoneNo;
        view.lblDistance.text=objmatches.matchDistance;
        view.btnCancelLoad.tag=indexPath.row;
        view.btnCancelLoad.accessibilityLabel=obj.internalBaseClassIdentifier;
    
        if([objmatches.matchOrderStatus isEqualToString:@"0"])
        {
            [view.btnStatus setTitle:LoadMatchedText forState:UIControlStateNormal];
            [view.btnStatus setBackgroundColor:[UIColor orangeColor]];
            view.btnCancelLoad.backgroundColor=LinkLoadButtonColor;
            [view.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
        }   
        else if([objmatches.matchOrderStatus isEqualToString:@"1"])
        {
            if([objmatches.isLoadInterested isEqualToString:@"0"] && [objmatches.isAssetInterested isEqualToString:@"0"]){
                
                [view.btnStatus setTitle:@"" forState:UIControlStateNormal];
                [view.btnStatus setBackgroundColor:[UIColor blackColor]];
                view.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
                [view.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
            }
            else if([objmatches.isLoadInterested isEqualToString:@"0"] && [objmatches.isAssetInterested isEqualToString:@"1"]){
                
                [view.btnStatus setTitle:@"" forState:UIControlStateNormal];
                [view.btnStatus setBackgroundColor:[UIColor blackColor]];
                view.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
                [view.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
                
            }
            else if([objmatches.isLoadInterested isEqualToString:@"1"] && [objmatches.isAssetInterested isEqualToString:@"0"]){
                
                [view.btnStatus setTitle:@"" forState:UIControlStateNormal];
                [view.btnStatus setBackgroundColor:[UIColor blackColor]];
                view.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
                [view.btnCancelLoad setTitle:AlreadyLinkRequestSent forState:UIControlStateNormal];
                
            }
            else if([objmatches.isLoadInterested isEqualToString:@"1"] && [objmatches.isAssetInterested isEqualToString:@"1"]){
                
                [view.btnStatus setTitle:LoadLinkedText forState:UIControlStateNormal];
                [view.btnStatus setBackgroundColor:[UIColor blackColor]];
                view.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
                [view.btnCancelLoad setTitle:ScheduleButtonText forState:UIControlStateNormal];
                
            }
//            [view.btnStatus setTitle:LoadLinkedText forState:UIControlStateNormal];
//            [view.btnStatus setBackgroundColor:[UIColor blackColor]];
//            view.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
//            [view.btnCancelLoad setTitle:ScheduleButtonText forState:UIControlStateNormal];
        }
        else
        {
            [view.btnStatus setTitle:LoadScheduledText forState:UIControlStateNormal];
            [view.btnStatus setBackgroundColor:[UIColor blackColor]];
            view.btnCancelLoad.backgroundColor=CancelLoadButtonColor;
            [view.btnCancelLoad setTitle:UnlinkButtonText forState:UIControlStateNormal];
        }
        if([objmatches.isLike isEqualToString:@"1"])
        {
            [view.btnLike setImage:imgNamed(@"imglikered") forState:UIControlStateNormal];
        }
        else
        {
            [view.btnLike setImage:imgNamed(@"imglikewhite") forState:UIControlStateNormal];
        }
        if([objmatches.isFavourite isEqualToString:@"1"])
        {
            [view.btnFav setImage:imgNamed(@"imgfavorange") forState:UIControlStateNormal];
        }
        else
        {
            [view.btnFav setImage:imgNamed(@"imgfavWhite") forState:UIControlStateNormal];
        }
        if([objmatches.isHide isEqualToString:@"1"])
        {
            [view.btnHide setImage:imgNamed(@"checkboxsquareselected") forState:UIControlStateNormal];
        }
        else
        {
            [view.btnHide setImage:imgNamed(@"checkboxsquare") forState:UIControlStateNormal];
        }
        self.mTableView.atomView = view;
        self.mTableView.atomView.backgroundColor=[UIColor whiteColor];*/
}

#pragma mark - Header Open Or Close
- (void)mTableView:(TQMultistageTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section
{
    selectedSection=section;
//    NSLog(@"Open Header ----%ld",section);
//     CDLoads *loads=[arrAllLoads objectAtIndex:section];
//    NSString *condition=[NSString stringWithFormat:@"matchLoadid=='%@'",loads.loadid];
//    arrAllMatches=[[CoreDataAdaptor fetchAllDataWhere:condition fromEntity:MatchEntity] mutableCopy];
//    [mTableView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)mTableView:(TQMultistageTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section
{
    // UITableViewHeaderFooterView *header = [mTableView headerViewForSection:section];
    // header.backgroundView.backgroundColor = [UIColor orangeColor];
   // NSLog(@"Close Header ---%ld",section);
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
 //   [self performSelectorInBackground:@selector(callLoadMoreData) withObject:nil];
}

#pragma mark - VC click events

- (IBAction)btnDrawerClicked:(id)sender {
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

- (IBAction)btnLoadmoreclicked:(id)sender
{
    if(limit1<totalRecords)
    {
         self.btnLoadmore.hidden=NO;
        [self performSelectorInBackground:@selector(callLoadMoreData_Loads)  withObject:nil];
    }
    else
    {
        self.btnLoadmore.hidden=YES;
    }
}


#pragma mark header view delegate

- (void)btnLoadDetailClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    Loads *obj=[arrAllLoads objectAtIndex:btn.tag];
    int ls=[obj.loadStatus intValue];
    
    LoadListDetailsVC *objLoadDetail=initVCToRedirect(SBAFTERSIGNUP, MYLOADLISTDETAILVC);
    objLoadDetail.cmpnyphno=@"";
    objLoadDetail.myphono=@"";
    objLoadDetail.officephno=@"";
    if(ls > 0)
    {
        objLoadDetail.strRedirectFrom=@"CALENDERVC";
        objLoadDetail.loadStatus = obj.loadStatus;
       
//        if(ls == 4){
//            objLoadDetail.strRedirectFrom=@"DRIVERLIST";
//        }
    }
    else
    {
        objLoadDetail.strRedirectFrom=@"";
        objLoadDetail.loadStatus = obj.loadStatus;
    }
    
    objLoadDetail.selectedLoad=obj;
    objLoadDetail.loadDetailVCProtocol=self;
    NSLog(@"%@",obj.comments);
    
    NSLog(@" LOAD STATUS  ==> %@",objLoadDetail.loadStatus);
    
    [self.navigationController pushViewController:objLoadDetail animated:YES];
}
- (void)btnDistanceSortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:distancesort]];
    arrAllLoads= [[arrAllLoads sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
     distancesort=!distancesort;
    [_mTableView reloadData];
}
- (void)btnPickupSortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"pickupDate" ascending:pickupsort]];
    arrAllLoads= [[arrAllLoads sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
       pickupsort=!pickupsort;
    [_mTableView reloadData];
}
- (void)btnDelievrySortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"delieveryDate" ascending:delieverysort]];
    arrAllLoads= [[arrAllLoads sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    delieverysort=!delieverysort;
    [_mTableView reloadData];
}
- (void)btnRateSortClicked:(id)sender
{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"offerRate" ascending:ratesort]];
    arrAllLoads= [[arrAllLoads sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
        ratesort=!ratesort;
    [_mTableView reloadData];
}
- (void)btnStatusSortClicked:(id)sender
{
    NSArray *sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"matches.@count" ascending:statussort]];
    arrAllLoads= [[arrAllLoads sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
     statussort=!statussort;
    [_mTableView reloadData];
}
#pragma mark - cell carrier name list delegate
- (IBAction)btnCloseMatchListClicked:(id)sender
{
    [_mTableView sendHeaderTouchActionWithSection:selectedSection];
}
- (IBAction)btnFavClicke:(id)sender // 
{
    
}
- (IBAction)btnMailClicked:(id)sender
{
    
}
#pragma mark - menu filter options
- (IBAction)btnMenuFilterClicked:(id)sender
{
    if(dicMatches.count >1)
    {
        menuNameArray = @[@"All Matches",@"Favorites",@"My network",@"Closest",@"Hide contacted",@"Show hidden"];
        menuImageArray = @[@"imgresetfilter",@"imgseefavorites",@"imgmynetwork",@"mapmarker1",@"imghidden",@"imgshowhidden"];
        FTPopOverMenuConfiguration *ftp=[FTPopOverMenuConfiguration defaultConfiguration];
        ftp.menuType=@"TOP";
        [FTPopOverMenu showForSender:sender
                       withMenuArray:menuNameArray
                          imageArray:menuImageArray
                           doneBlock:^(NSInteger selectedIndex)
         {
             Loads *obj=[arrAllLoads objectAtIndex:selectedSection];
             NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"matchOrderStatus = '2'"];
             NSMutableArray *arrmatches=[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
             NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
             if(filteredArray.count>0)
             {}
             else
             {
                 if(selectedIndex==0)
                 {
                     [self resetFilter];
                 }
                 else if(selectedIndex==1)
                 {
                     [self filterByFavourite:selectedIndex];
                 }
                 else if(selectedIndex==2)
                 {
                     [self filterByNetwork:selectedIndex];
                 }
                 else if(selectedIndex==3)
                 {
                     [self filterByDistance:selectedIndex];
                 }
                 else if(selectedIndex==4)
                 {
                     [self filterBycontacted:selectedIndex];
                 }
                 else
                 {
                     [self filterByHidden:selectedIndex];
                 }
             }
             
         } dismissBlock:^{
             
         }];
    }
    else
    {
        [AZNotification showNotificationWithTitle:@"Filter is disable for single record" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
    }
    
}
-(void)resetFilter
{
    Loads *obj=[arrAllLoads objectAtIndex:selectedSection];
//    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"matchOrderStatus != '0'"];
//    NSMutableArray *arrmatches=[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
//    NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
//    if(filteredArray.count==0)
//    {
        NSMutableArray *arrmatches=[dicmatchClone valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
        [dicMatches setObject:arrmatches forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
        [_mTableView reloadData];
        [_mTableView sendHeaderTouchActionWithSection:selectedSection]; 
   // }
   
}
-(void)filterByDistance:(NSInteger)selectedIndex
{
    Loads *obj=[arrAllLoads objectAtIndex:selectedSection];
     NSMutableArray *arrmatches=[dicmatchClone valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"matchDistance" ascending:closestsort]];
     NSArray* sorted= [[arrmatches sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    closestsort=!closestsort;
    [dicMatches setObject:[sorted mutableCopy] forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
    [_mTableView.tableView reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)filterByNetwork:(NSInteger)selectedIndex
{
    Loads *obj=[arrAllLoads objectAtIndex:selectedSection];
    User *obju=[DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    UserAccount *objuse=[obju.userAccount objectAtIndex:0];
        if(objuse.dotNumber.length==0)
        {
            NSString *strLat=objuse.officeLatitude;
            NSString *strLon=objuse.officeLongitude;
            NSString *strPredicae=[NSString stringWithFormat:@"officeLatitude='%@' and officeLongitude ='%@'",strLat,strLon];
            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:strPredicae];
            NSMutableArray *arrmatches=[dicmatchClone valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
            NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
            if(filteredArray.count>0)
            {
                [dicMatches setObject:filteredArray forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
                [_mTableView reloadData];
                [_mTableView sendHeaderTouchActionWithSection:selectedSection];
            }
            else
            {
                [self resetFilter];
                [AZNotification showNotificationWithTitle:@"No match is near to you" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }
        else
        {
            NSString *str=[NSString stringWithFormat:@"dotNumber='%@'",objuse.dotNumber];
            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:str];
            NSMutableArray *arrmatches=[dicmatchClone valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
            NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
            if(filteredArray.count>0)
            {
                [dicMatches setObject:filteredArray forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
                [_mTableView reloadData];
                [_mTableView sendHeaderTouchActionWithSection:selectedSection];
            }
            else
            {
                [self resetFilter];
                [AZNotification showNotificationWithTitle:@"No match is closest to you" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }
        
    //}
}
-(void)filterByFavourite:(NSInteger)selectedIndex
{
    Loads *obj=[arrAllLoads objectAtIndex:selectedSection];
//    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"matchOrderStatus != '0'"];
//    NSMutableArray *arrmatches=[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
//    NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
//    if(filteredArray.count==0)
//    {
//        
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"isFavourite = '1'"];
        NSMutableArray *arrmatches=[dicmatchClone valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
        NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
        if(filteredArray.count>0)
        {
            [dicMatches setObject:filteredArray forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
            [_mTableView reloadData];
            [_mTableView sendHeaderTouchActionWithSection:selectedSection];
        }
        else
        {
            [self resetFilter];
            [AZNotification showNotificationWithTitle:@"No match is marked as favourite by you" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
   // }
}
-(void)filterByHidden:(NSInteger)selectedIndex
{
    Loads *obj=[arrAllLoads objectAtIndex:selectedSection];
//    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"matchOrderStatus != '0'"];
//    NSMutableArray *arrmatches=[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
//    NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
//    if(filteredArray.count==0)
//    {
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"isHide = '1'"];
    NSMutableArray *arrmatches=[dicmatchClone valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
    NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
    if(filteredArray.count>0)
    {
        [dicMatches setObject:filteredArray forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
        [_mTableView reloadData];
        [_mTableView sendHeaderTouchActionWithSection:selectedSection];
    }
    else
    {
        [self resetFilter];
        [AZNotification showNotificationWithTitle:@"No match hide by you" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
    }
 //   }
}

-(void)filterBycontacted:(NSInteger)selectedIndex
{
    Loads *obj=[arrAllLoads objectAtIndex:selectedSection];
//    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"matchOrderStatus != '0'"];
//    NSMutableArray *arrmatches=[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
//    NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
//    if(filteredArray.count==0)
//    {
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"isContacted = '0'"];
        NSMutableArray *arrmatches=[dicmatchClone valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
        NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
        if(filteredArray.count>0)
        {
            [dicMatches setObject:filteredArray forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
            [_mTableView reloadData];
            [_mTableView sendHeaderTouchActionWithSection:selectedSection];
        }
        else
        {
            [self resetFilter];
            [AZNotification showNotificationWithTitle:@"No match is contacted by you" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
    //}
}
#pragma mark - Match Detail Delegate
- (void)handleMatchlblDistanceTap:(UITapGestureRecognizer *)tapRecognizer
{
    Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
    Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
    NSString *lat,*lon;
    if(objmatches.officeLatitude.length==0)
    {
        lat=objmatches.companyLatitude;
        lon=objmatches.companyLongitude;
    }
    else
    {
        lat=objmatches.officeLatitude;
        lon=objmatches.officeLongitude;
    }
    NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@,%@&daddr=%@,%@",obj.pickupLatitude,obj.pickupLongitude,lat,lon];
    WebContentVC *objwebvc=initVCToRedirect(SBMAIN, WEBCONTENTVC);
    objwebvc.webURL=url;
     [self.navigationController pushViewController:objwebvc animated:YES];
    
}
- (void)handleMatchlblAddressTap:(UITapGestureRecognizer *)tapRecognizer
{
    Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
    Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
    NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%@",objmatches.address];
    NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    WebContentVC *objwebvc=initVCToRedirect(SBMAIN, WEBCONTENTVC);
    objwebvc.webURL=encodedString;
    [self.navigationController pushViewController:objwebvc animated:YES];
}
- (void)btnStatusClicked:(id)sender
{
     [_mTableView sendCellTouchActionWithIndexPath:indexpathAtOpenedRow];
}
- (void)btnLikeClicked:(id)sender
{
    @try 
    {
        MatchDetailView *matchView=  (MatchDetailView *)self.mTableView.atomView;
        CellMatchesContainer *cell=(CellMatchesContainer *)[_mTableView tableView:_mTableView.tableView cellForRowAtIndexPath:indexpathAtOpenedRow];
        cell.vwCellBg.backgroundColor=[UIColor blackColor];
        [matchView.btnCancelLoad setTitle:ScheduleButtonText forState:UIControlStateNormal];
        Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
        Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
        if([objmatches.matchOrderStatus isEqualToString:@"0"])
        {
            [matchView.btnStatus setTitle:LoadMatchedText forState:UIControlStateNormal];
            [matchView.btnStatus setBackgroundColor:[UIColor orangeColor]];
            matchView.btnCancelLoad.backgroundColor=LinkLoadButtonColor;
            [matchView.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
        }   
        else if([objmatches.matchOrderStatus isEqualToString:@"1"])
        {
            [matchView.btnStatus setTitle:LoadLinkedText forState:UIControlStateNormal];
            [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
            matchView.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
            [matchView.btnCancelLoad setTitle:ScheduleButtonText forState:UIControlStateNormal];
        } 
        else
        {
            [matchView.btnStatus setTitle:LoadScheduledText forState:UIControlStateNormal];
            [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
            matchView.btnCancelLoad.backgroundColor=CancelLoadButtonColor;
            [matchView.btnCancelLoad setTitle:UnlinkButtonText forState:UIControlStateNormal];
        }
        NSString *likeflag;
        if([objmatches.isLike isEqualToString:@"0"])
        {
            likeflag=@"1";
            
            [matchView.btnLike setImage:imgNamed(@"imglikered") forState:UIControlStateNormal];
        }
        else
        {
            likeflag=@"0";
            [matchView.btnLike setImage:imgNamed(@"imglikewhite") forState:UIControlStateNormal];
        }
        NSMutableArray *arrmatches=[NSMutableArray arrayWithArray:[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]]];
        [arrmatches enumerateObjectsUsingBlock:^(Matches *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([objmatch.matchId isEqualToString:objmatches.matchId])
            {
                objmatch.isLike=likeflag;
                [arrmatches replaceObjectAtIndex:idx withObject:objmatch];
            }
        }];
        [dicMatches setObject:arrmatches forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
        NSDictionary *dic=@{
                            Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                            Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                            Req_matchid:objmatches.matchId,
                            Req_is_like:likeflag
                            };
        [self performSelector:@selector(markAsLike:) 
                   withObject:dic];
    } 
    @catch (NSException *exception) 
    {
         NSLog(@"Exception :%@",exception.description);
    } 
    
}
- (void)btnFavClicked:(id)sender
{
    @try 
    {
        MatchDetailView *matchView=  (MatchDetailView *)self.mTableView.atomView;
        CellMatchesContainer *cell=(CellMatchesContainer *)[_mTableView tableView:_mTableView.tableView cellForRowAtIndexPath:indexpathAtOpenedRow];
        cell.vwCellBg.backgroundColor=[UIColor blackColor];
        [matchView.btnCancelLoad setTitle:ScheduleButtonText forState:UIControlStateNormal];
        Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
        Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
        if([objmatches.matchOrderStatus isEqualToString:@"0"])
        {
            [matchView.btnStatus setTitle:LoadMatchedText forState:UIControlStateNormal];
            [matchView.btnStatus setBackgroundColor:[UIColor orangeColor]];
            matchView.btnCancelLoad.backgroundColor=LinkLoadButtonColor;
            [matchView.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
        }   
        else if([objmatches.matchOrderStatus isEqualToString:@"1"])
        {
            [matchView.btnStatus setTitle:LoadLinkedText forState:UIControlStateNormal];
            [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
            matchView.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
            [matchView.btnCancelLoad setTitle:ScheduleButtonText forState:UIControlStateNormal];
        } 
        else
        {
            [matchView.btnStatus setTitle:LoadScheduledText forState:UIControlStateNormal];
            [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
            matchView.btnCancelLoad.backgroundColor=CancelLoadButtonColor;
            [matchView.btnCancelLoad setTitle:UnlinkButtonText forState:UIControlStateNormal];
        }
        NSString *favflag;
        if([objmatches.isFavourite isEqualToString:@"0"] || [objmatches.isFavourite isEqualToString:@""])
        {
            favflag=@"1";
            [matchView.btnFav setImage:imgNamed(@"imgfavorange") forState:UIControlStateNormal];
            cell.btnFav.hidden=NO;
        }
        else
        {
            favflag=@"0";
            [matchView.btnFav setImage:imgNamed(@"imgfavWhite") forState:UIControlStateNormal];
            cell.btnFav.hidden=YES;
        }
        NSMutableArray *arrmatches=[NSMutableArray arrayWithArray:[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]]];
        [arrmatches enumerateObjectsUsingBlock:^(Matches *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([objmatch.matchId isEqualToString:objmatches.matchId])
            {
                objmatch.isFavourite=favflag;
                [arrmatches replaceObjectAtIndex:idx withObject:objmatch];
            }
        }];
        AppInstance.arrAllEquipmentByUserId=nil;
        AppInstance.countEquiByUid=@"0";
        
        [dicMatches setObject:arrmatches forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
        [_mTableView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpathAtOpenedRow] withRowAnimation:UITableViewRowAnimationNone];
        NSDictionary *dic=@{  Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                              Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                              Req_f_from_id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                              Req_is_fav:favflag,
                              Req_f_to_id:objmatches.parentId,
                              };
        [self performSelector:@selector(markAsFav:) 
                   withObject:dic];
    } 
    @catch (NSException *exception) 
    {
        NSLog(@"Exception :%@",exception.description);
    } 
}
- (void)btnShareClicked:(id)sender
{
     MatchDetailView *matchView=  (MatchDetailView *)self.mTableView.atomView;
    NSString *addressval;
    if(matchView.lblcaddress.text.length>0 && ![matchView.lblcaddress.text isEqualToString:@"(null)"])
    {
        addressval=[NSString stringWithFormat:@"Company Address : \n%@",matchView.lblcaddress.text];
    }
    else
    {
        addressval=@"";
    }
 //   NSString *initTxt=[NSString stringWithFormat:@"Owner Name :%@\n\nCompany Name :\n%@\n\n%@\n\nPhone:%@\n\n%@\n",matchView.lblownername.text,[addressval capitalizedString],[matchView.lblcaddress.text capitalizedString],matchView.lblonwerphone.text,matchView.lbltimeopen.text];
    
    NSString *initTxt=[NSString stringWithFormat:@"Owner Name :%@\n\nCompany Name :\n%@\n\n%@\n\nPhone:%@\n\n%@\n",matchView.lblownername.text,[matchView.lblcname.text capitalizedString],[addressval capitalizedString],matchView.lblonwerphone.text,matchView.lbltimeopen.text];
    
    
    NSArray *sharedObjects=@[initTxt];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharedObjects applicationActivities:nil];
    activityController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
}
- (void)btnHideClicked:(id)sender
{
    @try 
    {
            MatchDetailView *matchView=  (MatchDetailView *)self.mTableView.atomView;
            CellMatchesContainer *cell=(CellMatchesContainer *)[_mTableView tableView:_mTableView.tableView cellForRowAtIndexPath:indexpathAtOpenedRow];
            cell.vwCellBg.backgroundColor=[UIColor blackColor];
            Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
            Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
            if([objmatches.matchOrderStatus isEqualToString:@"0"])
            {
                [matchView.btnStatus setTitle:LoadMatchedText forState:UIControlStateNormal];
                [matchView.btnStatus setBackgroundColor:[UIColor orangeColor]];
                matchView.btnCancelLoad.backgroundColor=LinkLoadButtonColor;
                [matchView.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
            }   
            else if([objmatches.matchOrderStatus isEqualToString:@"1"])
            {
                NSLog(@"WE NEED TO MAKE CHANGES HJERE ???");
                
                [matchView.btnStatus setTitle:LoadLinkedText forState:UIControlStateNormal];
                [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
                matchView.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
                [matchView.btnCancelLoad setTitle:ScheduleButtonText forState:UIControlStateNormal];
            } 
            else
            {
                [matchView.btnStatus setTitle:LoadScheduledText forState:UIControlStateNormal];
                [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
                matchView.btnCancelLoad.backgroundColor=CancelLoadButtonColor;
                [matchView.btnCancelLoad setTitle:UnlinkButtonText forState:UIControlStateNormal];
            }
            NSString *hideflag;
            if([objmatches.isHide isEqualToString:@"0"])
            {
                hideflag=@"1";
                [matchView.btnHide setImage:imgNamed(@"checkboxsquareselected") forState:UIControlStateNormal];
            }
            else
            {
                hideflag=@"0";
                [matchView.btnHide setImage:imgNamed(@"checkboxsquare") forState:UIControlStateNormal];
            }
        NSMutableArray *arrmatches=[NSMutableArray arrayWithArray:[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]]];
            [arrmatches enumerateObjectsUsingBlock:^(Matches *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([objmatch.matchId isEqualToString:objmatches.matchId])
                {
                    objmatch.isHide=hideflag;
                    [arrmatches replaceObjectAtIndex:idx withObject:objmatch];
                }
            }];
            [dicMatches setObject:arrmatches forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
            NSDictionary *dic=@{
                                                            Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                                            Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                                            Req_matchid:objmatches.matchId,
                                                            Req_is_hide:hideflag
                                                            };

            [self performSelector:@selector(markAsHide:) 
                       withObject:dic];
        
    } @catch (NSException *exception) {
        NSLog(@"Exception 805 :%@",exception.description);
    } 
}
- (void)btnDetailMenuDrawerclicked:(id)sender
{
    Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
    Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
    NSString *lblMenuname1,*lblMenuname2,*lblMenuname3,*iscontact,*ishide,*imghide,*imgunhide;
    if([objmatches.isContacted isEqualToString:@"0"])
    {
        lblMenuname1=@"Mark as contacted";
        iscontact=@"1";
        
    }
    else
    {
         lblMenuname1=@"Mark as uncontacted";
        iscontact=@"0";
    }
    if([objmatches.isHide isEqualToString:@"0"])
    {
        ishide=@"1";
        lblMenuname2=@"Hide this";
        imghide=@"imghidden";
    }
    else
    {
         ishide=@"0";
        lblMenuname2=@"Unhide this";
         imghide=@"imgshowhidden";
    }
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"isHide = '1'"];
    NSMutableArray *arrmatches=[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
    NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
    if(filteredArray.count == arrmatches.count)
    {
          lblMenuname3=@"Unhide all";
        imgunhide=@"imgshowhidden";
    }
    else
    {
          lblMenuname3=@"Hide all";
        imgunhide=@"imghidden";
    }
    NSArray *menuNameArray2= @[lblMenuname1,lblMenuname2,@"Share",@"Find on map",lblMenuname3];
    NSArray *menuImageArray2 = @[@"imgcontacted",imghide,@"imgsharewhite",@"mapmarker1",imgunhide];
    FTPopOverMenuConfiguration *ftp=[FTPopOverMenuConfiguration defaultConfiguration];
    ftp.menuType=@"BOTTOM";
    [FTPopOverMenu showForSender:sender
                   withMenuArray:menuNameArray2
                      imageArray:menuImageArray2
                       doneBlock:^(NSInteger selectedIndex)
                        {
                                 if(selectedIndex==0)
                                 {
                                     [self markAsContactedmenu_clicked:iscontact];
                                 }
                                 else if(selectedIndex==1)
                                 {
                                     [self hidethismenu_clicked];
                                 }
                                 else if(selectedIndex==2)
                                 {
                                     [self sharemenu_clicked];
                                 }
                                 else if(selectedIndex==3)
                                 {
                                     [self findonmapmenu_clicked];
                                 }
                                 else
                                 {
                                     [self unhideallmenu_clicked:ishide];
                                 }
                         } dismissBlock:^{
                         }];
}
-(void)markAsContactedmenu_clicked:(NSString *)str
{
    [self updateConatctFlagonServer:str];
}
-(void)hidethismenu_clicked
{
    MatchDetailView *matchView=  (MatchDetailView *)self.mTableView.atomView;
    [self btnHideClicked:matchView.btnHide];
}
-(void)sharemenu_clicked
{
    MatchDetailView *matchView=  (MatchDetailView *)self.mTableView.atomView;
    [self btnShareClicked:matchView.btnShare];
}
-(void)findonmapmenu_clicked
{
    Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
    Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
   
    NSString *lat,*lon;
    if(objmatches.officeLatitude.length==0)
    {
        lat=objmatches.companyLatitude;
        lon=objmatches.companyLongitude;
    }
    else
    {
        lat=objmatches.officeLatitude;
        lon=objmatches.officeLongitude;
    }
    
 NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%@,%@",lat,lon];
    WebContentVC *objwebvc=initVCToRedirect(SBMAIN, WEBCONTENTVC);
    objwebvc.webURL=url;
    [self.navigationController pushViewController:objwebvc animated:YES];
}
-(void)unhideallmenu_clicked:(NSString *)str
{
    Loads *obj=[arrAllLoads objectAtIndex:selectedSection];
    NSString *markunhideString=@"0";
    NSMutableArray *arrMatch=[NSMutableArray arrayWithArray:obj.matches];
    NSMutableArray *arrTempMatch=[NSMutableArray new];
    for(Matches *objlmatches in arrMatch)
    {
        objlmatches.isHide=str;
        markunhideString=[markunhideString stringByAppendingString:[NSString stringWithFormat:@",%@",objlmatches.matchId]];
        if([objlmatches.matchOrderStatus  isEqualToString:@"2"] && objlmatches.matchFromId == [DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId])
        {
            [arrTempMatch addObject:objlmatches];
            break;
        }
        else
        {
           NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(parentId ==  '%@')",objlmatches.parentId]];
            if([[arrTempMatch filteredArrayUsingPredicate:predicate] count] == 0)
            {
                if(![objlmatches.matchOrderStatus  isEqualToString:@"2"])
                {
                    [arrTempMatch addObject:objlmatches];
                }
            }
        }
    }
    [dicMatches setObject:arrTempMatch forKey:obj.internalBaseClassIdentifier];
    AppInstance.dicAllMatchByLoadId=dicMatches;
    dicmatchClone = [NSKeyedUnarchiver unarchiveObjectWithData:
                     [NSKeyedArchiver archivedDataWithRootObject:dicMatches]];
  
    [_mTableView reloadData];
    [_mTableView sendHeaderTouchActionWithSection:selectedSection];
    NSDictionary *dic=@{
                        Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                        Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                        Req_matchid:markunhideString,
                        Req_is_hide:str
                        };
    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLIsHideMatch
         withParameters:dic
         withObject:self
         withSelector:@selector(getHideUnHideAllResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Marking As Hidden"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }

}
- (void)btnCancelLoadClicked:(id)sender
{
   
    UIButton *btn=(UIButton *)sender;
    NSString *statusvalue;
    Matches *objmatches=[[dicMatches valueForKey:btn.accessibilityLabel] objectAtIndex:btn.tag];
    
    if([btn.titleLabel.text isEqualToString:AlreadyLinkRequestSent]){
        //already interested no action needed
        return;
        
    }
    if([btn.titleLabel.text isEqualToString:LinkButtonText])
    {
        statusvalue=@"1";
        NSDictionary *dicLink=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_OrderFromId:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_OrderToId:objmatches.parentId,
                                Req_LoadId:objmatches.matchLoadid,
                                Req_EquiId:objmatches.matchEquiid,
                                Req_OrderType:statusvalue,
                                @"load_owner_id":[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                @"equi_owner_id":objmatches.matchToId,
                                @"is_carrier":@"0"
                                };
        [self linkALoadFromMatch:dicLink];
    }
    else if([btn.titleLabel.text isEqualToString:ScheduleButtonText])
    {
        statusvalue=@"2";
        NSDictionary *dicLink=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_OrderFromId:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_OrderToId:objmatches.parentId,
                                Req_LoadId:objmatches.matchLoadid,
                                Req_EquiId:objmatches.matchEquiid,
                                Req_OrderType:statusvalue,
                                Req_identifier:objmatches.matchOrderId,
                                Req_isLoadLink:@"1"};    
        [self updateStatusValue:dicLink];
        //return;
    }
    else
    {
        statusvalue=@"0";
        NSDictionary *dicLink=@{
                                Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                Req_OrderFromId:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                Req_OrderToId:objmatches.parentId,
                                Req_LoadId:objmatches.matchLoadid,
                                Req_EquiId:objmatches.matchEquiid,
                                Req_isLoadLink:@"yes",
                                Req_OrderType:statusvalue,
                                Req_identifier:objmatches.matchOrderId};    
        [self cancelStatusValue:dicLink];
    }
  
    
}
- (void)btnConatctOwnerClicked:(id)sender
{
    Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
    Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"CALL" message:@"Please select number to make a call" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
      
    }]];
    if(objmatches.phoneNo.length >0)
    {
        NSString *str=[NSString stringWithFormat:@"Personal Phone: %@",objmatches.phoneNo];
        [actionSheet addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",objmatches.phoneNo]];
            if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
            {
                [[UIApplication sharedApplication] openURL:phoneUrl];
            } 
            else
            {
                [AZNotification showNotificationWithTitle:CallFacilityNotAvailable controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
            
        }]];
    }
   
    if(objmatches.officePhoneNo.length >0)
    {
        NSString *str=[NSString stringWithFormat:@"Office Phone: %@",objmatches.officePhoneNo];
        [actionSheet addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",objmatches.officePhoneNo]];
            if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
            {
                [[UIApplication sharedApplication] openURL:phoneUrl];
            } 
            else
            {
                [AZNotification showNotificationWithTitle:CallFacilityNotAvailable controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
            
            
        }]];
    }
    
    if(objmatches.cmpnyPhoneNo.length >0)
    {
        
        NSString *str=[NSString stringWithFormat:@"Company Phone: %@",objmatches.cmpnyPhoneNo];
        [actionSheet addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",objmatches.cmpnyPhoneNo]];
            if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
            {
                [[UIApplication sharedApplication] openURL:phoneUrl];
            } 
            else
            {
                [AZNotification showNotificationWithTitle:CallFacilityNotAvailable controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
        }]];
    }
    [self presentViewController:actionSheet animated:YES completion:nil];
  
//    if ([MFMailComposeViewController canSendMail]) 
//    {
//        Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
//        Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
//        MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
//        NSString *initTxt=[NSString stringWithFormat:@"%@",MailComposerBodytext];
//        [emailDialog setSubject:MailComposerSubjectWhenContact];
//        [emailDialog setToRecipients:[NSArray arrayWithObjects:objmatches.primaryEmailId,objmatches.secondaryEmailId, nil]];
//        [emailDialog setMessageBody:initTxt isHTML:NO];
//        [emailDialog setMailComposeDelegate:self];
//        [self.navigationController presentViewController:emailDialog animated:YES completion:nil];
//    }
}
- (void)btnChatOwnerClicked:(id)sender
{
    Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
    Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"SEND SMS" message:@"Please select number to send sms" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    if(objmatches.phoneNo.length >0)
    {
         NSString *str=[NSString stringWithFormat:@"Personal Phone: %@",objmatches.phoneNo];
        [actionSheet addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self sendSMS:@"" recipientList:[NSArray arrayWithObjects:objmatches.phoneNo, nil]];            
        }]];
    }
    
    if(objmatches.officePhoneNo.length >0)
    {
        NSString *str=[NSString stringWithFormat:@"Office Phone: %@",objmatches.officePhoneNo];
        [actionSheet addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
          
            [self sendSMS:@"" recipientList:[NSArray arrayWithObjects:objmatches.officePhoneNo, nil]];
        }]];
    }
    
    if(objmatches.cmpnyPhoneNo.length >0)
    {
        
        NSString *str=[NSString stringWithFormat:@"Company Phone: %@",objmatches.cmpnyPhoneNo];
        [actionSheet addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self sendSMS:@"" recipientList:[NSArray arrayWithObjects:objmatches.cmpnyPhoneNo, nil]];
        }]];
    }
    [self presentViewController:actionSheet animated:YES completion:nil];
   
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
            
        case MFMailComposeResultSaved:
            break;
            
        case MFMailComposeResultSent:
        {
            [self updateConatctFlagonServer:@"1"];
        }
        break;
            
        case MFMailComposeResultFailed:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)updateConatctFlagonServer:(NSString *)str
{
    Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
    Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
    NSMutableArray *arrmatches=[NSMutableArray arrayWithArray:[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]]];
    [arrmatches enumerateObjectsUsingBlock:^(Matches *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([objmatch.matchId isEqualToString:objmatches.matchId])
        {
            objmatch.isContacted=str;
            [arrmatches replaceObjectAtIndex:idx withObject:objmatch];
        }
    }];
    AppInstance.arrAllEquipmentByUserId=nil;
    AppInstance.countEquiByUid=@"0";
    [dicMatches setObject:arrmatches forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
    [_mTableView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpathAtOpenedRow] withRowAnimation:UITableViewRowAnimationNone];
    NSDictionary *dic=@{  Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey], Req_matchid:objmatches.matchId,Req_is_contacted:str};
    [self performSelector:@selector(markAsContacted:) 
               withObject:dic];
}
#pragma mark - Webservice handling
-(void)callLoadMoreData_Loads
{
        NSLog(@"Limit 1 :------> %d",limit1);
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
             init:URLGetAllLoadByUserId
             withParameters:dicAllLoads
             withObject:self
             withSelector:@selector(getdicAllLoadsResponseLoadmore:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Fetching Loads"
             showProgress:NO];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
}
-(IBAction)getdicAllLoadsResponseLoadmore:(id)sender
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
            for (Loads *loads in [sender responseArray])
            {
//                if(loads.loadStatus.intValue == 0)
//                {
                    [arrAllLoads addObject:loads];
                    
//                }
//                else
//                {
//                    [arrScheduledLoad addObject:loads];
//                }
            }
           
            for(Loads *obj in [sender responseArray])
            {
                NSMutableArray* arrMatch=[NSMutableArray arrayWithArray:obj.matches];
                
                // NSMutableArray *arrTempMatch = [NSMutableArray new];
                // NSPredicate  *predicate;
                for(Matches *objlmatches in arrMatch)
                {
                    NSMutableArray *arr=[[NSMutableArray alloc]init];
                    if([dicMatches objectForKey:objlmatches.matchLoadid])
                    {
                        NSString *strParentId = objlmatches.parentId;
                        
                        arr= [dicMatches objectForKey:objlmatches.matchLoadid];
                        NSArray *filtered = [arr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"parentId == %@", strParentId]];
                        if(filtered.count == 0)
                        {
                            [arr addObject:objlmatches];
                        }
                        else{
                            
                            if([objlmatches.matchOrderStatus isEqualToString:@"1"]){
                                
                                //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentId == %@",strParentId];
                                
                                NSInteger matchedIndex = [arr indexOfObject:[filtered objectAtIndex:0]];
                                
                                [arr replaceObjectAtIndex:matchedIndex withObject:objlmatches];
                                
                                
                            }
                        }
                        [dicMatches setObject:arr forKey:[NSString stringWithFormat:@"%@",objlmatches.matchLoadid]];
                    }
                    else
                    {
                       
                        [arr addObject:objlmatches];
                        [dicMatches setObject:arr forKey:[NSString stringWithFormat:@"%@",objlmatches.matchLoadid]];
                    }
                }
            }
           
            AppInstance.arrAllLoadByUserId=arrAllLoads;
            AppInstance.dicAllMatchByLoadId=dicMatches;
            dicmatchClone = [NSKeyedUnarchiver unarchiveObjectWithData:
                             [NSKeyedArchiver archivedDataWithRootObject:dicMatches]];
            for(Loads *obj in arrAllLoads)
            {
                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"matchOrderStatus = '2'"];
                NSMutableArray *arrmatches=[dicmatchClone valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
                NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
                if(filteredArray.count>0)
                {
                    [dicMatches setObject:filteredArray forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
                }
            }
            
            [FTPopOverMenu dismiss];
            [self.mTableView reloadData];
            if(arrScheduledLoad.count >0)
            {
                [self.tblScheduledList reloadData];
                self.tblScheduledList.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
            
            limit1=limit1+limit2;
            limit2=constLimit; 
            if(limit1<totalRecords)
            {
                self.btnLoadmore.hidden=NO;
                self.mTableView.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
              //  [self performSelectorInBackground:@selector(callLoadMoreData_Loads)  withObject:nil];
            }
            else
            {
                self.btnLoadmore.hidden=YES;
                self.mTableView.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }
        else
        {
            self.mTableView.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}

-(void)getAllLoadDetail:(BOOL)showloader :(BOOL)showFullScreenloader
{
    limit1=0;
    limit2=constLimit;
    if(showloader)
    {
         [self showHUD:@"Fetching Loads"];
         //[_mTableView.tableView setLoaderWithString:@"Fetching Loads"];
    }
    else
    {
        self.mTableView.tableView.backgroundView=nil;
    }
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
        if(showFullScreenloader)
        {
            [self showHUD:@"Reseting Load Matches"];
        }
        [[WebServiceConnector alloc]
         init:URLGetAllLoadByUserId
         withParameters:dicAllLoads
         withObject:self
         withSelector:@selector(getdicAllLoadsResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Reseting Load Matches"
         showProgress:showFullScreenloader];
    }
    else
    {
        [self dismissHUD];
         self.mTableView.tableView.backgroundView=nil;
        //[AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        [self showAlertForRetry:NetworkLost];
    }
}
-(void)showAlertForRetry:(NSString *)str
{
    NSString *msg=[NSString stringWithFormat:@"%@",str];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
                                [self getAllLoadDetail:YES :NO];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}   
-(IBAction)getdicAllLoadsResponse:(id)sender
{
    [self dismissHUD];
    ShowNetworkIndicator(NO);
    if ([sender serviceResponseCode] != 100)
    {
            [self showAlertForRetry:[sender responseError]];

        
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            arrAllLoads=[NSMutableArray new];
            arrAllMatches=[NSMutableArray new];
            arrScheduledLoad = [NSMutableArray new];
          
            for (Loads *loads in [sender responseArray])
            {
//                if(loads.loadStatus.intValue == 0)
//                {
                    [arrAllLoads addObject:loads];
//                    
//                }
//                else
//                {
//                    [arrScheduledLoad addObject:loads];
//                }
            }
            totalRecords = [APITotalLoad intValue];
            AppInstance.countLodByUid=APITotalLoad;
            dicMatches=[NSMutableDictionary new];
         
            for(Loads *obj in arrAllLoads)
            {
                NSMutableArray* arrMatch = [NSMutableArray arrayWithArray:obj.matches];
                
               // NSMutableArray *arrTempMatch = [NSMutableArray new];
               // NSPredicate  *predicate;
             
                for(Matches *objlmatches in arrMatch)
                    {
                        if([dicMatches objectForKey:objlmatches.matchLoadid])
                        {
                            NSString *strParentId = objlmatches.parentId;
                            
                            NSMutableArray *arr= [dicMatches objectForKey:objlmatches.matchLoadid];
                            NSArray *filtered = [arr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"parentId == %@", strParentId]];
                            if(filtered.count == 0)
                            {
                                [arr addObject:objlmatches];
                            }
                            else{
                                
                                if([objlmatches.matchOrderStatus isEqualToString:@"1"]){
                                    
                                    NSInteger matchedIndex = [arr indexOfObject:[filtered objectAtIndex:0]];
                                    
                                    [arr replaceObjectAtIndex:matchedIndex withObject:objlmatches];
                                    
                                    
                                }
                            }
                            [dicMatches setObject:arr forKey:[NSString stringWithFormat:@"%@",objlmatches.matchLoadid]];
                        }
                        else
                        {
                            NSMutableArray *arr=[[NSMutableArray alloc]init];
                            [arr addObject:objlmatches];
                            [dicMatches setObject:arr forKey:[NSString stringWithFormat:@"%@",objlmatches.matchLoadid]];
                        }
                    }
            }
            
            AppInstance.arrAllScheduledLoadByUserId = arrScheduledLoad;
            AppInstance.arrAllLoadByUserId = arrAllLoads;
            AppInstance.dicAllMatchByLoadId = dicMatches;

            dicmatchClone = [NSKeyedUnarchiver unarchiveObjectWithData:
                                      [NSKeyedArchiver archivedDataWithRootObject:dicMatches]];
//            AppInstance.arrAllLoadByUserId=arrAllLoads;
//            AppInstance.dicAllMatchByLoadId=dicMatches;
//            dicmatchClone = [NSKeyedUnarchiver unarchiveObjectWithData:
//                             [NSKeyedArchiver archivedDataWithRootObject:dicMatches]];
            for(Loads *obj in arrAllLoads)
            {
                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"matchOrderStatus = '2'"];
                NSMutableArray *arrmatches=[dicmatchClone valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
                NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
                if(filteredArray.count>0)
                {
                    [dicMatches setObject:filteredArray forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
                }
            }
            [FTPopOverMenu dismiss];
         
            if([iscancelled isEqualToString:@"yes"])
            {   
                 [self.mTableView.tableView reloadData];
            }
            else
            {
                 [self.mTableView reloadData];
            }
            if(arrScheduledLoad.count >0)
            {
                [self.tblScheduledList reloadData];
                self.tblScheduledList.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
            limit1=limit1+limit2;
            limit2=constLimit;
            if(arrAllLoads.count == 0)
            {
                [self.mTableView.tableView setBlankPlaceHolderWithString:NoLoadFound];
                self.mTableView.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
                self.btnLoadmore.hidden=YES;
            }
            else
            {
                if(limit1<totalRecords)
                {
                    self.btnLoadmore.hidden=NO;
                }
                else
                {
                    self.btnLoadmore.hidden=YES;
                }
                self.mTableView.tableView.backgroundView=nil;
                self.mTableView.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }
        else
        {
             [self.mTableView reloadData];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
            [self.mTableView.tableView setBlankPlaceHolderWithString:APIResponseMessage];
            self.mTableView.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
             self.btnLoadmore.hidden=YES;
            if(arrScheduledLoad.count >0)
            {
                [self.tblScheduledList reloadData];
                self.tblScheduledList.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
            }
        }
    }
}

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
         showDisplayMsg:@"Linking with matches"
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
            MatchDetailView *matchView=  (MatchDetailView *)self.mTableView.atomView;
            CellMatchesContainer *cell=(CellMatchesContainer *)[_mTableView tableView:_mTableView.tableView cellForRowAtIndexPath:indexpathAtOpenedRow];
            cell.vwCellBg.backgroundColor=[UIColor blackColor];
            
            [matchView.btnStatus setTitle:LoadScheduledText forState:UIControlStateNormal];
            matchView.btnCancelLoad.backgroundColor=CancelLoadButtonColor;
            [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
            [matchView.btnCancelLoad setTitle:UnlinkButtonText forState:UIControlStateNormal];
            Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
            Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
            NSMutableArray *arrmatches=[NSMutableArray arrayWithArray:[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]]];
            [arrmatches enumerateObjectsUsingBlock:^(Matches *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([objmatch.matchId isEqualToString:objmatches.matchId])
                {
                    objmatch.matchOrderStatus=@"2";
                    [arrmatches replaceObjectAtIndex:idx withObject:objmatch];
                }
            }];
            AppInstance.arrAllEquipmentByUserId=nil;
            AppInstance.countEquiByUid=@"0";
            [dicMatches setObject:arrmatches forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
            [self prepareDicToExtractLinked];
            [_mTableView.tableView reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationNone];
            
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(void)cancelStatusValue:(NSDictionary *)dicLink
{
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLCancelOrder
         withParameters:dicLink
         withObject:self
         withSelector:@selector(getCancelledResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Cancel & Reset matches"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

-(IBAction)getCancelledResponse:(id)sender
{
 //  
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError]; 
         [self dismissHUD];
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            MatchDetailView *matchView=  (MatchDetailView *)self.mTableView.atomView;
            CellMatchesContainer *cell=(CellMatchesContainer *)[_mTableView tableView:_mTableView.tableView cellForRowAtIndexPath:indexpathAtOpenedRow];
            cell.vwCellBg.backgroundColor=[UIColor blackColor];
            [matchView.btnStatus setTitle:LoadMatchedText forState:UIControlStateNormal];
            matchView.btnCancelLoad.backgroundColor=LinkLoadButtonColor;
            [matchView.btnStatus setBackgroundColor:[UIColor orangeColor]];
            [matchView.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
//            Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
//            [self resetDictionary];
//            Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
//            NSMutableArray *arrmatches=[NSMutableArray arrayWithArray:[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]]];
//            [arrmatches enumerateObjectsUsingBlock:^(Matches *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
//                if ([objmatch.matchId isEqualToString:objmatches.matchId])
//                {
//                    objmatch.matchOrderStatus=@"0";
//                    [arrmatches replaceObjectAtIndex:idx withObject:objmatch];
//                }
//            }];
//            AppInstance.arrAllEquipmentByUserId=nil;
//            AppInstance.countEquiByUid=@"0";
//            [dicMatches setObject:arrmatches forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
//           
//            [_mTableView reloadData];
            iscancelled=@"yes";
             [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            [_mTableView reloadData];
            
            [self getAllLoadDetail:NO:YES];
           
        }
        else
        {
             [self dismissHUD];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(void)linkALoadFromMatch:(NSDictionary *)dicLink
{
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLLinkOrder
         withParameters:dicLink
         withObject:self
         withSelector:@selector(getInterestedResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Linking with matches"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getInterestedResponse:(id)sender
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
            MatchDetailView *matchView=  (MatchDetailView *)self.mTableView.atomView;
            CellMatchesContainer *cell=(CellMatchesContainer *)[_mTableView tableView:_mTableView.tableView cellForRowAtIndexPath:indexpathAtOpenedRow];
            cell.vwCellBg.backgroundColor=[UIColor blackColor];
      
//                [matchView.btnStatus setTitle:LoadLinkedText forState:UIControlStateNormal];
//                matchView.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
//                [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
//                [matchView.btnCancelLoad setTitle:ScheduleButtonText forState:UIControlStateNormal];

            
//            [matchView.btnStatus setTitle:@"" forState:UIControlStateNormal];
//            [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
//            matchView.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
//            [matchView.btnCancelLoad setTitle:AlreadyLinkRequestSent forState:UIControlStateNormal];
//
//
            
                Loads *obj=[arrAllLoads objectAtIndex:indexpathAtOpenedRow.section];
                Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexpathAtOpenedRow.row];
                NSMutableArray *arrmatches=[NSMutableArray arrayWithArray:[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]]];
                [arrmatches enumerateObjectsUsingBlock:^(Matches *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([objmatch.matchId isEqualToString:objmatches.matchId])
                    {
                        objmatch.matchOrderId=APIResponseOrderId;
                        objmatch.matchOrderStatus=@"1";
                        objmatch.isLoadInterested = @"1";
                        
                        NSLog(@"Before replace == > %@",arrmatches);
                        [arrmatches replaceObjectAtIndex:idx withObject:objmatch];

                        NSLog(@"aFTER replace == > %@",arrmatches);
//                        if([objmatch.isLoadInterested isEqualToString:@"1"] && [objmatch.isAssetInterested isEqualToString:@"1"]){
//
//                            [matchView.btnStatus setTitle:@"" forState:UIControlStateNormal];
//                            [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
//                            matchView.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
//                            [matchView.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
//
//                        }
//                        else{
//                            [matchView.btnStatus setTitle:@"" forState:UIControlStateNormal];
//                            [matchView.btnStatus setBackgroundColor:[UIColor blackColor]];
//                            matchView.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
//                            [matchView.btnCancelLoad setTitle:AlreadyLinkRequestSent forState:UIControlStateNormal];
//
//                        }
                     
                    }
                }];
            
      
            AppInstance.arrAllEquipmentByUserId=nil;
                AppInstance.countEquiByUid=@"0";
            [dicMatches setObject:arrmatches forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
            [_mTableView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpathAtOpenedRow] withRowAnimation:UITableViewRowAnimationNone];
            [UIView performWithoutAnimation: ^ { 
                CGPoint loc = _mTableView.tableView.contentOffset;
                
              //  NSIndexPath *index = [NSIndexPath index]
                //[_mTableView.tableView selectRowAtIndexPath:indexpathAtOpenedRow animated:NO scrollPosition:UITableViewScrollPositionNone];
                [self didSelectTableEvent:indexpathAtOpenedRow];
                
                [_mTableView.tableView reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationNone];
                _mTableView.tableView.contentOffset=loc;
            }];
            
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(void)markAsContacted:(NSDictionary *)dic
{
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLIsContactMtach
         withParameters:dic
         withObject:self
         withSelector:@selector(geContactResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Marking As Conatcted"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)geContactResponse:(id)sender
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
            if([APIIsContacted isEqualToString:@"1"])
            {
                [AZNotification showNotificationWithTitle:@"Carried marked as contacted !!" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
            else
            {
                [AZNotification showNotificationWithTitle:@"Carried marked as uncontacted !!" controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            }
            
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(void)markAsFav:(NSDictionary *)dic
{
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLMarkAsFavourite
         withParameters:dic
         withObject:self
         withSelector:@selector(getFavResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Marking As Favourite"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getFavResponse:(id)sender
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
            
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(void)markAsHide:(NSDictionary *)dic
{
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLIsHideMatch
         withParameters:dic
         withObject:self
         withSelector:@selector(getHideResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Marking As Hidden"
         showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getHideResponse:(id)sender
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
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(IBAction)getHideUnHideAllResponse:(id)sender
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
          
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(void)markAsLike:(NSDictionary *)dic
{
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLIsLikeMatch
             withParameters:dic
             withObject:self
             withSelector:@selector(getLikedResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Marking As Like"
             showProgress:NO];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
}
-(IBAction)getLikedResponse:(id)sender
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
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(void)prepareDicToExtractLinked
{
    Loads *obj=[arrAllLoads objectAtIndex:selectedSection];
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"matchOrderStatus != '0'"];
    NSMutableArray *arrmatches=[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
    NSArray *filteredArray = [arrmatches filteredArrayUsingPredicate:bPredicate];
    [dicMatches setObject:filteredArray forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
    [_mTableView.tableView reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)resetDictionary
{
    Loads *obj=[arrAllLoads objectAtIndex:selectedSection];
    NSMutableArray *arrmatches = [dicmatchClone valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
     
    [dicMatches setObject:arrmatches forKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]];
    [_mTableView.tableView reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)didSelectTableEvent:(NSIndexPath *)indexPath{
    
    MatchDetailView *view=[[MatchDetailView alloc] initWithFrame:CGRectMake(0, 0, self.mTableView.bounds.size.width, 445)];
    view = (MatchDetailView *)[nib objectAtIndex:0];
    view = (MatchDetailView *)[[[NSBundle mainBundle] loadNibNamed:@"MatchDetailView" owner:self options:nil] objectAtIndex:0];
    view.frame = CGRectMake(0, 0, self.mTableView.bounds.size.width, 445);
    Loads *obj=[arrAllLoads objectAtIndex:indexPath.section];
    Matches *objmatches=[[dicMatches valueForKey:[NSString stringWithFormat:@"%@",obj.internalBaseClassIdentifier]] objectAtIndex:indexPath.row];
    view.matchDetailViewDelegate=self;
    view.lblcname.text=[[objmatches.companyName stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"] capitalizedString];
    view.lblcaddress.text=objmatches.companyAddress;
    view.lblownername.text=[NSString stringWithFormat:@"%@ %@",objmatches.firstname,objmatches.lastname];
    view.lblonwerphone.text=objmatches.phoneNo;
    view.lblDistance.text=objmatches.matchDistance;
    view.btnCancelLoad.tag=indexPath.row;
    view.btnCancelLoad.accessibilityLabel=obj.internalBaseClassIdentifier;
    
    if([objmatches.matchOrderStatus isEqualToString:@"0"])
    {
        [view.btnStatus setTitle:LoadMatchedText forState:UIControlStateNormal];
        [view.btnStatus setBackgroundColor:[UIColor orangeColor]];
        view.btnCancelLoad.backgroundColor=LinkLoadButtonColor;
        [view.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
    }
    else if([objmatches.matchOrderStatus isEqualToString:@"1"])
    {
        if([objmatches.isLoadInterested isEqualToString:@"0"] && [objmatches.isAssetInterested isEqualToString:@"0"]){
            
            [view.btnStatus setTitle:LoadMatchedText forState:UIControlStateNormal];
            [view.btnStatus setBackgroundColor:[UIColor orangeColor]];
            view.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
            [view.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
        }
        else if([objmatches.isLoadInterested isEqualToString:@"0"] && [objmatches.isAssetInterested isEqualToString:@"1"]){
            
            [view.btnStatus setTitle:LoadMatchedText forState:UIControlStateNormal];
            [view.btnStatus setBackgroundColor:[UIColor orangeColor]];
            view.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
            [view.btnCancelLoad setTitle:LinkButtonText forState:UIControlStateNormal];
            
        }
        else if([objmatches.isLoadInterested isEqualToString:@"1"] && [objmatches.isAssetInterested isEqualToString:@"0"]){
            
            [view.btnStatus setTitle:LoadMatchedText forState:UIControlStateNormal];
            [view.btnStatus setBackgroundColor:[UIColor orangeColor]];
            view.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
            [view.btnCancelLoad setTitle:AlreadyLinkRequestSent forState:UIControlStateNormal];
            
        }
        else if([objmatches.isLoadInterested isEqualToString:@"1"] && [objmatches.isAssetInterested isEqualToString:@"1"]){
            
            [view.btnStatus setTitle:LoadLinkedText forState:UIControlStateNormal];
            [view.btnStatus setBackgroundColor:[UIColor orangeColor]];
            view.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
            [view.btnCancelLoad setTitle:ScheduleButtonText forState:UIControlStateNormal];
            
        }
        //[view.btnStatus setTitle:LoadLinkedText forState:UIControlStateNormal];
        //[view.btnStatus setBackgroundColor:[UIColor blackColor]];
        //view.btnCancelLoad.backgroundColor=ScheduledLoadButtonColor;
        //[view.btnCancelLoad setTitle:ScheduleButtonText forState:UIControlStateNormal];
    }
    else
    {
        [view.btnStatus setTitle:LoadScheduledText forState:UIControlStateNormal];
        [view.btnStatus setBackgroundColor:[UIColor blackColor]];
        view.btnCancelLoad.backgroundColor=CancelLoadButtonColor;
        [view.btnCancelLoad setTitle:UnlinkButtonText forState:UIControlStateNormal];
    }
    if([objmatches.isLike isEqualToString:@"1"])
    {
        [view.btnLike setImage:imgNamed(@"imglikered") forState:UIControlStateNormal];
    }
    else
    {
        [view.btnLike setImage:imgNamed(@"imglikewhite") forState:UIControlStateNormal];
    }
    if([objmatches.isFavourite isEqualToString:@"1"])
    {
        [view.btnFav setImage:imgNamed(@"imgfavorange") forState:UIControlStateNormal];
    }
    else
    {
        [view.btnFav setImage:imgNamed(@"imgfavWhite") forState:UIControlStateNormal];
    }
    if([objmatches.isHide isEqualToString:@"1"])
    {
        [view.btnHide setImage:imgNamed(@"checkboxsquareselected") forState:UIControlStateNormal];
    }
    else
    {
        [view.btnHide setImage:imgNamed(@"checkboxsquare") forState:UIControlStateNormal];
    }
    self.mTableView.atomView = view;
    self.mTableView.atomView.backgroundColor=[UIColor whiteColor];
   
}

- (IBAction)btnAddLoadClicked:(UIButton *)sender {

    AddLoadPopupVC *objLoadVC = initVCToRedirect(SBAFTERSIGNUP, ADDLOADPOPUPVC);
    objLoadVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    objLoadVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:objLoadVC animated:YES completion:nil];
    
}

-(void)pushVCtoCreateorOpenSavedLoad:(NSNotification *)ObjNotify {
    

    if ([ObjNotify.object isEqualToString:@"0"])
    {
        PostLoadVC *objPostLoad=initVCToRedirect(SBAFTERSIGNUP, POSTLOADVC);
        [self.navigationController pushViewController:objPostLoad animated:YES];
    }
    else
    {
        AllSavedLoadListVC *objsavedlist=initVCToRedirect(SBAFTERSIGNUP, ALLSAVEDLOADLIST);
        [self.navigationController pushViewController:objsavedlist animated:YES];
    }
}

@end
