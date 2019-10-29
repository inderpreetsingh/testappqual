//
//  CellCalenderSchedule.h
//  Lodr
//
//  Created by c196 on 25/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellCalenderScheduleDeleagate
@optional
- (IBAction)btnscheduledclicked:(id)sender;
- (IBAction)btnAlternateEquiclicked:(id)sender;
- (IBAction)btnDriverScheduleclicked:(id)sender;
- (IBAction)btnVwDetailsClciked:(id)sender;
@end
@interface CellCalenderSchedule : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *originschedulebtn;
@property (weak, nonatomic) IBOutlet UIView *vwSchudeledbtn;
@property (weak, nonatomic) IBOutlet UIView *vwMain;
@property (weak, nonatomic) IBOutlet UIView *vwResourcenames;
@property (weak, nonatomic) IBOutlet UIView *vwBtns;
@property (weak, nonatomic) IBOutlet UIButton *btnSchedule;
- (IBAction)btnscheduledclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAlternateEqui;
- (IBAction)btnAlternateEquiclicked:(id)sender;
- (IBAction)btnDriverScheduleclicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblNodriverAvailable;
@property (weak, nonatomic) IBOutlet UIButton *btnDriverSchedule;
- (IBAction)btnVwDetailsClciked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnVwDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblResourcename;
@property (nonatomic,strong) id<CellCalenderScheduleDeleagate> cellCalenderScheduleDeleagate;

@end
