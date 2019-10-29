//
//  CellMyAccountData.m
//  Lodr
//
//  Created by Payal Umraliya on 14/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellMyAccountData.h"

@implementation CellMyAccountData

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSArray *arrlbls =
    [NSArray arrayWithObjects:_txtzip, _txtcity, _txtPhone, _txtstate, _txtstreet, _txtmcnumber, _txtDotNumber, _txtCompanyName, _txtNewCompany, nil];
    
    for (UITextField *lbl in arrlbls)
    {
        lbl.layer.cornerRadius = 1.0f;
        lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
        lbl.layer.borderWidth = 1.0f;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _btnSearchCompany.layer.cornerRadius = 5.0f;
    _btnSearchCompany.clipsToBounds = YES;
    _btnSearchCompany.layer.borderColor = [UIColor blackColor].CGColor;
    _btnSearchCompany.layer.borderWidth = 2.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)btnstatenameclicked:(id)sender 
{
    [self.cellMyAccountDataDelegate btnstatenameclicked:sender];
}

- (IBAction)btnEditDotClicked:(id)sender
{
     [self.cellMyAccountDataDelegate btnEditDotClicked:sender];
}

- (IBAction)btnEditMcClicked:(id)sender
{
    [self.cellMyAccountDataDelegate btnEditMcClicked:sender];
}

- (IBAction)btnSearchCompanyClicked:(id)sender
{
    [self.cellMyAccountDataDelegate btnSearchCompanyClicked:sender];
}

@end
