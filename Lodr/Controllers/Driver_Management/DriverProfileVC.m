//
//  DriverProfileVC.m
//  Lodr
//
//  Created by c196 on 11/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "DriverProfileVC.h"
#import "WebContentVC.h"
#import "CustomAnnotClass.h"
#import "EditDriverVC.h"
@interface DriverProfileVC ()
{
    CellDriverProfileHeader *viewHeader;
    CellAssetFooter *viewFooter;
    NSMutableArray *arrFields,*arrValues,*photos;
    CustomAnnotClass *annotation1;
    UITapGestureRecognizer *mapviewtgr;
    CLLocationCoordinate2D coordinate,*currentcoordinnate;
    MKCoordinateRegion region;
    MWPhotoBrowser *browser;
    NSString *profiepic,*address,*phonrno,*firstname,*lastname,*officephone,*companyphone;
}
@end

@implementation DriverProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationBarHidden(YES);
    mapviewtgr = [[UITapGestureRecognizer alloc] 
                  initWithTarget:self action:@selector(handledriverMapviewTapGesture:)];
    mapviewtgr.numberOfTapsRequired = 1;
    mapviewtgr.numberOfTouchesRequired = 1;
    arrFields=[NSMutableArray new];
    arrValues=[NSMutableArray new];
    [arrFields addObject:@"Operating Address:"];
    [arrFields addObject:@"Contact number:"];
    if([_redrirectfrom isEqualToString:@"DriverDispatchLIST"])
    {
        if(_objmatch.userLatitude.length==0 || _objmatch.userLatitude==nil)
        {
            coordinate.latitude= [_objmatch.companyLatitude floatValue];
            coordinate.longitude=[_objmatch.companyLongitude floatValue];
        }
        else
        {
            coordinate.latitude= [_objmatch.userLatitude floatValue];
            coordinate.longitude=[_objmatch.userLongitude floatValue];
        }
        
        if([_objmatch.operatingAddress isEqualToString:@""] || _objmatch.operatingAddress.length==0)
        {
            address=_objmatch.companyAddress;
        }
        else
        {
            address=_objmatch.operatingAddress;
        }
        if([_objmatch.phoneNo isEqualToString:@""] || _objmatch.phoneNo.length==0)
        {
            phonrno=_objmatch.cmpnyPhoneNo;
        }
        else
        {
            phonrno=_objmatch.phoneNo;
        }
        profiepic=_objmatch.profilePicture;
        firstname=_objmatch.firstname;
        lastname=_objmatch.lastname;
        [arrValues addObject:address];
        [arrValues addObject:phonrno];
    }
    else
    {
        if(_objeuaccount.userLatitude.length==0 || _objeuaccount.userLongitude==nil)
        {
            coordinate.latitude= [_objeuaccount.companyLatitude floatValue];
            coordinate.longitude=[_objeuaccount.companyLongitude floatValue];
        }
        else
        {
            coordinate.latitude= [_objeuaccount.userLatitude floatValue];
            coordinate.longitude=[_objeuaccount.userLongitude floatValue];
        }
        
        if([_objeuaccount.operatingAddress isEqualToString:@""] || _objeuaccount.operatingAddress.length==0)
        {
            address=_objeuaccount.companyAddress;
        }
        else
        {
            address=_objeuaccount.operatingAddress;
        }
        if([_objeuaccount.phoneNo isEqualToString:@""] || _objeuaccount.phoneNo.length==0)
        {
            phonrno=_objeuaccount.cmpnyPhoneNo;
        }
        else
        {
            phonrno=_objeuaccount.phoneNo;
        }
       
        profiepic=_objeuaccount.profilePicture;
        firstname=_objeuaccount.firstname;
        lastname=_objeuaccount.lastname;
        [arrValues addObject:address];
        [arrValues addObject:phonrno];
    }
   
    
    annotation1 = [[CustomAnnotClass alloc] initWithCoordinate:coordinate andMarkTitle:@"Truck Location" andMarkSubTitle:@""];
    annotation1.coordinate=coordinate;
    region.center.latitude = coordinate.latitude ;
    region.center.longitude = coordinate.longitude;
    region.span.longitudeDelta = 0.15f;
    region.span.latitudeDelta = 0.15f;
    
    
    
    self.tblDriverProfile.rowHeight = UITableViewAutomaticDimension;
    self.tblDriverProfile.estimatedRowHeight=100;
    [self layoutHeaderAndFooter];
}
- (void)handledriverMapviewTapGesture:(UIGestureRecognizer *)gestureRecognizer
{
     NSString* url=@"";
    if([_redrirectfrom isEqualToString:@"DriverDispatchLIST"])
    {
        url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%@,%@&sensor=true", _objmatch.userLatitude,_objmatch.userLongitude];
    }
    else
    {
        url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%@,%@&sensor=true", _objeuaccount.userLatitude,_objeuaccount.userLongitude];
    }
    NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    WebContentVC *objwebvc=initVCToRedirect(SBMAIN, WEBCONTENTVC);
    objwebvc.webURL=encodedString;
    [self.navigationController pushViewController:objwebvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)layoutHeaderAndFooter
{
    @try {
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
        UINib *nibcell = [UINib nibWithNibName:@"CellAssetTop" bundle:nil];
        [[self tblDriverProfile] registerNib:nibcell forCellReuseIdentifier:@"CellAssetTop"];
//        UINib *nibcell5 = [UINib nibWithNibName:@"cellPdfview" bundle:nil];
//        [[self tblDriverProfile]  registerNib:nibcell5 forCellReuseIdentifier:@"cellPdfview"];
        self.tblDriverProfile.sectionFooterHeight = UITableViewAutomaticDimension;
        self.tblDriverProfile.estimatedSectionFooterHeight=350;
        
        viewHeader = [[[NSBundle mainBundle] loadNibNamed:@"CellDriverProfileHeader"
                                                    owner:self
                                                  options:nil] objectAtIndex:0];
        viewHeader.lblDriverName.text=[[NSString stringWithFormat:@"%@ %@",firstname,lastname]capitalizedString];
        NSString *str;
        if([profiepic containsString:@"http://"] || [profiepic containsString:@"https://"])
        {
            str=[NSString stringWithFormat:@"%@",profiepic];
        }
        else
        {
            str=[NSString stringWithFormat:@"%@%@",URLProfileImage,profiepic];
        }
        NSURL *imgurl=[NSURL URLWithString:str];
        viewHeader.imgDriverPic.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(zoomimage:)];
        
        tapGesture1.numberOfTapsRequired = 1;
        
        [viewHeader.imgDriverPic addGestureRecognizer:tapGesture1];
        [viewHeader.imgDriverPic sd_setImageWithURL:imgurl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(image !=nil)
            {
                viewHeader.imgDriverPic.image=image;
            }
            else
            {
            }
        }];
    } @catch (NSException *exception) {
        NSLog(@"Excepton :%@",exception.description);
    } 
    
}
- (void) zoomimage: (id)sender
{
    @try
    {   
        __block MWPhoto *photo;
         NSString *str=[NSString stringWithFormat:@"%@%@",URLProfileImage,profiepic];
        photos =[NSMutableArray new];
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:str]];
        photo.caption=[firstname uppercaseString];
        [photos addObject:photo];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
        nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nc animated:YES completion:nil];
        [browser setCurrentPhotoIndex:0];
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
    return arrFields.count+1; // top + pdf + pdf heading
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
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
        [cell.btnPlaceTruck setTitle:@"CHAT" forState:UIControlStateNormal];
        cell.cellAssetTopDelegate=self;
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
        return cell; 
    }
    else
    {
        if(indexPath.row > arrFields.count)
        {
            NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
            static NSString *cellIdentifier = @"cellPdfview";
            cellPdfview *cell = (cellPdfview*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                cell = [[cellPdfview alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
            }
            if(indexPath.row == totalRow -1)
            {
                cell.cellPdfviewDelegate=self;
                cell.btnPdfDelete.hidden=YES;
                [cell.btnPdfName setTitle:@"test123" forState:UIControlStateNormal];
                cell.btnPdfName.tag=indexPath.row-3;
                [cell.btnPdfName setImage:imgNamed(@"pdfimg") forState:UIControlStateNormal];
                cell.btnPdfName.titleLabel.font =[UIFont fontWithName:@"Arial" size:12];
                [cell.btnPdfName setContentEdgeInsets:UIEdgeInsetsMake(0.0f, 25.0f, 0.0f, 0.0f)];
                return cell;
            }
            else
            {
                [cell.btnPdfName setTitle:@"Related Files:" forState:UIControlStateNormal];
                cell.btnPdfName.titleLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:15];
                [cell.btnPdfName setImage:nil forState:UIControlStateNormal];
                cell.btnPdfDelete.hidden=YES;
                return cell;
            }
        }
        else
        {
            static NSString *CellIdentifier = @"CellDriverProfile";
            CellDriverProfile *cellDriverProfile = [_tblDriverProfile dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cellDriverProfile == nil)
            {
                NSArray *objCell = [[NSBundle mainBundle] loadNibNamed:@"CellDriverProfile" owner:self options:nil];
                cellDriverProfile = [objCell objectAtIndex:0];
            }
            
            cellDriverProfile.lblDriverDetails.numberOfLines=0;
            [cellDriverProfile.lblDriverDetails sizeToFit];
            cellDriverProfile.lblDriverDetails.textAlignment=NSTextAlignmentCenter;
            cellDriverProfile.lblDriverFieldName.text=[arrFields objectAtIndex:indexPath.row-1];
            cellDriverProfile.lblDriverDetails.text=[NSString stringWithFormat:@"%@",[arrValues objectAtIndex:indexPath.row-1]];
            return cellDriverProfile;
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return viewHeader;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
//    NSArray *nibFooter = [[NSBundle mainBundle] loadNibNamed:@"CellAssetFooter" owner:self options:nil];
//    CellAssetFooter *tblFooter = (CellAssetFooter *)[nibFooter objectAtIndex:0]; 
//    tblFooter.vwWithMultipleButtons.hidden=NO;
//    [tblFooter.btnEditAsset setTitle:@"EDIT DRIVER" forState:UIControlStateNormal];
//    tblFooter.vwWithSIngleButton.hidden=YES;
//    tblFooter.cellAssetFooterDelegate=self;
//    tblFooter.lblInstrtuctions.text=@"Click below to edit or publish or delete this driver";
    return [[UIView alloc]initWithFrame:CGRectZero];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 130;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{
    return 10;
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
   // UIButton *btn=(UIButton *)sender;
    
//    NSString *pdfurl=[NSString stringWithFormat:@"%@%@",URLEquipmentImage,[arrAssetDoc objectAtIndex:[btn tag]]];
//    WebContentVC *objweb=initVCToRedirect(SBMAIN, WEBCONTENTVC);
//    objweb.webURL=pdfurl;
//    [self.navigationController pushViewController:objweb animated:YES];
}
- (void)btnDeleteImageClicked:(id)sender
{
    //UIButton *btn=(UIButton *)sender;
    
}
#pragma mark Asset top delegate
- (void)btnPlaceTruckClicked:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"SEND SMS" message:@"Please select number to send sms" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    if(phonrno.length >0)
    {
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Personal Ph: %@",phonrno] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self sendSMS:@"" recipientList:[NSArray arrayWithObjects:phonrno, nil]];            
        }]];
    }
    
    if(officephone.length >0)
    {
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Office Ph: %@",officephone] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self sendSMS:@"" recipientList:[NSArray arrayWithObjects:officephone, nil]];
        }]];
    }
    
    if(companyphone.length >0)
    {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Company Ph: %@",companyphone] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {   
            [self sendSMS:@"" recipientList:[NSArray arrayWithObjects:companyphone, nil]];
        }]];
    }
    [self presentViewController:actionSheet animated:YES completion:nil];
}
#pragma mark - Asset Footer Delegate
- (IBAction)btnUpdateStatusClicked:(id)sender
{
    
}
- (IBAction)btnPublishClicked:(id)sender
{
    
}
-(IBAction)btnEditAssetClicked:(id)sender
{
    EditDriverVC *objedit=initVCToRedirect(SBAFTERSIGNUP, EDITDRIVERVC);
    [self.navigationController pushViewController:objedit animated:YES];
}
- (IBAction)btnDeleteAssetClicked:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:APPNAME
                                  message:@"Are you sure you want to delete this driver?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                            
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
- (IBAction)btnDrawerClicked:(id)sender
{
      [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (IBAction)btnSettingsClicked:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser 
{
    return 1;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index 
{
    return [photos objectAtIndex:0];
}
@end
