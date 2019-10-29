//
//  CellDriverStatusHeading.h
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDriverStatusHeading : UIView
@property (weak, nonatomic) IBOutlet UIView *vwTopHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblLoadstatus;
@property (weak, nonatomic) IBOutlet UILabel *lblLoadSubtitle;
@property (weak, nonatomic) IBOutlet UIView *viewwithbackbutton;
@property (weak, nonatomic) IBOutlet UIButton *btnStatusBack;
- (IBAction)btnStatusBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblLoadStatusHeading;

@end
