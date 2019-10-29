//
//  LoginVC.h
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBEncryptorAES.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import  <FirebaseAuth/FirebaseAuth.h>
#import "Firebase.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h> 
#import <TwitterKit/TwitterKit.h>
@interface LoginVC : BaseVC<GIDSignInUIDelegate,GIDSignInDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
- (IBAction)btnRegisterClicked:(id)sender;
- (IBAction)btnLoginClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIImageView *imgAppLogo;
@property (weak, nonatomic) IBOutlet UIView *vwTextFields;
- (IBAction)btnLoginDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLoginDrawer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollMain;
- (IBAction)btnfbloginclicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnfbLogin;

@property (weak, nonatomic) IBOutlet UIButton *btnTwitterLogin;
- (IBAction)btnTwitterLoginClicked:(id)sender;
- (IBAction)btnGoogleLoginClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnGoogleLogin;

@end
