//
//  SPGooglePlacesAutocompleteViewController.m
//  SPGooglePlacesAutocomplete
//
//  Created by Stephen Poletto on 7/17/12.
//  Copyright (c) 2012 Stephen Poletto. All rights reserved.
//

#import "SPGooglePlacesAutocompleteViewController.h"
#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesAutocompletePlace.h"
#import "UITableView+Placeholder.h"
#import "JTProgressHUD.h"
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#define METERS_PER_MILE 1609.344
#define IOS_OLDER_THAN_X(XX)           ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] < XX )
#define IOS_NEWER_OR_EQUAL_TO_X(XX)    ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= XX )
#define IOS_NEWER_TO_X(XX)    ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] > XX )
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface SPGooglePlacesAutocompleteViewController ()
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D Coordinate;
    NSMutableDictionary *aMapDataDictionary;
}
@end

@implementation SPGooglePlacesAutocompleteViewController
@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] init];
        searchQuery.radius = 100.0;
        searchQuery.language = @"en";
        searchQuery.types = SPPlaceTypeGeocode; // Only return geocoding (address) results.
        if([_centerlat isEqualToString:@""] || _centerlat==nil )
        {
            searchQuery.location1 = mapView.userLocation.coordinate;
            MKCoordinateRegion region;
            region.center = mapView.userLocation.coordinate;
            [self.mapView setRegion: region animated:YES];
        }
        else
        {
            CLLocationCoordinate2D anyLocation;
            anyLocation.latitude = [_centerlat doubleValue];
            anyLocation.longitude  = [_centerlon doubleValue];
            searchQuery.location1 = anyLocation;
            MKCoordinateRegion region;
            region.center =anyLocation;
            [self.mapView setRegion: region animated:YES];
        }
        shouldBeginEditing = YES;
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.navigationController.navigationBarHidden = YES;
  self.searchDisplayController.searchBar.barTintColor=[UIColor whiteColor];
    self.searchDisplayController.searchBar.placeholder = @"";
   // self.searchDisplayController.searchBar.showsCancelButton = YES;
    self.vwNavbar.layer.cornerRadius=3.0f;
    self.mapView.layer.cornerRadius=3.0f;
    

    self.searchDisplayController.searchBar.layer.borderColor=[UIColor clearColor].CGColor;
      UITextField *txfSearchField = [self.searchDisplayController.searchBar valueForKey:@"_searchField"];
    txfSearchField.layer.borderColor=[UIColor blackColor].CGColor;
    txfSearchField.layer.borderWidth=0.5f;
    txfSearchField.backgroundColor=[UIColor whiteColor];
    txfSearchField.textColor=[UIColor blackColor];
    txfSearchField.layer.cornerRadius=3.0f;
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:self.btnClosePopup.titleLabel.textColor];
    self.searchDisplayController.searchResultsTableView.frame=mapView.frame;
    self.btnusemycurrentlocation.layer.cornerRadius=2.0f;
    self.btnusemycurrentlocation.clipsToBounds=YES;
    [self.view endEditing:YES];
    if([self.requestMapFor isEqualToString:@"EquiScreenAddress"] 
       || [self.requestMapFor isEqualToString:@"SubAssetScreenAddress"]  )
    {
        self.heightbtnCurrentlocation.constant=35;
      
        self.btnMapviewTapped.userInteractionEnabled=YES;
    }
    else if([self.requestMapFor isEqualToString:@"PICKUP"] || [self.requestMapFor isEqualToString:@"DELIEVERY"])
    {
        self.heightbtnCurrentlocation.constant=35;
        self.btnMapviewTapped.userInteractionEnabled=YES;
    }
    else
    {
        self.heightbtnCurrentlocation.constant=0;
        self.btnMapviewTapped.userInteractionEnabled=NO;
    }
      [self.btnMapviewTapped removeFromSuperview];
    
    [self.view layoutIfNeeded];
   [self requestAlwaysAuthorization];
    
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (@available(iOS 11.0, *)) {
        [self.searchDisplayController.searchBar.heightAnchor constraintLessThanOrEqualToConstant: 44].active = YES;
    }
}
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    [searchBar resignFirstResponder];
//}
-(void)viewWillAppear:(BOOL)animated
{
    @try
    {
        [super viewWillAppear:animated];
        if([_centerlat isEqualToString:@""] || _centerlat==nil )
        {
            searchQuery.location1 = mapView.userLocation.coordinate;
            MKCoordinateRegion region;
            region.center = mapView.userLocation.coordinate;
            if ( (region.center.latitude >= -90) && (region.center.latitude <= 90) && (region.center.longitude >= -180) && (region.center.longitude <= 180))
            {
                [self.mapView setRegion:[self.mapView regionThatFits:region]];
            }
            else
            {
                [self.mapView setRegion: region animated:YES];
            }
        }
        else
        {
            MKCoordinateSpan span;
            span.latitudeDelta = 0.02;
            span.longitudeDelta = 0.02;
            CLLocationCoordinate2D anyLocation;
            anyLocation.latitude = [_centerlat doubleValue];
            anyLocation.longitude  = [_centerlon doubleValue];
            searchQuery.location1 = anyLocation;
            MKCoordinateRegion region;
            region.center =anyLocation;
            region.span = span;
            if ( (region.center.latitude >= -90) && (region.center.latitude <= 90) && (region.center.longitude >= -180) && (region.center.longitude <= 180))
            {
                [self.mapView setRegion:[self.mapView regionThatFits:region]];
            }
            else
            {
                [self.mapView setRegion: region animated:YES];
            }
        }
    } 
    @catch (NSException *exception) 
    {
        NSString *str=[NSString stringWithFormat:@"Line : 140  |  Vc - GooglePlaceVC  |  Function - viewwillAppear  |  Exception - %@",exception.description];
        [self crashReporter:str];
    } 
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied)
    {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" :   @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'When in use' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if (status == kCLAuthorizationStatusNotDetermined) 
    {
        [locationManager requestAlwaysAuthorization];
    }
}
- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}

