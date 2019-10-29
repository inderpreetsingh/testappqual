
//
//  LoadDetailVC.m
//  Lodr
//
//  Created by Payal Umraliya on 21/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "LoadDetailVC.h"
#import "EquiEspecial.h"
#import "Medialist.h"
#import "SubEquiEspecial.h"
#import "CustomAnnotClass.h"
#import "CoreDataAdaptor.h"
#import "WebContentVC.h"
#import "EditLoadVC.h"
#import "CDSubEspecialEquiList.h"
#import "Matches.h"
#import "Equipments.h"
#import "DriverReportsStatusVC.h"

@interface LoadDetailVC ()
{
    NSString *fromText,*toText;
    CellLoadDetailHeader *headerview;
    LoadDetailFooter *footer;
    NSString *streid,*stresid,*streidesid,*editedpickupaddress,*editeddelieveryaddress;
    UIActivityIndicatorView *indicator;
    CLLocation *sourceCoordinate;
    CLLocation *destinationCoordinate;
    MKCoordinateRegion viewRegion;
    CustomAnnotClass *annotation1;
    CustomAnnotClass *annotation2;
    CustomAnnotClass *annotation3;
    MKMapItem *distMapItem;
    MKDirections *direction;
    NSMutableArray *arrLoadDocs,*arrLoadImages;
    UITapGestureRecognizer *mapviewtgr;
    NSArray *arrRouts;
    MWPhotoBrowser *browser;
    NSString *updatedloadstatus;
}
@property (nonatomic, assign) UIControlContentVerticalAlignment verticalAlignment;
@end

@implementation LoadDetailVC

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NavigationBarHidden(YES);
    
    NSLog(@"MY SELECTED LOAD === > %@",_selectedLoad);
    _tblLoadDetail.estimatedRowHeight = 90.0;
    _tblLoadDetail.rowHeight = UITableViewAutomaticDimension;
    
    _tblLoadDetail.sectionFooterHeight = UITableViewAutomaticDimension;
    _tblLoadDetail.estimatedSectionFooterHeight = 400;
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.color=[UIColor whiteColor];
    //    self.tblLoadDetail.rowHeight = UITableViewAutomaticDimension;
    //    self.tblLoadDetail.estimatedRowHeight=400;
    
    mapviewtgr = [[UITapGestureRecognizer alloc]
                  initWithTarget:self action:@selector(handleMapviewTapGesture:)];
    mapviewtgr.numberOfTapsRequired = 1;
    mapviewtgr.numberOfTouchesRequired = 1;
    [self registerCustomNibForAllcell];
    //[self showHUD:@"Loading Map directions"];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - custom methods
-(void)registerCustomNibForAllcell
{
    UINib *nibcell = [UINib nibWithNibName:@"CellLoadDetailTop" bundle:nil];
    [[self tblLoadDetail] registerNib:nibcell forCellReuseIdentifier:@"CellLoadDetailTop"];
    
    UINib *nibcell2 = [UINib nibWithNibName:@"CellLoadDetailMiddle" bundle:nil];
    [[self tblLoadDetail]  registerNib:nibcell2 forCellReuseIdentifier:@"CellLoadDetailMiddle"];
    
    UINib *nibcell3 = [UINib nibWithNibName:@"CellLoadDetailMiddleFields" bundle:nil];
    [[self tblLoadDetail]  registerNib:nibcell3 forCellReuseIdentifier:@"CellLoadDetailMiddleFields"];
    
    UINib *nibcell4 = [UINib nibWithNibName:@"CellWithCV" bundle:nil];
    [[self tblLoadDetail]  registerNib:nibcell4 forCellReuseIdentifier:@"CellWithCV"];
    
    UINib *nibcell5 = [UINib nibWithNibName:@"cellPdfview" bundle:nil];
    [[self tblLoadDetail]  registerNib:nibcell5 forCellReuseIdentifier:@"cellPdfview"];
    
    [self setHeaderFooter];
}
-(void)setHeaderFooter
{
    NSArray *nibheader = [[NSBundle mainBundle] loadNibNamed:@"CellLoadDetailHeader" owner:self options:nil];
    headerview = (CellLoadDetailHeader *)[nibheader objectAtIndex:0];
    
    NSArray *nibfooter = [[NSBundle mainBundle] loadNibNamed:@"LoadDetailFooter" owner:self options:nil];
    footer = (LoadDetailFooter *)[nibfooter objectAtIndex:0];
    
    footer.btneditload.layer.cornerRadius=1.0f;
    footer.btnmakepublish.layer.cornerRadius=1.0f;
    footer.btnmarkascancel.layer.cornerRadius=1.0f;
    footer.btnlinkscheduleconfirm.layer.cornerRadius=1.0f;
    [self setImagesArray];
}
-(void)setImagesArray
{
    arrLoadDocs=[NSMutableArray new];
    arrLoadImages=[NSMutableArray new];
    for(Medialist *mda in _selectedLoad.medialist)
    {
        if([mda.mediaType isEqualToString:@"1"])
        {
            [arrLoadImages addObject:mda.mediaName];
        }
        else
        {
            [arrLoadDocs addObject:mda.mediaName];
        }
    }
    [self setEuipmentNames];
}
-(void)setEuipmentNames
{
    @try
    {
        NSArray *arrequi=[_selectedLoad.eId componentsSeparatedByString:@","];
        NSArray *arrsubqui=[_selectedLoad.esId componentsSeparatedByString:@","];
        for (int i=0; i<arrequi.count; i++)
        {
            NSString *condition=[NSString stringWithFormat:@"internalBaseClassIdentifier=='%@'",[arrequi objectAtIndex:i]];
            NSMutableArray*arrMatch=[[CoreDataAdaptor fetchAllDataWhere:condition fromEntity:EquiEspecialEntity] mutableCopy];
            if(arrMatch.count >0)
            {
                EquiEspecial *obje=[arrMatch objectAtIndex:0];
                NSString *str=obje.eName;
                streid=str;
            }
        }
        stresid=@"";
        for (int i=0; i<arrsubqui.count; i++)
        {
            NSString *condition=[NSString stringWithFormat:@"internalBaseClassIdentifier=='%@'",[arrsubqui objectAtIndex:i]];
            NSMutableArray*arrMatch=[[CoreDataAdaptor fetchAllDataWhere:condition fromEntity:SubEquiEspecialEntity] mutableCopy];
            if(arrMatch.count >0)
            {
                SubEquiEspecial *obje=[arrMatch objectAtIndex:0];
                NSString *str=obje.esName;
                stresid=[stresid stringByAppendingString:[str stringByAppendingString:@","]];
            }
        }
        if(stresid.length>0)
        {
            stresid = [stresid substringToIndex:[stresid length]-1];
        }
        streidesid=[NSString stringWithFormat:@"%@",stresid];
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
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception :%@",exception.description);
    }
}
-(void)slideshow:(int)rownum
{
    @try
    {
        
        __block MWPhoto *photo;
        _photos=[NSMutableArray new];
        for(int i=0 ; i <_selectedLoad.medialist.count; i++)
        {
            Medialist *media=[_selectedLoad.medialist objectAtIndex:i];
            NSString *str=[NSString stringWithFormat:@"%@%@",URLLoadImage,media.mediaName];
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
                photo.caption=_selectedLoad.loadCode;
                [_photos addObject:photo];
            }
        }
        
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
        nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nc animated:YES completion:nil];
        
        [browser setCurrentPhotoIndex:rownum];
    } @catch (NSException *exception) {
        
    }
}

