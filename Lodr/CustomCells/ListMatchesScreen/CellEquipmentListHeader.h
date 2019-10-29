//
//  CellEquipmentListHeader.h
//  Lodr
//
//  Created by Payal Umraliya on 07/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellEquipmentListHeaderDelegate
@optional
- (IBAction)btnLocationSortClciekd:(id)sender;
- (IBAction)btnStatusSortClicked:(id)sender;
- (IBAction)btnRateSortClicked:(id)sender;
- (IBAction)btnEquiNameClicked:(id)sender;
- (IBAction)btnCollapseHeaderClicked:(id)sender;
- (IBAction)btnViewInMapClicked:(id)sender;
- (IBAction)btnViewInListClicked:(id)sender;
- (IBAction)btnloadnameclicked:(id)sender;
@end


@interface CellEquipmentListHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIView *vwBg;
@property (weak, nonatomic) IBOutlet UIView *vwLoadNames;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblEName;
@property (weak, nonatomic) IBOutlet UIView *vwHeadervw;
@property (weak, nonatomic) IBOutlet UIView *vwHeading;
@property (weak, nonatomic) IBOutlet UIView *vwFieldsname;
@property (weak, nonatomic) IBOutlet UILabel *lbltextScheduled;
@property (weak, nonatomic) IBOutlet UIButton *btnEquiname;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightbtnloadname;
@property (weak, nonatomic) IBOutlet UIView *vwmainview;
@property (weak, nonatomic) IBOutlet UIView *vwLocationAndDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblBlackCount;
@property (weak, nonatomic) IBOutlet UILabel *lbllocationname;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UIView *vwEquiStatus;
@property (weak, nonatomic) IBOutlet UIView *vwRupees;
@property (weak, nonatomic) IBOutlet UILabel *lblOrangeCount;
@property (weak, nonatomic) IBOutlet UILabel *lblAssettype;
@property (weak, nonatomic) IBOutlet UIButton *btnstatussort;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vwheaderviewheight;
@property (weak, nonatomic) IBOutlet UIButton *btnLocationSort;
@property (weak, nonatomic) IBOutlet UIButton *btnRatesort;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vwfieldsHeightHeader;
- (IBAction)btnCollapseHeaderClicked:(id)sender;
@property (nonatomic, weak) id <CellEquipmentListHeaderDelegate> cellEquipmentListHeaderDelegate;
- (IBAction)btnLocationSortClciekd:(id)sender;
- (IBAction)btnStatusSortClicked:(id)sender;
- (IBAction)btnRateSortClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCollapseHeader;
- (IBAction)btnViewInMapClicked:(id)sender;
- (IBAction)btnViewInListClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnViewInMap;
@property (weak, nonatomic) IBOutlet UIButton *btnViewInList;
- (IBAction)btnloadnameclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnloadname;
@property (weak, nonatomic) IBOutlet UIView *vwstatsnames;
@property (weak, nonatomic) IBOutlet UIButton *btnRedirectToLoaddetail;
@property (weak, nonatomic) IBOutlet UILabel *lblSep;
- (IBAction)btnEquiNameClicked:(id)sender;
@end