- (void)dealloc {
    [selectedPlaceAnnotation release];
    [mapView release];
    [searchQuery release];
    [super dealloc];
}

- (IBAction)recenterMapToUserLocation:(id)sender
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    region.span = span;
    region.center = self.mapView.userLocation.coordinate;
    
    [self.mapView setRegion:region animated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResultPlaces count];
}

- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [searchResultPlaces objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SPGooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:18.0];
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)recenterMapToPlacemark:(CLPlacemark *)placemark {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    region.span = span;
    region.center = placemark.location.coordinate;
    
    [self.mapView setRegion:region];
}

- (void)addPlacemarkAnnotationToMap:(CLPlacemark *)placemark addressString:(NSString *)address 
{
    [self.searchDisplayController.searchResultsTableView setLoaderAnimationWithText:@""];
    [self.mapView removeAnnotation:selectedPlaceAnnotation];
    [selectedPlaceAnnotation release];
    selectedPlaceAnnotation = [[MKPointAnnotation alloc] init];
    selectedPlaceAnnotation.coordinate = placemark.location.coordinate;
    NSString *lat=[NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
    NSString *lon=[NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
    aMapDataDictionary=[[NSMutableDictionary alloc]init];
    [aMapDataDictionary setObject:self.requestMapFor forKey:@"AddressType"];
     selectedPlaceAnnotation.title = address;
    
    [aMapDataDictionary setObject:lat forKey:@"AddressLatitude"];
    [aMapDataDictionary setObject:lon forKey:@"AddressLongitude"];
    if(address.length==0 || address==nil)
    {
        address=@"";
    }
    [aMapDataDictionary setObject:address forKey:@"SelectedAddress"];
    if(placemark.locality.length >0)
    {
        [aMapDataDictionary setObject:placemark.locality forKey:@"SelectedCity"];
    }
    else
    {
        [aMapDataDictionary setObject:@"" forKey:@"SelectedCity"];
    }
    if(placemark.administrativeArea.length >0)
    {
        [aMapDataDictionary setObject:placemark.administrativeArea forKey:@"SelectedState"];
    }
    else
    {
        [aMapDataDictionary setObject:@"" forKey:@"SelectedState"];
    }
    if(placemark.country.length >0)
    {
        [aMapDataDictionary setObject:placemark.country forKey:@"SelectedCountry"];
    }
    else
    {
        [aMapDataDictionary setObject:@"" forKey:@"SelectedCountry"];
    }
    
    [self.mapView addAnnotation:selectedPlaceAnnotation];
   
    self.searchDisplayController.searchResultsTableView.backgroundView=nil;
    [self.view endEditing:YES];
//    [self getAdrressFromLatLong:placemark.location.coordinate.latitude lon:placemark.location.coordinate.longitude];
}
-(void)getAdrressFromLatLong : (CGFloat)lat lon:(CGFloat)lon
{
    @try 
    {
        CLGeocoder *ceo = [[CLGeocoder alloc]init];
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
        
        [ceo reverseGeocodeLocation: loc completionHandler:
         ^(NSArray *placemarks, NSError *error) 
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             if(locatedAt.length==0 || locatedAt==nil)
             {
                 locatedAt=@"";
             }
             [aMapDataDictionary setObject:locatedAt forKey:@"SelectedAddress"];
             if(placemark.locality.length >0)
             {
                 [aMapDataDictionary setObject:placemark.locality forKey:@"SelectedCity"];
             }
             else
             {
                 [aMapDataDictionary setObject:@"" forKey:@"SelectedCity"];
             }
             if(placemark.administrativeArea.length >0)
             {
                 [aMapDataDictionary setObject:placemark.administrativeArea forKey:@"SelectedState"];
             }
             else
             {
                 [aMapDataDictionary setObject:@"" forKey:@"SelectedState"];
             }
             if(placemark.country.length >0)
             {
                 [aMapDataDictionary setObject:placemark.country forKey:@"SelectedCountry"];
             }
             else
             {
                 [aMapDataDictionary setObject:@"" forKey:@"SelectedCountry"];
             }
          
              [self.mapView addAnnotation:selectedPlaceAnnotation];
             if([self.requestMapFor isEqualToString:@"WelcomeScreenAddress"] || [self.requestMapFor isEqualToString:@"WelcomeScreenOperatingAddress"] )
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedSetWelcomeScreenAddress object:self userInfo:aMapDataDictionary];
             }
             else if([self.requestMapFor isEqualToString:@"EquiScreenAddress"])
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedSetSelectedTruckLocationData object:self userInfo:aMapDataDictionary];
             }
             
             else if([self.requestMapFor isEqualToString:@"SubAssetScreenAddress"])
             {
                  [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedSetSelectedSubAssetLocationData object:self userInfo:aMapDataDictionary];
             }
             else if([self.requestMapFor containsString:@"EDIT"])
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedEditAddress object:self userInfo:aMapDataDictionary];
             }
             else
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedSetAddress object:self userInfo:aMapDataDictionary];
             }
            [JTProgressHUD hide];
         }];
        self.searchDisplayController.searchResultsTableView.backgroundView=nil;
      
    } 
    @catch (NSException *exception) 
    {
        NSString *str=[NSString stringWithFormat:@"Line : 362  |  Vc - googleplacevc  |  Function - getAdrressFromLatLong  |  Exception - %@",exception.description];
        [self crashReporter:str];
    } 
}

