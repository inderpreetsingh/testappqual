//
//  MyEquipmentList.h
//  Lodr
//
//  Created by Payal Umraliya on 04/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQMultistageTableView.h"
#import <QuartzCore/QuartzCore.h>
#import "CellEquipmentListHeader.h"
#import "CellMatchedLoadListForEquipment.h"
#import <MapKit/MapKit.h>
#import "FBClusteringManager.h"
#import "CellWithTableview.h"
@interface MyEquipmentList : BaseVC<UITableViewDelegate,UITableViewDataSource,CellEquipmentListHeaderDelegate,CellMatchedLoadListForEquipmentDelegate,MKMapViewDelegate,FBClusteringManagerDelegate,CellWithTableviewDelegate>

- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
- (IBAction)btnSettingsClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *numberOfAnnotationsLabel;
@property (weak, nonatomic) IBOutlet UIView *vwmapdetails;
@property (weak, nonatomic) IBOutlet UILabel *lbltruckdata;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightmapdetails;
@property  (strong, nonatomic) NSString *strRedirectFrom;  
@property (weak, nonatomic) IBOutlet UIView *vwMaptruck;
@property (nonatomic, assign) NSUInteger numberOfLocations;
@property (weak, nonatomic) IBOutlet MKMapView *maptruckView;

@property (nonatomic, strong) FBClusteringManager *clusteringManager;
@property (weak, nonatomic) IBOutlet UIButton *mappindetail;
- (IBAction)btnMapPinDetailClciked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbltruckAddress;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollData;
@property (strong, nonatomic) IBOutlet UITableView *tblList;
@property (strong, nonatomic) IBOutlet UITableView *tblList2;
@property (strong, nonatomic) IBOutlet UITableView *tblList3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightList1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightList2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightList3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightScroll;
@property (strong, nonatomic) IBOutlet UILabel *lblmapviewtext;
@property (strong, nonatomic) IBOutlet UIView *vwmapheading;
@property (strong, nonatomic) IBOutlet UIButton *btnLoadmore;
- (IBAction)btnLoadMoreclicked:(id)sender;

@end
