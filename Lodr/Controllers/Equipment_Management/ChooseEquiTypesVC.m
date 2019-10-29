//
//  ChooseEquiTypesVC.m
//  Lodr
//
//  Created by c196 on 26/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "ChooseEquiTypesVC.h"
#import "PostEquipmentVC.h"
#import "AddSubAssetVC.h"
#import "SubEquiEspecial.h"
#import "AssetAbility.h"
#import "CellSelectOfficeHub.h"
#import "FetchOfficesVC.h"

@interface ChooseEquiTypesVC () <FetchOfficesVCDelegate>
{
    UserAccount *objUserAccount;
    
    OfficeDetails *objOffice;
    
    CellWelcomeFooter *tblfooter;
    CellPostEquiHeader *tblHeadervw;
    NSString *selectedid,*selectedasset,*choosenasset,*choosendid;
    NSArray *arrOffices;
    NSMutableArray *arrEuipmentList,*equipmentselected,*arrAbilities,*abilitySelected;
}
@end

@implementation ChooseEquiTypesVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    NavigationBarHidden(YES);
    
    if ([DefaultsValues getBooleanValueFromUserDefaults_ForKey:SavedSignedIn] == YES)
    {
        User *objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
        objUserAccount = [objuser.userAccount objectAtIndex:0];
    }
    
    self.tblAbilityList.hidden=YES;
    abilitySelected=[NSMutableArray new];
    equipmentselected=[NSMutableArray new];
    self.tblEquiList.estimatedRowHeight=60;
    self.tblEquiList.rowHeight = UITableViewAutomaticDimension;
    self.tblAbilityList.estimatedRowHeight=60;
    self.tblAbilityList.rowHeight = UITableViewAutomaticDimension;
    self.tblEquiList.backgroundColor=[UIColor clearColor];
    self.tblAbilityList.backgroundColor=[UIColor clearColor];
    self.btnback.hidden=YES;
    
    if (AppInstance.assetTypeArray.count == 0)
    {
          [self getAllAssettypes];
    }
    else
    {
        arrEuipmentList = AppInstance.assetTypeArray;
        [self getAllOffices];
    }
}
-(void)showAlertForRetry:(NSString *)str
{
    NSString *msg=[NSString stringWithFormat:@"%@",str];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
                                  [self getAllAssettypes];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}
- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)getAllOffices
{
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
    [dicParam setValue:objUserAccount.companyId forKey:@"company_id"];
    [dicParam setValue:objUserAccount.userId forKey:@"user_id"];
    
    if ([[NetworkAvailability instance] isReachable])
    {
        [[WebServiceConnector alloc] init:URLFetchAllOffice
                           withParameters:dicParam
                               withObject:self
                             withSelector:@selector(getOfficesResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:@"Loading offices"
                             showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [self showAlertForRetry:[NetworkLost capitalizedString]];
    }
}

- (IBAction)getOfficesResponse:(id)sender
{
    [self dismissHUD];
    
    if ([sender serviceResponseCode] != 100)
    {
        [self showAlertForRetry:[[sender responseError] capitalizedString]];
    }
    else
    {
        if ([APIResponseStatus isEqualToString:APISuccess])
        {
            arrOffices = [sender responseArray];
            
            for (OfficeDetails *objOffice in arrOffices)
            {
                if ([objUserAccount.officeId isEqualToString:[NSString stringWithFormat:@"%ld", (NSInteger)objOffice.officeId]])
                {
                    [self didSelectOffice:objOffice];
                    break;
                }
            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

-(void)getAllAssettypes
{
    NSDictionary *dicAllEqui=@{
                               Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                               Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey]};    
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLGetAllEquiSubTypes
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getEquiSubtypeResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Loading Asset types"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
       // [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        [self showAlertForRetry:[NetworkLost capitalizedString]];
    }
}
-(IBAction)getEquiSubtypeResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
       [self showAlertForRetry:[[sender responseError] capitalizedString]];  
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
             arrEuipmentList =[NSMutableArray new];
            for(SubEquiEspecial *objsub in [sender responseArray])
            {
                [arrEuipmentList addObject:objsub];
            }
            AppInstance.assetTypeArray = arrEuipmentList;
            [self.tblEquiList reloadData];
            
            if (objUserAccount != nil)
            {
                [self getAllOffices];
            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
- (IBAction)btnbackclicked:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnDrawerclicked:(id)sender 
{
     [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
#pragma mark - tableview delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    if (tableView == _tblAbilityList)
    {
        SubEquiEspecial *obj=[arrAbilities objectAtIndex:section];
        return obj.assetAbility.count+1;
    }
    else
    {
         return arrEuipmentList.count + 1 + 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    tblHeadervw=nil;
    tblHeadervw=[[CellPostEquiHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblEquiList.frame.size.width, 590)];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostEquiHeader" owner:self options:nil];
    tblHeadervw = (CellPostEquiHeader *)[nib objectAtIndex:0];
    
   
    tblHeadervw.btnOpenSaved.hidden=YES;
    tblHeadervw.heightVwHeading.constant=80;
    tblHeadervw.cellPostEquiHeaderDelegate=self;
    tblHeadervw.heightEspecialEqui.constant=0;
    tblHeadervw.btnPostEquiEspecial.clipsToBounds=YES;
    [tblHeadervw.vwSubDetails removeFromSuperview];
    if(tableView == self.tblEquiList)
    {
         tblHeadervw.lblHeadingtext.text=@"Add New Asset";
    }
    else
    {
        if([selectedasset containsString:@"Power"])
        {
            tblHeadervw.lblHeadingtext.text=@"Powered Asset";
        }
        else
        {
            tblHeadervw.lblHeadingtext.text=@"Supporting Equipment";
        }
    }
    return tblHeadervw;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    NSArray *nibfooter = [[NSBundle mainBundle] loadNibNamed:@"welcomeFooter" owner:self options:nil];
    tblfooter = (CellWelcomeFooter *)[nibfooter objectAtIndex:0];
    tblfooter.backgroundColor=[UIColor clearColor];
    tblfooter.vwFootercompany.backgroundColor=[UIColor clearColor];
    tblfooter.cellWelcomeFooterDelegate=self;
    tblfooter.heightvwWelocmeFooter.constant=0;
    tblfooter.heightOfficeFooter.constant=0;
    tblfooter.heightSummaryFooter.constant=0;
    tblfooter.vwSummaryFooter.clipsToBounds=YES;
    tblfooter.vwFootercompany.clipsToBounds=YES;
    tblfooter.vwOfficeInfoFooter.clipsToBounds=YES;
    tblfooter.heightcmpnyFooter.constant=150;
    if(tableView == self.tblEquiList)
    {
         [tblfooter.btncmpnayback setTitle:@"CANCEL" forState:UIControlStateNormal];
    }
    else
    {
         [tblfooter.btncmpnayback setTitle:@"BACK" forState:UIControlStateNormal];
    }
    tblfooter.btncmpnynext.tag=100;
    return tblfooter;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    static NSString *customTableIdentifier = @"CellListWithCheckBox";
    
    CellListWithCheckBox *cell = (CellListWithCheckBox *)[tableView dequeueReusableCellWithIdentifier:customTableIdentifier];
    
    if (nil == cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellListWithCheckBox" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.vwCellMain.backgroundColor=[UIColor clearColor];
        cell.btnCellClick.userInteractionEnabled=NO;
        cell.lblListName.textColor=[UIColor whiteColor];
    }
    
    if (indexPath.row==0)
    {
        if(tableView == self.tblEquiList)
        {
            cell.lblListName.text=@"I'm adding a:";
        }
        else
        {
            if([selectedasset containsString:@"Power"])
            {
                cell.lblListName.text=@"This Powered Asset Can:";
            }
            else
            {
                cell.lblListName.text=@"This Support Asset Can:";
            }
        }
        
        cell.btnCheckbox.hidden=YES;
        cell.widthbtncb.constant=0;
        cell.leadinglbl.constant=2;
        cell.lblsubtext.text=@"";
        cell.lblsubtext.numberOfLines=0;
        [cell.lblsubtext sizeToFit];
    }
    else
    {
        cell.btnCheckbox.hidden=NO;
        cell.widthbtncb.constant=15;
        cell.leadinglbl.constant=12;
        
        if (tableView == self.tblEquiList)
        {
            if (indexPath.row == arrEuipmentList.count + 1)
            {
                CellSelectOfficeHub *cell = (CellSelectOfficeHub *)[tableView dequeueReusableCellWithIdentifier:customTableIdentifier];
                
                if (nil == cell)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellSelectOfficeHub" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                }
                
                cell.txtOfficeHub.text = objOffice.officeName;
                [cell.btnOfficeHub addTarget:self action:@selector(btnOfficeHubClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
            }

            NSLog(@"%ld", indexPath.row);
            
            SubEquiEspecial *obj=[arrEuipmentList objectAtIndex:indexPath.row-1];
            cell.lblListName.text=obj.esName;
            if ([equipmentselected containsObject:indexPath])
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth=0.0f;
                selectedasset=obj.esName;
                selectedid=obj.internalBaseClassIdentifier;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth=1.0f;
            }
        }
        else
        {

            SubEquiEspecial *obj=[arrAbilities objectAtIndex:indexPath.section];
            AssetAbility *objaa=[obj.assetAbility objectAtIndex:indexPath.row-1];
            cell.lblListName.text=objaa.capacityValue;
            if ([abilitySelected containsObject:indexPath])
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth=0.0f;
                choosenasset=objaa.capacityValue;
                choosendid=[NSString stringWithFormat:@"%@",objaa.assetAbilityIdentifier];
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth=1.0f;
            }
        }
        //NSString *str=[NSString stringWithFormat:@"%@",[obj.capability stringByReplacingOccurrencesOfString:@"-" withString:@"\n- "]];
        //cell.lblListName.text=obj.esName;
        cell.lblsubtext.text=@"";
        cell.lblsubtext.numberOfLines=0;
        [cell.lblsubtext sizeToFit];
        
    }
    return cell;
}
-(NSString *)gatherEquipmentIds
{
    NSString *listOfAllEqui = @"";
    SubEquiEspecial *objequi;
    for(NSIndexPath *index in equipmentselected)
    {
        objequi=[arrEuipmentList objectAtIndex:index.row];
        NSString *eID =[NSString stringWithFormat:@"%@",objequi.internalBaseClassIdentifier];
        listOfAllEqui=eID;
        
    }
    return listOfAllEqui;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if(indexPath.row==0)
    {
        
    }
    else
    {
        if(tableView == self.tblEquiList)
        {
            if (indexPath.row == 4)
            {
                return;
            }
            
            if ([equipmentselected containsObject:indexPath])
            {
                [equipmentselected removeObject:indexPath];
            }
            else
            {
                [equipmentselected removeAllObjects];
                [equipmentselected addObject:indexPath];
            }
            [self.tblEquiList reloadData];
        }
        else
        {
            if ([abilitySelected containsObject:indexPath])
            {
                [abilitySelected removeObject:indexPath];
            }
            else
            {
                [abilitySelected removeAllObjects];
                [abilitySelected addObject:indexPath];
            }
            [self.tblAbilityList reloadData];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.tblAbilityList)
    {
        return 40;
    }
    else
    {
         return UITableViewAutomaticDimension;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{ 
    return 150;
}

- (IBAction)btnOfficeHubClicked:(id)sender
{
    [self.view endEditing:YES];
    
    FetchOfficesVC *vc = initVCToRedirect(SBSEARCH, @"idFetchOfficesVC");
    vc.delegate = self;
    vc.arrOffices = arrOffices;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectOffice:(id)officeDetails
{
    objOffice = officeDetails;
    
    [_tblEquiList beginUpdates];
    [_tblEquiList reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [_tblEquiList endUpdates];
}

#pragma mark - welcome footer delegate
- (IBAction)btncmpnybackclicked:(id)sender
{
    if([[sender titleLabel].text isEqualToString:@"CANCEL"])
    {
        HomeVC *objHomeVC =initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
        AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objHomeVC];
        [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        return;
    }
    if([selectedasset containsString:@"Trailer"])
    {
        HomeVC *objHomeVC =initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
        AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objHomeVC];
        [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
    }
    else
    {
        self.tblEquiList.hidden=NO;
        self.tblAbilityList.hidden=YES;
    }
}
- (IBAction)btncmpnynextclicked:(id)sender
{
    if(self.tblAbilityList.hidden == YES)
    {
        if(equipmentselected.count ==0)
        {
            [AZNotification showNotificationWithTitle:RequiredAssetType controller:ROOTVIEW notificationType:AZNotificationTypeError];
            return;
        }
        
        if (objOffice == nil)
        {
            [AZNotification showNotificationWithTitle:@"Please select Office/HUB" controller:ROOTVIEW notificationType:AZNotificationTypeError];
            return;
        }
        
        if([selectedasset containsString:@"Trailer"])
        {
            PostEquipmentVC *postload=initVCToRedirect(SBAFTERSIGNUP,POSTEQUIPMENTVC);
            postload.selectedAssetId=selectedid;
            postload.selectedSubAssetId=@"0";
            postload.selectedCapacity=@"";
            postload.strRedirectFrom=@"CHOOSEASSET";
            postload.objOfficeDetails = objOffice;
            [self.navigationController pushViewController:postload animated:YES];
        }
        else
        {
            self.tblEquiList.hidden=YES;
            self.tblAbilityList.hidden=NO;
            [abilitySelected removeAllObjects];
            arrAbilities = [NSMutableArray new];
            if([selectedasset containsString:@"Power"])
            {
                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"internalBaseClassIdentifier=='1'"];
                arrAbilities=[[arrEuipmentList filteredArrayUsingPredicate:bPredicate] mutableCopy];
            }
            else
            {
                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"internalBaseClassIdentifier == '3'"];
                arrAbilities=[[arrEuipmentList filteredArrayUsingPredicate:bPredicate] mutableCopy];
            }
            [self.tblAbilityList reloadData];
        }
    }
    else
    {
        if(abilitySelected.count ==0)
        {
            [AZNotification showNotificationWithTitle:RequiredAssetDetailCapability controller:ROOTVIEW notificationType:AZNotificationTypeError];
            return;
        }
        if([selectedasset containsString:@"Power"])
        {
            if([choosendid isEqualToString:@"1"] || [choosendid isEqualToString:@"3"])
            {
                PostEquipmentVC *postload=initVCToRedirect(SBAFTERSIGNUP,POSTEQUIPMENTVC);
                postload.selectedAssetId=selectedid;
                postload.strRedirectFrom=@"CHOOSEASSET";
                postload.selectedSubAssetId=choosendid;
                postload.selectedCapacity=choosenasset;
                postload.objOfficeDetails = objOffice;
                [self.navigationController pushViewController:postload animated:YES];
            }
            else
            {
                AddSubAssetVC *postload=initVCToRedirect(SBAFTERSIGNUP,ADDASSETVC);
                postload.selectedAssetId=selectedid;
                postload.selectedAssetName=selectedasset;
                postload.selectedsubassetId=choosendid;
                postload.selectedsubassetname=choosenasset;
                postload.objOfficeDetails = objOffice;
                [self.navigationController pushViewController:postload animated:YES];
            }
        }
        else
        {
            AddSubAssetVC *postload=initVCToRedirect(SBAFTERSIGNUP,ADDASSETVC);
            postload.selectedAssetId=selectedid;
            postload.selectedAssetName=selectedasset;
            postload.selectedsubassetId=choosendid;
            postload.selectedsubassetname=choosenasset;
            postload.objOfficeDetails = objOffice;
            [self.navigationController pushViewController:postload animated:YES];
        }
    }
}
@end
