//
//  DriverHomeVC.h
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellHomeScreenHeader.h"
#import "CellHomeScreenOptions.h"
#import "CellHomeSwitchOnOff.h"
@interface DriverHomeVC : BaseVC<UITableViewDelegate,UITableViewDataSource,CellHomeScreenHeaderDelegate,CellHomeScreenOptionsDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwNavBar;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
- (IBAction)btnSettingsClicked:(id)sender;
- (IBAction)btnDraawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UITableView *tblDriverHome;
@property  (strong, nonatomic) NSString *strRedirectFrom;
@property  (strong, nonatomic) NSString *driverstatus;
@end
