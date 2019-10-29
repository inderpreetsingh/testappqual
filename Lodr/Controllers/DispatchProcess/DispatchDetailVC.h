//
//  DispatchDetailVC.h
//  Lodr
//
//  Created by c196 on 28/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellLoadDetailTop.h"
#import "CellDispatchTop.h"
#import "CellDisptachDateTime.h"
#import "CellDispatchChooseAsset.h"
#import "CellLoadDetailHeader.h"
#import "CellFooterDispatchvw.h"
#import "CellListWithCheckBox.h"
#import "Loads.h"
#import "ZSYPopoverListView.h"
#import "Driver.h"
#import "PowerAsset.h"
#import "SupportAsset.h"

@interface DispatchDetailVC : BaseVC<UITableViewDelegate,UITableViewDataSource,CellDisptachDateTimeDelegate,CellFooterDispatchvwDelegate,CellLoadDetailHeaderDelegate,CellCellDispatchChooseAssetDelegate,ZSYPopoverListDelegate,ZSYPopoverListDatasource,CellListWithCheckBoxDelegate>
@property (strong, nonatomic) IBOutlet UIView *vwnavbar;
@property (strong, nonatomic) IBOutlet UIButton *btndrawer;
- (IBAction)btndrawerclicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnback;
- (IBAction)btnbackclicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tbldispatchdetail;

@property (strong, nonatomic) Loads *selectedLoad;

@end
