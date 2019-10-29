//
//  EditSubAssetVC.m
//  Lodr
//
//  Created by c196 on 26/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "EditSubAssetVC.h"
#import "Function.h"
#import "Medialist.h"
#import "WebContentVC.h"
#import "User.h"
#import "UserAccount.h"
@interface EditSubAssetVC ()
{
    int noOfPhotos;
    UIView *overlay,*overlayview;
    NSMutableArray *arrEuipmentList,*arrEquiImages,*arrEquiDocs;
    CellPostEquiFooter *tblfootervw;
    CellPostEquiHeader *tblHeadervw;
    UIActivityIndicatorView *indicator;
    User *objuser;
    UserAccount *objuseraccount;
}
@end

@implementation EditSubAssetVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
    NavigationBarHidden(YES);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    objuseraccount =[objuser.userAccount objectAtIndex:0];
    self.tbleditEquipment.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nibcell = [UINib nibWithNibName:@"CellWithCV" bundle:nil];
    [[self tbleditEquipment] registerNib:nibcell forCellReuseIdentifier:@"CellWithCV"];
    
    UINib *nibcell2 = [UINib nibWithNibName:@"cellPdfview" bundle:nil];
    [[self tbleditEquipment]  registerNib:nibcell2 forCellReuseIdentifier:@"cellPdfview"];
        
    arrEquiImages=[NSMutableArray new];
    arrEquiDocs=[NSMutableArray new];
   
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.color=[UIColor whiteColor];
   
    for(Medialist *mda in _editEquiDetail.medialist)
    {
        if([mda.mediaName containsString:@"doc"] || [mda.mediaName containsString:@"pdf"])
        {
            [arrEquiDocs addObject:mda.mediaName];
        }
        else
        {
            [arrEquiImages addObject:mda.mediaName];
        }
    }
     [AppInstance.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
 
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
    tblHeadervw.lblHeaderTitle.text=@"Update Asset";
    tblHeadervw.vwheaderSubAsset.hidden=NO;
    tblHeadervw.txtNameOfSubAsset.text=_editEquiDetail.equiName;
    [tblHeadervw.vwSubDetails removeFromSuperview];
    [tblHeadervw.vwHeading removeFromSuperview];
    if([_editEquiDetail.assetTypeId isEqualToString:@"3"])
    {
        tblHeadervw.heightSubAssets.constant=180;
        tblHeadervw.txtAssetEmptyWeight.hidden=YES;
        [tblHeadervw.btnweighttext removeFromSuperview];
        [tblHeadervw.lblheadingweight removeFromSuperview];
    }
    else
    {
         tblHeadervw.txtAssetEmptyWeight.hidden=NO;
    }
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
    if([_editEquiDetail.assetTypeId isEqualToString:@"3"])
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
    [arrEquiDocs removeObjectAtIndex:[dltsender tag]];
    [self.tbleditEquipment reloadData];
}
- (void)btnDeleteImageClicked:(id)sender
{
    @try {
        UIButton *dltsender=(UIButton *)sender;
        
        
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
    @try 
    {
        if([_editEquiDetail.assetTypeId isEqualToString:@"3"])
        {
            tblHeadervw.txtAssetEmptyWeight.text=@"0";
        }
        if(
           [self validateTxtLength:tblHeadervw.txtNameOfSubAsset.text withMessage:RequiredEquiname]&&
            [self validateTxtLength:tblHeadervw.txtAssetEmptyWeight.text withMessage:RequiredWeight]
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
            
            NSDictionary *dicsavequipment=@{
                                            Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                            Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                            Req_E_Id:@"0",
                                            Req_Es_Id:@"0",
                                            Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                            Req_Equi_Name:tblHeadervw.txtNameOfSubAsset.text,
                                            Req_Equi_Length:@"0",
                                            Req_Equi_Height:@"0",
                                            Req_Equi_Width:@"0",
                                            Req_Equi_EmptyWeight:tblHeadervw.txtEquiEmptyWeight.text,
                                            Req_Equi_Weight:@"0",
                                            Req_Visible_To :@"0",
                                            Req_Equi_Availability:@"0",
                                            Req_Equi_Notes:tblfootervw.txtFooterNotes.text,
                                            Req_Is_Publish:@"1",
                                            Req_Equi_Photo1:[arrEquiImages objectAtIndex:0],
                                            Req_Equi_Photo2:[arrEquiImages objectAtIndex:1],
                                            Req_Equi_Photo3:[arrEquiImages objectAtIndex:2],
                                            Req_Equi_Photo4:[arrEquiImages objectAtIndex:3],
                                            Req_Equi_Photo5:[arrEquiImages objectAtIndex:4],
                                            Req_Equi_Doc:[arrEquiDocs objectAtIndex:0],
                                            Req_Equi_Latitude:userlat,
                                            Req_Equi_Longitude:userlon,
                                            Req_identifier:_editEquiDetail.internalBaseClassIdentifier
                                            };    
            if([[NetworkAvailability instance]isReachable])
            {
                [[WebServiceConnector alloc]
                 init:URLUpdateEquipment
                 withParameters:dicsavequipment
                 withObject:self
                 withSelector:@selector(getPostLEquiResponse:)
                 forServiceType:@"FORMDATA"
                 showDisplayMsg:@"Edit Assets"
                 showProgress:YES];
            }
            else
            {
                [self dismissHUD];
                [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
            }
        }
        
    } @catch (NSException *exception) {
        
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

#pragma mark - Cell equipment header Delegate
- (IBAction)btnPostEquiOpenSavedClicked:(id)sender
{
    
}
- (IBAction)btnPostEquiListClicked:(id)sender
{

}
- (IBAction)btnPostEquiEspecialClicked:(id)sender
{
   
}
- (IBAction)btnPostEquiVisibilityClicked:(id)sender
{
 
}
- (IBAction)btnPostEquiAvailabilityClicked:(id)sender
{
  
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
