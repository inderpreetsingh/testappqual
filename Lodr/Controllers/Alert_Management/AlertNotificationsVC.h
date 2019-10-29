//
//  AlertNotificationsVC.h
//  Lodr
//
//  Created by c196 on 09/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellAlertHeader.h"
#import "CellAlertDetails.h"
#import "TQMultistageTableView.h"
@interface AlertNotificationsVC : BaseVC<TQTableViewDelegate,TQTableViewDataSource,CellAlertHeaderDelegate,CellAlertDetailsDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwnavbar;
- (IBAction)btnSettingsClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (strong, nonatomic) IBOutlet TQMultistageTableView *tblAllAlerts;

@end
