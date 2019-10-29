//
//  DriverListVC.h
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQMultistageTableView.h"
#import "CellDriverHeader.h"
@interface DriverListVC : BaseVC<TQTableViewDelegate,TQTableViewDataSource,CellDriverHeaderDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwNavBar;
@property (strong, nonatomic) IBOutlet TQMultistageTableView *tblDrivers;
- (IBAction)btnSettingClicked:(id)sender;
- (IBAction)btnDrawerClicked:(id)sender;
@property  (strong, nonatomic) NSString *strRedirectFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;

@end
