//
//  DriverProfileVC.h
//  Lodr
//
//  Created by c196 on 11/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDriverProfileHeader.h"
#import "CellDriverProfile.h"
#import "CellAssetTop.h"
#import "CellAssetFooter.h"
#import "cellPdfview.h"
#import "Matches.h"
#import <MapKit/MapKit.h>
#import "MWPhotoBrowser.h"
#import "MyNetwork.h"
@interface DriverProfileVC : BaseVC<UITableViewDelegate,UITableViewDataSource,CellAssetTopDelegate,CellAssetFooterDelegate,CellPdfviewDelegate,MWPhotoBrowserDelegate
,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwnavbar;
@property (weak, nonatomic) IBOutlet UITableView *tblDriverProfile;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
- (IBAction)btnDrawerClicked:(id)sender;
- (IBAction)btnSettingsClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
@property (strong, nonatomic) Matches *objmatch;
@property (strong, nonatomic) MyNetwork *objeuaccount;
@property (strong, nonatomic) NSString *redrirectfrom;
@end
