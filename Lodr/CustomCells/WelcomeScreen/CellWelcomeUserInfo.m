//
//  CellWelcomeUserInfo.m
//  Lodr
//
//  Created by c196 on 22/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellWelcomeUserInfo.h"

@implementation CellWelcomeUserInfo

- (void)awakeFromNib 
{
    [super awakeFromNib];
    
    NSArray *arrlbls=[NSArray arrayWithObjects:_txtyourname,_txtphonenumber,nil];
    
    for (UITextField *lbl in arrlbls)
    {
        lbl.layer.cornerRadius=1.0f;
        lbl.layer.borderColor=[UIColor lightGrayColor].CGColor;
        lbl.layer.borderWidth=1.0f;
    }
    
    _imgUserPhoto.layer.cornerRadius=_imgUserPhoto.frame.size.height/2;
    _imgUserPhoto.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _imgUserPhoto.layer.borderWidth=1.0f;
    _imgUserPhoto.clipsToBounds=YES;
    
    _txtUserInfoAddress.layer.cornerRadius=2.0f;
    _txtUserInfoAddress.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _txtUserInfoAddress.layer.borderWidth=1.0f;
    _txtUserInfoAddress.clipsToBounds=YES;
    
    _txtEmail.layer.cornerRadius=2.0f;
    _txtEmail.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _txtEmail.layer.borderWidth=1.0f;
    _txtEmail.clipsToBounds=YES;

    _txtPassword.layer.cornerRadius=2.0f;
    _txtPassword.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _txtPassword.layer.borderWidth=1.0f;
    _txtPassword.clipsToBounds=YES;

    _txtUserInfoAddress.placeholder=@"Enter address";
    self.txtUserInfoAddress.placeholderColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btnuserinfocmpanyaddrClicked:(id)sender {
    [self.cellWelcomeUserInfoDelegate btnuserinfocmpanyaddrClicked:sender];
}

- (IBAction)btnUserInfoMapPinClicked:(id)sender {
    [self.cellWelcomeUserInfoDelegate btnUserInfoMapPinClicked:sender];
}
@end