#pragma mark - load map direction
-(void)callMapDirectionMethod:(NSArray *)argu
{
    CLLocation *loc=[argu objectAtIndex:0];
    CLLocationCoordinate2D loct=loc.coordinate;
    CLLocation *loc2=[argu objectAtIndex:1];
    CLLocationCoordinate2D loct2=loc2.coordinate;
    [self GetDirections:loct and:loct2 ofcell:[argu objectAtIndex:2]];
    //    [self LoadMapRoute:[argu objectAtIndex:0] andDestinationAddress:[argu objectAtIndex:1]  andcell:[argu objectAtIndex:2] ];
}
- (void)GetDirections:(CLLocationCoordinate2D)srclocationCoordinate and:(CLLocationCoordinate2D)destlocation ofcell:(CellLoadDetailMiddle*)cell
{
    MKPlacemark *aPlcSource = [[MKPlacemark alloc] initWithCoordinate:srclocationCoordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil]];
    
    MKPlacemark *aPlcDest = [[MKPlacemark alloc] initWithCoordinate:destlocation addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil]];
    
    MKMapItem *mpItemSource = [[MKMapItem alloc] initWithPlacemark:aPlcSource];
    [mpItemSource setName:@"Source"];
    
    MKMapItem *mpItemDest  = [[MKMapItem alloc] initWithPlacemark:aPlcDest];
    [mpItemDest setName:@"Dest"];
    
    MKDirectionsRequest *aDirectReq = [[MKDirectionsRequest alloc] init];
    [aDirectReq setSource:mpItemSource];
    [aDirectReq setDestination:mpItemDest];
    [aDirectReq setTransportType:MKDirectionsTransportTypeAutomobile];
    
    MKDirections *aDirections = [[MKDirections alloc] initWithRequest:aDirectReq];
    [aDirections calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error :: %@",error);
        }
        else{
            
            NSArray *aArrRoutes = [response routes];
            NSLog(@"Routes :: %@",aArrRoutes);
            
            [cell.mapDirectionView removeOverlays:cell.mapDirectionView .overlays];
            
            [aArrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
             {
                 MKRoute *aRoute = obj;
                 MKMapPoint middlePoint = aRoute.polyline.points[aRoute.polyline.pointCount/2];
                 [cell.mapDirectionView  addOverlay:aRoute.polyline];
                 [self addAnnotationSrcAndDestination_applemap:srclocationCoordinate :destlocation andAdds:cell.mapDirectionView :MKCoordinateForMapPoint(middlePoint)];
                 //                NSLog(@"Route Name : %@",aRoute.name);
                 //                NSLog(@"Total Distance (in Meters) :%f",aRoute.distance);
                 //                NSArray *aArrSteps = [aRoute steps];
                 //
                 //                NSLog(@"Total Steps : %lu",(unsigned long)[aArrSteps count]);
                 //
                 //
                 //
                 //                [aArrSteps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                 //                    NSLog(@"Rout Instruction : %@",[obj instructions]);
                 //                    //NSLog(@"Rout Distance : %f",[obj distance]);
                 //                }];
                 
             }];
            
            cell.mapDirectionView.delegate = self;
            [cell.activityLoadDirection stopAnimating];
            cell.lblLoadDirection.hidden=YES;
            [self zoomToFitMapAnnotations:cell.mapDirectionView];
            [self dismissHUD];
        }
    }];
}

