//
//  CellDriverHeader.h
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellDriverHeaderDelegate
@optional
- (IBAction)btnExpandCollapseClicked:(id)sender;
- (IBAction)btnSwitchToMapClicked:(id)sender;
- (IBAction)btnSwitchToListClicked:(id)sender;
- (IBAction)btnMyProfileClicked:(id)sender;
- (IBAction)btnSortByLocationClicked:(id)sender;
- (IBAction)btnSortByStatusClicked:(id)sender;
@end

@interface CellDriverHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vwheaderhight;
@property (weak, nonatomic) IBOutlet UIView *vwMain;
@property (weak, nonatomic) IBOutlet UIView *vwHeader;
@property (weak, nonatomic) IBOutlet UIView *vwHeading1;
@property (weak, nonatomic) IBOutlet UIView *vwHeading2;
@property (weak, nonatomic) IBOutlet UIView *vwHeading3;
@property (weak, nonatomic) IBOutlet UIView *vwAllContent;
@property (weak, nonatomic) IBOutlet UIView *vwDriverLocartion;
@property (weak, nonatomic) IBOutlet UIView *vwDriverSattaus;

@property (weak, nonatomic) IBOutlet UIButton *btnSwitchToMap;
@property (weak, nonatomic) IBOutlet UIButton *btnSwitchToList;
@property (weak, nonatomic) IBOutlet UIButton *btnExpandCollapse;

@property (weak, nonatomic) IBOutlet UILabel *lblHeading1title;
@property (weak, nonatomic) IBOutlet UILabel *lblDriverstatusvalue;
@property (weak, nonatomic) IBOutlet UILabel *lblDriverDuty;
@property (weak, nonatomic) IBOutlet UILabel *lblDrivername;
@property (weak, nonatomic) IBOutlet UILabel *lblLocationName;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UIButton *btnLocationSort;
@property (weak, nonatomic) IBOutlet UIButton *btnStatusSort;

- (IBAction)btnExpandCollapseClicked:(id)sender;
- (IBAction)btnSwitchToMapClicked:(id)sender;
- (IBAction)btnSwitchToListClicked:(id)sender;
- (IBAction)btnMyProfileClicked:(id)sender;
- (IBAction)btnSortByLocationClicked:(id)sender;
- (IBAction)btnSortByStatusClicked:(id)sender;

@property (nonatomic, weak) id <CellDriverHeaderDelegate> cellDriverHeaderDelegate;
@end
