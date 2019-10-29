//
//  CellWelcomeUserInfo.h
//  Lodr
//
//  Created by c196 on 22/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@protocol CellWelcomeUserInfoDelegate

@optional

- (IBAction)btnuserinfocmpanyaddrClicked:(id)sender;
- (IBAction)btnUserInfoMapPinClicked:(id)sender;

@end

@interface CellWelcomeUserInfo : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgUserPhoto;

@property (weak, nonatomic) IBOutlet UITextField *txtphonenumber;
@property (weak, nonatomic) IBOutlet UITextField *txtyourname;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIView *vwuseraddress;
@property (weak, nonatomic) IBOutlet UIButton *btnuserinfocmpanyaddr;

- (IBAction)btnuserinfocmpanyaddrClicked:(id)sender;
- (IBAction)btnUserInfoMapPinClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *txtUserInfoAddress;
@property (nonatomic, weak) id <CellWelcomeUserInfoDelegate> cellWelcomeUserInfoDelegate;

@end
