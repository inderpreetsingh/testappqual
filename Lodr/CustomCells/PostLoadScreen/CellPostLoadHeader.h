//
//  CellPostLoadHeader.h
//  Lodr
//
//  Created by Payal Umraliya on 19/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
@protocol CellPostLoadHeaderDelegate
@optional
- (IBAction)btnLoadPostEquiListClicked:(id)sender;
- (IBAction)btnLoadPostAddEspecialEquiClicked:(id)sender;
- (IBAction)btnLoadPostOpenSavedClicked:(id)sender;
- (IBAction)btnLoadPostBestOfferClicked:(id)sender;
- (IBAction)btnLoadPostPickupcityStateClicked:(id)sender;
- (IBAction)btnLoadPostPickupMapPinClicked:(id)sender;
- (IBAction)btnLoadPostPickUpTimeClicked:(id)sender;
- (IBAction)btnLoadPostPickUpAddressClicked:(id)sender;
- (IBAction)btnLoadPostDelievrycityStateClicked:(id)sender;
- (IBAction)btnLoadPostDelievryTimeClicked:(id)sender;
- (IBAction)btnLoadPostDelievryCityStateMapPinClicked:(id)sender;
- (IBAction)btnLoadPostPickupAddressMapClicked:(id)sender;
- (IBAction)btnLoadPostDelieveryAddressClicked:(id)sender;
- (IBAction)btnLoadPostVisibilityClicked:(id)sender;
- (IBAction)btnLoadPostAllowCommentClicked:(id)sender;
- (IBAction)btnLoadPostDelieveryAddressMapClicked:(id)sender;
- (IBAction)btnUnitMeasureclicked:(id)sender;
@end
@interface CellPostLoadHeader : UIView
@property (weak, nonatomic) IBOutlet UIView *viewHeading;
@property (weak, nonatomic) IBOutlet UIView *viewSubDetails;

@property (weak, nonatomic) IBOutlet UITextField *txtPostLoadLength;
@property (weak, nonatomic) IBOutlet UITextField *txtPostLoadWidth;
@property (weak, nonatomic) IBOutlet UITextField *txtPostLoadWeight;
@property (weak, nonatomic) IBOutlet UITextField *txtPostLoadHeight;
@property (weak, nonatomic) IBOutlet UITextField *txtPostLoadOfferrate;

@property (weak, nonatomic) IBOutlet UILabel *lblPostLoadHeading;

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *txtPostLoadvwLoadDesc;

@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostEquipmentList;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostAddEspecialEqui;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostOpenSaved;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostIsBestOffer;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostPickupcityState;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostPickupCityStateMapPin;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostPickUpTime;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostPickUpAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostDelievrycityState;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostDelievryTime;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostDelievryCityStateMappin;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostPickupAddressMap;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostDelieveryAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostDelieveryAddressMap;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostVisibility;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadPostAllowComment;

- (IBAction)btnLoadPostEquiListClicked:(id)sender;
- (IBAction)btnLoadPostAddEspecialEquiClicked:(id)sender;
- (IBAction)btnLoadPostOpenSavedClicked:(id)sender;
- (IBAction)btnLoadPostBestOfferClicked:(id)sender;
- (IBAction)btnLoadPostPickupcityStateClicked:(id)sender;
- (IBAction)btnLoadPostPickupMapPinClicked:(id)sender;
- (IBAction)btnLoadPostPickUpTimeClicked:(id)sender;
- (IBAction)btnLoadPostPickUpAddressClicked:(id)sender;
- (IBAction)btnLoadPostDelievrycityStateClicked:(id)sender;
- (IBAction)btnLoadPostDelievryTimeClicked:(id)sender;
- (IBAction)btnLoadPostDelievryCityStateMapPinClicked:(id)sender;
- (IBAction)btnLoadPostPickupAddressMapClicked:(id)sender;
- (IBAction)btnLoadPostDelieveryAddressClicked:(id)sender;
- (IBAction)btnLoadPostVisibilityClicked:(id)sender;
- (IBAction)btnLoadPostAllowCommentClicked:(id)sender;
- (IBAction)btnUnitMeasureclicked:(id)sender;
- (IBAction)btnLoadPostDelieveryAddressMapClicked:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVwHeader;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightvwchoosentEspecials;
@property (weak, nonatomic) IBOutlet UIView *vwEquimentSelection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightAddTrailers;
@property (strong, nonatomic) IBOutlet UITextField *txtbolpod;
@property (strong, nonatomic) IBOutlet UITextField *txtquantity;

@property (weak, nonatomic) IBOutlet UITextField *txtLoadNumber;

@property (strong, nonatomic) IBOutlet UIButton *btnUnitMeasure;
@property (strong, nonatomic) IBOutlet UITextField *txtloadname;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBtnSavedLoad;
@property (nonatomic, weak) id <CellPostLoadHeaderDelegate> cellPostLoadHeaderDelegate;
@end
