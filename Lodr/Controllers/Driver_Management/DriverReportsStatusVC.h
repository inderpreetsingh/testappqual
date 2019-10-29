//
//  DriverReportsStatusVC.h
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDriverStatus.h"
#import "CellDriverStatusHeading.h"
#import "CellWelcomeFooter.h"
#import "CellWelcomeFooter.h"
#import "JTProgressHUD.h"
@protocol driverReportsStatusProtocol <NSObject>
@optional
-(void)sendDataToDetailvc:(NSString *)str;

@end
@interface DriverReportsStatusVC : BaseVC<UITableViewDataSource,UITableViewDelegate,CellWelcomeFooterDelegate,CellDriverStatusDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwNavBar;
@property(nonatomic,assign)id driverReportsStatusProtocol;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
- (IBAction)btnSettingsClicked:(id)sender;
- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UITableView *tblReports;
@property (strong,nonatomic) NSString *strCurrentStatusValue,*loadid,*loadstatus,*equiid;

@end
