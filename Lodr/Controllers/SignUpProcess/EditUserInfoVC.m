//
//  EditUserInfoVC.m
//  Lodr
//
//  Created by c196 on 11/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "EditUserInfoVC.h"
#import "TermsCell.h"

@interface EditUserInfoVC ()
{
    BOOL isConditionVerified;
    
    UIView *overlay, *overlayview;
    NSArray *nibHeader, *nibFooter, *arruserInfoOptionCellText;
    NSMutableArray *arrroleselected;
    CellAccountHeader *tblheader;
    CellWelcomeFooter *tblFooter;
    User *objuser;
    UserAccount *objuserac;
    NSData *imageSelectedData;
    NSString *userphone, *roltext, *addUserinfoaddress, *useraddress, *nameofuser, *userphonenumber;
    
    NSString *strEmail, *strPassword;
}
@end

@implementation EditUserInfoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NavigationBarHidden(YES);
    
    self.tblUserinfo.rowHeight = UITableViewAutomaticDimension;
    self.tblUserinfo.estimatedRowHeight = 50;
    
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    
    if (objuser.userAccount.count > 0)
    {
        objuserac = [objuser.userAccount objectAtIndex:0];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    arrroleselected = [NSMutableArray new];
    arruserInfoOptionCellText = [NSArray arrayWithObjects:@"I AM ALSO A DRIVER", @"MY COMPANY IS A CARRIER", @"MY COMPANY CREATES LOADS", nil];
    
    if ([objuserac.operatingAddress isEqualToString:objuserac.companyAddress]) {
        useraddress = @"";
        addUserinfoaddress = @"1";
    } else {
        useraddress = objuserac.operatingAddress;
        addUserinfoaddress = @"0";
    }
    
    nameofuser = [NSString stringWithFormat:@"%@", objuser.firstname];
    userphonenumber = objuserac.phoneNo;
    roltext = objuserac.role;
    strEmail = objuser.primaryEmailId;
    
    if ([roltext containsString:@"1"])
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
        [arrroleselected addObject:path];
    }
    
    if ([roltext containsString:@"2"])
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
        [arrroleselected addObject:path];
    }
    
    if ([roltext containsString:@"3"])
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
        [arrroleselected addObject:path];
    }
}

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
//    return 3;
//    return 2;
//    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tblheader == nil)
    {
        nibHeader = [[NSBundle mainBundle] loadNibNamed:@"CellAccountHeader" owner:self options:nil];
        tblheader = [[CellAccountHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblUserinfo.frame.size.width, 420)];
        tblheader = (CellAccountHeader *)[nibHeader objectAtIndex:0]; 
    }
   
    tblheader.cellAccountHeaderDelegate = self;
    tblheader.heightOperatingAddress.constant = 0;
    tblheader.lblLargeTitle.text = @"My Account";
    tblheader.lblOfiiceInfoText.text = @"USER INFO";
    tblheader.lblSubtitleSmall.text = @"Setup your account information";
    tblheader.heightHeaderHeading.constant = 165;
    tblheader.heightOfficeIHeader.constant = 0;
    tblheader.vwHeaderOfficeInfo.clipsToBounds = YES;
    tblheader.heigthlblpagename.constant = 50;
    tblheader.lblOfiiceInfoText.clipsToBounds = YES;
    
    return tblheader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    nibFooter = [[NSBundle mainBundle] loadNibNamed:@"welcomeFooter" owner:self options:nil];
    tblFooter = [[CellWelcomeFooter alloc] initWithFrame:CGRectMake(0, 0, self.tblUserinfo.frame.size.width, 320)];
    tblFooter = (CellWelcomeFooter *)[nibFooter objectAtIndex:0]; 
    tblFooter.cellWelcomeFooterDelegate = self;
    tblFooter.heightvwWelocmeFooter.constant = 0;
    tblFooter.heightOfficeFooter.constant = 0;
    tblFooter.heightcmpnyFooter.constant = 0;
    tblFooter.vwWelcomeFoooter.clipsToBounds = YES;
    tblFooter.vwFootercompany.clipsToBounds = YES;
    tblFooter.vwOfficeInfoFooter.clipsToBounds = YES;
    tblFooter.heightSummaryFooter.constant = 150;
    [tblFooter.brnSummaryRegister setTitle:@"UPDATE USER INFO" forState:UIControlStateNormal];
    
    return tblFooter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        if (indexPath.row == 0)
        {
            static NSString *customTableIdentifier = @"CellWelcomeUserInfo";
            CellWelcomeUserInfo *cell = (CellWelcomeUserInfo *)[_tblUserinfo dequeueReusableCellWithIdentifier:customTableIdentifier];
            
            if (!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellWelcomeUserInfo" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openSelectionforimage:)];
                tapGesture1.numberOfTapsRequired = 1;
                [cell.imgUserPhoto addGestureRecognizer:tapGesture1];
            }
            
            cell.txtUserInfoAddress.delegate = self;
            cell.cellWelcomeUserInfoDelegate = self;
            
            if (useraddress.length > 0)
            {
                cell.txtUserInfoAddress.text = useraddress;
            }
            
            if ([addUserinfoaddress isEqualToString:@"0"] || [addUserinfoaddress isEqualToString:@""])
            {
                [cell.btnuserinfocmpanyaddr setImage:imgNamed(@"checkboxsquare")  forState:UIControlStateNormal];
                
                if (useraddress.length > 0)
                {
                    cell.txtUserInfoAddress.text=useraddress;
                }
                else
                {
                    cell.txtUserInfoAddress.text=objuserac.operatingAddress;
                }
            }
            else
            {
                [cell.btnuserinfocmpanyaddr setImage:imgNamed(@"checkboxsquareselected") forState:UIControlStateNormal];
                cell.txtUserInfoAddress.text = @"";
            }
            
            if (imageSelectedData.length == 0)
            {
                NSString *userstr;
                
                if ([objuser.profilePicture containsString:@"http://"] || [objuser.profilePicture containsString:@"https://"])
                {
                    userstr = [NSString stringWithFormat:@"%@", objuser.profilePicture];
                }
                else
                {
                    userstr = [NSString stringWithFormat:@"%@%@", URLProfileImage, objuser.profilePicture];
                }
                NSURL *imgurl = [NSURL URLWithString:userstr];
                
                [cell.imgUserPhoto sd_setImageWithURL:imgurl
                                     placeholderImage:nil
                                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                if (image != nil)
                                                {
                                                    cell.imgUserPhoto.image=image;
                                                }
                                            }];
            }
            
            cell.txtyourname.tag=111;
            cell.txtphonenumber.tag=222;
            cell.txtEmail.tag = 333;
            cell.txtPassword.tag = 444;
            cell.txtyourname.delegate = self;
            cell.txtphonenumber.delegate = self;
            cell.txtEmail.delegate = self;
            cell.txtPassword.delegate = self;
            cell.txtyourname.text=nameofuser;
            cell.txtphonenumber.text=userphonenumber;
            cell.txtEmail.text = strEmail;
            
            return cell;
        }
        else if (indexPath.row == 1)
        {
            static NSString *customTableIdentifier = @"CellListWithCheckBox";
            CellListWithCheckBox *cell = (CellListWithCheckBox *)[_tblUserinfo dequeueReusableCellWithIdentifier:customTableIdentifier];
            if (nil == cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellListWithCheckBox" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.vwCheckboxsubtext.hidden=YES;
            cell.lblsubtext.text=@"";
            [cell.lblsubtext sizeToFit];
            cell.cellListWithCheckBoxDelegate=self;
            cell.btnCellClick.userInteractionEnabled=YES;
            cell.lblListName.text=[arruserInfoOptionCellText objectAtIndex:indexPath.row-1];
            
            if ([arrroleselected containsObject:indexPath])
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth=0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth=1.0f;
            }
            
            return cell;
        }
        else if (indexPath.row == 2)
        {
            static NSString *customTableIdentifier = @"CellListWithCheckBox";
            CellListWithCheckBox *cell = (CellListWithCheckBox *)[_tblUserinfo dequeueReusableCellWithIdentifier:customTableIdentifier];
            
            if (nil == cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellListWithCheckBox" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.vwCheckboxsubtext.hidden = YES;
            cell.lblsubtext.text = @"";
            [cell.lblsubtext sizeToFit];
            cell.cellListWithCheckBoxDelegate = self;
            cell.btnCellClick.userInteractionEnabled = YES;
            cell.lblListName.text = @"I AGREE TO LODR TERMS AND CONDITIONS";
        
            if (isConditionVerified)
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor = [UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth = 0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor = [UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth = 1.0f;
            }
            
            return cell;  
        }
        else
        {
            static NSString *customTableIdentifier = @"idTermsCell";
            TermsCell *cell = (TermsCell *)[_tblUserinfo dequeueReusableCellWithIdentifier:customTableIdentifier];
            
            if (nil == cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TermsCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            [cell.btnTerms addTarget:self action:@selector(btnTermsClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
    } @catch (NSException *exception) { }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 165;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{
    return 150;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 111)
    {
        nameofuser=textField.text;
    }
    else if(textField.tag == 222)
    {
        userphonenumber=textField.text;
    }
    else if(textField.tag == 333)
    {
        strEmail=textField.text;
    }
    else if(textField.tag == 444)
    {
        strPassword=textField.text;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    CellWelcomeUserInfo *cellwelcome=(CellWelcomeUserInfo*)[_tblUserinfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if(textView.text.length >0)
    {
        useraddress=textView.text;
        addUserinfoaddress=@"0";
        [cellwelcome.btnuserinfocmpanyaddr setImage:imgNamed(@"checkboxsquare")  forState:UIControlStateNormal];
    }
    else
    {
        useraddress=@"";
        addUserinfoaddress=@"1";
        [cellwelcome.btnuserinfocmpanyaddr setImage:imgNamed(@"checkboxsquareselected")  forState:UIControlStateNormal];
    }
}

- (IBAction)btnuserinfocmpanyaddrClicked:(id)sender {
    
    UIButton *senderbtn=(UIButton*)sender;
    senderbtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    if([addUserinfoaddress isEqualToString:@"1"])
    {
        [senderbtn setImage:imgNamed(@"checkboxsquare")  forState:UIControlStateNormal];
        senderbtn.accessibilityLabel=@"0";
        addUserinfoaddress=@"0";
    }
    else
    {
        [senderbtn setImage:imgNamed(@"checkboxsquareselected")  forState:UIControlStateNormal];
        senderbtn.accessibilityLabel=@"1";
        addUserinfoaddress=@"1";
    }
}

- (IBAction)btnUserInfoMapPinClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedSetWelcomeScreenAddress object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSelectedWelcomeLocation:) name:NCNamedSetWelcomeScreenAddress object:nil];
    [self.view endEditing:YES];
    SPGooglePlacesAutocompleteViewController *googlePlacesVC = [[SPGooglePlacesAutocompleteViewController alloc] init];
    googlePlacesVC.requestMapFor=@"WelcomeScreenAddress";
    CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
    [floatingController setFrameColor:[UIColor whiteColor]];
    UIWindow *window1 = [[UIApplication sharedApplication] keyWindow];
    UIView *rootView = [window1.rootViewController view];
    [floatingController showInView:rootView
         withContentViewController:googlePlacesVC
                          animated:YES];
}

#pragma mark - cell list box

- (IBAction)btnTermsClicked:(id)sender
{
    [self.view endEditing:TRUE];
    
    NSString *strHelp = @"https://lodrapp.com/tc/";
    NSURL *urlHelp = [NSURL URLWithString:strHelp];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:urlHelp];
    });
}

