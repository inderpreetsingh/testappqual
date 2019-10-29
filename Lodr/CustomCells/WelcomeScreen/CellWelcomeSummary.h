//
//  CellWelcomeSummary.h
//  Lodr
//
//  Created by c196 on 25/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellWelcomeSummaryDelegate
@optional
- (IBAction)btnEditProfileClicked:(id)sender;
@end
@interface CellWelcomeSummary : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblSummaryHeading;
@property (weak, nonatomic) IBOutlet UILabel *lblsummaryOfficename;
@property (weak, nonatomic) IBOutlet UILabel *lblsummarydot;
@property (weak, nonatomic) IBOutlet UILabel *lblsummaryaddress;
@property (weak, nonatomic) IBOutlet UIView *vwroles;
@property (weak, nonatomic) IBOutlet UILabel *lblsummaryphone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightDotNumber;
- (IBAction)btnEditProfileClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imguserimage;
@property (weak, nonatomic) IBOutlet UIView *vphoto;
@property (weak, nonatomic) IBOutlet UIButton *btnshipper;
@property (strong, nonatomic) IBOutlet UIButton *btnEditAccount;
@property (weak, nonatomic) IBOutlet UIButton *btndriver;
@property (weak, nonatomic) IBOutlet UIButton *btncarrier;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBtnDriver;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBtnDriver;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBtnLoads;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBtnLoads;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLblDotNumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLblMcNumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLblMcNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblMcNumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVwAvailability;
@property (weak, nonatomic) IBOutlet UIView *vwAvailability;

@property (weak, nonatomic) IBOutlet UIButton *btnAvailabilityUnlimited;
@property (weak, nonatomic) IBOutlet UIButton *btnAvailabilityUSCanada;
@property (weak, nonatomic) IBOutlet UIButton *btnAvailabilityInterstate;
@property (weak, nonatomic) IBOutlet UIButton *btnAvailabilityIntrastate;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightimage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightroles;


@property (nonatomic, weak) id <CellWelcomeSummaryDelegate> cellWelcomeSummaryDelegate;
@end
