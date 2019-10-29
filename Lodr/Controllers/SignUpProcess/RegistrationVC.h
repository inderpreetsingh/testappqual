//
//  RegistrationVC.h
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellRegistrationFooter.h"
#import "CellRegistrationHeader.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import  <FirebaseAuth/FirebaseAuth.h>
#import "Firebase.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h> 
#import <TwitterKit/TwitterKit.h>
#import "FBEncryptorAES.h"
#import "CellRegistrationFields.h"
@interface RegistrationVC : BaseVC<CellRegistrationFooterDelegate,CellRegistrationHeaderDelegate,GIDSignInUIDelegate,GIDSignInDelegate>
- (IBAction)btnRegisterDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnRegisterDrawer;

@property (weak, nonatomic) IBOutlet UITableView *tblRegister;
@property (weak, nonatomic) IBOutlet UIView *vwVerificationMail;

- (IBAction)btnResendMailClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnResend;
- (IBAction)btnLoginClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnBackRegister;
- (IBAction)btnBackRegisterClicked:(id)sender;
@property (weak, nonatomic) NSString *callToVerification;
@end
