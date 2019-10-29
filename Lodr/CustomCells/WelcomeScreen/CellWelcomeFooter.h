//
//  CellWelcomeFooter.h
//  Lodr
//
//  Created by c196 on 26/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellWelcomeFooterDelegate
@optional
- (IBAction)btntblWelcomeNextClicked:(id)sender;
- (IBAction)btnSummaryBackClicked:(id)sender;
- (IBAction)btnSummaryRegisterClicked:(id)sender;
- (IBAction)btnOfficeInfoNextClciked:(id)sender;
- (IBAction)btncmpnybackclicked:(id)sender;
- (IBAction)btncmpnynextclicked:(id)sender;
- (IBAction)btnOfficeInfoBackClicked:(id)sender;
@end
@interface CellWelcomeFooter : UIView
@property (weak, nonatomic) IBOutlet UIView *vwWelcomeFoooter;
//@property (weak, nonatomic) IBOutlet UIView *vwUserInfoFooter;
@property (weak, nonatomic) IBOutlet UIView *vwSummaryFooter;
@property (weak, nonatomic) IBOutlet UIView *vwOfficeInfoFooter;

@property (weak, nonatomic) IBOutlet UITextField *txtofficePhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeFaxNumber;

@property (weak, nonatomic) IBOutlet UIButton *brnSummaryRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnWelcomeNext;
@property (weak, nonatomic) IBOutlet UIButton *btnOfficeInfoBack;
@property (weak, nonatomic) IBOutlet UIButton *btncmpnynext;
@property (weak, nonatomic) IBOutlet UILabel *lblfaxheading;
@property (weak, nonatomic) IBOutlet UILabel *lblphonenheading;
@property (weak, nonatomic) IBOutlet UIButton *btncmpnayback;
@property (weak, nonatomic) IBOutlet UIButton *btnSummaryback;
@property (weak, nonatomic) IBOutlet UIButton *btnOfficeInfoNext;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightvwWelocmeFooter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfficeFooter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightcmpnyFooter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightSummaryFooter;

@property (weak, nonatomic) IBOutlet UIView *vwFootercompany;
@property (nonatomic, weak) id <CellWelcomeFooterDelegate> cellWelcomeFooterDelegate;
- (IBAction)btntblWelcomeNextClicked:(id)sender;
- (IBAction)btnSummaryBackClicked:(id)sender;
- (IBAction)btnSummaryRegisterClicked:(id)sender;
- (IBAction)btnOfficeInfoNextClciked:(id)sender;
- (IBAction)btncmpnybackclicked:(id)sender;
- (IBAction)btncmpnynextclicked:(id)sender;
- (IBAction)btnOfficeInfoBackClicked:(id)sender;
@end
