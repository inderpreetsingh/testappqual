//
//  RegistrationVC.m
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "RegistrationVC.h"
#import "WebContentVC.h"
#import "DotRegistrationVC.h"
#import "HomeVC.h"
@interface RegistrationVC ()
{
    NSArray *arrTextFields;
    CellRegistrationHeader *viewHeader;
    CellRegistrationFooter *footer;
}
@end

@implementation RegistrationVC

#pragma mark -VC life cycle
- (void)viewDidLoad 
{
    [super viewDidLoad];
    NavigationBarHidden(YES);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    arrTextFields=[[NSArray alloc]initWithObjects:@"First Name", @"Last Name",@"Email",@"Choose Password",@"Confirm Password",nil];
    self.tblRegister.backgroundColor = [UIColor clearColor];
    self.btnLogin.layer.cornerRadius=3.0f;
    self.btnResend.layer.cornerRadius=3.0f;
    if([self.callToVerification isEqualToString:@"Yes"])
    {
        _vwVerificationMail.alpha=1.0f;
        _tblRegister.alpha=0.0f;
        self.btnBackRegister.hidden=YES;
    }
    else
    {
        _vwVerificationMail.alpha=0.0f;
        _tblRegister.alpha=1.0f;
        self.btnBackRegister.hidden=NO;
          [self.btnBackRegister setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
    }
    
     [self.btnRegisterDrawer setImage:imgNamed(iconDrawer2) forState:UIControlStateNormal];
  
    [self layoutForHeaderFooter];
}
-(void)dismissKeyboard 
{
    [self.view endEditing:YES];
}
-(void)layoutForHeaderFooter
{
    viewHeader=[[CellRegistrationHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblRegister.frame.size.width, 370)];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellRegistrationHeader" owner:self options:nil];
    viewHeader = (CellRegistrationHeader *)[nib objectAtIndex:0]; 
  
    viewHeader.btnFb.layer.cornerRadius=3.0f;
    viewHeader.btnGplus.layer.cornerRadius=3.0f;
    viewHeader.btnTwit.layer.cornerRadius=3.0f;
    
   footer=[[CellRegistrationFooter alloc] initWithFrame:CGRectMake(0, 0, self.tblRegister.frame.size.width, 135)];
    
    NSArray *nibfooter = [[NSBundle mainBundle] loadNibNamed:@"CellRegistrationFooter" owner:self options:nil];
    footer = (CellRegistrationFooter *)[nibfooter objectAtIndex:0];
    footer.btnSignUp.layer.cornerRadius=3.0f;
}
#pragma mark - tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
    return 1; 
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return arrTextFields.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    static NSString *cellIdentifier = @"CellRegistrationFields";
    CellRegistrationFields *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) 
    { 
        cell = [[CellRegistrationFields alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
    }
   
    cell.lblTextFieldHeading.text=[arrTextFields objectAtIndex:indexPath.row];
    [cell.txtHeadingValue setKeyboardType:[[arrTextFields objectAtIndex:indexPath.row] integerValue]];
    if([cell.lblTextFieldHeading.text isEqualToString:@"Choose Password"]  || [cell.lblTextFieldHeading.text isEqualToString:@"Confirm Password"])
    {
        cell.txtHeadingValue.placeholder = @"Password";
        cell.txtHeadingValue.secureTextEntry = YES;
        [cell.txtHeadingValue setKeyboardType:UIKeyboardTypeASCIICapable];
    }
    else if([cell.lblTextFieldHeading.text isEqualToString:@"Email"])
    {
        cell.txtHeadingValue.secureTextEntry = NO;
        [cell.txtHeadingValue setKeyboardType:UIKeyboardTypeEmailAddress];
         cell.txtHeadingValue.placeholder=[arrTextFields objectAtIndex:indexPath.row];
    }
    else
    {
        cell.txtHeadingValue.secureTextEntry = NO;
        [cell.txtHeadingValue setKeyboardType:UIKeyboardTypeASCIICapable];
         cell.txtHeadingValue.placeholder=[arrTextFields objectAtIndex:indexPath.row];
    }
   
//    UILabel *lblFieldName=(UILabel *)[cell viewWithTag:10];
//    UITextField *txtFieldValue=(UITextField *)[cell viewWithTag:20];
    //lblFieldName.text =[arrTextFields objectAtIndex:indexPath.row];
    cell.txtHeadingValue.tag=500+indexPath.row;
    cell.txtHeadingValue.placeholder =[arrTextFields objectAtIndex:indexPath.row];
    cell.txtHeadingValue.layer.borderWidth=1.0f;
    cell.txtHeadingValue.layer.borderColor=[UIColor lightGrayColor].CGColor;
    return cell; 
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    viewHeader.cellRegistrationHeaderDelegate=self;
    return viewHeader;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{  
    footer.delegate=self;
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{ 
    return 135.0f; 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 370.0f;
}

#pragma mark - Custom Methods
#pragma mark - Layout Settings

#pragma mark - Click events
- (IBAction)btnResendMailClicked:(id)sender 
{
    @try {
    
    if([[NetworkAvailability instance]isReachable])
    {
        User *objuser=[DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
        NSDictionary *dicVerifyEmail = @{
                                      Req_secret_key:GlobalSecretKey,
                                      Req_access_key:GlobalAccessKey,
                                      Req_firstname:objuser.firstname,
                                      Req_email:objuser.primaryEmailId
                                      };
        [[WebServiceConnector alloc]
         init:URLVerificationEmail
         withParameters:dicVerifyEmail
         withObject:self
         withSelector:@selector(getVerificationResponse:)
         forServiceType:@"JSON"
         showDisplayMsg:@"Requesting for verification email"
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

- (IBAction)btnLoginClicked:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark - Footer Delegate

- (void)btnSignUpClicked:(id)sender 
{
    @try {
    
    NSMutableDictionary *dictTxtField=[NSMutableDictionary new];
       for (int a=0; a<arrTextFields.count; a++) 
    {
        UITextField *textField = (UITextField*)[self.view viewWithTag:500+a];
        if(textField.text.length==0)
        {
              [dictTxtField setValue:@"" forKey:textField.placeholder];
        }
        else
        {
              [dictTxtField setValue:textField.text forKey:textField.placeholder];
        }
    }
    if(
    [self validateTxtLength:[dictTxtField valueForKey:@"First Name"] withMessage:RequiredFirstname] &&
    [self validateTxtLength:[dictTxtField valueForKey:@"Last Name"] withMessage:RequiredLastname ]  &&
    [self validateTxtLength:[dictTxtField valueForKey:@"Email"] withMessage:RequiredEmail] &&
    [self validateEmailText:[dictTxtField valueForKey:@"Email"] withMessage:InvalidEmail]&&
    [self validateTxtLength:[dictTxtField valueForKey:@"Choose Password"] withMessage:RequiredPassword] &&
    [self validateTxtLength:[dictTxtField valueForKey:@"Confirm Password"] withMessage:RequiredVerifyPassword] &&
    [self validateVerifyText:[dictTxtField valueForKey:@"Choose Password"] confirmpassword:[dictTxtField valueForKey:@"Confirm Password"] withMessage:MismatchEmail]
          )
    {
        [self showHUD:@"Signing Up..."];
        
        NSDictionary *dicRegister = @{
                                      Req_secret_key:GlobalSecretKey,
                                      Req_access_key:GlobalAccessKey,
                                      Req_userrole:@"0",
                                      Req_firstname:[dictTxtField valueForKey:@"First Name"],
                                      Req_lastname:[dictTxtField valueForKey:@"Last Name"],
                                      Req_email:[dictTxtField valueForKey:@"Email"],
                                      Req_secure_password:[dictTxtField valueForKey:@"Choose Password"],
                                      Req_phone:@"",
                                      Req_device_type:@"1",
                                      Req_device_token:[self checkDevToken],
                                      Req_profile:@""
                                      };
        if([[NetworkAvailability instance]isReachable])
        {
            
            [[WebServiceConnector alloc]
             init:URLRegistration
             withParameters:dicRegister
             withObject:self
             withSelector:@selector(getRegistrationResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Signing Up"
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

- (void)btnTermsClicked:(id)sender
{
    WebContentVC *objWebvc = initVCToRedirect(SBMAIN, WEBCONTENTVC);
    objWebvc.webURL=TermsPrivacyUrl;
    [self.navigationController pushViewController:objWebvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)btnBackRegisterClicked:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Social Logins

- (void)btnTwitClicked:(id)sender
{
  
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
                         NSString *email;
                         if([userInfo email]!=nil)
                         {
                             email=[userInfo email];
                         }
                         else
                         {
                             email=@"";
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
- (void)btnFbClicked:(id)sender
{
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
- (void)btnGplusClicked:(id)sender
{
 
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

#pragma mark - ws handling

-(IBAction)getRegistrationResponse:(id)sender
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
            [DefaultsValues setStringValueToUserDefaults:objUser.primaryEmailId ForKey:SavedUserEmail];
            [DefaultsValues setBooleanValueToUserDefaults:NO ForKey:SavedSignedIn];
            [DefaultsValues setStringValueToUserDefaults:objUser.internalBaseClassIdentifier ForKey:SavedUserId];
            [DefaultsValues setStringValueToUserDefaults:[FBEncryptorAES encryptBase64String:objUser.accesscode keyString:GlobalConfigBaseValue separateLines:NO] ForKey:SavedAccessKey];
              
                    [_vwVerificationMail setAlpha:0.0f];
                    [UIView animateWithDuration:0.6f animations:^{
                        [_vwVerificationMail setAlpha:1.0f];
                        [_tblRegister setAlpha:0.0f];
                    } 
                    completion:^(BOOL finished)
                     {
                         _btnBackRegister.hidden=YES;
                     }];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
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
-(IBAction)getVerificationResponse:(id)sender
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
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:APPNAME
                                          message:APIResponseMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
//                                     [AZNotification showNotificationWithTitle:APIResponseMessage controller:self notificationType:AZNotificationTypeSuccess];
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
- (IBAction)btnRegisterDrawerClicked:(id)sender {
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
@end