- (void)dismissSearchControllerWhileStayingActive {
    // Animate out the table view.
    NSTimeInterval animationDuration = 0.3;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.searchDisplayController.searchResultsTableView.alpha = 0.0;
    [UIView commitAnimations];
    //self.searchDisplayController.searchBar.showsCancelButton = YES;
    //self.searchDisplayController.searchBar.tintColor=[UIColor setBlueColor];
   // [self.searchDisplayController.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchDisplayController.searchBar resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [self.view endEditing:YES];
    SPGooglePlacesAutocompletePlace *place = [self placeAtIndexPath:indexPath];
    [tableView setLoaderAnimationWithText:@""];
    [place resolveToPlacemark:^(CLPlacemark *placemark, NSString *addressString, NSError *error) 
    {
        if (error)
        {
            SPPresentAlertViewWithErrorAndTitle(error, @"Could not map selected Place");
        } 
        else if (placemark)
        {
            [self addPlacemarkAnnotationToMap:placemark addressString:addressString];
            [self recenterMapToPlacemark:placemark];
            [self dismissSearchControllerWhileStayingActive];
            [self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        else
        {
            SPPresentAlertViewWithErrorAndTitle(error, @"Cannot fetch place mark detail");
        }
         tableView.backgroundView=nil;
    }];
}

#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)handleSearchForSearchString:(NSString *)searchString
{
//    self.searchDisplayController.searchBar.showsCancelButton = YES;
//    self.searchDisplayController.searchBar.tintColor=[UIColor setBlueColor];
    searchQuery.types = SPPlaceTypeGeocode;
    searchQuery.location1 = self.mapView.userLocation.coordinate;
    searchQuery.input = searchString;
    
    [searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            SPPresentAlertViewWithErrorAndTitle(error, @"Could not fetch Places");
        } else {
            [searchResultPlaces release];
            searchResultPlaces = [places retain];
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
    }];
}
//- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
//{
//    self.navigationController.navigationBarHidden = YES;
//}
//
//
//-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
//{
//    self.navigationController.navigationBarHidden = NO;
//}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self handleSearchForSearchString:searchString];
    return YES;
}
-(void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    
    tableView.backgroundColor=[UIColor colorWithRed:226.0/255.0 green:226.0/255.0  blue:226.0/255.0  alpha:0.8];
}

#pragma mark -
#pragma mark UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
//    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor blueColor]];
    if (![searchBar isFirstResponder]) {
        // User tapped the 'clear' button.
        
        shouldBeginEditing = NO;
        [self.searchDisplayController setActive:NO];
        [self.mapView removeAnnotation:selectedPlaceAnnotation];
    }
   // self.searchDisplayController.searchBar.showsCancelButton = YES;
   // self.searchDisplayController.searchBar.tintColor=[UIColor setBlueColor];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
   
    if (shouldBeginEditing) {
        // Animate in the table view.
        
        self.searchDisplayController.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        self.searchDisplayController.searchBar.keyboardAppearance=UIKeyboardAppearanceDark;
        UITextField *textField = [self.searchDisplayController.searchBar valueForKey:@"_searchField"];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
       self.searchDisplayController.searchResultsTableView.alpha = 1.0;
    }
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}

