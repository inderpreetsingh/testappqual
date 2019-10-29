//
//  CellAlertHeader.h
//  Lodr
//
//  Created by c196 on 09/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellAlertHeaderDelegate
@optional
- (IBAction)btnBackClicked:(id)sender;
@end

@interface CellAlertHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIView *vwWithBack;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBackButtonView;

@property (weak, nonatomic) IBOutlet UIButton *btnTitle;
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *vwCounters;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblcount;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (nonatomic, weak) id <CellAlertHeaderDelegate> cellAlertHeaderDelegate;

@end