-(void)LoadMapRoute:(NSString*)SourceAddress andDestinationAddress:(NSString*)DestinationAdds andcell:(CellLoadDetailMiddle*)cell
{
    if(arrRouts.count > 0)
    {
        return;
    }
    [cell.activityLoadDirection startAnimating];
    cell.lblLoadDirection.hidden=NO;
    NSString *strUrl;
    
    strUrl= [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@",SourceAddress,DestinationAdds];
    strUrl=[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
    NSError* error;
    if (data)
    {
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data //1
                              options:kNilOptions
                              error:&error];
        arrRouts=[json objectForKey:@"routes"];
        if ([arrRouts isKindOfClass:[NSArray class]]&&arrRouts.count==0)
        {
            [cell.activityLoadDirection stopAnimating];
            cell.lblLoadDirection.text=@"Could not load direction";
            [self dismissHUD];
            return;
        }
        
        NSArray* arrpolyline = [[[json valueForKeyPath:@"routes.legs.steps.polyline.points"] objectAtIndex:0] objectAtIndex:0]; //2
        double srcLat=[[[[json valueForKeyPath:@"routes.legs.start_location.lat"] objectAtIndex:0] objectAtIndex:0] doubleValue];
        double srcLong=[[[[json valueForKeyPath:@"routes.legs.start_location.lng"] objectAtIndex:0] objectAtIndex:0] doubleValue];
        double destLat=[[[[json valueForKeyPath:@"routes.legs.end_location.lat"] objectAtIndex:0] objectAtIndex:0] doubleValue];
        double destLong=[[[[json valueForKeyPath:@"routes.legs.end_location.lng"] objectAtIndex:0] objectAtIndex:0] doubleValue];
        CLLocationCoordinate2D sourceCordinate = CLLocationCoordinate2DMake(srcLat, srcLong);
        CLLocationCoordinate2D destCordinate = CLLocationCoordinate2DMake(destLat, destLong);
        
        
        
        NSMutableArray *polyLinesArray =[[NSMutableArray alloc]initWithCapacity:0];
        //
        for (int i = 0; i < [arrpolyline count]; i++)
        {
            NSString* encodedPoints = [arrpolyline objectAtIndex:i] ;
            MKPolyline *route = [self polylineWithEncodedString:encodedPoints];
            [polyLinesArray addObject:route];
        }
        [cell.mapDirectionView addOverlays:polyLinesArray];
        [self addAnnotationSrcAndDestination:sourceCordinate :destCordinate andAdds:SourceAddress andDestinationAddress:DestinationAdds :cell.mapDirectionView :polyLinesArray];
        
        cell.mapDirectionView.delegate = self;
        [cell.activityLoadDirection stopAnimating];
        cell.lblLoadDirection.hidden=YES;
        [self zoomToFitMapAnnotations:cell.mapDirectionView];
        [self dismissHUD];
    }
    else
    {
        [cell.activityLoadDirection stopAnimating];
        cell.lblLoadDirection.text=@"Can not load direction";
        [self dismissHUD];
    }
}

- (void)zoomToFitMapAnnotations:(MKMapView *)mapView
{
    if ([mapView.annotations count] == 0) return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(id<MKAnnotation> annotation in mapView.annotations) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    
    // Add a little extra space on the sides
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}

-(void)addAnnotationSrcAndDestination_applemap :(CLLocationCoordinate2D )srcCord :(CLLocationCoordinate2D)destCord andAdds:(MKMapView *)map :(CLLocationCoordinate2D)centrcoordinate
{
    
    CLLocationCoordinate2D driverCordinates;
    
    if(_selectedLoad.loadStatus.integerValue > 0){
        
        
        driverCordinates.latitude = _selectedLoad.driverLatitude.doubleValue;
        driverCordinates.longitude = _selectedLoad.driverLongitude.doubleValue;
        
    }
    
    
    annotation1 = [[CustomAnnotClass alloc] initWithCoordinate:sourceCoordinate.coordinate andMarkTitle:@"Pickup" andMarkSubTitle:@""];
    annotation1.coordinate=srcCord;
    
    annotation2 = [[CustomAnnotClass alloc] initWithCoordinate:destinationCoordinate.coordinate andMarkTitle:@"Delivery" andMarkSubTitle:@""];
    annotation2.coordinate=destCord;
    for (id<MKAnnotation> annotation in map.annotations)
    {
        [map removeAnnotation:annotation];
    }
    
    [map addAnnotation:annotation1];
    [map addAnnotation:annotation2];
    
    NSString *loadStatus = @"";
    
    
    /*  0 - unassign //
     1 -
     2 -ontime -
     3 delayed
     4-
     */
    if([_strRedirectFrom isEqualToString:@"DRIVERLIST"]){
        
        NSLog(@"DRIVER LIST ============");
        
        
        Drivers *objd=[DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDriverData];
        //0 - off duty 1- on duty
        if([objd.dutyStatus isEqualToString:@"0"]){
            
            _selectedLoad.driverLatitude = _selectedLoad.driverLatitude;
            _selectedLoad.driverLongitude = _selectedLoad.driverLongitude;
        }
        else{
            
            if([AppInstance.userCurrentLat isEqualToString:@""] || AppInstance.userCurrentLat == nil){
                if([_selectedLoad.driverLatitude isEqualToString:@""] || _selectedLoad.driverLatitude == nil){
                    
                    _selectedLoad.driverLatitude = _selectedLoad.pickupLatitude;
                    _selectedLoad.driverLongitude = _selectedLoad.pickupLongitude;
                }
                
            }
            else{
                
                _selectedLoad.driverLatitude = AppInstance.userCurrentLat;
                _selectedLoad.driverLongitude = AppInstance.userCurrentLon;
            }
            
        }
    }
    
    else{
        
        if([_selectedLoad.driverLatitude isEqualToString:@""] || _selectedLoad.driverLatitude == nil){
            
            _selectedLoad.driverLatitude = _selectedLoad.pickupLatitude;
            _selectedLoad.driverLongitude = _selectedLoad.pickupLongitude;
        }
        
    }
    if([_selectedLoad.loadStatus isEqualToString:@"1"])
    {
        loadStatus = @"PICKUP";
        //            annotation3= [[CustomAnnotClass alloc] initWithCoordinate:CLLocationCoordinate2DMake(_selectedLoad.driverLatitude.doubleValue, _selectedLoad.driverLongitude.doubleValue)  andMarkTitle:@"Direction" andMarkSubTitle:@"PICKUP"];
        //            [map  addAnnotation: annotation3];
        
    }
    else if([_selectedLoad.loadStatus isEqualToString:@"2"])
    {
        loadStatus = @"ONTIME";
        //            annotation3= [[CustomAnnotClass alloc] initWithCoordinate:CLLocationCoordinate2DMake(_selectedLoad.driverLatitude.doubleValue, _selectedLoad.driverLongitude.doubleValue)  andMarkTitle:@"Direction" andMarkSubTitle:@"ONTIME"];
        //            [map  addAnnotation: annotation3];
        
    }
    else if([_selectedLoad.loadStatus isEqualToString:@"3"])
    {
        loadStatus = @"DELAYED";
        //            annotation3= [[CustomAnnotClass alloc] initWithCoordinate:CLLocationCoordinate2DMake(_selectedLoad.driverLatitude.doubleValue, _selectedLoad.driverLongitude.doubleValue)  andMarkTitle:@"Direction" andMarkSubTitle:@"DELAYED"];
        //            [map  addAnnotation: annotation3];
    }
    else if([_selectedLoad.loadStatus isEqualToString:@"4"])
    {
        loadStatus = @"DELIVERED";
        _selectedLoad.driverLatitude = _selectedLoad.deliveryLatitude;
        _selectedLoad.driverLongitude = _selectedLoad.deliveryLongitude;
        
    }
    if(![_selectedLoad.loadStatus isEqualToString:@"0"]){
        annotation3= [[CustomAnnotClass alloc] initWithCoordinate:CLLocationCoordinate2DMake(_selectedLoad.driverLatitude.doubleValue, _selectedLoad.driverLongitude.doubleValue) andMarkTitle:@"Direction" andMarkSubTitle:loadStatus];
        [map  addAnnotation: annotation3];
    }
    
}



-(void)addAnnotationSrcAndDestination :(CLLocationCoordinate2D )srcCord :(CLLocationCoordinate2D)destCord andAdds:(NSString*)SourceAddress andDestinationAddress:(NSString*)DestinationAdds :(MKMapView *)map :(NSMutableArray *)routes
{
    annotation1 = [[CustomAnnotClass alloc] initWithCoordinate:sourceCoordinate.coordinate andMarkTitle:@"Pickup" andMarkSubTitle:SourceAddress];
    annotation1.coordinate=srcCord;
    
    annotation2 = [[CustomAnnotClass alloc] initWithCoordinate:destinationCoordinate.coordinate andMarkTitle:@"Delivery" andMarkSubTitle:DestinationAdds];
    annotation2.coordinate=destCord;
    for (id<MKAnnotation> annotation in map.annotations)
    {
        [map removeAnnotation:annotation];
    }
    
    [map addAnnotation:annotation1];
    [map addAnnotation:annotation2];
}


- (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString
{
    const char *bytes = [encodedString UTF8String];
    NSUInteger length = [encodedString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger idx = 0;
    
    NSUInteger count = length / 4;
    CLLocationCoordinate2D *coords = calloc(count, sizeof(CLLocationCoordinate2D));
    NSUInteger coordIdx = 0;
    
    float latitude = 0;
    float longitude = 0;
    while (idx < length) {
        char byte = 0;
        int res = 0;
        char shift = 0;
        
        do {
            byte = bytes[idx++] - 63;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLat = ((res & 1) ? ~(res >> 1) : (res >> 1));
        latitude += deltaLat;
        
        shift = 0;
        res = 0;
        
        do {
            byte = bytes[idx++] - 0x3F;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLon = ((res & 1) ? ~(res >> 1) : (res >> 1));
        longitude += deltaLon;
        
        float finalLat = latitude * 1E-5;
        float finalLon = longitude * 1E-5;
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(finalLat, finalLon);
        coords[coordIdx++] = coord;
        
        if (coordIdx == count) {
            NSUInteger newCount = count + 10;
            coords = realloc(coords, newCount * sizeof(CLLocationCoordinate2D));
            count = newCount;
        }
    }
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coords count:coordIdx];
    free(coords);
    
    return polyline;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *identifier = @"CustomAnnotClass";
    MKAnnotationView *annotationView = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
    } else {
        annotationView.annotation = annotation;
    }
    if ([annotation isKindOfClass:[CustomAnnotClass class]])
    {
        CustomAnnotClass *cust=(CustomAnnotClass*)annotation;
        if([cust.markTitle isEqualToString:@"Direction"])
        {
            // annotationView.image=[UIImage imageNamed:@"imgcallout"];
            UIColor *color;
            if([cust.markSubTitle isEqualToString:@"ONTIME"])
            {
                color=[UIColor whiteColor];
            }
            else if([cust.markSubTitle isEqualToString:@"DELAYED"])
            {
                color=CancelLoadButtonColor;
            }
            else if([cust.markSubTitle isEqualToString:@"PICKUP"])
            {
                color=[UIColor whiteColor];
            }
            else if([cust.markSubTitle isEqualToString:@"DELIVERED"])
            {
                color=GreenButtonColor;
            }
            
            else
            {
                color=GreenButtonColor;
            }
            
            UIImage *actualimg= [UIImage imageNamed:@"imgcallout"];
            UIImage *img = [self drawTextStatus:cust.markSubTitle
                                        inImage:actualimg
                                        atPoint: CGPointMake(0, 6)
                                          color:color];
            annotationView.image = img;
            annotationView.canShowCallout = NO;
            annotationView.frame = CGRectMake(0, 0, 80, 40);
            
            annotationView.centerOffset = CGPointMake(15,(-annotationView.image.size.height/2)-2);
            
            //            [button addTarget:self
            //                       action:@selector(viewDetails) forControlEvents:UIControlEventTouchUpInside];
            
        }
        else
        {
            annotationView.image=[UIImage imageNamed:@"mapMarker"];
        }
        
        return annotationView;
    }
    
    return nil;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor colorWithRed:0/255.0 green:255/255.0 blue:255/255.0 alpha:1]];
        [renderer setLineWidth:5.0];
        
        return renderer;
    }
    return nil;
}

