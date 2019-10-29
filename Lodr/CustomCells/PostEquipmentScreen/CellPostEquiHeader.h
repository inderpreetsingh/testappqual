//
//  CellPostEquiHeader.h
//  Lodr
//
//  Created by Payal Umraliya on 20/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellPostEquiHeaderDelegate
@optional
- (IBAction)btnPostEquiOpenSavedClicked:(id)sender;
- (IBAction)btnPostEquiListClicked:(id)sender;
- (IBAction)btnPostEquiEspecialClicked:(id)sender;
- (IBAction)btnPostEquiVisibilityClicked:(id)sender;
- (IBAction)btnPostEquiAvailabilityClicked:(id)sender;
@end

@interface CellPostEquiHeader : UIView
@property (weak, nonatomic) IBOutlet UIView *vwHeading;
@property (weak, nonatomic) IBOutlet UIView *vwSubDetails;
@property (weak, nonatomic) IBOutlet UIView *vwTextOfHeading;
@property (strong, nonatomic) IBOutlet UITextField *txtEquiEmptyWeight;

@property (weak, nonatomic) IBOutlet UITextField *txtPostEquiLength;
@property (weak, nonatomic) IBOutlet UITextField *txtPostEquiWidth;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtPostEquiWeight;
@property (weak, nonatomic) IBOutlet UITextField *txtPostEquiHeight;
@property (weak, nonatomic) IBOutlet UITextField *txtPostEquiName;

@property (weak, nonatomic) IBOutlet UIButton *btnOpenSaved;
@property (weak, nonatomic) IBOutlet UIButton *btnPostEquiList;
@property (weak, nonatomic) IBOutlet UIButton *btnPostEquiEspecial;
@property (weak, nonatomic) IBOutlet UIButton *btnPostEquiVisiblity;
@property (weak, nonatomic) IBOutlet UIButton *btnPostEquiAvailability;
@property (weak, nonatomic) IBOutlet UIView *vwheaderSubAsset;
@property (weak, nonatomic) IBOutlet UITextField *txtNameOfSubAsset;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightEspecialEqui;
@property (weak, nonatomic) IBOutlet UILabel *lblHeadingtext;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVwHeading;

- (IBAction)btnPostEquiOpenSavedClicked:(id)sender;
- (IBAction)btnPostEquiListClicked:(id)sender;
- (IBAction)btnPostEquiEspecialClicked:(id)sender;
- (IBAction)btnPostEquiVisibilityClicked:(id)sender;
- (IBAction)btnPostEquiAvailabilityClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnweighttext;
@property (strong, nonatomic) IBOutlet UILabel *lblheadingweight;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightSubAssets;
@property (strong, nonatomic) IBOutlet UITextField *txtAssetEmptyWeight;
@property (nonatomic, weak) id <CellPostEquiHeaderDelegate> cellPostEquiHeaderDelegate;

@end
