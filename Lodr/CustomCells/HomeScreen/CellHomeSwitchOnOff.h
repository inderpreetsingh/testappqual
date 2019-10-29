//
//  CellHomeSwitchOnOff.h
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellHomeSwitchOnOff : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnOnDuty;
- (IBAction)btnOnDutyClicked:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingBtnDuty;

@end
