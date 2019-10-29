//
//  SubAssetDetailsVC.h
//  Lodr
//
//  Created by c196 on 26/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellWithCV.h"
#import "CellCvPickedImage.h"
#import "cellPdfview.h"
#import <MapKit/MapKit.h>
#import "MWPhotoBrowser.h"
#import "CellAssetHeader.h"
#import "CellAssetFooter.h"
#import "Equipments.h"
#import "CellAssetTop.h"
@interface SubAssetDetailsVC : BaseVC<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,MWPhotoBrowserDelegate,CellPdfviewDelegate,CellCvPickedImageDelegate,CellAssetFooterDelegate,CellAssetTopDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwnavbar;
@property (weak, nonatomic) IBOutlet UITableView *tblEquiDetails;
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (strong, nonatomic) Equipments *selectedEqui;
@property (strong, nonatomic) NSString *strRedirectFrom;
@end
