//
//  CellFooterDispatchvw.h
//  Lodr
//
//  Created by c196 on 30/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellFooterDispatchvwDelegate
@optional
- (IBAction)btnnotscheduleclicekd:(id)sender;
- (IBAction)btnscheduledclciekd:(id)sender;
- (IBAction)btnaddmoreassetclicked:(id)sender;
@end

@interface CellFooterDispatchvw : UIView
@property (strong, nonatomic) IBOutlet UIButton *btnaddmoreasset;
- (IBAction)btnaddmoreassetclicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnschedule;
- (IBAction)btnscheduledclciekd:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnnotschedle;
@property (strong, nonatomic) IBOutlet UILabel *lblseparator;
- (IBAction)btnnotscheduleclicekd:(id)sender;
@property (nonatomic, weak) id <CellFooterDispatchvwDelegate> cellFooterDispatchvwDelegate;
@end