- (IBAction)btnCellClicked:(id)sender
{
    [self.view endEditing:YES];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblUserinfo];
    NSIndexPath *indexPath = [self.tblUserinfo indexPathForRowAtPoint:buttonPosition];
    
    CellListWithCheckBox *cell=(CellListWithCheckBox*)[self.tblUserinfo cellForRowAtIndexPath:indexPath];

    if (indexPath.row == 1)
    {
        if ([arrroleselected containsObject:indexPath])
        {
            [arrroleselected removeObject:indexPath];
        }
        else
        {
            [arrroleselected addObject:indexPath];
        }
        
        if ([arrroleselected containsObject:indexPath])
        {
            [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
            cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
            cell.btnCheckbox.layer.borderWidth=0.0f;
        }
        else
        {
            [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
            cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
            cell.btnCheckbox.layer.borderWidth=1.0f;
        }

    }
    else
    {
        if (!isConditionVerified) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Terms & Conditions"
                                                                           message:@"Confirm You Have Read Lodr App Terms & Conditions?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [self updateTermsCheck:cell];
                                                              }];
            
            UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            
            [alert addAction:yesAction];
            [alert addAction:noAction];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:YES completion:nil];
            });
        } else {
            [self updateTermsCheck:cell];
        }
    }
}

- (void)updateTermsCheck:(CellListWithCheckBox *)cell {
    isConditionVerified = !isConditionVerified;
    
    if (isConditionVerified)
    {
        [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
        cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
        cell.btnCheckbox.layer.borderWidth=0.0f;
    }
    else
    {
        [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
        cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
        cell.btnCheckbox.layer.borderWidth=1.0f;
    }
}

-(void)setSelectedWelcomeLocation:(NSNotification *)anote
{
    NSDictionary *dict = anote.userInfo;
    NSString *requestAddressType=[NSString stringWithFormat:@"%@",[dict objectForKey:@"AddressType"]];
    if([requestAddressType isEqualToString:@"WelcomeScreenAddress"])
    {
        UITextView *textFieldDot = (UITextView*)[self.view viewWithTag:700];
        NSDictionary *dict = anote.userInfo;
        textFieldDot.text=[dict objectForKey:@"SelectedAddress"];
        useraddress=textFieldDot.text;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedSetWelcomeScreenAddress object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedDismissView object:self];
}
- (IBAction)btnSummaryBackClicked:(id)sender 
{
    [DefaultsValues removeObjectForKey:SavedDOTData];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSummaryRegisterClicked:(id)sender
{
    @try 
    {
        if(([addUserinfoaddress isEqualToString:@"0"] || [addUserinfoaddress isEqualToString:@""] || addUserinfoaddress==nil) && ( [useraddress isEqualToString:@""]||useraddress==nil ) )
        {
            [AZNotification showNotificationWithTitle:RequiredUserChoiceAddress  controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
            return;
        }
        else
        {
            if([self validateTxtLength:userphonenumber withMessage:RequiredPhoneNumberForDot] && [self validateTxtLength:nameofuser withMessage:@"Name of user is required"])
            {
                if ([self validateEmailText:strEmail withMessage:InvalidEmail] && (strPassword.length == 0 ? YES : [self validateTxtLength:strPassword withMessage:RequiredPassword]))
                {
                    NSString *oadd;
                    if([addUserinfoaddress isEqualToString:@"1"])
                    {
                        oadd=objuserac.companyAddress;
                    }
                    else
                    {
                        if(useraddress.length==0)
                        {
                            oadd=objuserac.companyAddress;
                        }
                        else
                        {
                            oadd=useraddress;
                        }
                    }
                    NSString *imgstr=@"";
                    if(imageSelectedData!=nil)
                    {
                        imgstr=[Base64 encode:imageSelectedData];
                    }
                    else
                    {
                        imgstr=@"";
                    }
                    roltext=@"";
                    for(NSIndexPath *index in arrroleselected)
                    {
                        
                        NSString *eID =[NSString stringWithFormat:@"%ld",(long)index.row];
                        if([arrroleselected lastObject]!=index)
                        {
                            roltext = [roltext stringByAppendingString:[eID stringByAppendingString:@","]];
                        }
                        else
                        {
                            roltext = [roltext stringByAppendingString:eID];
                        }
                    }
                    if(roltext.length==0 || roltext == nil)
                    {
                        [AZNotification showNotificationWithTitle:RoleSelectionUpdateRequired controller:ROOTVIEW notificationType:AZNotificationTypeError];
                        return;
                    }
                    
                    if (!isConditionVerified)
                    {
                        [AZNotification showNotificationWithTitle:@"Please agree to terms and conditions before making changes" controller:ROOTVIEW notificationType:AZNotificationTypeError];
                        return;
                    }
                    
                    if ([[NetworkAvailability instance] isReachable])
                    {
                        @try
                        {
                            bool isChangePassword = strPassword.length > 0;
                            
                            NSDictionary *dicCreateAccount = @{
                                                               Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                                               Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                                               Req_User_role:roltext,
                                                               Req_Role:roltext,
                                                               Req_City:objuserac.city,
                                                               Req_State:objuserac.state,
                                                               Req_Country:objuserac.country,
                                                               Req_DotNumber:objuserac.dotNumber,
                                                               Req_McNumber:objuserac.mcNumber,
                                                               Req_CloseTime:@"",
                                                               Req_OpenTime:@"",
                                                               Req_CmpnyPhoneNo:objuserac.cmpnyPhoneNo,
                                                               Req_Office_Phone:objuserac.officePhoneNo,
                                                               Req_Phone_no:userphonenumber,
                                                               Req_CompanyName:objuserac.companyName,
                                                               Req_Office_name:objuserac.officeName,
                                                               Req_CompanyAddress:objuserac.companyAddress,
                                                               Req_OfficeAddress:objuserac.officeAddress,
                                                               Req_SecondaryEmailId:objuserac.secondaryEmailId,
                                                               Req_Ofiice_Fax:objuserac.officeFaxNo,
                                                               Req_OperatingAddress:oadd,
                                                               Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                                               Req_profile:imgstr,
                                                               Req_cstreet:objuserac.companyStreet,
                                                               Req_czip:objuserac.companyZip,
                                                               Req_Pref_id:objuserac.internalBaseClassIdentifier,
                                                               Req_firstname:nameofuser,
                                                               Req_dotstatus:objuserac.dotnumStatus,
                                                               Req_email:strEmail,
                                                               Req_secure_password:strPassword == nil ? @"" : strPassword,
                                                               @"is_password_changed":[NSNumber numberWithBool:isChangePassword],
                                                               @"company_id" : objuserac.companyId,
                                                               @"office_id" : objuserac.officeId,
                                                               @"is_condition_verified" : @"1"
                                                               };
                            [[WebServiceConnector alloc]
                             init:URLUpdateRoleAccount
                             withParameters:dicCreateAccount
                             withObject:self
                             withSelector:@selector(getUpdateUserAccountResponse:)
                             forServiceType:@"JSON"
                             showDisplayMsg:@"Updating User Details"
                             showProgress:YES];
                        }
                        @catch (NSException *exception) {
                            
                        }
                        
                    }
                    else
                    {
                        [self dismissHUD];
                        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
                    }
                }
            }
        }
    } 
    @catch (NSException *exception) {
        
    } 
}
-(IBAction)getUpdateUserAccountResponse:(id)sender
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
            [DefaultsValues removeObjectForKey:SavedDOTData];
            User *objUser = [[sender responseArray] objectAtIndex:0];
            [DefaultsValues setCustomObjToUserDefaults:objUser ForKey:SavedUserData];
            [DefaultsValues setStringValueToUserDefaults:objUser.internalBaseClassIdentifier ForKey:SavedUserId];
            [DefaultsValues setStringValueToUserDefaults:objUser.primaryEmailId ForKey:SavedUserEmail];
            [DefaultsValues setBooleanValueToUserDefaults:YES ForKey:SavedFlagUserRoleCreation];
            [_EditUserInfoVCProtocol reloadDetailsAfterEdit_User];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
#pragma mark - image picker controller delegate
-(void)openSelectionforimage: (id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                [self takePhoto];
                                //[self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                [self choosePhoto];
                                //[self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}
-(void) takePhoto{
    
    if (TARGET_IPHONE_SIMULATOR)
    {
        NSLog(@"App Running in Simulator");
    }
    else
    {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
}
-(void) choosePhoto
{
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    CellWelcomeUserInfo *cellselected=(CellWelcomeUserInfo*)[_tblUserinfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIImage *img = [Function scaleAndRotateImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    cellselected.imgUserPhoto.image=img;
    imageSelectedData=UIImageJPEGRepresentation(img, 0.5);
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.allowsEditing = NO;
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.navigationBar.barTintColor=[UIColor orangeColor];
    imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnbackclciked:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnRightClicked:(id)sender {
    [self.view endEditing:YES];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
@end
