//
//  CellMyAccountData.h
//  Lodr
//
//  Created by Payal Umraliya on 14/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellMyAccountDataDelegate

@optional

- (IBAction)btnstatenameclicked:(id)sender;
- (IBAction)btnEditDotClicked:(id)sender;
- (IBAction)btnEditMcClicked:(id)sender;
- (IBAction)btnSearchCompanyClicked:(id)sender;

@end


@interface CellMyAccountData : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *vwMain;
@property (weak, nonatomic) IBOutlet UILabel *lblDotNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) IBOutlet UIButton *btnEditdot;
@property (weak, nonatomic) IBOutlet UIButton *btnShipper;
@property (weak, nonatomic) IBOutlet UIButton *btnCarrier;
@property (weak, nonatomic) IBOutlet UIButton *btnEditMC;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchCompany;
@property (weak, nonatomic) IBOutlet UILabel *lblmcnumber;
@property (weak, nonatomic) IBOutlet UILabel *lblstreet;
@property (weak, nonatomic) IBOutlet UILabel *lblcity;
@property (weak, nonatomic) IBOutlet UILabel *lblstate;
@property (weak, nonatomic) IBOutlet UILabel *lblzip;
@property (weak, nonatomic) IBOutlet UITextField *txtDotNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtCompanyName;
@property (weak, nonatomic) IBOutlet UITextField *txtmcnumber;
@property (weak, nonatomic) IBOutlet UITextField *txtstreet;
@property (weak, nonatomic) IBOutlet UITextField *txtcity;
@property (weak, nonatomic) IBOutlet UITextField *txtstate;
@property (weak, nonatomic) IBOutlet UITextField *txtzip;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnStatename;


@property (weak, nonatomic) IBOutlet UILabel *lblOldCompany;
@property (weak, nonatomic) IBOutlet UILabel *lblNewCompany;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyDesc;
@property (weak, nonatomic) IBOutlet UITextField *txtNewCompany;


@property (nonatomic, weak) id <CellMyAccountDataDelegate> cellMyAccountDataDelegate;

- (IBAction)btnEditDotClicked:(id)sender;
- (IBAction)btnstatenameclicked:(id)sender;

@end
