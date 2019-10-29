//
//  AddSubAssetVC.m
//  Lodr
//
//  Created by c196 on 26/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "AddSubAssetVC.h"
#import "HomeVC.h"
@interface AddSubAssetVC ()
{
    CellPostEquiFooter *tblfootervw;
    CellPostEquiHeader *tblHeadervw;
    NSMutableArray *arrEquiImages;
    __block NSString *eaddess,*eastatecode;
}
@end

@implementation AddSubAssetVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    arrEquiImages=[NSMutableArray new];
    self.tbladdform.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nibcell = [UINib nibWithNibName:@"CellWithCV" bundle:nil];
    [[self tbladdform] registerNib:nibcell forCellReuseIdentifier:@"CellWithCV"];
    
    UINib *nibcell2 = [UINib nibWithNibName:@"cellPdfview" bundle:nil];
    [[self tbladdform]  registerNib:nibcell2 forCellReuseIdentifier:@"cellPdfview"];
   // __block NSString *eaddess=@"",*eastatecode=@"";
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:[AppInstance.userCurrentLat floatValue] longitude:[AppInstance.userCurrentLon floatValue]];
    CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];
    [reverseGeocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *myPlacemark = [placemarks objectAtIndex:0];
        eaddess = [[myPlacemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
        eastatecode = myPlacemark.administrativeArea;
    }];
}