#pragma mark -
#pragma mark MKMapView Delegate
- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        [self.mapView addAnnotation:annotationView.annotation];
         [self.mapView setRegion:MKCoordinateRegionMake(droppedAt, MKCoordinateSpanMake(0.02, 0.02)) animated:YES];
    }
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
//    [self.mapView selectAnnotation:selectedPlaceAnnotation animated:YES];
//    [self showHUD:@"Placing asset to current location"];
//    aMapDataDictionary=[[NSMutableDictionary alloc]init];
//    [aMapDataDictionary setObject:self.requestMapFor forKey:@"AddressType"];
//    [aMapDataDictionary setObject:[NSString stringWithFormat:@"%f",view.annotation.coordinate.latitude] forKey:@"AddressLatitude"];
//    [aMapDataDictionary setObject:[NSString stringWithFormat:@"%f",view.annotation.coordinate.longitude] forKey:@"AddressLongitude"];
//    [self getAdrressFromLatLong:view.annotation.coordinate.latitude lon:view.annotation.coordinate.longitude];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapViewIn viewForAnnotation:(id <MKAnnotation>)annotation {
  
    if (mapViewIn != self.mapView || [annotation isKindOfClass:[MKUserLocation class]]) 
    {
        //return nil;
    }
    static NSString *annotationIdentifier = @"SPGooglePlacesAutocompleteAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    }
  
    [annotationView setSelected:YES animated:YES];
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
   // annotationView.draggable=YES;
    return annotationView;
}
-(CLLocationCoordinate2D) getLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    // Whenever we've dropped a pin on the map, immediately select it to present its callout bubble.
    [self.mapView selectAnnotation:selectedPlaceAnnotation animated:YES];
}

- (void)annotationDetailButtonPressed:(id)sender
{
}

- (IBAction)btnClosePopupClicked:(id)sender
{
    @try 
    {
        if(aMapDataDictionary !=nil || aMapDataDictionary.count >0)
        {
            
            if([self.requestMapFor isEqualToString:@"WelcomeScreenAddress"] || [self.requestMapFor isEqualToString:@"WelcomeScreenOperatingAddress"] )
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedSetWelcomeScreenAddress object:self userInfo:aMapDataDictionary];
            }
            else if([self.requestMapFor isEqualToString:@"EquiScreenAddress"])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedSetSelectedTruckLocationData object:self userInfo:aMapDataDictionary];
            }
            else if([self.requestMapFor isEqualToString:@"SubAssetScreenAddress"])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedSetSelectedSubAssetLocationData object:self userInfo:aMapDataDictionary];
            }
            else if([self.requestMapFor containsString:@"EDIT"])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedEditAddress object:self userInfo:aMapDataDictionary];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedSetAddress object:self userInfo:aMapDataDictionary];
            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:RequiredMapPopupAddress controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
    @catch (NSException *exception)
    {
        NSString *str=[NSString stringWithFormat:@"Line : 580  |  Vc - googleplacevc  |  Function - showMapViewPopUp  |  Exception - %@",exception.description];
        [self crashReporter:str];
    } 
   
}

- (IBAction)btnCancelClicked:(id)sender
{
     [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedDismissView object:self];
}
- (IBAction)btnusemycurrentlocationclicked:(id)sender
{
    if( [self.requestMapFor isEqualToString:@"PICKUP"] )
    {
        [self showHUD:@"Setting pick up lcoation  to current location"];
    }
    else if([self.requestMapFor isEqualToString:@"DELIEVERY"] )
    {
        [self showHUD:@"Setting delivery lcoation to current location"];
    }
    else
    {
          [self showHUD:@"Placing asset to current location"];
    }
    aMapDataDictionary=[[NSMutableDictionary alloc]init];
    [aMapDataDictionary setObject:self.requestMapFor forKey:@"AddressType"];
    [aMapDataDictionary setObject:[NSString stringWithFormat:@"%f",self.mapView.userLocation.coordinate.latitude] forKey:@"AddressLatitude"];
    [aMapDataDictionary setObject:[NSString stringWithFormat:@"%f",self.mapView.userLocation.coordinate.longitude] forKey:@"AddressLongitude"];
    [self getAdrressFromLatLong:self.mapView.userLocation.coordinate.latitude lon:self.mapView.userLocation.coordinate.longitude];
    
}
- (IBAction)btnMapviewTappedClicked:(id)sender 
{
  //  [self btnusemycurrentlocationclicked:self.btnusemycurrentlocation];
}
@end
