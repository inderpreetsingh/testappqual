//
//  CellLoadDetailHeader.h
//  Lodr
//
//  Created by Payal Umraliya on 22/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellLoadDetailHeaderDelegate
@optional
- (IBAction)btnloaddetailheaderclicked:(id)sender;
- (IBAction)btnCurrentStatusClicked:(id)sender;
@end
@interface CellLoadDetailHeader : UIView
@property (weak, nonatomic) IBOutlet UIView *vwTopHeader;
@property (weak, nonatomic) IBOutlet UIView *vwStatus;
@property (weak, nonatomic) IBOutlet UIView *vwWithBackbutton;
@property (weak, nonatomic) IBOutlet UILabel *lblLoadStatus;
- (IBAction)btnCurrentStatusClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCurrentStatus;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vwstatusheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vwbacklabelheight;
@property (weak, nonatomic) IBOutlet UIButton *btnloaddetailheader;
- (IBAction)btnloaddetailheaderclicked:(id)sender;
@property (nonatomic, weak) id <CellLoadDetailHeaderDelegate> cellLoadDetailHeaderDelegate;
@end
