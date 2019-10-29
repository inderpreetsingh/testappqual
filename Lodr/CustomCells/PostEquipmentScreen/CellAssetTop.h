//
//  CellAssetTop.h
//  Lodr
//
//  Created by c196 on 03/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@protocol CellAssetTopDelegate
@optional
- (void)btnPlaceTruckClicked:(id)sender;
@end
@interface CellAssetTop : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblMspLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapLatLocation;
@property (weak, nonatomic) IBOutlet UIView *vwWithCancelBtns;
@property (weak, nonatomic) IBOutlet UIButton *btnPlaceTruck;
- (IBAction)btnPlaceTruckClicked:(id)sender;
@property (nonatomic, weak) id <CellAssetTopDelegate> cellAssetTopDelegate;

@end
