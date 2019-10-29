//
//  PostEquipmentVC.m
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "PostEquipmentVC.h"
#import "Function.h"
#import "User.h"
#import "UserAccount.h"
#import "DotWarning.h"
#import "EditDotAccount.h"

@interface PostEquipmentVC () <DotWarningDelegate>
{
    int noOfPhotos;
    UIView *overlay, *overlayview;
    
    ZSYPopoverListView *listView;
    
    NSMutableArray *arrEuipmentList, *arrEspecialEuipmentlist, *equipmentselected, *especialequiSelected, *arrEquiImages, *arrboolSelectionImages;
    
    NSArray *arrvisiblity, *arrAvailability;
    
    NSString *selectedPopupName,*listOfEquis,*listOfEquiSpecials,*allEids,*allEEids,*visibilityvalue,*availabilityvalue,*equinames,*especialequinames;
    
    CellPostEquiFooter *tblfootervw;
    CellPostEquiHeader *tblHeadervw;
    User *objuser;
    UserAccount *objuseraccount;
    __block NSString *eaddess,*eastatecode;
}
@end

@implementation PostEquipmentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NavigationBarHidden(YES);
    
    if ([_strRedirectFrom isEqualToString:@"CALENDER"] || [_strRedirectFrom isEqualToString:@"CHOOSEASSET"])
    {
        [self.btnpeBack setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
    }
    else
    {
        [self.btnpeBack setImage:imgNamed(@"") forState:UIControlStateNormal];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    objuseraccount = [objuser.userAccount objectAtIndex:0];
    
    self.tblPostEquipment.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nibcell = [UINib nibWithNibName:@"CellWithCV" bundle:nil];
    [[self tblPostEquipment] registerNib:nibcell forCellReuseIdentifier:@"CellWithCV"];
    
    UINib *nibcell2 = [UINib nibWithNibName:@"cellPdfview" bundle:nil];
    [[self tblPostEquipment] registerNib:nibcell2 forCellReuseIdentifier:@"cellPdfview"];
  
    arrvisiblity = [[NSArray alloc]initWithObjects:@"Private", @"My Network", @"Everyone", nil];
    arrAvailability = [[NSArray alloc]initWithObjects:@"Unlimited (US/Mexico/Canada)", @"US/Canada (Can cross into Canada)", @"US Interstate (Can cross state lines)", @"US Interstate (Same  state only)", nil];
    
    arrEquiImages = [NSMutableArray new];
    equipmentselected = [NSMutableArray new];
    especialequiSelected = [NSMutableArray new];
    arrEuipmentList = [NSMutableArray new];
    arrEspecialEuipmentlist = [NSMutableArray new];
    
    arrEuipmentList = [[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:SubEquiEspecialEntity] mutableCopy];
    arrEspecialEuipmentlist = [[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:SubEquiEspecialEntity] mutableCopy];
    
    if (arrEuipmentList.count == 0)
    {
        [self getAllEquipmentsBase];
        arrEuipmentList = [[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:SubEquiEspecialEntity]mutableCopy];
    }
    
    [AppInstance.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    
    visibilityvalue = @"2";
    availabilityvalue = [NSString stringWithFormat:@"%d", [DefaultsValues getIntegerValueFromUserDefaults_ForKey:SavedAvailability]];
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:[AppInstance.userCurrentLat floatValue] longitude:[AppInstance.userCurrentLon floatValue]];
    
    CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];
    [reverseGeocoder reverseGeocodeLocation:loc
                          completionHandler:^(NSArray *placemarks, NSError *error) {
                              CLPlacemark *myPlacemark = [placemarks objectAtIndex:0];
                              eaddess = [[myPlacemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                              eastatecode = myPlacemark.administrativeArea;
                          }];
}

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - tableview delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tblHeadervw == nil)
    {
        tblHeadervw = [[CellPostEquiHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblPostEquipment.frame.size.width, 590)];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostEquiHeader" owner:self options:nil];
        tblHeadervw = (CellPostEquiHeader *)[nib objectAtIndex:0]; 
    }
    
    tblHeadervw.btnOpenSaved.hidden = YES;
    tblHeadervw.heightVwHeading.constant = 80;
    tblHeadervw.cellPostEquiHeaderDelegate = self;
    tblHeadervw.heightEspecialEqui.constant = 0;
    tblHeadervw.btnPostEquiEspecial.clipsToBounds = YES;
    tblHeadervw.vwheaderSubAsset.hidden = YES;
    [tblHeadervw.btnPostEquiAvailability setTitle:[arrAvailability objectAtIndex:[availabilityvalue intValue]] forState:UIControlStateNormal];
    
    if ([_selectedSubAssetId isEqualToString:@"3"])
    {
        tblHeadervw.btnPostEquiList.userInteractionEnabled = NO;
        tblHeadervw.btnPostEquiList.enabled = NO;
        tblHeadervw.btnPostEquiList.backgroundColor = [UIColor lightGrayColor];
        [tblHeadervw.btnPostEquiList setTitle:_selectedCapacity forState:UIControlStateNormal];
    }
    else
    {
        tblHeadervw.btnPostEquiList.backgroundColor = [UIColor whiteColor];
        tblHeadervw.btnPostEquiList.userInteractionEnabled =YES;
        tblHeadervw.btnPostEquiList.enabled = YES;
         [tblHeadervw.btnPostEquiList setTitle:equinames forState:UIControlStateNormal];
    }
   
    [tblHeadervw.btnPostEquiVisiblity setTitle:[arrvisiblity objectAtIndex:[visibilityvalue intValue]] forState:UIControlStateNormal];
    return tblHeadervw;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    tblfootervw = [[CellPostEquiFooter alloc] initWithFrame:CGRectMake(0, 0, _tblPostEquipment.frame.size.width, 190)];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostEquiFooter" owner:self options:nil];
    tblfootervw = (CellPostEquiFooter *)[nib objectAtIndex:0]; 
    tblfootervw.btnSaveEqui.hidden = YES;
    tblfootervw.btnPublishEqui.hidden = NO;
    tblfootervw.btnEquiUpdate.hidden = YES;
    tblfootervw.cellPostEquiFooterDelegate = self;
    return tblfootervw;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    if (indexPath.row == 0)
    {
        static NSString *cellIdentifier = @"CellWithCV";
        
        CellWithCV *cell = (CellWithCV*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) 
        { 
            cell = [[CellWithCV alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
        }
        
        cell.lblAllphoto.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
        cell.cvPhotoes.dataSource = self;
        cell.cvPhotoes.delegate = self;
        
        if (arrEquiImages.count == 0)
        {
            cell.cvPhotoes.hidden = YES;
            cell.lblNoData.hidden = NO;
        }
        else
        {
            cell.cvPhotoes.hidden = NO;
            cell.lblNoData.hidden = YES;
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
        cell.btnPdfName.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
        [cell.btnPdfName setImage:imgNamed(@"imgplus") forState:UIControlStateNormal];
        cell.btnPdfDelete.hidden = YES;
        cell.cellPdfviewDelegate = self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
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
    return 645;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{ 
    return 190;
}

- (IBAction)btnBackClicked:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDrawerClicked:(id)sender
{
    [self.view endEditing:YES];
    
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
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
    CellWithCV *cellimages = (CellWithCV*)[_tblPostEquipment cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
    CellWithCV *cellselected=(CellWithCV*)[_tblPostEquipment cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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

#pragma mark - cell post equipment delegate
-(void)prepareRequestToSaveOnServer:(NSString *)ispublish
{
    @try 
    {
        // [self validateTxtLength:tblHeadervw.btnPostEquiAvailability.titleLabel.text withMessage:RequiredAvailbilityValue]
        if(
           [self validateTxtLength:tblHeadervw.btnPostEquiList.titleLabel.text withMessage:RequiredTrailersType] &&
           [self validateTxtLength:tblHeadervw.txtPostEquiName.text withMessage:RequiredEquiname] &&
           [self validateTxtLength:tblHeadervw.txtEquiEmptyWeight.text withMessage:RequiredEmptyWeight] &&
           [self validateTxtLength:tblHeadervw.txtPostEquiLength.text withMessage:RequiredLength] &&
           [self validateTxtLength:tblHeadervw.txtPostEquiWidth.text withMessage:RequiredWidth] &&
           [self validateTxtLength:tblHeadervw.txtPostEquiWeight.text withMessage:RequiredWeight] &&
           [self validateTxtLength:tblHeadervw.txtPostEquiHeight.text withMessage:RequiredHeight] &&
           [self validateTxtLength:tblHeadervw.btnPostEquiVisiblity.titleLabel.text withMessage:RequiredViewableTo]
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
              [self showHUD:@"Saving Asset"];
           
            NSString *selectedAsset=_selectedAssetId;
            if (_selectedAssetId.length==0)
            {
                selectedAsset=@"2";
            }
            if(_selectedSubAssetId.length==0)
            {
                _selectedSubAssetId=@"0";
            }
            NSString *eidlist,*eeidlist;
            if([_selectedSubAssetId isEqualToString:@"3"])
            {
                eidlist=@"0";
                eeidlist=@"13";
            }
            else
            {
                eidlist=allEids;
                eeidlist=allEEids;
            }
            
            NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
            [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey] forKey:Req_access_key];
            [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey] forKey:Req_secret_key];
            [dicParam setValue:eidlist forKey:Req_E_Id];
            [dicParam setValue:eeidlist forKey:Req_Es_Id];
            [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:Req_User_Id];
            [dicParam setValue:tblHeadervw.txtPostEquiName.text forKey:Req_Equi_Name];
            [dicParam setValue:tblHeadervw.txtPostEquiLength.text forKey:Req_Equi_Length];
            [dicParam setValue:tblHeadervw.txtPostEquiHeight.text forKey:Req_Equi_Height];
            [dicParam setValue:tblHeadervw.txtPostEquiWidth.text forKey:Req_Equi_Width];
            [dicParam setValue:tblHeadervw.txtPostEquiWeight.text forKey:Req_Equi_Weight];
            [dicParam setValue:visibilityvalue forKey:Req_Visible_To];
            [dicParam setValue:availabilityvalue forKey:Req_Equi_Availability];
            [dicParam setValue:tblfootervw.txtFooterNotes.text forKey:Req_Equi_Notes];
            [dicParam setValue:ispublish forKey:Req_Is_Publish];
            [dicParam setValue:[arrEquiImages objectAtIndex:0] forKey:Req_Equi_Photo1];
            [dicParam setValue:[arrEquiImages objectAtIndex:1] forKey:Req_Equi_Photo2];
            [dicParam setValue:[arrEquiImages objectAtIndex:2] forKey:Req_Equi_Photo3];
            [dicParam setValue:[arrEquiImages objectAtIndex:3] forKey:Req_Equi_Photo4];
            [dicParam setValue:[arrEquiImages objectAtIndex:4] forKey:Req_Equi_Photo5];
            [dicParam setValue:userlat forKey:Req_Equi_Latitude];
            [dicParam setValue:userlon forKey:Req_Equi_Longitude];
            [dicParam setValue:eaddess ?eaddess :@"" forKey:Req_LastEquiAddess];
            [dicParam setValue:eastatecode?eastatecode:@"" forKey:Req_LastEquiStatecode];
            [dicParam setValue:selectedAsset forKey:Req_AssetTypeId];
            [dicParam setValue:_selectedSubAssetId forKey:Req_AssetAbilityId];
            [dicParam setValue:tblHeadervw.txtEquiEmptyWeight.text forKey:Req_Equi_EmptyWeight];
            
            if (_objOfficeDetails != nil)
            {
                [dicParam setValue:[NSString stringWithFormat:@"%ld", (NSInteger)_objOfficeDetails.officeId] forKey:@"office_id"];
            }
            
//            NSDictionary *dicsavequipment=@{
//                                            Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
//                                            Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
//                                            Req_E_Id:eidlist,
//                                            Req_Es_Id:eeidlist,
//                                            Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
//                                            Req_Equi_Name:tblHeadervw.txtPostEquiName.text,
//                                            Req_Equi_Length:tblHeadervw.txtPostEquiLength.text,
//                                            Req_Equi_Height:tblHeadervw.txtPostEquiHeight.text,
//                                            Req_Equi_Width:tblHeadervw.txtPostEquiWidth.text,
//                                            Req_Equi_Weight:tblHeadervw.txtPostEquiWeight.text,
//                                            Req_Visible_To :visibilityvalue,
//                                            Req_Equi_Availability:availabilityvalue,
//                                            Req_Equi_Notes:tblfootervw.txtFooterNotes.text,
//                                            Req_Is_Publish:ispublish,
//                                            Req_Equi_Photo1:[arrEquiImages objectAtIndex:0],
//                                            Req_Equi_Photo2:[arrEquiImages objectAtIndex:1],
//                                            Req_Equi_Photo3:[arrEquiImages objectAtIndex:2],
//                                            Req_Equi_Photo4:[arrEquiImages objectAtIndex:3],
//                                            Req_Equi_Photo5:[arrEquiImages objectAtIndex:4],
//                                            Req_Equi_Latitude:userlat,
//                                            Req_Equi_Longitude:userlon,
//                                            Req_LastEquiAddess:eaddess ?eaddess :@"",
//                                            Req_LastEquiStatecode:eastatecode?eastatecode:@"",
//                                            Req_AssetTypeId:selectedAsset,
//                                            Req_AssetAbilityId:_selectedSubAssetId,
//                                            Req_Equi_EmptyWeight:tblHeadervw.txtEquiEmptyWeight.text
//                                            };
            if ([[NetworkAvailability instance]isReachable])
            {
                [[WebServiceConnector alloc] init:URLPostNewEquipment
                                   withParameters:dicParam
                                       withObject:self
                                     withSelector:@selector(getPostLEquiResponse:)
                                   forServiceType:@"FORMDATA"
                                   showDisplayMsg:@"Saving Asset"
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
-(NSString *)gatherEquipmentIds
{
    NSString *listOfAllEqui = @"";
    SubEquiEspecial *objequi;
    for(NSIndexPath *index in equipmentselected)
    {
        objequi=[arrEuipmentList objectAtIndex:index.row];
        NSString *eID =[NSString stringWithFormat:@"%@",objequi.internalBaseClassIdentifier];
        equinames=[NSString stringWithFormat:@"%@",objequi.esName];
        if([equipmentselected lastObject]!=index)
        {
            listOfAllEqui = [listOfAllEqui stringByAppendingString:[eID stringByAppendingString:@","]];
        }
        else
        {
            listOfAllEqui = [listOfAllEqui stringByAppendingString:eID];
        }
        
    }
    return listOfAllEqui;
}
-(NSString *)gatherEquipmentEspecialIds
{
    NSString *listOfEspecialEquis = @"";
    SubEquiEspecial *objequi;
    for(NSIndexPath *index in especialequiSelected)
    {
        objequi=[arrEspecialEuipmentlist objectAtIndex:index.row];
        especialequinames=[NSString stringWithFormat:@"%@",objequi.esName];
        NSString *eeID =[NSString stringWithFormat:@"%@",objequi.internalBaseClassIdentifier];
        if([especialequiSelected lastObject]!=index)
        {
            listOfEspecialEquis = [listOfEspecialEquis stringByAppendingString:[eeID stringByAppendingString:@","]];
        }
        else
        {
            listOfEspecialEquis = [listOfEspecialEquis stringByAppendingString:eeID];
        }
    }
    return listOfEspecialEquis;
}
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
        
    } 
   
}

- (ZSYPopoverListView *)showListView :(ZSYPopoverListView *)listviewname withSelectiontext :(NSString *)selectionm widthval:(CGFloat)w heightval :(CGFloat)h
{
    selectedPopupName = selectionm;
    
    listviewname.backgroundColor = [UIColor whiteColor];
    listviewname = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    listviewname.center = self.view.center;
    listviewname.titleName.backgroundColor = [UIColor whiteColor];
    listviewname.titleName.text = [NSString stringWithFormat:@"%@", selectionm];
    listviewname.datasource = self;
    listviewname.delegate = self;
    listviewname.layer.cornerRadius = 3.0f;
    listviewname.calledFor = selectedPopupName;
    listviewname.clipsToBounds = YES;
    
    [listviewname setDoneButtonWithTitle:@"" block:^{
        [overlayview removeFromSuperview];
    }];
    
    if ([selectedPopupName isEqualToString:VisibilityTitle] || [selectedPopupName isEqualToString:AvailablilityTitle])
    {
        [listviewname setCancelButtonTitle:@"" block:^{ }];
    }
    else
    {
        [listviewname setCancelButtonTitle:@"Done" block:^{
            
            [overlayview removeFromSuperview];
            
            if ([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
            {
                listOfEquis = @"";
                listOfEquis = [self gatherEquipmentIds];
                
                if (listOfEquis.length == 0)
                {
                    [tblHeadervw.btnPostEquiList setTitle:@"" forState:UIControlStateNormal];
                    equinames = @"";
                }
                else
                {
                    [tblHeadervw.btnPostEquiList setTitle:equinames forState:UIControlStateNormal];
                }
                
                allEids = @"0";
                allEEids = listOfEquis;
                [self.tblPostEquipment reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }
    
    [self addOverlay];
    [self.view endEditing:YES];
    return listviewname;
}

#pragma mark - Cell equipment header Delegate

- (IBAction)btnsettingsclciked:(id)sender
{
    EditDotAccount *obdriverList = initVCToRedirect(SBMAIN,EDITDOTACCOUNTVC);
    AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:obdriverList];
    [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (IBAction)btnPostEquiOpenSavedClicked:(id)sender
{
    
}

- (IBAction)btnPostEquiListClicked:(id)sender
{
    listView = [self showListView:listView withSelectiontext:EspecialEquiPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT - 100];
    [listView show];
}

- (IBAction)btnPostEquiEspecialClicked:(id)sender
{
    listView = [self showListView:listView withSelectiontext:EspecialEquiPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT / 2];
    [listView show];
}

- (IBAction)btnPostEquiVisibilityClicked:(id)sender
{
    listView = [self showListView:listView withSelectiontext:VisibilityTitle widthval:200 heightval:235];
    [listView show];
}

- (IBAction)btnPostEquiAvailabilityClicked:(id)sender
{
    listView = [self showListView:listView withSelectiontext:AvailablilityTitle widthval:SCREEN_WIDTH - 20 heightval:300];
    [listView show];
}

- (IBAction)btnPublishEquiClicked:(id)sender
{
//    PU COMMENTED UNCOMMENT WHEN LIVE
//    if([objuseraccount.dotnumStatus isEqualToString:@"0"])
//    {
//        DotWarning *objvw=[[[NSBundle mainBundle]loadNibNamed:@"DotWarning" owner:self options:nil] lastObject];
//        objvw.dotWarningDelegate=self;
//        [self.view addSubview:objvw];
//    }
//    else
//    {
        [self prepareRequestToSaveOnServer:@"1"];
//    }
}

- (IBAction)btnSaveEquiClicekd:(id)sender
{
     [self prepareRequestToSaveOnServer:@"0"];
}

- (IBAction)btnUpdateEquiClicked:(id)sender
{
    
}

#pragma mark - table view delegate datasource for popup view

- (CGFloat)popoverListView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([selectedPopupName isEqualToString:LocationPopUpTitle])
    {
        return listView.frame.size.height;
    }
     else if ([selectedPopupName isEqualToString:AvailablilityTitle])
     {
         return UITableViewAutomaticDimension;
     }
    else
    {
        return UITableViewAutomaticDimension;
    }
}

- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try
    {
        if ([selectedPopupName isEqualToString:VisibilityTitle])
        {
            return arrvisiblity.count;
        }
        else if ([selectedPopupName isEqualToString:AvailablilityTitle])
        {
            return arrAvailability.count;
        }
        else if ([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
        {
            return arrEuipmentList.count;
        }
        else
        {
            return 0;
        }
    }
    @catch (NSException *exception) { }
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
        
        cell.btnCellClick.userInteractionEnabled = NO;
        
        if ([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
        {
            cell.lblsubtext.text = @"";
            [cell.lblsubtext sizeToFit];
            
            if ([equipmentselected containsObject:indexPath])
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor = [UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth = 0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor = [UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth = 1.0f;
            }
            
            SubEquiEspecial *objse = [arrEspecialEuipmentlist objectAtIndex:indexPath.row];
            cell.lblListName.text = objse.esName;
            cell.lblListName.numberOfLines = 2;
            cell.vwCheckboxsubtext.hidden = YES;
        }
        else if ([selectedPopupName isEqualToString:VisibilityTitle])
        {
            cell.vwCheckboxsubtext.hidden = YES;
            cell.lblsubtext.text = @"";
            [cell.lblsubtext sizeToFit];
            
            if ([visibilityvalue intValue] == indexPath.row)
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor = [UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth = 0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor = [UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth = 1.0f;
            }
            
            cell.lblListName.text = [arrvisiblity objectAtIndex:indexPath.row];
        }
        else if ([selectedPopupName isEqualToString:AvailablilityTitle])
        {
            cell.vwCheckboxsubtext.hidden = NO;
            
            if ([availabilityvalue intValue] == indexPath.row)
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor = [UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth = 0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor = [UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth = 1.0f;
            }
            
            cell.lblListName.text = [arrAvailability objectAtIndex:indexPath.row];
            cell.lblsubtext.text = @"";
            [cell.lblsubtext sizeToFit];
        }
        else
        {
            cell.vwCheckboxsubtext.hidden = YES;
            cell.lblsubtext.text = @"";
            [cell.lblsubtext sizeToFit];
            
            if ([equipmentselected containsObject:indexPath])
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor = [UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth = 0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor = [UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth = 1.0f;
            }
            
            SubEquiEspecial *obje = [arrEuipmentList objectAtIndex:indexPath.row];
            cell.lblListName.text = obje.esName;
        }
        return cell;
    }
    @catch (NSException *exception) {
        
    }
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
    {
        if ([equipmentselected containsObject:indexPath])
        {
            [equipmentselected removeObject:indexPath];
        }
        else
        {
            [equipmentselected removeAllObjects];
            [equipmentselected addObject:indexPath];
        }
    }
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
    {
        if ([equipmentselected containsObject:indexPath])
        {
            [equipmentselected removeObject:indexPath];
        }
        else
        {
            [equipmentselected removeAllObjects];
            [equipmentselected addObject:indexPath];
        }      
    }
    else if ([selectedPopupName isEqualToString:VisibilityTitle])
    {
        visibilityvalue = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        [tblHeadervw.btnPostEquiVisiblity setTitle:[arrvisiblity objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [listView dismiss];
        [overlayview removeFromSuperview];
    }
    else if ([selectedPopupName isEqualToString:AvailablilityTitle])
    {
        availabilityvalue = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        [tblHeadervw.btnPostEquiAvailability setTitle:[arrAvailability objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [listView dismiss];
        [overlayview removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