- (void)handleMapviewTapGesture:(UIGestureRecognizer *)tap
{
    //    CellLoadDetailMiddle *cell =[self.tblLoadDetail cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    //    CGPoint tapPoint = [tap locationInView:cell.mapDirectionView];
    //
    //    CLLocationCoordinate2D tapCoord = [cell.mapDirectionView convertPoint:tapPoint toCoordinateFromView:cell.mapDirectionView];
    //    MKMapPoint mapPoint = MKMapPointForCoordinate(tapCoord);
    //    CGPoint mapPointAsCGP = CGPointMake(mapPoint.x, mapPoint.y);
    //
    //    for (id<MKOverlay> overlay in cell.mapDirectionView.overlays) {
    //        if([overlay isKindOfClass:[MKPolyline class]]){
    //            MKPolyline *polygon = (MKPolyline*) overlay;
    //
    //            CGMutablePathRef mpr = CGPathCreateMutable();
    //
    //            MKMapPoint *polygonPoints = polygon.points;
    //
    //            for (int p=0; p < polygon.pointCount; p++){
    //                MKMapPoint mp = polygonPoints[p];
    //                if (p == 0)
    //                    CGPathMoveToPoint(mpr, NULL, mp.x, mp.y);
    //                else
    //                    CGPathAddLineToPoint(mpr, NULL, mp.x, mp.y);
    //            }
    //
    //            if(CGPathContainsPoint(mpr , NULL, mapPointAsCGP, FALSE)){
    //                [btnCallout removeFromSuperview];
    //            btnCallout.frame=CGRectMake(mapPointAsCGP.x, mapPointAsCGP.y, 100, 60);
    //                [cell.mapDirectionView addSubview:btnCallout];
    //            }
    //
    //            CGPathRelease(mpr);
    //        }
    //    }
    NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@,%@&daddr=%@,%@&sensor=true", _selectedLoad.pickupLatitude,_selectedLoad.pickupLongitude,_selectedLoad.deliveryLatitude,_selectedLoad.deliveryLongitude];
    NSString *encodedString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    WebContentVC *objwebvc=initVCToRedirect(SBMAIN, WEBCONTENTVC);
    objwebvc.webURL=encodedString;
    [self.navigationController pushViewController:objwebvc animated:YES];
}
#pragma mark - tableview delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrLoadDocs.count+4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        if(indexPath.row==0)
        {
            static NSString *cellIdentifier = @"CellLoadDetailTop";
            CellLoadDetailTop *cell = (CellLoadDetailTop*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell)
            {
                cell = [[CellLoadDetailTop alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.lblLoadCode.text=_selectedLoad.loadCode;
            
            cell.lblfromstatecode.text=_selectedLoad.pickupStateCode;
            cell.lbltostatecode.text=_selectedLoad.deliveryStateCode;
            
            cell.heightlblFromcompnyname.constant=0;
            cell.heightlbltocompnyname.constant=0;
            
            cell.lblfromtextvw.text=_selectedLoad.pickupAddress;
            [cell.lblfromtextvw sizeToFit];
            
            cell.lbltotextvw.text=_selectedLoad.deliveryAddress;
            [cell.lbltotextvw sizeToFit];
            
            cell.lblfromphone.text=@"";
            cell.lbltophone.text=@"";
            
            cell.heightlblfromphone.constant=0;
            cell.heightlbltophone.constant=0;
            
            cell.lblfromopentime.text=@"";
            cell.lbltoopentime.text=@"";
            
            cell.lblpickuptime.text=_selectedLoad.pickupTime;
            cell.lbldelieveytime.text=_selectedLoad.deliveryTime;
            
            if ([_selectedLoad.isBestoffer isEqualToString:@"1"])
            {
                cell.lblRate.text = [NSString stringWithFormat:@"BO"];
            }
            else
            {
                cell.lblRate.text = [NSString stringWithFormat:@"$%@", _selectedLoad.offerRate];
            }
            
            cell.lblCompanyName.text = _strCompanyName;
            
            cell.lblfromdate.text=[NSString stringWithFormat:@"%@",[GlobalFunction stringDate:_selectedLoad.pickupDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd/yy"]];
            cell.lbltodate.text=[NSString stringWithFormat:@"%@",[GlobalFunction stringDate:_selectedLoad.delieveryDate fromFormat:@"yyyy-MM-dd" toFormat:@"MM/dd/yy"]];
            return cell;
        }
        else if(indexPath.row==1)
        {
            static NSString *cellIdentifier = @"CellLoadDetailMiddle";
            CellLoadDetailMiddle *cell = (CellLoadDetailMiddle*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell)
            {
                cell = [[CellLoadDetailMiddle alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            if([_strRedirectFrom isEqualToString:@"MATCHESLIST"] ||[_strRedirectFrom isEqualToString:@"ASSETSCHEDULED"] )
            {
                cell.heightContactBtns.constant=65;
            }
            else if([_strRedirectFrom isEqualToString:@"DRIVERLIST"])
            {
                cell.heightContactBtns.constant=65;
            }
            else
            {
                cell.heightContactBtns.constant=0;
            }
            cell.cellLoadDetailMiddleDelegate=self;
            cell.mapDirectionView.delegate=self;
            if([_selectedLoad.loadStatus isEqualToString:@"3"] ||[_selectedLoad.loadStatus isEqualToString:@"4"] || [_selectedLoad.loadStatus isEqualToString:@"2"] || [_selectedLoad.loadStatus isEqualToString:@"1"])
            {
                cell.mapDirectionView.showsUserLocation=YES;
            }
            [cell.mapDirectionView addGestureRecognizer:mapviewtgr];
            CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:[_selectedLoad.pickupLatitude floatValue] longitude:[_selectedLoad.pickupLongitude floatValue]];
            CLLocation *LocationAtual2 = [[CLLocation alloc] initWithLatitude:[_selectedLoad.deliveryLatitude floatValue] longitude:[_selectedLoad.deliveryLongitude floatValue]];
            //            NSArray *argArray = [NSArray arrayWithObjects:_selectedLoad.pickupAddress, _selectedLoad.deliveryAddress,cell,nil];
            NSArray *argArray = [NSArray arrayWithObjects:LocationAtual,LocationAtual2,cell,nil];
            [self performSelector:@selector(callMapDirectionMethod:) withObject:argArray afterDelay:0.1];
            return cell;
        }
        else if(indexPath.row==2)
        {
            static NSString *cellIdentifier = @"CellLoadDetailMiddleFields";
            CellLoadDetailMiddleFields *cell = (CellLoadDetailMiddleFields*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell)
            {
                cell = [[CellLoadDetailMiddleFields alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            if ([_selectedLoad.isBestoffer isEqualToString:@"1"])
            {
                cell.lblPrice.text = [NSString stringWithFormat:@"BO"];
            }
            else
            {
                cell.lblPrice.text = [NSString stringWithFormat:@"$ %@",_selectedLoad.offerRate];
            }
            
//            cell.lblPrice.text = [NSString stringWithFormat:@"$ %@",_selectedLoad.offerRate];
            cell.lblEquiAndEspecialEqui.text=streidesid;
            cell.lblEquiAndEspecialEqui.numberOfLines=0;
            [cell.lblEquiAndEspecialEqui sizeToFit];
            cell.lblLoadDesc.text=_selectedLoad.loadDescription;
            cell.lblLoadDesc.numberOfLines=0;
            [cell.lblLoadDesc sizeToFit];
            cell.lblLoadWidth.text=[NSString stringWithFormat:@"%@ ft",_selectedLoad.loadWidth];
            cell.lblLoadHeight.text=[NSString stringWithFormat:@"%@ ft",_selectedLoad.loadHeight];
            cell.lblLoadLength.text=[NSString stringWithFormat:@"%@ ft",_selectedLoad.loadLength];
            cell.lblLoadWeight.text=[NSString stringWithFormat:@"%@ lbs",_selectedLoad.loadWeight];
            if([_selectedLoad.visiableTo isEqualToString:@"1"])
            {
                cell.lblVisibility.text=@"My Network";
            }
            else if([_selectedLoad.visiableTo isEqualToString:@"2"])
            {
                cell.lblVisibility.text=@"Everyone";
            }
            else
            {
                cell.lblVisibility.text=@"Private";
            }
            return cell;
        }
        else if(indexPath.row==3)
        {
            static NSString *cellIdentifier = @"CellWithCV";
            CellWithCV *cell = (CellWithCV*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell)
            {
                cell = [[CellWithCV alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.cvPhotoes.delegate=self;
            cell.cvPhotoes.dataSource=self;
            cell.lblAllphoto.text=@"   All Photos:";
            if(arrLoadImages.count==0)
            {
                cell.cvPhotoes.hidden=YES;
                cell.lblNoData.hidden=NO;
                cell.lblNoData.text=@"No photo available for this load";
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
            [cell.btnPdfName setTitle:[arrLoadDocs objectAtIndex:indexPath.row-4] forState:UIControlStateNormal];
            cell.btnPdfName.tag=indexPath.row-4;
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

    [headerview.btnloaddetailheader setHidden:YES];
    headerview.vwWithBackbutton.hidden=YES;
    if([_strRedirectFrom isEqualToString:@"MATCHESLIST"])
    {
        headerview.vwStatus.hidden=YES;
        headerview.vwWithBackbutton.hidden=NO;
        headerview.cellLoadDetailHeaderDelegate=self;
        headerview.vwstatusheight.constant=0;
        headerview.vwbacklabelheight.constant=40;
        if([_loadStatus isEqualToString:@"0"])
        {
            NSString *strEqui=[NSString stringWithFormat:@"This load is a MATCH to %@",_equipname];
            headerview.lblLoadStatus.text=strEqui;
            headerview.vwWithBackbutton.backgroundColor=[UIColor orangeColor];
        }
        else
        {
            NSString *strEqui=[NSString stringWithFormat:@"This load is a LINKED to %@",_equipname];
            headerview.lblLoadStatus.text=strEqui;
            headerview.vwWithBackbutton.backgroundColor=[UIColor blackColor];
        }
    }
    else if([_strRedirectFrom isEqualToString:@"ASSETSCHEDULED"])
    {
        headerview.vwstatusheight.constant=0;
        headerview.vwbacklabelheight.constant=0;
        headerview.vwStatus.hidden=YES;
        headerview.vwWithBackbutton.hidden=YES;
    }
    else if([_strRedirectFrom isEqualToString:@"DRIVERLIST"])
    {
        headerview.vwStatus.hidden=NO;
        headerview.vwWithBackbutton.hidden=NO;
        headerview.lblLoadStatus.text=@"";
        headerview.cellLoadDetailHeaderDelegate=self;
        if(updatedloadstatus.length>0)
        {
            if([updatedloadstatus isEqualToString:@"1"])
            {
                [headerview.btnCurrentStatus setTitle:@"PICKUP" forState:UIControlStateNormal];
            }
            else if([updatedloadstatus isEqualToString:@"2"])
            {
                [headerview.btnCurrentStatus setTitle:@"ON TIME" forState:UIControlStateNormal];
            }
            else if([updatedloadstatus isEqualToString:@"3"])
            {
                [headerview.btnCurrentStatus setTitle:@"DELAYED" forState:UIControlStateNormal];
            }
            else if([updatedloadstatus isEqualToString:@"4"])
            {
                [headerview.btnCurrentStatus setTitle:@"DELIVERED" forState:UIControlStateNormal];
            }
            else if([updatedloadstatus isEqualToString:@"5"] || [updatedloadstatus isEqualToString:@"0"])
            {
                [headerview.btnCurrentStatus setTitle:@"SCHEDULED" forState:UIControlStateNormal];
            }
        }
        else
        {
            if([_selectedLoad.loadStatus isEqualToString:@"1"])
            {
                [headerview.btnCurrentStatus setTitle:@"PICKUP" forState:UIControlStateNormal];
            }
            else if([_selectedLoad.loadStatus isEqualToString:@"2"])
            {
                [headerview.btnCurrentStatus setTitle:@"ON TIME" forState:UIControlStateNormal];
            }
            else if([_selectedLoad.loadStatus isEqualToString:@"3"])
            {
                [headerview.btnCurrentStatus setTitle:@"DELAYED" forState:UIControlStateNormal];
            }
            else if([_selectedLoad.loadStatus isEqualToString:@"4"])
            {
                [headerview.btnCurrentStatus setTitle:@"DELIVERED" forState:UIControlStateNormal];
            }
            else
            {
                [headerview.btnCurrentStatus setTitle:@"SCHEDULED" forState:UIControlStateNormal];
            }
        }
    }
    else
    {
        headerview.vwstatusheight.constant=0;
        headerview.vwbacklabelheight.constant=0;
        headerview.vwStatus.hidden=YES;
        headerview.vwWithBackbutton.hidden=YES;
    }
    return headerview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return UITableViewAutomaticDimension;
    }
    else if(indexPath.row==1)
    {
        return  225;
    }
    else if(indexPath.row==2)
    {
        return UITableViewAutomaticDimension;
    }
    else if(indexPath.row==3)
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
    if([_strRedirectFrom isEqualToString:@"MATCHESLIST"])
    {
        return 100.0f;
    }
    if([_strRedirectFrom isEqualToString:@"ASSETSCHEDULED"] )
    {
        return 60.0f;
    }
    else if([_strRedirectFrom isEqualToString:@"DRIVERLIST"] )
    {
        return 180.0f;
    }
    else
    {
        return 60.0f;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footer.lblNotes.text=_selectedLoad.notes;
    if(footer.lblNotes.text.length==0)
    {
        footer.lblNotes.text=@"No notes available";
    }
    if([_selectedLoad.isAllowComment isEqualToString:@"1"])
    {
        footer.lblComments.text=@"No comments available";
    }
    else{
        footer.lblComments.text=@"Comments are disable for this load.";
    }
    
    if([_selectedLoad.isAllowComment isEqualToString:@"1"])
    {
        [footer.btnAllowComment setImage:imgNamed(@"checkboxselectedsqueare") forState:UIControlStateNormal];
    }
    else
    {
        [footer.btnAllowComment setImage:imgNamed(@"checkboxsquare") forState:UIControlStateNormal];
    }
    
    if([_strRedirectFrom isEqualToString:@"MATCHESLIST"] )
    {
        footer.vwwithmultiplebtns.hidden=YES;
        footer.vwwithsinglebutton.hidden=NO;
        if([_loadStatus isEqualToString:@"0"])
        {
            [footer.btnlinkscheduleconfirm setTitle:LinkButtonText forState:UIControlStateNormal];
            [footer.btnlinkscheduleconfirm setBackgroundColor:LinkLoadButtonColor];
            footer.btnlinkscheduleconfirm.accessibilityIdentifier=@"1";
            footer.heightbtnnotinterested.constant=0;
            
        }
        else if([_loadStatus isEqualToString:@"1"])
        {
            
            if([_selectedLoad.isLoadInterested isEqualToString:@"0"] && [_selectedLoad.isAssetInterested isEqualToString:@"0"]){
                
                [footer.btnlinkscheduleconfirm setTitle:LinkButtonText forState:UIControlStateNormal];
                [footer.btnlinkscheduleconfirm setBackgroundColor:ScheduledLoadButtonColor];
                footer.btnlinkscheduleconfirm.accessibilityIdentifier=@"2";
                footer.heightbtnnotinterested.constant=0;
            }
            
            else if([_selectedLoad.isLoadInterested isEqualToString:@"0"] && [_selectedLoad.isAssetInterested isEqualToString:@"1"]){
                
                [footer.btnlinkscheduleconfirm setTitle:NOTINTERESTED forState:UIControlStateNormal];
                [footer.btnlinkscheduleconfirm setBackgroundColor:ScheduledLoadButtonColor];
                footer.btnlinkscheduleconfirm.accessibilityIdentifier=@"2";
                footer.heightbtnnotinterested.constant=0;
                
            }
            else if([_selectedLoad.isLoadInterested isEqualToString:@"1"] && [_selectedLoad.isAssetInterested isEqualToString:@"0"]){
                
                [footer.btnlinkscheduleconfirm setTitle:LinkButtonText forState:UIControlStateNormal];
                [footer.btnlinkscheduleconfirm setBackgroundColor:ScheduledLoadButtonColor];
                footer.btnlinkscheduleconfirm.accessibilityIdentifier=@"2";
                footer.heightbtnnotinterested.constant=0;
                
                
            }
            else if([_selectedLoad.isLoadInterested isEqualToString:@"1"] && [_selectedLoad.isAssetInterested isEqualToString:@"1"]){
                
                [footer.btnlinkscheduleconfirm setTitle:ScheduleButtonText forState:UIControlStateNormal];
                [footer.btnlinkscheduleconfirm setBackgroundColor:ScheduledLoadButtonColor];
                footer.btnlinkscheduleconfirm.accessibilityIdentifier=@"2";
                footer.heightbtnnotinterested.constant=40;
                
                
            }
            
            //            [footer.btnlinkscheduleconfirm setTitle:ScheduleButtonText forState:UIControlStateNormal];
            //            [footer.btnlinkscheduleconfirm setBackgroundColor:ScheduledLoadButtonColor];
            //            footer.btnlinkscheduleconfirm.accessibilityIdentifier=@"2";
            //            footer.heightbtnnotinterested.constant=40;
        }
        else
        {
            [footer.btnlinkscheduleconfirm setTitle:UnlinkButtonText forState:UIControlStateNormal];
            [footer.btnlinkscheduleconfirm setBackgroundColor:CancelLoadButtonColor];
            footer.btnlinkscheduleconfirm.accessibilityIdentifier=@"0";
            footer.heightbtnnotinterested.constant=0;
        }
        footer.lblinstructions.textColor=[UIColor clearColor];
        [footer layoutIfNeeded];
    }
    else if([_strRedirectFrom isEqualToString:@"DRIVERLIST"])
    {
        footer.vwwithmultiplebtns.hidden=YES;
        footer.vwwithsinglebutton.hidden=NO;
        [footer.btnlinkscheduleconfirm setTitle:ReportStatusButtonText forState:UIControlStateNormal];
        [footer.btnlinkscheduleconfirm setBackgroundColor:ThemeOrangeColor];
        footer.btnlinkscheduleconfirm.accessibilityIdentifier=@"0";
        footer.heightbtnnotinterested.constant=0;
        footer.lblinstructions.textColor=[UIColor clearColor];
        [footer layoutIfNeeded];
    }
    else if([_strRedirectFrom isEqualToString:@"ASSETSCHEDULED"] )
    {
        footer.vwwithmultiplebtns.hidden=YES;
        footer.vwwithsinglebutton.hidden=YES;
        footer.lblinstructions.textColor=[UIColor clearColor];
        footer.heightmultiplebtn.constant=0;
        footer.heightFootersinglebtn.constant=0;
    }
    else if([_strRedirectFrom isEqualToString:@"CALENDERVC"])
    {
        footer.vwwithmultiplebtns.hidden=YES;
        footer.vwwithsinglebutton.hidden=YES;
        footer.lblinstructions.textColor=[UIColor clearColor];
        footer.heightmultiplebtn.constant=0;
        footer.heightFootersinglebtn.constant=0;
    }
    else
    {
        footer.vwwithmultiplebtns.hidden=NO;
        footer.vwwithsinglebutton.hidden=YES;
        footer.lblinstructions.textColor=[UIColor whiteColor];
    }
    footer.loadDetailFooterDelegate=self;
    if([_selectedLoad.isPublish isEqualToString:@"1"])
    {
        [footer.btnmakepublish setTitle:@"UNPUBLISH" forState:UIControlStateNormal];
    }
    else
    {
        [footer.btnmakepublish setTitle:@"PUBLISH" forState:UIControlStateNormal];
    }
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if([_strRedirectFrom isEqualToString:@"CALENDERVC"]){
        return 0;
        
    }
    return 180;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - cell footer delegate
- (void)btnmakepublishclicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSString *pubflag;
    if([_selectedLoad.isPublish isEqualToString:@"1"])
    {
        pubflag=@"0";
        _selectedLoad.isPublish=@"0";
        [btn setTitle:@"UNPUBLISH" forState:UIControlStateNormal];
    }
    else
    {
        pubflag=@"1";
        _selectedLoad.isPublish=@"1";
        [btn setTitle:@"PUBLISH" forState:UIControlStateNormal];
    }
    
    NSDictionary *dic=@{  Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                          Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                          Req_identifier:_selectedLoad.internalBaseClassIdentifier,
                          Req_Is_Publish:pubflag,
                          };
    if([[NetworkAvailability instance]isReachable])
    {
        [[WebServiceConnector alloc]
         init:URLMakePublishLoad
         withParameters:dic
         withObject:self
         withSelector:@selector(getPublishedResponse:)
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
-(IBAction)getPublishedResponse:(id)sender
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
            [AppInstance.arrAllSavedLoadByUserId  enumerateObjectsUsingBlock:^(Loads *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([objmatch.internalBaseClassIdentifier isEqualToString:_selectedLoad.internalBaseClassIdentifier])
                {
                    objmatch.isPublish=_selectedLoad.isPublish;
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
- (void)btnmarkascancelclicked:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:APPNAME
                                  message:@"Are you sure you want to delete this load?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             NSDictionary *dic=@{  Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                                   Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                                   Req_identifier:_selectedLoad.internalBaseClassIdentifier
                                                   };
                             if([[NetworkAvailability instance]isReachable])
                             {
                                 [[WebServiceConnector alloc]
                                  init:URLDeleteLoad
                                  withParameters:dic
                                  withObject:self
                                  withSelector:@selector(getDeletedResponse:)
                                  forServiceType:@"JSON"
                                  showDisplayMsg:@"Deleting Load"
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
-(IBAction)getDeletedResponse:(id)sender
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
            [AppInstance.arrAllSavedLoadByUserId  enumerateObjectsUsingBlock:^(Loads *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([objmatch.internalBaseClassIdentifier isEqualToString:_selectedLoad.internalBaseClassIdentifier])
                {
                    [AppInstance.arrAllSavedLoadByUserId  removeObjectAtIndex:idx];
                }
            }];
            AppInstance.countSavedLodByUid=[NSString stringWithFormat:@"%lu",(unsigned long)AppInstance.arrAllSavedLoadByUserId.count];
            [AppInstance.arrAllLoadByUserId  enumerateObjectsUsingBlock:^(Loads *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([objmatch.internalBaseClassIdentifier isEqualToString:_selectedLoad.internalBaseClassIdentifier])
                {
                    [AppInstance.arrAllLoadByUserId  removeObjectAtIndex:idx];
                }
            }];
            AppInstance.countLodByUid=[NSString stringWithFormat:@"%lu",(unsigned long)AppInstance.arrAllLoadByUserId.count];
            [_loadDetailVCProtocol callWsAgain_FetchLoad];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
    }
}
- (void)btneditloadclicked:(id)sender
{
    //    CATransition *transition = [CATransition animation];
    //    transition.duration = 0.5;
    //    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    transition.type = kCATransitionPush;
    //    transition.subtype = kCATransitionFromLeft;
    //    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    Loads *editedLoad=_selectedLoad;
    EditLoadVC *objedit=initVCToRedirect(SBAFTERSIGNUP, EDITLOADVC);
    //    editedLoad.eId=streid;
    //    editedLoad.esId=stresid;
    objedit.editLoadDetail=editedLoad;
    [self.navigationController pushViewController:objedit animated:YES];
}
- (void)btnlinkscheduleconfirmclicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if([_strRedirectFrom isEqualToString:@"DRIVERLIST"])
    {
        if([_selectedLoad.loadStatus isEqualToString:@"4"])
        {
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"This load is already delivered.Driver can not report the status of delivered load."
                                                  message:@""
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction
                                           actionWithTitle:@"Okay"
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action)
                                           {
                                           }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            DriverReportsStatusVC *objstatus=initVCToRedirect(SBAFTERSIGNUP, DRIVERREPORTSTATUSVC);
            if([_selectedLoad.loadStatus isEqualToString:@"0"])
            {
                objstatus.strCurrentStatusValue=@"SCHEDULED";
            }
            else if([_selectedLoad.loadStatus isEqualToString:@"1"])
            {
                objstatus.strCurrentStatusValue=@"PICKUP";
            }
            else if([_selectedLoad.loadStatus isEqualToString:@"2"])
            {
                objstatus.strCurrentStatusValue=@"ON TIME";
            }
            else if([_selectedLoad.loadStatus isEqualToString:@"3"])
            {
                objstatus.strCurrentStatusValue=@"DELAYED";
            }
            else if([_selectedLoad.loadStatus isEqualToString:@"4"])
            {
                objstatus.strCurrentStatusValue=@"DELIVERED";
            }
            objstatus.loadid=_selectedLoad.internalBaseClassIdentifier;
            objstatus.equiid= _selectedLoad.equiId;
            objstatus.driverReportsStatusProtocol=self;
            [self.navigationController pushViewController:objstatus animated:YES];
        }
    }
    else
    {
        NSString *statusvalue;
        if([btn.titleLabel.text isEqualToString:LinkButtonText])
        {
            statusvalue=@"1";
            NSDictionary *dicLink=@{
                                    Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                    Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                    Req_OrderFromId:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                    Req_OrderToId:_selectedLoad.userId,
                                    Req_LoadId:_selectedLoad.internalBaseClassIdentifier,
                                    Req_EquiId:_equipmentid,
                                    Req_OrderType:statusvalue,
                                    @"load_owner_id":_selectedLoad.userId,
                                    @"equi_owner_id":[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                    @"is_carrier":@"1"
                                    };
            [self linkALoadFromMatch:dicLink];
        }
        else if([btn.titleLabel.text isEqualToString:NOTINTERESTED]){
            //if alreardy interested no action is needed..... SK
            
            return;
            
            /*
             NSDictionary *dicLink=@{
             Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
             Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
             Req_OrderFromId:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
             Req_OrderToId:_selectedLoad.userId,
             Req_LoadId:_selectedLoad.internalBaseClassIdentifier,
             Req_EquiId:_equipmentid,
             Req_OrderType:@"0",
             Req_identifier:_matchorderid,
             Req_AllMatchesId:_allothermatchesIdList,
             Req_isLoadLink:@"yes"
             };
             [self cancelStatusValue:dicLink];
             
             */
        }
        else if([btn.titleLabel.text isEqualToString:ScheduleButtonText])
        {
            statusvalue=@"2";
            NSDictionary *dicLink=@{
                                    Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                    Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                    Req_OrderFromId:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                    Req_OrderToId:_selectedLoad.userId,
                                    Req_LoadId:_selectedLoad.internalBaseClassIdentifier,
                                    Req_EquiId:_equipmentid,
                                    Req_OrderType:statusvalue,
                                    Req_identifier:_matchorderid,
                                    Req_isLoadLink:@"0"};
            [self updateStatusValue:dicLink];
            //return;
        }
        else
        {
            //   _isUnlink = true;
            statusvalue=@"0";
            NSDictionary *dicLink=@{
                                    Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                    Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                    Req_OrderFromId:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                    Req_OrderToId:_selectedLoad.userId,
                                    Req_LoadId:_selectedLoad.internalBaseClassIdentifier,
                                    Req_EquiId:_equipmentid,
                                    Req_OrderType:statusvalue,
                                    Req_identifier:_matchorderid,
                                    Req_AllMatchesId:_allothermatchesIdList,
                                    Req_isLoadLink:@"yes"
                                    };
            [self cancelStatusValue:dicLink];
        }
        
    }
}
- (IBAction)btnnotinterestedclicked:(id)sender
{
    NSDictionary *dicLink=@{
                            Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                            Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                            Req_OrderFromId:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                            Req_OrderToId:_selectedLoad.userId,
                            Req_LoadId:_selectedLoad.internalBaseClassIdentifier,
                            Req_EquiId:_equipmentid,
                            Req_OrderType:@"0",
                            Req_identifier:_matchorderid,
                            Req_AllMatchesId:_allothermatchesIdList
                            };
    [self cancelStatusValue:dicLink];
}
#pragma mark - update status web api

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
         showDisplayMsg:@"Scheduling with matches"
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
            _loadStatus=@"2";
            [self updateObjectForstatusForManageArray:_loadStatus];
            [_tblLoadDetail  reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
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
         showDisplayMsg:@"Cancelling matches"
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
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            //            if(_isUnlink){
            //
            //                _isUnlink = false;
            [self.navigationController popViewControllerAnimated:true];
            
            //            }
            _loadStatus=@"0";
            [self updateObjectForstatusForManageArray:_loadStatus];
            [_tblLoadDetail  reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
        else
        {
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
            _matchorderid=APIResponseOrderId;
            _loadStatus = @"1";
            _selectedLoad.isAssetInterested = @"1";
            
            [self updateObjectForstatusForManageArray:_loadStatus];
            [_tblLoadDetail  reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
        }
    }
}

-(void)updateObjectForstatusForManageArray:(NSString *)status
{
    NSString *str=[NSString stringWithFormat:@"internalBaseClassIdentifier == '%@'",_equipmentid];
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:str];
    NSMutableArray *arrmatches=[[AppInstance.arrAllEquipmentByUserId filteredArrayUsingPredicate:bPredicate]mutableCopy];
    if(arrmatches.count >0)
    {
        Equipments *ep=[arrmatches objectAtIndex:0];
        NSMutableArray *arr=[ep.matches mutableCopy];
        [arr enumerateObjectsUsingBlock:^(Matches *obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             if([obj.matchId isEqualToString:_matchId])
             {
                 obj.matchOrderStatus=status;
                 [arr replaceObjectAtIndex:idx withObject:obj];
             }
         }];
        ep.matches=arr;
        [AppInstance.arrAllEquipmentByUserId  enumerateObjectsUsingBlock:^(Equipments *obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             if([obj.internalBaseClassIdentifier isEqualToString:_equipmentid])
             {
                 [AppInstance.arrAllEquipmentByUserId  replaceObjectAtIndex:idx withObject:ep];
             }
         }];
    }
}
#pragma mark - cell load detail header delegate
- (IBAction)btnloaddetailheaderclicked:(id)sender
{
    if(updatedloadstatus.length>0)
    {
        [_loadDetailVCProtocol sendDataToLDriveroadListvc:[NSArray arrayWithObjects:_selectedLoad.internalBaseClassIdentifier,updatedloadstatus,nil]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - cell load detail middle delegate
- (IBAction)btnCurrentStatusClicked:(id)sender
{
    if([_selectedLoad.loadStatus isEqualToString:@"4"])
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"This load is already delievered.Driver can not report the status of delivered load."
                                              message:@""
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Okay"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                       }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        DriverReportsStatusVC *objstatus=initVCToRedirect(SBAFTERSIGNUP, DRIVERREPORTSTATUSVC);
        if([_selectedLoad.loadStatus isEqualToString:@"0"])
        {
            objstatus.strCurrentStatusValue=@"SCHEDULED";
        }
        else if([_selectedLoad.loadStatus isEqualToString:@"1"])
        {
            objstatus.strCurrentStatusValue=@"PICKUP";
        }
        else if([_selectedLoad.loadStatus isEqualToString:@"2"])
        {
            objstatus.strCurrentStatusValue=@"ON TIME";
        }
        else if([_selectedLoad.loadStatus isEqualToString:@"3"])
        {
            objstatus.strCurrentStatusValue=@"DELAYED";
        }
        else if([_selectedLoad.loadStatus isEqualToString:@"4"])
        {
            objstatus.strCurrentStatusValue=@"DELIVERED";
        }
        
        objstatus.loadid=_selectedLoad.internalBaseClassIdentifier;
        objstatus.equiid=_selectedLoad.equiId;
        objstatus.driverReportsStatusProtocol=self;
        
        [self.navigationController pushViewController:objstatus animated:YES];
    }
}
- (IBAction)btnsmsclicked:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"SEND SMS" message:@"Please select number to send sms" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    if(_myphono.length >0)
    {
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Personal Ph: %@",_myphono] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self sendSMS:@"" recipientList:[NSArray arrayWithObjects:_myphono, nil]];
        }]];
    }
    
    if(_officephno.length >0)
    {
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Office Ph: %@",_officephno] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self sendSMS:@"" recipientList:[NSArray arrayWithObjects:_officephno, nil]];
        }]];
    }
    
    if(_cmpnyphno.length >0)
    {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Company Ph: %@",_cmpnyphno] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self sendSMS:@"" recipientList:[NSArray arrayWithObjects:_cmpnyphno, nil]];
        }]];
    }
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (IBAction)btnContactClicked:(id)sender
{
    //    if ([MFMailComposeViewController canSendMail])
    //    {
    //        MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
    //        NSString *initTxt=[NSString stringWithFormat:@"%@",MailComposerBodytext];
    //        [emailDialog setSubject:MailComposerSubjectWhenContact];
    //        [emailDialog setToRecipients:nil];
    //        [emailDialog setMessageBody:initTxt isHTML:NO];
    //        [emailDialog setMailComposeDelegate:self];
    //        [self.navigationController presentViewController:emailDialog animated:YES completion:nil];
    //    }
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"CALL" message:@"Please select number to make a call" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    if(_myphono.length >0)
    {
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Personal Ph: %@",_myphono] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",_myphono]];
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
    
    if(_officephno.length >0)
    {
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Office Ph: %@",_officephno] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",_officephno]];
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
    
    if(_cmpnyphno.length >0)
    {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Company Ph: %@",_cmpnyphno] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",_cmpnyphno]];
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
}

#pragma mark - Collection view  delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrLoadImages.count;
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
    NSString *str=[NSString stringWithFormat:@"%@%@",URLThumbImage,[arrLoadImages objectAtIndex:indexPath.item]];
    
    NSURL *imgurl=[NSURL URLWithString:str];
    NSLog(@"Image url :%@",imgurl);
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

#pragma mark - image delete delegate
- (IBAction)btnPdfNameClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    NSString *pdfurl=[NSString stringWithFormat:@"%@%@",URLLoadImage,[arrLoadDocs objectAtIndex:[btn tag]]];
    WebContentVC *objweb=initVCToRedirect(SBMAIN, WEBCONTENTVC);
    objweb.webURL=pdfurl;
    [self.navigationController pushViewController:objweb animated:YES];
}

- (void)btnDeleteImageClicked:(id)sender
{
    
}

- (IBAction)btnDrawerClicked:(id)sender
{
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (IBAction)btnBackClicked:(id)sender
{
    @try
    {
        if(updatedloadstatus.length>0)
        {
            [_loadDetailVCProtocol sendDataToLDriveroadListvc:[NSArray arrayWithObjects:_selectedLoad.internalBaseClassIdentifier,updatedloadstatus,nil]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    @catch (NSException *exception)
    {
        
    }
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
        }
            break;
            
        case MFMailComposeResultFailed:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - protocol
-(void)sendDataToDetailvc:(NSString *)str
{
    updatedloadstatus=str;
    _selectedLoad.loadStatus=str;
    [self.tblLoadDetail setContentOffset:CGPointZero animated:YES];
    [self.tblLoadDetail reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}
@end

