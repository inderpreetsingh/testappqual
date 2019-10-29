//
//  CellAccountHeader.m
//  Lodr
//
//  Created by Payal Umraliya on 14/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellAccountHeader.h"

@implementation CellAccountHeader

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.txtvwAddressOffic.layer.borderWidth=1.0f;
    self.txtvwAddressOffic.layer.cornerRadius=1.0f;
    self.txtvwAddressOffic.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtOfficeName.layer.borderWidth=1.0f;
    self.txtOfficeName.layer.cornerRadius=1.0f;
    self.txtOfficeName.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtOperatingAddress.layer.borderWidth=1.0f;
    self.txtOperatingAddress.layer.cornerRadius=1.0f;
    self.txtOperatingAddress.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.txtOperatingAddress.placeholder=@"Enter address";
    self.txtOperatingAddress.placeholderColor=[UIColor lightGrayColor];
    
    _btnSearch.layer.cornerRadius = 5.0f;
    _btnSearch.clipsToBounds = YES;
    _btnSearch.layer.borderColor = [UIColor blackColor].CGColor;
    _btnSearch.layer.borderWidth = 2.0f;

}
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    _btnSearch.layer.cornerRadius = 5.0f;
//    _btnSearch.clipsToBounds = YES;
//    _btnSearch.layer.borderColor = [UIColor blackColor].CGColor;
//    _btnSearch.layer.borderWidth = 2.0f;
//}

- (IBAction)btnSameAsCompanyCheckboxClicked:(id)sender 
{
    [self.cellAccountHeaderDelegate btnSameAsCompanyCheckboxClicked:sender];
}
- (IBAction)btnmapviewclicked:(id)sender {
 [self.cellAccountHeaderDelegate btnmapviewclicked:sender];
}
- (IBAction)btnOpetingAddressClicked:(id)sender {
    [self.cellAccountHeaderDelegate btnOpetingAddressClicked:sender];
}
@end
