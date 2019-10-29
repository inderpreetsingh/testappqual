//
//  SubAssetDetailsVC.m
//  Lodr
//
//  Created by c196 on 26/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "SubAssetDetailsVC.h"
#import "Medialist.h"
#import "WebContentVC.h"
#import "EditSubAssetVC.h"
#import "CustomAnnotClass.h"
#import "SPGooglePlacesAutocompleteViewController.h"
#import "CQMFloatingController.h"
@interface SubAssetDetailsVC ()
{
    CellAssetHeader *headerview;
    CellAssetFooter *footer;
    NSMutableArray *arrAssetDoc,*arrAssetImages,*photos;
    MWPhotoBrowser *browser;
    CustomAnnotClass *annotation1;
    UITapGestureRecognizer *mapviewtgr;
    CLLocationCoordinate2D coordinate,*currentcoordinnate;
    MKCoordinateRegion region;
}
@end

@implementation SubAssetDetailsVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
    mapviewtgr = [[UITapGestureRecognizer alloc] 
                  initWithTarget:self action:@selector(handleMapviewTapGesture:)];
    mapviewtgr.numberOfTapsRequired = 1;
    mapviewtgr.numberOfTouchesRequired = 1;
    [self registerCustomNibForAllcell];
    if(_selectedEqui.equiLatitude.length==0 || _selectedEqui.equiLatitude==nil)
    {
        coordinate.latitude= [AppInstance.userCurrentLat floatValue];
        coordinate.longitude=[AppInstance.userCurrentLon floatValue];
    }
    else
    {
        coordinate.latitude= [_selectedEqui.equiLatitude floatValue];
        coordinate.longitude=[_selectedEqui.equiLongitude floatValue];
    }
    
    annotation1 = [[CustomAnnotClass alloc] initWithCoordinate:coordinate andMarkTitle:@"Truck Location" andMarkSubTitle:@""];
    annotation1.coordinate=coordinate;
    region.center.latitude = coordinate.latitude ;
    region.center.longitude = coordinate.longitude;
    region.span.longitudeDelta = 0.15f;
    region.span.latitudeDelta = 0.15f;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedSetSelectedSubAssetLocationData object:nil];
    [self registerCustomNibForAllcell];
}
- (void)handleMapviewTapGesture:(UIGestureRecognizer *)gestureRecognizer
{
//    NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%@,%@&sensor=true", _selectedEqui.equiLatitude,_selectedEqui.equiLongitude];
//    
//    NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    WebContentVC *objwebvc=initVCToRedirect(SBMAIN, WEBCONTENTVC);
//    objwebvc.webURL=encodedString;
//    [self.navigationController pushViewController:objwebvc animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSelectedTruckLocation:) name:NCNamedSetSelectedSubAssetLocationData object:nil];
    [self.view endEditing:YES];
    SPGooglePlacesAutocompleteViewController *googlePlacesVC = [[SPGooglePlacesAutocompleteViewController alloc] init];
    googlePlacesVC.requestMapFor=@"SubAssetScreenAddress";
    CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
    [floatingController setFrameColor:[UIColor whiteColor]];
    UIWindow *window1 = [[UIApplication sharedApplication] keyWindow];
    UIView *rootView = [window1.rootViewController view];
    [floatingController showInView:rootView
         withContentViewController:googlePlacesVC
                          animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - custom methods
-(void)registerCustomNibForAllcell
{
    UINib *nibcell = [UINib nibWithNibName:@"CellAssetTop" bundle:nil];
    [[self tblEquiDetails] registerNib:nibcell forCellReuseIdentifier:@"CellAssetTop"];
    
    UINib *nibcell4 = [UINib nibWithNibName:@"CellWithCV" bundle:nil];
    [[self tblEquiDetails]  registerNib:nibcell4 forCellReuseIdentifier:@"CellWithCV"];
    
    UINib *nibcell5 = [UINib nibWithNibName:@"cellPdfview" bundle:nil];
    [[self tblEquiDetails]  registerNib:nibcell5 forCellReuseIdentifier:@"cellPdfview"];
    
    self.tblEquiDetails.sectionFooterHeight = UITableViewAutomaticDimension;
    self.tblEquiDetails.estimatedSectionFooterHeight=350;
    browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = NO;
    browser.alwaysShowControls = YES;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.autoPlayOnAppear = YES;
    browser.hidesBottomBarWhenPushed=YES;
    browser.customImageSelectedIconName = @"ImageSelected.png";
    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [self setHeaderFooter];
}
-(void)setHeaderFooter
{
    NSArray *nibheader = [[NSBundle mainBundle] loadNibNamed:@"CellAssetHeader" owner:self options:nil];
    headerview = (CellAssetHeader *)[nibheader objectAtIndex:0]; 
    
    NSArray *nibfooter = [[NSBundle mainBundle] loadNibNamed:@"CellAssetFooter" owner:self options:nil];
    footer = (CellAssetFooter *)[nibfooter objectAtIndex:0];
    
    footer.btnEditAsset.layer.cornerRadius=1.0f;
    footer.btnPublish.layer.cornerRadius=1.0f;
    footer.btnDeleteAsset.layer.cornerRadius=1.0f;
    footer.btnUpdateStatus.layer.cornerRadius=1.0f;
    [self setImagesArray];
}
-(void)setImagesArray
{
    arrAssetDoc=[NSMutableArray new];
    arrAssetImages=[NSMutableArray new];
    for(Medialist *mda in _selectedEqui.medialist)
    {
        if([mda.mediaType isEqualToString:@"1"])
        {
            [arrAssetImages addObject:mda.mediaName];
        }
        else
        {
            [arrAssetDoc addObject:mda.mediaName];
        }
    }
}
-(void)slideshow:(int)rownum
{
    @try
    {   
        __block MWPhoto *photo;
        photos=[NSMutableArray new];
        for(int i=0 ; i <_selectedEqui.medialist.count; i++)
        {
            Medialist *media=[_selectedEqui.medialist objectAtIndex:i];
            NSString *str=[NSString stringWithFormat:@"%@%@",URLEquipmentImage,media.mediaName];
            if([media.mediaType isEqualToString:@"1"])
            {
                photo = [MWPhoto photoWithURL:[NSURL URLWithString:str]];
            }
            else if([media.mediaType isEqualToString:@"2"])
            {
                
            }
            else
            {
                photo.videoURL=[NSURL URLWithString:str];
                photo.isVideo=YES;
            }
            if(photo!=nil)
            {
                photo.caption=_selectedEqui.equiName;
                [photos addObject:photo];
            }
        }
        
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
        nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nc animated:YES completion:nil];
        
        [browser setCurrentPhotoIndex:rownum];
    } @catch (NSException *exception) {
        
    } 
}
#pragma mark - tableview delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{ 
    return 1; 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return arrAssetDoc.count+2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    @try
    {
        if(indexPath.row==0)
        {
            static NSString *cellIdentifier = @"CellAssetTop";
            CellAssetTop *cell = (CellAssetTop*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                cell = [[CellAssetTop alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
            }
            cell.mapLatLocation.delegate=self;
            [cell.mapLatLocation addGestureRecognizer:mapviewtgr];
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //               
            [cell.mapLatLocation removeAnnotation:annotation1];
            [cell.mapLatLocation addAnnotation:annotation1];
            if (CLLocationCoordinate2DIsValid(coordinate)) 
            {
                [cell.mapLatLocation setCenterCoordinate:coordinate];
                MKMapPoint annotationPoint = MKMapPointForCoordinate(coordinate);
                MKMapRect zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.0, 0.0);
                [cell.mapLatLocation setVisibleMapRect:zoomRect animated:YES];
                [cell.mapLatLocation setRegion:region animated:YES];
                cell.mapLatLocation.showsUserLocation=NO;
            } else
            {
                cell.mapLatLocation.showsUserLocation=YES;
            }
            //});
            cell.cellAssetTopDelegate=self;
            return cell; 
        }
        else if(indexPath.row==1)
        {
            static NSString *cellIdentifier = @"CellWithCV";
            CellWithCV *cell = (CellWithCV*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                cell = [[CellWithCV alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
            }
            cell.cvPhotoes.delegate=self;
            cell.cvPhotoes.dataSource=self;
            cell.lblAllphoto.text=@"   Related Files:";
            if(arrAssetImages.count==0)
            {
                cell.cvPhotoes.hidden=YES;
                cell.lblNoData.hidden=NO;
                cell.lblNoData.text=@"No photo available for this asset";
            }
            else
            {
                cell.cvPhotoes.hidden=NO;
                cell.lblNoData.hidden=YES;
                cell.lblNoData.text=@"";
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
            cell.cellPdfviewDelegate=self;
            cell.btnPdfDelete.hidden=YES;
            [cell.btnPdfName setTitle:[arrAssetDoc objectAtIndex:indexPath.row-3] forState:UIControlStateNormal];
            cell.btnPdfName.tag=indexPath.row-3;
            [cell.btnPdfName setImage:imgNamed(@"pdfimg") forState:UIControlStateNormal];
            cell.btnPdfName.titleLabel.font =[UIFont fontWithName:@"Arial" size:12];
            return cell;
        }
    } 
    @catch (NSException *exception) {
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    headerview.lblNameOfTrailer.text=_selectedEqui.equiName;
    if([_selectedEqui.assetTypeId isEqualToString:@"1"])
    {
        headerview.lbltypeofasset.text=@"Powered Asset";
        headerview.lblAssetability.text=_selectedEqui.capacityValue;
    }
    else if([_selectedEqui.assetTypeId isEqualToString:@"2"])
    {
        headerview.lbltypeofasset.text=@"Trailer";
        headerview.lblAssetability.text=@"Carry a load";
    }
    else
    {
        headerview.lbltypeofasset.text=@"Supporting Asset";
        headerview.lblAssetability.text=_selectedEqui.capacityValue;
    }
    return headerview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 280;
    }
    else if(indexPath.row==1)
    {
        return  150;
    }
    else
    {
        return 30;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 261;
}   

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{  
    if([_strRedirectFrom isEqualToString:@"MATCHESLIST"])
    {
        footer.vwWithMultipleButtons.hidden=YES;
        footer.vwWithSIngleButton.hidden=NO;
    }
    else  if([_strRedirectFrom isEqualToString:@"CALENDERVC"])
    {
        footer.vwWithMultipleButtons.hidden=YES;
        footer.vwWithSIngleButton.hidden=YES;
        footer.lblInstrtuctions.textColor=[UIColor clearColor];
        footer.heightmultiplebtn.constant=0;
        footer.heightFootersinglebtn.constant=0;
    }
    else
    {
        footer.vwWithMultipleButtons.hidden=NO;
        footer.vwWithSIngleButton.hidden=YES;
        if(_selectedEqui.equiNotes.length > 0)
        {
            footer.lblComments.text=_selectedEqui.equiNotes;
        }
        else
        {
            footer.lblComments.text=@"No notes available";
        }
        if([_selectedEqui.visibleTo isEqualToString:@"1"])
        {
            footer.lblVisibility.text=@"My Network";
        }
        else if([_selectedEqui.visibleTo isEqualToString:@"2"])
        {
            footer.lblVisibility.text=@"Everyone";
        }
        else
        {
            footer.lblVisibility.text=@"Private";
        }
        
        if([_selectedEqui.isPublish isEqualToString:@"1"])
        {
            [footer.btnPublish setTitle:@"UNPUBLISH" forState:UIControlStateNormal];
        }
        else
        {
            [footer.btnPublish setTitle:@"PUBLISH" forState:UIControlStateNormal];
        }
    }
    footer.cellAssetFooterDelegate=self;
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{ 
    return UITableViewAutomaticDimension; 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - Collection view  delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrAssetImages.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellCvPickedImage *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCvPickedImage" forIndexPath:indexPath];
    cell.btnDeleteImage.tag=indexPath.item;
    cell.cellCvPickedImageDelegate=self;
    
    cell.imgcancel.hidden=YES;
    cell.btnDeleteImage.hidden=YES;
    cell.btnDeleteImage.tag=indexPath.item;
    cell.cellCvPickedImageDelegate=self;
    NSString *str=[NSString stringWithFormat:@"%@%@",URLThumbImage,[arrAssetImages objectAtIndex:indexPath.item]];
    NSURL *imgurl=[NSURL URLWithString:str];
    
    [cell.imgLarge sd_setImageWithURL:imgurl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image !=nil)
        {
            cell.imgLarge.image=image;
        }
        else
        {
            
        }
    }];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self slideshow:(int)indexPath.item];
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
#pragma mark - mapview delegate
#pragma mark -
#pragma mark MKMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapViewIn viewForAnnotation:(id <MKAnnotation>)annotation 
{
    static NSString *identifier = @"CustomAnnotClass";
    //    if ([annotation isKindOfClass:[CustomAnnotClass class]]) {
    
    MKAnnotationView *annotationView = (MKAnnotationView *) [mapViewIn dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
    } else {
        annotationView.annotation = annotation;
    }
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image=[UIImage imageNamed:@"mapMarker"];
    return annotationView;
    //    }
    //    else
    //    {
    //        
    //    }
    //return nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region1  = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [mapView setRegion:[mapView regionThatFits:region1] animated:YES];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    [mapView addAnnotation:point];
}
#pragma mark - image delete delegate
- (IBAction)btnPdfNameClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    NSString *pdfurl=[NSString stringWithFormat:@"%@%@",URLEquipmentImage,[arrAssetDoc objectAtIndex:[btn tag]]];
    WebContentVC *objweb=initVCToRedirect(SBMAIN, WEBCONTENTVC);
    objweb.webURL=pdfurl;
    [self.navigationController pushViewController:objweb animated:YES];
}

- (void)btnDeleteImageClicked:(id)sender
{
    
}
#pragma mark - mw photo browser deleagets

- (CGRect)contentSizeRectForTextView:(UITextView *)textView
{
    [textView.layoutManager ensureLayoutForTextContainer:textView.textContainer];
    CGRect textBounds = [textView.layoutManager usedRectForTextContainer:textView.textContainer];
    CGFloat width =  (CGFloat)ceil(textBounds.size.width + textView.textContainerInset.left + textView.textContainerInset.right);
    CGFloat height = (CGFloat)ceil(textBounds.size.height + textView.textContainerInset.top + textView.textContainerInset.bottom);
    return CGRectMake(0, 0, width, height);
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser 
{
    return photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index 
{
    if (index < photos.count)
        return [photos objectAtIndex:index];
    return nil;
}
- (IBAction)btnBackClicked:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDrawerClicked:(id)sender {
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
- (void)btnPlaceTruckClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSelectedTruckLocation:) name:NCNamedSetSelectedSubAssetLocationData object:nil];
    [self.view endEditing:YES];
    SPGooglePlacesAutocompleteViewController *googlePlacesVC = [[SPGooglePlacesAutocompleteViewController alloc] init];
    googlePlacesVC.requestMapFor=@"SubAssetScreenAddress";
    CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
    [floatingController setFrameColor:[UIColor whiteColor]];
    UIWindow *window1 = [[UIApplication sharedApplication] keyWindow];
    UIView *rootView = [window1.rootViewController view];
    [floatingController showInView:rootView
         withContentViewController:googlePlacesVC
                          animated:YES];
}
-(void)setSelectedTruckLocation:(NSNotification *)anote
{
    NSDictionary *dict = anote.userInfo;
    coordinate.latitude= [[dict objectForKey:@"AddressLatitude"]  floatValue];
    coordinate.longitude=[[dict objectForKey:@"AddressLongitude"]  floatValue];
    annotation1 = [[CustomAnnotClass alloc] initWithCoordinate:coordinate andMarkTitle:@"Truck Location" andMarkSubTitle:@""];
    annotation1.coordinate=coordinate;
    region.center.latitude = coordinate.latitude ;
    region.center.longitude = coordinate.longitude;
    
    [self.tblEquiDetails beginUpdates];
    [self.tblEquiDetails reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tblEquiDetails endUpdates]; 
    [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedDismissView object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedSetSelectedSubAssetLocationData object:nil];
    NSString *str1,*str2,*str3,*str4;
    if([dict objectForKey:@"AddressLatitude"]==nil)
    {
        str1=@"";
    }
    else
    {
        str1=[dict objectForKey:@"AddressLatitude"];
    }
    if([dict objectForKey:@"AddressLongitude"]==nil)
    {
        str2=@"";
    }
    else
    {
        str2=[dict objectForKey:@"AddressLongitude"];
    }
    if([dict objectForKey:@"SelectedAddress"]==nil)
    {
        str3=@"";
    }
    else
    {
        str3=[dict objectForKey:@"SelectedAddress"];
    }
    if([dict objectForKey:@"SelectedState"]==nil)
    {
        str4=@"";
    }
    else
    {
        str4=[dict objectForKey:@"SelectedState"];
    }
    
    NSDictionary *dicAllEqui=@{
                               Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                               Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                               Req_EquiId:_selectedEqui.internalBaseClassIdentifier,
                               Req_UserLatitude:str1,
                               Req_UserLongitude:str2,
                               Req_Equi_Address:str3,
                               Req_State:str4
                               }; 
    [self updateTruckLocation:dicAllEqui]; 
}
-(void)updateTruckLocation:(NSDictionary*)dicAllEqui
{
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLUpdateLocationForTruck
         withParameters:dicAllEqui
         withObject:self
         withSelector:@selector(getUpdateLocationResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Updating Asset location"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}
-(IBAction)getUpdateLocationResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];   
        AppInstance.locationUpdated =@"NO";
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
        }   
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
#pragma mark Asset footer delegate
- (IBAction)btnUpdateStatusClicked:(id)sender
{
    
}
- (IBAction)btnPublishClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSString *pubflag;
    if([_selectedEqui.isPublish isEqualToString:@"1"])
    {
        pubflag=@"0";
        _selectedEqui.isPublish=@"0";
        [btn setTitle:@"UNPUBLISH" forState:UIControlStateNormal];
    }
    else
    {
        pubflag=@"1";
        _selectedEqui.isPublish=@"1";
        [btn setTitle:@"PUBLISH" forState:UIControlStateNormal];
    }
    
    NSDictionary *dic=@{  Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                          Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                          Req_identifier:_selectedEqui.internalBaseClassIdentifier,
                          Req_Is_Publish:pubflag,
                          };
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLMakePublishEquipment
         withParameters:dic
         withObject:self
         withSelector:@selector(getPublishedAssetResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Marking As Published"
         showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
    
}
-(IBAction)getPublishedAssetResponse:(id)sender
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
            [AppInstance.arrAllEquipmentByUserId  enumerateObjectsUsingBlock:^(Equipments *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([objmatch.internalBaseClassIdentifier isEqualToString:_selectedEqui.internalBaseClassIdentifier])
                {
                    objmatch.isPublish=_selectedEqui.isPublish;
                    [AppInstance.arrAllSavedLoadByUserId replaceObjectAtIndex:idx withObject:objmatch];
                }
            }];            
            [self.navigationController popViewControllerAnimated:YES];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}
-(IBAction)btnEditAssetClicked:(id)sender
{
    Equipments *editedequi=_selectedEqui;
    EditSubAssetVC *objedit=initVCToRedirect(SBAFTERSIGNUP, EDITSUBASSETVC);
    objedit.editEquiDetail=editedequi;
    [self.navigationController pushViewController:objedit animated:YES];
}
- (IBAction)btnDeleteAssetClicked:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:APPNAME
                                  message:@"Are you sure you want to delete this asset?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             NSDictionary *dic=@{  Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                                   Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                                   Req_identifier:_selectedEqui.internalBaseClassIdentifier
                                                   };
                             if([[NetworkAvailability instance]isReachable])
                             {
                                 [[WebServiceConnector alloc]
                                  init:URLDeleteAsset
                                  withParameters:dic
                                  withObject:self
                                  withSelector:@selector(getDeletedAssetResponse:)
                                  forServiceType:@"JSON"
                                  showDisplayMsg:@"Deleting Asset"
                                  showProgress:YES];
                             }
                             else
                             {
                                 [self dismissHUD];
                                 [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
                             }
                             
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"No"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
-(IBAction)getDeletedAssetResponse:(id)sender
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
            AppInstance.arrAllLoadByUserId=nil;
            AppInstance.dicAllMatchByLoadId=nil;
            AppInstance.countLodByUid=@"0";
            AppInstance.arrAllEquipmentByUserId=nil;
            AppInstance.countEquiByUid=@"0";
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess]; 
        }
    }
}

@end