#pragma mark - tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
    return 1; 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tblHeadervw==nil)
    {
        tblHeadervw=[[CellPostEquiHeader alloc] initWithFrame:CGRectMake(0, 0, self.tbladdform.frame.size.width, 590)];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostEquiHeader" owner:self options:nil];
        tblHeadervw = (CellPostEquiHeader *)[nib objectAtIndex:0]; 
    }
    tblHeadervw.vwheaderSubAsset.hidden=NO;
    tblHeadervw.lblHeaderTitle.text=self.selectedAssetName;
    [tblHeadervw.vwHeading removeFromSuperview];
    [tblHeadervw.vwSubDetails removeFromSuperview];
     if([self.selectedAssetName containsString:@"Support"])
     {
         tblHeadervw.heightSubAssets.constant=180;
         tblHeadervw.txtAssetEmptyWeight.hidden=YES;
         [tblHeadervw.btnweighttext removeFromSuperview];
         [tblHeadervw.lblheadingweight removeFromSuperview];
        // tblHeadervw.txtAssetEmptyWeight.text=@"0";
     }
    else
    {
         tblHeadervw.heightSubAssets.constant=250;
         tblHeadervw.txtAssetEmptyWeight.hidden=NO;
    }
    return tblHeadervw;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    tblfootervw=[[CellPostEquiFooter alloc] initWithFrame:CGRectMake(0, 0, self.tbladdform.frame.size.width, 190)];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostEquiFooter" owner:self options:nil];
    tblfootervw = (CellPostEquiFooter *)[nib objectAtIndex:0]; 
    tblfootervw.btnSaveEqui.hidden=YES;
    tblfootervw.btnPublishEqui.hidden=NO;
    tblfootervw.btnEquiUpdate.hidden=YES;
    tblfootervw.cellPostEquiFooterDelegate=self;
    [tblfootervw.btnPublishEqui setTitle:@"ACTIVATE" forState:UIControlStateNormal];
    return tblfootervw;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    if(indexPath.row==0)
    {
        static NSString *cellIdentifier = @"CellWithCV";
        CellWithCV *cell = (CellWithCV*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) 
        { 
            cell = [[CellWithCV alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
        }
        cell.lblAllphoto.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];
        cell.cvPhotoes.dataSource=self;
        cell.cvPhotoes.delegate=self;
        if(arrEquiImages.count==0)
        {
            cell.cvPhotoes.hidden=YES;
            cell.lblNoData.hidden=NO;
        }
        else
        {
            cell.cvPhotoes.hidden=NO;
            cell.lblNoData.hidden=YES;
        }
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"cellPdfview";
        cellPdfview *cell = (cellPdfview*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) 
        { 
            cell = [[cellPdfview alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
        }
        [cell.btnPdfName setTitle:@"Add Pictures" forState:UIControlStateNormal];
        cell.btnPdfName.titleLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];
        [cell.btnPdfName setImage:imgNamed(@"imgplus") forState:UIControlStateNormal];
        cell.btnPdfDelete.hidden=YES;
        cell.cellPdfviewDelegate=self;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 150;
    }
    else
    {
        return 30;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    if([self.selectedAssetName containsString:@"Support"])
    {
        return 180;
    }
    else
    {
    return 250;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{ 
    return 190;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnDrawerclicked:(id)sender 
{
    [self.view endEditing:YES];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (IBAction)btnBackclciked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Collection view  delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrEquiImages.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellCvPickedImage *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCvPickedImage" forIndexPath:indexPath];
    cell.btnDeleteImage.tag=indexPath.item;
    cell.cellCvPickedImageDelegate=self;
    cell.imgLarge.image=[arrEquiImages objectAtIndex:indexPath.item];
   
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.height,collectionView.frame.size.height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}
- (void)btnDeleteImageClicked:(id)sender
{
    UIButton *dltsender=(UIButton *)sender;
    [arrEquiImages removeObjectAtIndex:[dltsender tag]];
    CellWithCV *cellimages = (CellWithCV*)[_tbladdform cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if(arrEquiImages.count > 0)
    {
        [cellimages.cvPhotoes reloadData];
        cellimages.lblNoData.hidden=YES;
        cellimages.cvPhotoes.hidden=NO;
    }
    else
    {
        cellimages.lblNoData.hidden=NO;
        cellimages.cvPhotoes.hidden=YES;
    }
    
}
#pragma mark - Cell FOOTER delegate
- (IBAction)btnPdfNameClicked:(id)sender 
{
    [self openImagePicker];
}
-(void)openImagePicker
{
    CellWithCV *cellselected=(CellWithCV*)[_tbladdform cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if(arrEquiImages.count<5)
    {
        DKImagePickerController *pickerController = [DKImagePickerController new];
        pickerController.assetType = DKImagePickerControllerAssetTypeAllPhotos;
        pickerController.showsCancelButton = YES;
        pickerController.showsEmptyAlbums = NO;
        pickerController.allowMultipleTypes = YES;
        pickerController.maxSelectableCount=5-arrEquiImages.count;
        pickerController.defaultSelectedAssets = @[];
        pickerController.sourceType = DKImagePickerControllerSourceTypeBoth;
        pickerController.navigationBar.barTintColor=[UIColor orangeColor];
        pickerController.navigationBar.tintColor=[UIColor whiteColor];
        [pickerController setDidSelectAssets:^(NSArray * __nonnull assets)
         {
             for(int i =0;i<assets.count;i++)
             {
                 DKAsset * asset=[assets objectAtIndex:i];
                 [asset fetchOriginalImageWithCompleteBlock:^(UIImage * img, NSDictionary * dic) 
                  {
                      img = [Function scaleAndRotateImage:img];
                      [arrEquiImages addObject:img];
                      if(i == (assets.count -1))
                      {
                          [cellselected.cvPhotoes reloadData];
                          cellselected.cvPhotoes.hidden=NO;
                          cellselected.lblNoData.hidden=YES;
                      }
                  }];
             }
         }];
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    else
    {
        [AZNotification showNotificationWithTitle:MaxLimitPhoto controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
- (IBAction)btnPublishEquiClicked:(id)sender
{
    [self prepareRequestToSaveOnServer:@"1"];
}
#pragma mark - cell post equipment delegate
-(void)prepareRequestToSaveOnServer:(NSString *)ispublish
{
    @try 
    {
          if([self.selectedAssetName containsString:@"Support"])
          {
              tblHeadervw.txtAssetEmptyWeight.text=@"0";
          }
        if(
           [self validateTxtLength:tblHeadervw.txtNameOfSubAsset.text withMessage:RequiredEquiname] &&
           [self validateTxtLength:tblHeadervw.txtAssetEmptyWeight.text withMessage:RequiredWeight]
           )
        {
            switch (arrEquiImages.count) {
                case 0:
                {
                    [arrEquiImages addObject:@""];
                    [arrEquiImages addObject:@""];
                    [arrEquiImages addObject:@""];
                    [arrEquiImages addObject:@""];
                    [arrEquiImages addObject:@""];
                }
                    break;
                case 1:
                {
                    [arrEquiImages addObject:@""];
                    [arrEquiImages addObject:@""];
                    [arrEquiImages addObject:@""];
                    [arrEquiImages addObject:@""];
                }
                    break;
                case 2:
                {
                    [arrEquiImages addObject:@""];
                    [arrEquiImages addObject:@""];
                    [arrEquiImages addObject:@""];
                }
                    break;
                case 3:
                {
                    [arrEquiImages addObject:@""];
                    [arrEquiImages addObject:@""];
                }
                    break;
                case 4:
                {
                    [arrEquiImages addObject:@""];
                }
                    break;
                default:
                    break;
            }
            NSString *userlat,*userlon;
           //  NSString *latitude,*userlon;
            
                User *objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
                //            coordinate.latitude = objuser.
                if(objuser.userAccount.count > 0){
                    
                    NSArray *arrUserObj = objuser.userAccount;
                    UserAccount *objUserAcc = arrUserObj.firstObject;
                    userlat = objUserAcc.officeLatitude;
                    userlon = objUserAcc.officeLongitude;
                    
                }
                else{
                    
                    if(AppInstance.userCurrentLat == nil || AppInstance.userCurrentLon ==nil )
                    {
                        userlon=@"";
                        userlat=@"";
                    }
                    else
                    {
                        userlon=AppInstance.userCurrentLon;
                        userlat=AppInstance.userCurrentLat;
                    }
                    
                }
          
            NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
            [dicParam setValue:@"0" forKey:Req_E_Id];
            [dicParam setValue:@"0" forKey:Req_Es_Id];
            [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:Req_User_Id];
            [dicParam setValue:tblHeadervw.txtNameOfSubAsset.text forKey:Req_Equi_Name];
            [dicParam setValue:@"0" forKey:Req_Equi_Length];
            [dicParam setValue:@"0" forKey:Req_Equi_Height];
            [dicParam setValue:@"0" forKey:Req_Equi_Width];
            [dicParam setValue:@"0" forKey:Req_Equi_Weight];
            [dicParam setValue:@"0" forKey:Req_Visible_To];
            [dicParam setValue:@"0" forKey:Req_Equi_Availability];
            [dicParam setValue:tblfootervw.txtFooterNotes.text forKey:Req_Equi_Notes];
            [dicParam setValue:@"1" forKey:Req_Is_Publish];
            [dicParam setValue:[arrEquiImages objectAtIndex:0] forKey:Req_Equi_Photo1];
            [dicParam setValue:[arrEquiImages objectAtIndex:1] forKey:Req_Equi_Photo2];
            [dicParam setValue:[arrEquiImages objectAtIndex:2] forKey:Req_Equi_Photo3];
            [dicParam setValue:[arrEquiImages objectAtIndex:3] forKey:Req_Equi_Photo4];
            [dicParam setValue:[arrEquiImages objectAtIndex:4] forKey:Req_Equi_Photo5];
            [dicParam setValue:userlat forKey:Req_Equi_Latitude];
            [dicParam setValue:userlon forKey:Req_Equi_Longitude];
            [dicParam setValue:eaddess forKey:Req_LastEquiAddess];
            [dicParam setValue:eastatecode forKey:Req_LastEquiStatecode];
            [dicParam setValue:_selectedAssetId forKey:Req_AssetTypeId];
            [dicParam setValue:_selectedsubassetId forKey:Req_AssetAbilityId];
            [dicParam setValue:tblHeadervw.txtEquiEmptyWeight.text forKey:Req_Equi_EmptyWeight];
            
            if (_objOfficeDetails != nil)
            {
                [dicParam setValue:[NSString stringWithFormat:@"%ld", (NSInteger)_objOfficeDetails.officeId] forKey:@"office_id"];
            }

//            [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey] forKey:Req_access_key];
//            [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey] forKey:Req_secret_key];

//            NSDictionary *dicsavequipment=@{
//                                            Req_E_Id:@"0",
//                                            Req_Es_Id:@"0",
//                                            Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
//                                            Req_Equi_Name:tblHeadervw.txtNameOfSubAsset.text,
//                                            Req_Equi_Length:@"0",
//                                            Req_Equi_Height:@"0",
//                                            Req_Equi_Width:@"0",
//                                            Req_Equi_Weight:@"0",
//                                            Req_Visible_To :@"0",
//                                            Req_Equi_Availability:@"0",
//                                            Req_Equi_Notes:tblfootervw.txtFooterNotes.text,
//                                            Req_Is_Publish:@"1",
//                                            Req_Equi_Photo1:[arrEquiImages objectAtIndex:0],
//                                            Req_Equi_Photo2:[arrEquiImages objectAtIndex:1],
//                                            Req_Equi_Photo3:[arrEquiImages objectAtIndex:2],
//                                            Req_Equi_Photo4:[arrEquiImages objectAtIndex:3],
//                                            Req_Equi_Photo5:[arrEquiImages objectAtIndex:4],
//                                            Req_Equi_Latitude:userlat,
//                                            Req_Equi_Longitude:userlon,
//                                            Req_LastEquiAddess:eaddess,
//                                            Req_LastEquiStatecode:eastatecode,
//                                            Req_AssetTypeId:_selectedAssetId,
//                                            Req_AssetAbilityId:_selectedsubassetId,
//                                            Req_Equi_EmptyWeight:tblHeadervw.txtEquiEmptyWeight.text
//                                            };
            if([[NetworkAvailability instance]isReachable])
            {
                [[WebServiceConnector alloc]
                 init:URLPostNewEquipment
                 withParameters:dicParam
                 withObject:self
                 withSelector:@selector(getPostLEquiResponse:)
                 forServiceType:@"FORMDATA"
                 showDisplayMsg:@"Saving Equipments"
                 showProgress:YES];
            }
            else
            {
                [self dismissHUD];
                [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
            }

        }
        
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.description);
    }  
}
-(IBAction)getPostLEquiResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:Msg101 controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            if([APIIsPublished isEqualToString:@"1"])
            {
                AppInstance.arrAllLoadByUserId=nil;
                AppInstance.dicAllMatchByLoadId=nil;
                AppInstance.countLodByUid=@"0";
                AppInstance.arrAllEquipmentByUserId=nil;
                AppInstance.countEquiByUid=@"0";
            }
            HomeVC *objHomeVC =initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objHomeVC];
            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
            
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

@end
