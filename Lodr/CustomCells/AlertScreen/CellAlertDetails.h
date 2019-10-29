//
//  CellAlertDetails.h
//  Lodr
//
//  Created by c196 on 09/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellAlertDetailsDelegate
@optional
- (IBAction)btnDltNotificationsClicked:(id)sender;
@end
@interface CellAlertDetails : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwMatchName;
@property (weak, nonatomic) IBOutlet UIView *lblAlertValue;
@property (weak, nonatomic) IBOutlet UIButton *btnShowAlertDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblmatchesnames;
@property (weak, nonatomic) IBOutlet UILabel *lblalertText;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteNotifications;
- (IBAction)btnDltNotificationsClicked:(id)sender;
@property (nonatomic, weak) id <CellAlertDetailsDelegate> cellAlertDetailsDelegate;


@end
