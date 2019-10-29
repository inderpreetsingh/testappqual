//
//  EditAssetVC.m
//  Lodr
//
//  Created by c196 on 04/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "EditAssetVC.h"
#import "Function.h"
#import "Medialist.h"
#import "WebContentVC.h"
#import "User.h"
#import "UserAccount.h"
@interface EditAssetVC ()
{
    int noOfPhotos;
    UIView *overlay,*overlayview;
    
    ZSYPopoverListView *listView;
    
    NSMutableArray *arrEuipmentList,*equipmentselected,*arrEquiImages,*arrEquiDocs,*arrImageIds,*arrDocIds;
    
    NSArray *arrvisiblity,*arrAvailability;
    
    NSString *selectedPopupName,*listOfEquis,*allEids,*visibilityvalue,*availabilityvalue,*equinames,*deletedimageid;
    
    CellPostEquiFooter *tblfootervw;
    CellPostEquiHeader *tblHeadervw;
    UIActivityIndicatorView *indicator;
    User *objuser;
    UserAccount *objuseraccount;
      __block NSString *eaddess,*eastatecode;
}
@end

@implementation EditAssetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationBarHidden(YES);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    objuseraccount =[objuser.userAccount objectAtIndex:0];
    self.tbleditEquipment.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nibcell = [UINib nibWithNibName:@"CellWithCV" bundle:nil];
    [[self tbleditEquipment] registerNib:nibcell forCellReuseIdentifier:@"CellWithCV"];
    deletedimageid=@"0";
    UINib *nibcell2 = [UINib nibWithNibName:@"cellPdfview" bundle:nil];
    [[self tbleditEquipment]  registerNib:nibcell2 forCellReuseIdentifier:@"cellPdfview"];
    
    arrvisiblity=[[NSArray alloc]initWithObjects:@"Private",@"My Network",@"Everyone", nil];
    arrAvailability=[[NSArray alloc]initWithObjects:@"Unlimited",@"24Hours",@"1 Week",@"30 Days",nil];
    
    arrEquiImages=[NSMutableArray new];
    arrEquiDocs=[NSMutableArray new];
    equipmentselected=[NSMutableArray new];
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.color=[UIColor whiteColor];
    arrImageIds=[NSMutableArray new];
    arrDocIds=[NSMutableArray new];
    for(Medialist *mda in _editEquiDetail.medialist)
    {
        if([mda.mediaName containsString:@"doc"] || [mda.mediaName containsString:@"pdf"])
        {
            [arrEquiDocs addObject:mda.mediaName];
            [arrDocIds addObject:mda.medialistIdentifier];
        }
        else
        {
            [arrEquiImages addObject:mda.mediaName];
            [arrImageIds addObject:mda.medialistIdentifier];
        }
    }
    NSArray *arrsubqui=[_editEquiDetail.esId componentsSeparatedByString:@","];
    
    equinames=@"";
    for (int i=0; i<arrsubqui.count; i++) 
    {
        NSString *condition=[NSString stringWithFormat:@"internalBaseClassIdentifier=='%@'",[arrsubqui objectAtIndex:i]];
        NSMutableArray*arrMatch=[[CoreDataAdaptor fetchAllDataWhere:condition fromEntity:SubEquiEspecialEntity] mutableCopy];
        if(arrMatch.count >0)
        {
            SubEquiEspecial *obje=[arrMatch objectAtIndex:0];
            NSString *str=obje.esName;
            equinames=str;
        }
    }
    [AppInstance.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    visibilityvalue=_editEquiDetail.visibleTo;
    availabilityvalue=_editEquiDetail.equiAvailablity;
    arrEuipmentList = [NSMutableArray new];
    arrEuipmentList = [[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:SubEquiEspecialEntity]mutableCopy];
    allEids=_editEquiDetail.esId;
    
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:[AppInstance.userCurrentLat floatValue] longitude:[AppInstance.userCurrentLon floatValue]
                       ];
    CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];
    [reverseGeocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *myPlacemark = [placemarks objectAtIndex:0];
        eaddess = [[myPlacemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
        eastatecode = myPlacemark.administrativeArea;
    }];
}
-(void)dismissKeyboard 
{
    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark - tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
    return 1; 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return arrEquiDocs.count+2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tblHeadervw==nil)
    {
        tblHeadervw=[[CellPostEquiHeader alloc] initWithFrame:CGRectMake(0, 0, self.tbleditEquipment.frame.size.width, 590)];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostEquiHeader" owner:self options:nil];
        tblHeadervw = (CellPostEquiHeader *)[nib objectAtIndex:0]; 
    }
  
    tblHeadervw.btnOpenSaved.hidden=YES;
    tblHeadervw.heightVwHeading.constant=80;
    tblHeadervw.cellPostEquiHeaderDelegate=self;
    tblHeadervw.heightEspecialEqui.constant=0;
    tblHeadervw.btnPostEquiEspecial.clipsToBounds=YES;
    tblHeadervw.lblHeadingtext.text=@"Update Asset";
    [tblHeadervw.btnPostEquiAvailability setTitle:[arrAvailability objectAtIndex:[availabilityvalue intValue]] forState:UIControlStateNormal];
    [tblHeadervw.btnPostEquiList setTitle:equinames forState:UIControlStateNormal];
    [tblHeadervw.btnPostEquiVisiblity setTitle:[arrvisiblity objectAtIndex:[visibilityvalue intValue]] forState:UIControlStateNormal];
    tblHeadervw.txtPostEquiWidth.text=_editEquiDetail.equiWidth;
    tblHeadervw.txtPostEquiHeight.text=_editEquiDetail.equiHeight;
    tblHeadervw.txtPostEquiWeight.text=_editEquiDetail.equiWeight;
    tblHeadervw.txtPostEquiLength.text=_editEquiDetail.equiLength;
    tblHeadervw.txtPostEquiName.text=_editEquiDetail.equiName;
    tblHeadervw.txtEquiEmptyWeight.text=_editEquiDetail.equiEmptyWeight;
    return tblHeadervw;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    tblfootervw=[[CellPostEquiFooter alloc] initWithFrame:CGRectMake(0, 0, self.tbleditEquipment.frame.size.width, 190)];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostEquiFooter" owner:self options:nil];
    tblfootervw = (CellPostEquiFooter *)[nib objectAtIndex:0]; 
    tblfootervw.btnSaveEqui.hidden=YES;
    tblfootervw.btnPublishEqui.hidden=YES;
    tblfootervw.btnEquiUpdate.hidden=NO;
    tblfootervw.cellPostEquiFooterDelegate=self;
    if(_editEquiDetail.equiNotes.length == 0)
    {
         tblfootervw.txtFooterNotes.text=@"No notes available";
    }
    else
    {
         tblfootervw.txtFooterNotes.text=_editEquiDetail.equiNotes;
    }
   
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
    else if(indexPath.row==1)
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
    else
    {
        static NSString *cellIdentifier = @"cellPdfview";
        cellPdfview *cell = (cellPdfview*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) 
        { 
            cell = [[cellPdfview alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
        }
        cell.btnPdfName.tag=indexPath.row;
        cell.btnPdfDelete.hidden=NO;
        cell.btnPdfDelete.tag=indexPath.row-2;
        [cell.btnPdfName setTitle:[arrEquiDocs objectAtIndex:indexPath.row-2] forState:UIControlStateNormal];
        [cell.btnPdfName setImage:imgNamed(@"pdfimg") forState:UIControlStateNormal];
        cell.btnPdfName.titleLabel.font =[UIFont fontWithName:@"Arial" size:12];
        cell.btnPdfDelete.accessibilityLabel=[arrDocIds objectAtIndex:indexPath.row-2];
        cell.cellPdfviewDelegate=self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==1)
    {
        [self openImagePicker];
    }
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

- (IBAction)btnDrawerClicked:(id)sender {
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
    if([[arrEquiImages objectAtIndex:indexPath.item] isKindOfClass:[UIImage class]])
    {
        cell.btnDeleteImage.accessibilityLabel=@"0";
        cell.imgLarge.image=[arrEquiImages objectAtIndex:indexPath.item];
        [indicator removeFromSuperview];
    }
    else
    {
        NSString *str=[NSString stringWithFormat:@"%@%@",URLThumbImage,[arrEquiImages objectAtIndex:indexPath.item]];
        NSURL *imgurl=[NSURL URLWithString:str];
        [indicator startAnimating];
        [indicator setCenter:cell.imgLarge.center];
        [cell.contentView addSubview:indicator];
        
        [cell.imgLarge sd_setImageWithURL:imgurl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(image !=nil)
            {
                cell.imgLarge.image=image;
                [indicator removeFromSuperview];
            }
            else
            {
                [indicator removeFromSuperview];
            }
        }];
        
        if([[arrEquiImages objectAtIndex:indexPath.item] containsString:@"doc"]||[[arrEquiImages objectAtIndex:indexPath.item] containsString:@"pdf"])     
        {
            cell.imgLarge.hidden=YES;
            cell.btnDeleteImage.hidden=YES;
        }
        else
        {
            cell.imgLarge.hidden=NO;
            cell.btnDeleteImage.hidden=NO;
            cell.btnDeleteImage.accessibilityLabel=[arrImageIds objectAtIndex:indexPath.item];
        }
    }
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
- (IBAction)btnPdfDeleteClicked:(id)sender 
{
    UIButton *dltsender=(UIButton *)sender;
    [arrDocIds removeObjectAtIndex:[dltsender tag]];
    [arrEquiDocs removeObjectAtIndex:[dltsender tag]];
    deletedimageid=[NSString stringWithFormat:@"%@,%@",deletedimageid,dltsender.accessibilityLabel];
    [self.tbleditEquipment reloadData];
}
- (void)btnDeleteImageClicked:(id)sender
{
    @try {
        UIButton *dltsender=(UIButton *)sender;
        if([[arrEquiImages objectAtIndex:[dltsender tag]] isKindOfClass:[NSString class]])
        {
            deletedimageid=[NSString stringWithFormat:@"%@,%@",deletedimageid,dltsender.accessibilityLabel];
            [arrImageIds removeObjectAtIndex:[dltsender tag]];
        }
        
        [arrEquiImages removeObjectAtIndex:[dltsender tag]];
        CellWithCV *cellimages = (CellWithCV*)[_tbleditEquipment cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
    } @catch (NSException *exception) {
        
    }  
}
#pragma mark - Cell FOOTER delegate
- (IBAction)btnPdfNameClicked:(id)sender 
{
    UIButton *btn=(UIButton *)sender; 
    if(btn.tag > 1)
    {
        NSString *pdfurl=[NSString stringWithFormat:@"%@%@",URLEquipmentImage,btn.titleLabel.text];
        WebContentVC *objweb=initVCToRedirect(SBMAIN, WEBCONTENTVC);
        objweb.webURL=pdfurl;
        [self.navigationController pushViewController:objweb animated:YES];
    }
    else
    {
        [self openImagePicker];
    }
}
-(void)openImagePicker
{
    CellWithCV *cellselected=(CellWithCV*)[_tbleditEquipment cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
    //[self validateTxtLength:tblHeadervw.btnPostEquiAvailability.titleLabel.text withMessage:RequiredAvailbilityValue]
    @try 
    {
        if(
           [self validateTxtLength:tblHeadervw.btnPostEquiList.titleLabel.text withMessage:RequiredTrailersType] &&
           [self validateTxtLength:tblHeadervw.txtPostEquiName.text withMessage:RequiredDescription] &&
           [self validateTxtLength:tblHeadervw.txtEquiEmptyWeight.text withMessage:RequiredEmptyWeight] &&
           [self validateTxtLength:tblHeadervw.txtPostEquiLength.text withMessage:RequiredLength] &&
           [self validateTxtLength:tblHeadervw.txtPostEquiWidth.text withMessage:RequiredWidth] &&
           [self validateTxtLength:tblHeadervw.txtPostEquiWeight.text withMessage:RequiredWeight] &&
           [self validateTxtLength:tblHeadervw.txtPostEquiHeight.text withMessage:RequiredHeight] &&
           [self validateTxtLength:tblHeadervw.btnPostEquiVisiblity.titleLabel.text withMessage:RequiredViewableTo]
           )
        {
            for(int i=0;i<arrEquiImages.count;i++)
            {
                if([[arrEquiImages objectAtIndex:i] isKindOfClass:[NSString class]])
                {
                    [arrEquiImages removeObjectAtIndex:i];
                }
            }
            if(arrEquiDocs.count == 0)
            {
                [arrEquiDocs addObject:@""];
            }
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
           

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are You Sure ?" message:@"All your matches and links would be resetted.Do You Wish to continue ?" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [self callWSToContinue:ispublish];
                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
            
            [alert addAction:cancelAction];
            [alert addAction:yesAction];
            
            [self.navigationController presentViewController:alert animated:TRUE completion:nil];
           
        }
        
    } @catch (NSException *exception) {
        NSLog(@"EXCEPTION %@",exception.description);
        
    }  
}
- (void)callWSToContinue:(NSString *)ispublish{
    
    NSString *strIsSync = @"1";
    NSString *userlat=@"",*userlon=@"";
    
    if(_editEquiDetail.equiLatitude.length==0)
    {
        userlat=AppInstance.userCurrentLat;
        userlon=AppInstance.userCurrentLon;
    }
    else
    {
        userlat=_editEquiDetail.equiLatitude;
        userlon=_editEquiDetail.equiLongitude;
    }
    if(_editEquiDetail.matches.count > 0){
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"matchOrderStatus == %@",@"3"];
        
        NSArray *arrFilter = [_editEquiDetail.matches filteredArrayUsingPredicate:predicate];
        if(arrFilter.count > 0){
            //Waiting for client to answer -- SK
            if([_editEquiDetail.eloadStatus isEqualToString:@"5"]){
                //in schedule mode
                //when load
                strIsSync = @"1";
            }
            else{
                //dispatched
                strIsSync = @"0";
            }
        }
        else{
            strIsSync = @"0";
        }
    }
    NSString *lati = AppInstance.userCurrentLat;
    NSString *longi = AppInstance.userCurrentLon;
    
    if([strIsSync isEqualToString:@"1"]){
        //call post new load api
        NSDictionary *dicsavequipment=@{
                                        //                                             Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                        Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                        Req_E_Id:_editEquiDetail.eId,
                                        Req_Es_Id:_editEquiDetail.esId,
                                        Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                        Req_Equi_Name:tblHeadervw.txtPostEquiName.text,
                                        Req_Equi_Length:tblHeadervw.txtPostEquiLength.text,
                                        Req_Equi_Height:tblHeadervw.txtPostEquiHeight.text,
                                        Req_Equi_Width:tblHeadervw.txtPostEquiWidth.text,
                                        Req_Equi_Weight:tblHeadervw.txtPostEquiWeight.text,
                                        Req_Visible_To :visibilityvalue,
                                        Req_Equi_Availability:availabilityvalue,
                                        Req_Equi_Notes:tblfootervw.txtFooterNotes.text,
                                        Req_Is_Publish:ispublish,
                                        Req_Equi_Photo1:[arrEquiImages objectAtIndex:0],
                                        Req_Equi_Photo2:[arrEquiImages objectAtIndex:1],
                                        Req_Equi_Photo3:[arrEquiImages objectAtIndex:2],
                                        Req_Equi_Photo4:[arrEquiImages objectAtIndex:3],
                                        Req_Equi_Photo5:[arrEquiImages objectAtIndex:4],
                                        Req_Equi_Latitude:userlat,
                                        Req_Equi_Longitude:userlon,
                                        Req_LastEquiAddess:eaddess ?eaddess :@"",
                                        Req_LastEquiStatecode:eastatecode?eastatecode:@"",
                                        Req_AssetTypeId:_editEquiDetail.assetTypeId,
                                        Req_AssetAbilityId:_editEquiDetail.assetAbilityId,
                                        Req_Equi_EmptyWeight:tblHeadervw.txtEquiEmptyWeight.text,
                                        Req_EquiId: _editEquiDetail.internalBaseClassIdentifier
                                        };
        
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLPostNewEquipment
             withParameters:dicsavequipment
             withObject:self
             withSelector:@selector(getPostLEquiResponse:)
             forServiceType:@"FORMDATA"
             showDisplayMsg:@"Edit Equipments"
             showProgress:YES];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
    else{
        //call edit load api
        NSDictionary *dicsavequipment=@{Req_LoadId:_editEquiDetail.eloadId,
                                        Req_UserLatitude:lati,
                                        Req_UserLongitude:longi,
                                        Req_IsAsync : strIsSync,
                                        Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                        Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                        Req_E_Id:@"0",
                                        Req_Es_Id:allEids,
                                        Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                        Req_Equi_Name:tblHeadervw.txtPostEquiName.text,
                                        Req_Equi_Length:tblHeadervw.txtPostEquiLength.text,
                                        Req_Equi_Height:tblHeadervw.txtPostEquiHeight.text,
                                        Req_Equi_Width:tblHeadervw.txtPostEquiWidth.text,
                                        Req_Equi_Weight:tblHeadervw.txtPostEquiWeight.text,
                                        Req_Visible_To :visibilityvalue,
                                        Req_Equi_Availability:availabilityvalue,
                                        Req_Equi_Notes:tblfootervw.txtFooterNotes.text,
                                        Req_Is_Publish:_editEquiDetail.isPublish,
                                        Req_Equi_Photo1:[arrEquiImages objectAtIndex:0],
                                        Req_Equi_Photo2:[arrEquiImages objectAtIndex:1],
                                        Req_Equi_Photo3:[arrEquiImages objectAtIndex:2],
                                        Req_Equi_Photo4:[arrEquiImages objectAtIndex:3],
                                        Req_Equi_Photo5:[arrEquiImages objectAtIndex:4],
                                        Req_Equi_Doc:[arrEquiDocs objectAtIndex:0],
                                        Req_Equi_Latitude:userlat,
                                        Req_Equi_Longitude:userlon,
                                        Req_identifier:_editEquiDetail.internalBaseClassIdentifier,
                                        Req_Deleted_img_ids:deletedimageid,
                                        Req_Equi_EmptyWeight:tblHeadervw.txtEquiEmptyWeight.text,
                                        Req_LastEquiAddess:eaddess ?eaddess :@"",
                                        Req_LastEquiStatecode:eastatecode?eastatecode:@"",
                                        };
        
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLUpdateEquipment
             withParameters:dicsavequipment
             withObject:self
             withSelector:@selector(getPostLEquiResponse:)
             forServiceType:@"FORMDATA"
             showDisplayMsg:@"Edit Equipments"
             showProgress:YES];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
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
    {//500*18-----//
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
-(ZSYPopoverListView *)showListView :(ZSYPopoverListView *)listviewname withSelectiontext :(NSString *)selectionm widthval:(CGFloat)w heightval :(CGFloat)h
{
    selectedPopupName=selectionm;
    listviewname.backgroundColor=[UIColor whiteColor];
    listviewname = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0,0, w, h)];
    listviewname.center=self.view.center;
    listviewname.titleName.backgroundColor=[UIColor whiteColor];
    listviewname.titleName.text = [NSString stringWithFormat:@"%@",selectionm];
    listviewname.datasource = self;
    listviewname.delegate = self;
    listviewname.layer.cornerRadius=3.0f;
    listviewname.calledFor=selectedPopupName;
    listviewname.clipsToBounds=YES;
    
    [listviewname setDoneButtonWithTitle:@"" block:^{
        [overlayview removeFromSuperview];
    }];
    if([selectedPopupName isEqualToString:VisibilityTitle] || [selectedPopupName isEqualToString:AvailablilityTitle])
    {
        [listviewname setCancelButtonTitle:@"" block:^{
        }];
    }
    else
    {
        [listviewname setCancelButtonTitle:@"Done" block:^{
            [overlayview removeFromSuperview];
            if([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
            {
                listOfEquis=@"";
                listOfEquis = [self gatherEquipmentIds];
                if(listOfEquis.length==0)
                {
                    [tblHeadervw.btnPostEquiList setTitle:@"" forState:UIControlStateNormal];
                    equinames=@"";
                }
                else
                {
                    [tblHeadervw.btnPostEquiList setTitle:equinames forState:UIControlStateNormal];
                }
                allEids=listOfEquis;
                _editEquiDetail.esId=@"0";
                _editEquiDetail.esId=allEids;
                [equipmentselected removeAllObjects];
                [self.tbleditEquipment reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }
    [self addOverlay];
    [self.view endEditing:YES];
    return listviewname;
}
#pragma mark - Cell equipment header Delegate
- (IBAction)btnPostEquiOpenSavedClicked:(id)sender
{
    
}
- (IBAction)btnPostEquiListClicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:EspecialEquiPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT-100];
    [listView show];
}
- (IBAction)btnPostEquiEspecialClicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:EspecialEquiPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT/2];
    [listView show];
}
- (IBAction)btnPostEquiVisibilityClicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:VisibilityTitle widthval:200 heightval:235];
    [listView show];
}
- (IBAction)btnPostEquiAvailabilityClicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:AvailablilityTitle widthval:200 heightval:280];
    [listView show];
}

- (IBAction)btnPublishEquiClicked:(id)sender
{
    // [self prepareRequestToSaveOnServer:@"1"];
}
- (IBAction)btnSaveEquiClicekd:(id)sender
{
    [self prepareRequestToSaveOnServer:@"0"];
}
- (IBAction)btnUpdateEquiClicked:(id)sender
{
     [self prepareRequestToSaveOnServer:@"1"];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"On update asset details all linked/interested load with this asset will reset.You need to link it again." message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction* ok = [UIAlertAction
//                         actionWithTitle:@"Update"
//                         style:UIAlertActionStyleDefault
//                         handler:^(UIAlertAction * action)
//                         {
//                              [self prepareRequestToSaveOnServer:@"1"];
//                         }];
//    UIAlertAction* cancel = [UIAlertAction
//                             actionWithTitle:@"Cancel"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 [alert dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
//    [alert addAction:ok];
//    [alert addAction:cancel];
//    [self presentViewController:alert animated:YES completion:^{    }];
}
#pragma mark -table view delegate datasource for popup view
-(CGFloat)popoverListView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([selectedPopupName isEqualToString:LocationPopUpTitle])
    {
        return listView.frame.size.height;
    }
    else
    {
        return UITableViewAutomaticDimension;
    }
}
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try {
        
        if([selectedPopupName isEqualToString:VisibilityTitle])
        {
            return arrvisiblity.count;
        }
        else if([selectedPopupName isEqualToString:AvailablilityTitle])
        {
            return arrAvailability.count;
        }
        else if([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
        {
            return arrEuipmentList.count;
        }
        else
        {
            return 0;
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
        if([selectedPopupName isEqualToString:VisibilityTitle])
        {
            if([visibilityvalue intValue] == indexPath.row)
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
            cell.lblListName.text=[arrvisiblity objectAtIndex:indexPath.row];
        }
        else if([selectedPopupName isEqualToString:AvailablilityTitle])
        {
            if([availabilityvalue intValue] == indexPath.row)
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
            cell.lblListName.text=[arrAvailability objectAtIndex:indexPath.row];
        }
        else
        {
            SubEquiEspecial *obje=[arrEuipmentList objectAtIndex:indexPath.row];
            cell.lblListName.text=obje.esName;
            if ([equipmentselected containsObject:indexPath] || [_editEquiDetail.esId containsString:obje.internalBaseClassIdentifier])
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
            cell.lblListName.numberOfLines =2;
            
           
        }
        return cell;
    }
    @catch (NSException *exception) {
        
    }
    
}
- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
    {
        if ([equipmentselected containsObject:indexPath])
        {
            [equipmentselected removeObject:indexPath];
        }
        else
        {
            [equipmentselected removeAllObjects];
            _editEquiDetail.esId=@"";
            [equipmentselected addObject:indexPath];
        }
    }
   
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
    {
        if ([equipmentselected containsObject:indexPath])
        {
            [equipmentselected removeObject:indexPath];
        }
        else
        {
            [equipmentselected removeAllObjects];
            _editEquiDetail.esId=@"";
            [equipmentselected addObject:indexPath];
        }      
    }
    else if([selectedPopupName isEqualToString:VisibilityTitle])
    {
        
        visibilityvalue=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        [tblHeadervw.btnPostEquiVisiblity setTitle:[arrvisiblity objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [listView dismiss];
        [overlayview removeFromSuperview];
    }
    else if([selectedPopupName isEqualToString:AvailablilityTitle])
    {
        availabilityvalue=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        [tblHeadervw.btnPostEquiAvailability setTitle:[arrAvailability objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [listView dismiss];
        [overlayview removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
