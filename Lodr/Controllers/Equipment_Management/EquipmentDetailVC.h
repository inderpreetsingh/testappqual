//
//  EquipmentDetailVC.h
//  Lodr
//
//  Created by c196 on 03/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CellWithCV.h"
#import "CellCvPickedImage.h"
#import "cellPdfview.h"
#import "MWPhotoBrowser.h"
#import "CellAssetTop.h"
#import "CellAssetMiddle.h"
#import "CellAssetHeader.h"
#import "CellAssetFooter.h"
#import "Equipments.h"
@interface EquipmentDetailVC : BaseVC<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,MWPhotoBrowserDelegate,CellPdfviewDelegate,CellCvPickedImageDelegate,MKMapViewDelegate,CellAssetTopDelegate,CellAssetFooterDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwnavbar;
@property (weak, nonatomic) IBOutlet UITableView *tblEquiDetails;
@property (weak, nonatomic) IBOutlet UIImageView *imgNavbar;
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (strong, nonatomic) Equipments *selectedEqui;
@property (strong, nonatomic) NSString *strRedirectFrom;
@end
