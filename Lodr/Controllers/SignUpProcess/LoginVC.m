//
//  LoginVC.m
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "LoginVC.h"
#import "RegistrationVC.h"
#import "DotRegistrationVC.h"
#import "HomeVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

#pragma mark -VC life cycle


- (void)viewDidLoad
{
    [super viewDidLoad];   
    NavigationBarHidden(YES);
  
     _txtEmail.layer.cornerRadius=1.0f;
    _txtPassword.layer.cornerRadius=1.0f;
    [AppInstance.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    
     [self.btnLoginDrawer setImage:imgNamed(iconDrawer2) forState:UIControlStateNormal];
    self.btnfbLogin.layer.cornerRadius=2.0f;
    self.btnGoogleLogin.layer.cornerRadius=2.0f;
    self.btnTwitterLogin.layer.cornerRadius=2.0f;
    self.btnTwitterLogin.clipsToBounds=YES;
    self.btnGoogleLogin.clipsToBounds=YES;
    self.btnfbLogin.clipsToBounds=YES;
    if(SCREEN_WIDTH > 375)
    {
         [self.scrollMain setContentSize:CGSizeMake(SCREEN_WIDTH, 1000)];
    }
    else
    {
        [self.scrollMain setContentSize:CGSizeMake(SCREEN_WIDTH, 851)];
        
    }
    [self.scrollMain layoutIfNeeded];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scrollMain setContentOffset:CGPointZero animated:YES];
}

#pragma mark - Custom Methods
#pragma mark - Layout Settings
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - Click events
- (IBAction)btnRegisterClicked:(id)sender
{
    
    RegistrationVC *registervc =initVCToRedirect(SBMAIN, REGISTERVC);
    registervc.callToVerification=@"No";
    [self.navigationController pushViewController:registervc animated:YES];
}

