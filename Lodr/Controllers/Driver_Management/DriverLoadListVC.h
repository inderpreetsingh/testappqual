//
//  DriverLoadListVC.h
//  Lodr
//
//  Created by c196 on 05/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellCalenderHeader.h"
#import "DriverLoadDetailsVC.h"


@interface DriverLoadListVC : BaseVC<UITableViewDelegate,UITableViewDataSource,CellCalenderHeaderDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwnavbar;
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightHeader;
@property (weak, nonatomic) IBOutlet UIView *vwTableheader;
@property (weak, nonatomic) IBOutlet UITableView *tblDriversLoad;
- (IBAction)btnDistanceSortClicked:(id)sender;
- (IBAction)btnPickupSortClicked:(id)sender;
- (IBAction)btnDelieverySortClicked:(id)sender;
- (IBAction)btnStatusSortClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDistance;
@property (weak, nonatomic) IBOutlet UIButton *btnpickup;
@property (weak, nonatomic) IBOutlet UIButton *btndelievery;
@property (weak, nonatomic) IBOutlet UIButton *btnstatys;

@end
