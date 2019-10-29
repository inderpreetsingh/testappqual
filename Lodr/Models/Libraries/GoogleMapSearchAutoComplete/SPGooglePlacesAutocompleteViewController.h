//
//  SPGooglePlacesAutocompleteViewController.h
//  SPGooglePlacesAutocomplete
//
//  Created by Stephen Poletto on 7/17/12.
//  Copyright (c) 2012 Stephen Poletto. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class SPGooglePlacesAutocompleteQuery;

@interface SPGooglePlacesAutocompleteViewController : BaseVC <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate, MKMapViewDelegate> 
{
    NSArray *searchResultPlaces;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    MKPointAnnotation *selectedPlaceAnnotation;
    
    BOOL shouldBeginEditing;
}
- (IBAction)btnMapviewTappedClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnMapviewTapped;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *btnClosePopup;
- (IBAction)btnClosePopupClicked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)btnusemycurrentlocationclicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *vwNavbar;
@property (strong, nonatomic) IBOutlet UIButton *btnusemycurrentlocation;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightbtnCurrentlocation;
@property (strong, nonatomic) NSString *requestMapFor,*centerlat,*centerlon;
@end