- (IBAction)btnLoginClicked:(id)sender
{
    @try {
    if(
       [self validateTxtLength:_txtEmail.text withMessage:RequiredEmail] &&
       [self validateEmailText:_txtEmail.text withMessage:InvalidEmail]&&
       [self validateTxtLength:_txtPassword.text withMessage:RequiredPassword] 
       )
    {
          
        NSDictionary *dicLogin=@{
                                 Req_access_key:GlobalAccessKey,
                                 Req_secret_key:GlobalSecretKey,
                                 Req_email:_txtEmail.text,
                                 Req_secure_password:_txtPassword.text,
                                 Req_device_type:@"1",
                                 Req_device_token:[self checkDevToken]};    
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLLogin
             withParameters:dicLogin
             withObject:self
             withSelector:@selector(getLoginResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Signing In"
             showProgress:YES];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
    } @catch (NSException *exception) {
        [self dismissHUD];  
    } 
}
-(IBAction)getLoginResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:Msg101 controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            User *objUser = [[sender responseArray] objectAtIndex:0];
            
            [DefaultsValues setCustomObjToUserDefaults:objUser ForKey:SavedUserData];
            [DefaultsValues setStringValueToUserDefaults:APIResponseToken ForKey:SavedSecretKey];    
            [DefaultsValues setStringValueToUserDefaults:objUser.internalBaseClassIdentifier ForKey:SavedUserId];
            [DefaultsValues setBooleanValueToUserDefaults:YES ForKey:SavedSignedIn];
            [DefaultsValues setStringValueToUserDefaults:objUser.primaryEmailId ForKey:SavedUserEmail];
            [DefaultsValues setStringValueToUserDefaults:[FBEncryptorAES encryptBase64String:objUser.accesscode keyString:GlobalConfigBaseValue separateLines:NO] ForKey:SavedAccessKey];
            NSLog(@"%@",[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]);
            
            if(objUser.userAccount.count >0)
            {
                HomeVC *objHomeVC =initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
                [AppInstance setDrawerWithCenterViewNamed:objHomeVC];
            }
            else
            {
                DotRegistrationVC *welcomevc=initVCToRedirect(SBMAIN, DOTREGISTRATIONVC);
                [AppInstance setDrawerWithCenterViewNamed:welcomevc];
            }
           
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
- (IBAction)btnLoginDrawerClicked:(id)sender
{
    [self.view endEditing:YES];
     [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}


- (IBAction)btnfbloginclicked:(id)sender {
    @try 
    {
        NSError *signOutError;
        [[FIRAuth auth] signOut:&signOutError];
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        dispatch_async(dispatch_get_main_queue(), ^{
            [loginManager
             logInWithReadPermissions:@[ @"public_profile", @"email" ]
             fromViewController:self
             handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                 if (error)
                 {
                     [AZNotification showNotificationWithTitle:error.localizedDescription controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
                 }
                 else if (result.isCancelled)
                 {
                     NSLog(@"Cancelled");
                 }
                 else
                 {
                     [self showHUD:@"Signing with Facebook..."];
                     FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                                      credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                                      .tokenString];
                     [[FIRAuth auth] signInWithCredential:credential
                                               completion:^(FIRUser *firuser, NSError *error) 
                      {
                          if(error)
                          {
                              [AZNotification showNotificationWithTitle:error.localizedDescription controller:ROOTVIEW notificationType:AZNotificationTypeError];
                              NSLog(@"FB ERROR");
                              NSLog(@"*******************************************************************************");
                              NSLog(@"%@",error.localizedDescription);
                              NSLog(@"*******************************************************************************");
                              [self dismissHUD];
                          }
                          else
                          {
                              id<FIRUserInfo> userInfo;
                              for (id<FIRUserInfo> userInfodata in firuser.providerData)
                              {
                                  if ([userInfodata.providerID isEqualToString:FIRFacebookAuthProviderID]) 
                                  {
                                      userInfo=userInfodata;
                                  }
                              }
                              if([userInfo photoURL]!=nil)
                              {
                                  [DefaultsValues setCustomObjToUserDefaults:[userInfo photoURL] ForKey:SavedUserSocialProfileURL];
                              }
                              NSString *emailval,*displayname,*userid;
                              if([userInfo displayName] == nil)
                              {
                                  displayname=@"";
                              }
                              else
                              {
                                  displayname=[userInfo displayName];
                              }
                              if([userInfo email] == nil)
                              {
                                  emailval=@"";
                              }
                              else
                              {
                                  displayname=[userInfo email];
                              }
                              if([userInfo uid] == nil)
                              {
                                  userid=@"";
                              }
                              else
                              {
                                  userid=[userInfo uid];
                              }
                              NSString *userprofile;
                              if([userInfo photoURL]!=nil)
                              {
                                  userprofile=[NSString stringWithFormat:@"%@",[userInfo photoURL]];
                              }
                              else
                              {
                                  userprofile=@"";
                              }

                              NSDictionary *dicRegister = @{
                                                            Req_secret_key:GlobalSecretKey,
                                                            Req_access_key:GlobalAccessKey,
                                                            Req_userrole:@"0",
                                                            Req_firstname:[userInfo displayName],
                                                            Req_lastname:@"",
                                                            Req_email:[userInfo email],
                                                            Req_secure_password:@"",
                                                            Req_phone:@"",
                                                            Req_device_type:@"1",
                                                            Req_device_token:[self checkDevToken],
                                                            Req_profile:userprofile,
                                                            Req_facebookid:[userInfo uid],
                                                            Req_googleid:@"0",
                                                            Req_twitterid:@"0"
                                                            };
                              [self btnSocialSignUp:dicRegister];
                          }
                      }];
                 }
             }];
        });
    } 
    @catch (NSException *exception) {
        
    } 
}

- (IBAction)btnTwitterLoginClicked:(id)sender {
    NSError *signOutError;
    [[FIRAuth auth] signOut:&signOutError];
    
    
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error)
     {
         [self dismissHUD];
         if (session) 
         {
             FIRAuthCredential *credential =
             [FIRTwitterAuthProvider credentialWithToken:session.authToken
                                                  secret:session.authTokenSecret];
             [[FIRAuth auth] signInWithCredential:credential
                                       completion:^(FIRUser *firuser, NSError *error) 
              {
                  if(error)
                  {
                      [AZNotification showNotificationWithTitle:error.localizedDescription controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
                      [self dismissHUD];
                  }
                  else
                  {
                      id<FIRUserInfo> userInfo;
                      for (id<FIRUserInfo> userInfodata in firuser.providerData)
                      {
                          if ([userInfodata.providerID isEqualToString:FIRTwitterAuthProviderID]) 
                          {
                              userInfo=userInfodata;
                          }
                      }
                      
                      if([userInfo photoURL]!=nil)
                      {
                          [DefaultsValues setCustomObjToUserDefaults:[userInfo photoURL] ForKey:SavedUserSocialProfileURL];
                      }
                      NSString *userprofile;
                      if([userInfo photoURL]!=nil)
                      {
                          userprofile=[NSString stringWithFormat:@"%@",[userInfo photoURL]];
                      }
                      else
                      {
                          userprofile=@"";
                      }
                      NSString *email;
                      if([userInfo email]!=nil)
                      {
                          email=[userInfo email];
                      }
                      else
                      {
                          email=@"";
                      }
                      NSDictionary *dicRegister = @{
                                                    Req_secret_key:GlobalSecretKey,
                                                    Req_access_key:GlobalAccessKey,
                                                    Req_userrole:@"0",
                                                    Req_firstname:[userInfo displayName],
                                                    Req_lastname:@"",
                                                    Req_email:email,
                                                    Req_secure_password:@"",
                                                    Req_phone:@"",
                                                    Req_device_type:@"1",
                                                    Req_device_token:[self checkDevToken],
                                                    Req_profile:userprofile,
                                                    Req_facebookid:@"0",
                                                    Req_googleid:@"0",
                                                    Req_twitterid:[userInfo uid]
                                                    };
                      [self btnSocialSignUp:dicRegister];
                  }
              }];
         }
         else
         {
             [AZNotification showNotificationWithTitle:error.localizedDescription controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
         }
     }];
}

- (IBAction)btnGoogleLoginClicked:(id)sender {
    NSError *signOutError;
    [[FIRAuth auth] signOut:&signOutError];
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    [[GIDSignIn sharedInstance] signIn];
}

#pragma mark - login with social
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error 
{
    @try {
        
        if (error == nil) 
        {
            [self showHUD:@"Signing with Google..."];
            GIDAuthentication *authentication = user.authentication;
            FIRAuthCredential *credential =
            [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                             accessToken:authentication.accessToken];
            [[FIRAuth auth] signInWithCredential:credential
                                      completion:^(FIRUser *firuser, NSError *error) 
             {
                 if(error)
                 {
                     [AZNotification showNotificationWithTitle:error.localizedDescription controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
                     [self dismissHUD];
                 }
                 else
                 {
                     id<FIRUserInfo> userInfo;
                     for (id<FIRUserInfo> userInfodata in firuser.providerData)
                     {
                         if ([userInfodata.providerID isEqualToString:FIRGoogleAuthProviderID]) 
                         {
                             userInfo=userInfodata;
                         }
                     }
                     if([userInfo photoURL]!=nil)
                     {
                         [DefaultsValues setCustomObjToUserDefaults:[userInfo photoURL] ForKey:SavedUserSocialProfileURL];
                     }
                     NSString *userprofile;
                     if([userInfo photoURL]!=nil)
                     {
                         userprofile=[NSString stringWithFormat:@"%@",[userInfo photoURL]];
                     }
                     else
                     {
                         userprofile=@"";
                     }
                     NSDictionary *dicRegister = @{
                                                   Req_secret_key:GlobalSecretKey,
                                                   Req_access_key:GlobalAccessKey,
                                                   Req_userrole:@"0",
                                                   Req_firstname:[userInfo displayName],
                                                   Req_lastname:@"",
                                                   Req_email:[userInfo email],
                                                   Req_secure_password:@"",
                                                   Req_phone:@"",
                                                   Req_device_type:@"1",
                                                   Req_device_token:[self checkDevToken],
                                                   Req_profile:userprofile,
                                                   Req_facebookid:@"0",
                                                   Req_googleid:[userInfo uid],
                                                   Req_twitterid:@"0"
                                                   };
                     [self btnSocialSignUp:dicRegister];
                 }
             }];
        } 
        else 
        {
        }
    } @catch (NSException *exception) {
        
    } 
}
-(void)btnSocialSignUp :(NSDictionary *)dictSocialRegister
{
    @try {
        
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLLoginWithSocialMedia
             withParameters:dictSocialRegister
             withObject:self
             withSelector:@selector(getSocialRegistrationResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Processing Request"
             showProgress:YES];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
        
    } @catch (NSException *exception) {
        [self dismissHUD];  
    } 
}
-(IBAction)getSocialRegistrationResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:Msg101 controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
            User *objUser = [[sender responseArray] objectAtIndex:0];
            [DefaultsValues setCustomObjToUserDefaults:objUser ForKey:SavedUserData];
            [DefaultsValues setStringValueToUserDefaults:APIResponseToken ForKey:SavedSecretKey];    
            [DefaultsValues setBooleanValueToUserDefaults:YES ForKey:SavedSignedIn];
            [DefaultsValues setStringValueToUserDefaults:[FBEncryptorAES encryptBase64String:objUser.accesscode keyString:GlobalConfigBaseValue separateLines:NO] ForKey:SavedAccessKey];
            [DefaultsValues setStringValueToUserDefaults:objUser.internalBaseClassIdentifier ForKey:SavedUserId];
            
            if(objUser.userAccount.count == 0)
            {
                DotRegistrationVC  *objwelcomevc=initVCToRedirect(SBMAIN, DOTREGISTRATIONVC);
                [AppInstance setDrawerWithCenterViewNamed:objwelcomevc];
            }
            else
            {
                HomeVC  *objhomevc=initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
                [AppInstance setDrawerWithCenterViewNamed:objhomevc];
            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
@end
