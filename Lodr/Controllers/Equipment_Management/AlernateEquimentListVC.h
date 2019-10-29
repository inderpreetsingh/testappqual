//
//  AlernateEquimentListVC.h
//  Lodr
//
//  Created by c196 on 07/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loads.h"
#import "Equipments.h"
#import "Matches.h"
#import "CellEquipmentListHeader.h"
#import "TQMultistageTableView.h"
#import "CellCalenderSchedule.h"
@protocol alernateEquimentListVCProtocol <NSObject>
@optional
-(void)refreshCalender:(NSString *)str;

@end
@interface AlernateEquimentListVC : BaseVC<CellEquipmentListHeaderDelegate,TQTableViewDataSource,TQTableViewDelegate,CellCalenderScheduleDeleagate>
@property (weak, nonatomic) IBOutlet UIView *vwnavbar;
- (IBAction)btnBackclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBACK;
- (IBAction)btnDrawerclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UIView *vwHeading;
@property (weak, nonatomic) IBOutlet UIView *vwSelctequilael;
@property (weak, nonatomic) IBOutlet UIView *vwLoadname;
@property (weak, nonatomic) IBOutlet UILabel *lblloaddistance;
@property (weak, nonatomic) IBOutlet UILabel *lblloadname;
@property (weak, nonatomic) IBOutlet UILabel *lblpickuplocation;
@property (weak, nonatomic) IBOutlet UILabel *lbldelieverylocation;
@property (weak, nonatomic) IBOutlet UITableView *tblequilist;
@property (strong, nonatomic) IBOutlet TQMultistageTableView *tblelist;
@property (strong, nonatomic) NSString *chooseneid,*pickuptime,*delieverytime,*loadid,*pickstatecode,*delieverystatecode,*distnceval,*orderid,*orderfromid,*ordertoid,*equiid;
@property(nonatomic,assign)id alernateEquimentListVCProtocol;
@end
