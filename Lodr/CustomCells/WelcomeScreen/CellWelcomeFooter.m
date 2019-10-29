//
//  CellWelcomeFooter.m
//  Lodr
//
//  Created by c196 on 26/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellWelcomeFooter.h"

@implementation CellWelcomeFooter
- (void)awakeFromNib {
    [super awakeFromNib];
    self.txtofficePhoneNum.layer.borderWidth=1.0f;
    self.txtofficePhoneNum.layer.cornerRadius=1.0f;
    self.txtofficePhoneNum.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtOfficeFaxNumber.layer.borderWidth=1.0f;
    self.txtOfficeFaxNumber.layer.cornerRadius=1.0f;
    self.txtOfficeFaxNumber.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
}
- (IBAction)btntblWelcomeNextClicked:(id)sender {
    [self.cellWelcomeFooterDelegate btntblWelcomeNextClicked:sender];
}
- (IBAction)btnSummaryBackClicked:(id)sender {
     [self.cellWelcomeFooterDelegate btnSummaryBackClicked:sender];
}
- (IBAction)btnSummaryRegisterClicked:(id)sender
{
     [self.cellWelcomeFooterDelegate btnSummaryRegisterClicked:sender];
}
- (IBAction)btnOfficeInfoBackClicked:(id)sender {
     [self.cellWelcomeFooterDelegate btnOfficeInfoBackClicked:sender];
}
- (IBAction)btnOfficeInfoNextClciked:(id)sender {
     [self.cellWelcomeFooterDelegate btnOfficeInfoNextClciked:sender];
}

- (IBAction)btncmpnybackclicked:(id)sender {
     [self.cellWelcomeFooterDelegate btncmpnybackclicked:sender];
}

- (IBAction)btncmpnynextclicked:(id)sender {
     [self.cellWelcomeFooterDelegate btncmpnynextclicked:sender];
}
@end
