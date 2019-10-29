//
//  EditOfficeInfoVC.m
//  Lodr
//
//  Created by c196 on 11/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "EditOfficeInfoVC.h"
#import "SearchCompanyVC.h"
#import "AdminChangeCell.h"
#import "CompanyRequest.h"
#import "CompanyAdmin.h"
#import "CompanyAdminRequestVC.h"

@interface EditOfficeInfoVC () <SearchCompanyVCDelegate, CompanyAdminRequestVCDelegate>
{
    NSMutableArray <CompanyRequest *>*arrRequests;

    NSString *strOfficeId;
    
    NSString *strOfficeLat;
    NSString *strOfficeLon;
    
    NSArray *nibHeader,*nibFooter;
    CellAccountHeader *tblheader;
    CellWelcomeFooter *tblFooter;
    UserAccount *objuserac;
    User *objuser;
    NSArray *arrOfficeCellFieldHeading;
    NSMutableArray *arrOfficeCellText;
    NSString *addressOerating,*issameascompnay;
    
    CompanyAdmin *objCompanyAdmin;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomVwRequests;
@property (weak, nonatomic) IBOutlet UILabel *lblRequestCaption;
@property (weak, nonatomic) IBOutlet UIButton *btnView;
@property (weak, nonatomic) IBOutlet UIButton *btnLater;

@end

@implementation EditOfficeInfoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
 
    NavigationBarHidden(YES);
    
    arrRequests = [[NSMutableArray alloc] init];
    
    _btnView.layer.cornerRadius = CGRectGetHeight(_btnView.frame) / 2;
    _btnView.clipsToBounds = YES;

    self.tblOfficeinfo.rowHeight = UITableViewAutomaticDimension;
    self.tblOfficeinfo.estimatedRowHeight = 105;
    arrOfficeCellText = [NSMutableArray new];
   
    arrOfficeCellFieldHeading = [NSArray arrayWithObjects:@"Office Phone Number", @"Office Fax Number", nil];
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    
    if (objuser.userAccount.count > 0)
    {
        objuserac = [objuser.userAccount objectAtIndex:0];

        strOfficeId = objuserac.officeId;

        strOfficeLat = objuserac.officeLatitude;
        strOfficeLon = objuserac.officeLongitude;
        
        if ((bool)objuserac.isOfficeAdmin)
        {
            [self fetchCompanyAdminRequests];
        }
        else
        {
            [self fetchCompanyDetails];
        }
    }
    
    [arrOfficeCellText addObject:objuserac.officePhoneNo];
    [arrOfficeCellText addObject:objuserac.officeFaxNo];
    
    if ([objuserac.officeAddress isEqualToString:objuserac.companyAddress])
    {
        issameascompnay = @"1";
    }
    else
    {
        issameascompnay = @"0";
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

- (void)fetchCompanyAdminRequests
{
    if (strOfficeId == nil)
    {
        return;
    }
    
    [self showHUD:@"Fetching company admin requests"];
    
    if ([[NetworkAvailability instance] isReachable])
    {
        NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
        [dicParam setValue:strOfficeId forKey:@"office_id"];
        [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:@"user_id"];
        
        [[WebServiceConnector alloc] init:URLFetchOfficeAdminRequests
                           withParameters:dicParam
                               withObject:self
                             withSelector:@selector(getCompanyAdminRequestResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:@"Requesting office admin requests"
                             showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

- (IBAction)getCompanyAdminRequestResponse:(id)sender
{
    [self dismissHUD];
    
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:Msg101 controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
    }
    else
    {
        if ([APIResponseStatus isEqualToString:APISuccess])
        {
            NSArray *arrRequest = [sender responseArray];
            [arrRequests addObjectsFromArray:arrRequest];
            
            if (arrRequests.count > 0)
            {
                _lblRequestCaption.text = [NSString stringWithFormat:@"You have %ld office admin change requests. Would you like to view same?", arrRequests.count];

                _bottomVwRequests.constant = 0.0f;
                [UIView animateWithDuration:0.5 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

- (void)fetchCompanyDetails
{
    [self.view endEditing:YES];
    
    [self showHUD:@"Fetching company details"];
    
    if ([[NetworkAvailability instance] isReachable])
    {
        NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
        [dicParam setValue:strOfficeId forKey:@"office_id"];
        [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:@"user_id"];
        
        [[WebServiceConnector alloc] init:URLFetchOfficeAdmin
                           withParameters:dicParam
                               withObject:self
                             withSelector:@selector(getCompanyDetailsResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:@"Requesting company details"
                             showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

- (IBAction)getCompanyDetailsResponse:(id)sender
{
    [self dismissHUD];
    
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:Msg101 controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
    }
    else
    {
        if ([APIResponseStatus isEqualToString:APISuccess])
        {
            objCompanyAdmin = [[CompanyAdmin alloc] initWithDictionary:[[sender responseDict] valueForKey:@"CompanyAdmin"]];
            [_tblOfficeinfo reloadData];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

- (IBAction)btnViewReqsClicked:(id)sender
{
    [self.view endEditing:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self btnLaterClicked:nil];
    });
    CompanyAdminRequestVC *vc = initVCToRedirect(SBSEARCH, Company_Admin_Request_VC);
    vc.delegate = self;
    vc.arrRequests = [[NSMutableArray alloc] init];
    vc.arrRequests = arrRequests;
    vc.strCompanyId = strOfficeId;
    vc.selRequestType = RequestTypeOffice;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnLaterClicked:(id)sender
{
    [self.view endEditing:YES];
    
    _bottomVwRequests.constant = -125.0f;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)btnChangeClicked:(id)sender {
    [self.view endEditing:true];
    
    UIAlertController *alertConfirm = [UIAlertController alertControllerWithTitle:@"Main Office Admin"
                                                                          message:@"Confirm you will be Admin?"
                                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *btnConfirm = [UIAlertAction actionWithTitle:@"Yes"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           [self requestAdminChange];
                                                       }];
    
    UIAlertAction *btnCancel = [UIAlertAction actionWithTitle:@"No"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          
                                                      }];
    
    [alertConfirm addAction:btnConfirm];
    [alertConfirm addAction:btnCancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertConfirm animated:YES completion:nil];
    });
}

- (void)requestAdminChange
{
    [self.view endEditing:YES];
    
    [self showHUD:@"Requesting Admin Change ..."];
    
    if ([[NetworkAvailability instance] isReachable])
    {
        NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
        [dicParam setValue:strOfficeId forKey:@"office_id"];
        [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:@"user_id"];
        [dicParam setValue:objuser.primaryEmailId forKey:@"email"];
        
        [[WebServiceConnector alloc] init:URLRequestOfficeAdminChange
                           withParameters:dicParam
                               withObject:self
                             withSelector:@selector(companyAdminChangeResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:@"Requesting Admin Change ..."
                             showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

- (IBAction)companyAdminChangeResponse:(id)sender
{
    [self dismissHUD];
    
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:Msg101 controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
    }
    else
    {
        if ([APIResponseStatus isEqualToString:APISuccess])
        {
            UIAlertController *alertConfirm = [UIAlertController alertControllerWithTitle:@"Office Admin Change"
                                                                                  message:@"Request has been sent successfully."
                                                                           preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *btnOk = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self fetchCompanyDetails];
                                                          }];
            
            [alertConfirm addAction:btnOk];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alertConfirm animated:YES completion:nil];
            });
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

- (void)didAcceptRequest {
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    
    if (objuser.userAccount.count > 0)
    {
        objuserac = [objuser.userAccount objectAtIndex:0];
        objuserac.isOfficeAdmin = 0;
    }
    
    [self fetchCompanyDetails];
    
    [_tblOfficeinfo reloadData];
}


#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (objCompanyAdmin != nil)
    {
        NSNumber *adminId = [NSNumber numberWithDouble:objCompanyAdmin.adminId];
        
        if ([adminId stringValue] != objuser.internalBaseClassIdentifier)
        {
            return arrOfficeCellFieldHeading.count + 1;
        }
    }
    
    return arrOfficeCellFieldHeading.count;
}

- (IBAction)textFieldDidChange:(UITextField *)sender
{
    objuserac.officeName = sender.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 604)
    {
        [arrOfficeCellText replaceObjectAtIndex:0 withObject:textField.text];
    }
    else if (textField.tag == 605)
    {
        [arrOfficeCellText replaceObjectAtIndex:1 withObject:textField.text];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length > 0)
    {
        [tblheader.btnSameAsComapnyAddressCheckbox setImage:imgNamed(@"checkboxsquare")  forState:UIControlStateNormal];
        
        if (textView.tag == 800)
        {
            addressOerating = textView.text;
        }
        
        issameascompnay = @"0";
    }
    else
    {
        [tblheader.btnSameAsComapnyAddressCheckbox setImage:imgNamed(@"checkboxsquareselected")  forState:UIControlStateNormal];
        addressOerating=@"";
        issameascompnay=@"1";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tblheader == nil)
    {
        nibHeader = [[NSBundle mainBundle] loadNibNamed:@"CellAccountHeader" owner:self options:nil];
        tblheader = [[CellAccountHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblOfficeinfo.frame.size.width, 520)];
        tblheader = (CellAccountHeader *)[nibHeader objectAtIndex:1];
    }
    
    [tblheader.btnSearch addTarget:self action:@selector(btnSearchClicked:) forControlEvents:UIControlEventTouchUpInside];
    tblheader.txtOfficeName.text = objuserac.officeName;
    [tblheader.txtOfficeName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidEnd];
    
    tblheader.cellAccountHeaderDelegate = self;
    tblheader.heigthlblpagename.constant = 50;
    tblheader.lblOfiiceInfoText.clipsToBounds = YES;
    tblheader.heightHeaderHeading.constant = 165;
    tblheader.heightOfficeIHeader.constant = 255;
    tblheader.vwHeaderOfficeInfo.clipsToBounds = YES;
    tblheader.vwWithHeadingText.clipsToBounds = YES;
    tblheader.lblLargeTitle.text = @"My Account";
    tblheader.lblSubtitleSmall.text = @"Setup your account information";
    tblheader.lblOfiiceInfoText.text = @"YOUR OFFICE / HUB INFO";
    tblheader.txtOperatingAddress.tag = 800;
    tblheader.btnSameAsComapnyAddressCheckbox.tag = 701;
    tblheader.txtOperatingAddress.delegate = self;
    tblheader.txtOperatingAddress.text = objuserac.officeAddress;
    
    if (addressOerating.length > 0)
    {
        tblheader.txtOperatingAddress.text = addressOerating;
    }
    else
    {
        tblheader.txtOperatingAddress.text = objuserac.officeAddress;
    }
    
    if (![issameascompnay isEqualToString:@"1"] || ![objuserac.officeAddress isEqualToString:addressOerating])
    {
        [tblheader.btnSameAsComapnyAddressCheckbox setImage:imgNamed(@"checkboxsquare")  forState:UIControlStateNormal];
    }
    else
    {
        [tblheader.btnSameAsComapnyAddressCheckbox setImage:imgNamed(@"checkboxsquareselected") forState:UIControlStateNormal];
    }
    
    if ([objuserac.officeAddress isEqualToString:objuserac.companyAddress])
    {
        [tblheader.btnSameAsComapnyAddressCheckbox setImage:imgNamed(@"checkboxsquareselected")  forState:UIControlStateNormal];
        tblheader.txtOperatingAddress.text=@"";
    }
    
    if ((bool)objuserac.isOfficeAdmin)
    {
        tblheader.btnSearch.hidden = YES;
        tblheader.txtOfficeName.enabled = NO;
    }
    else
    {
        tblheader.txtOfficeName.enabled = _isOfficeFieldEnabled;
        tblheader.txtOperatingAddress.editable = _isOfficeFieldEnabled;
    }
    
    return tblheader;
}

- (IBAction)btnSearchClicked:(id)sender
{
    SearchCompanyVC *vc = initVCToRedirect(SBSEARCH, SEARCHCOMPANYVC);
    vc.delegate = self;
    vc.selectedSearchType = SearchDetailsTypeOffice;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectCompany:(OfficeDetails *)companyDetails
{
    if ([companyDetails.officeLatitude isEqualToString:@""])
    {
        strOfficeLat = @"";
        strOfficeLon = @"";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [AZNotification showNotificationWithTitle:@"Please select place from location icon" controller:self notificationType:AZNotificationTypeError];
        });
    }
    else
    {
        strOfficeLat = companyDetails.officeLatitude;
        strOfficeLon = companyDetails.officeLongitude;
    }

    _isOfficeFieldEnabled = NO;
    strOfficeId = [NSString stringWithFormat:@"%ld", (NSInteger)companyDetails.officeId];
    objuserac.officeName = companyDetails.officeName;
    objuserac.officeFaxNo = companyDetails.officeFaxNo;
    objuserac.officeAddress = companyDetails.officeAddress;
    objuserac.phoneNo = companyDetails.officePhoneNo;
    [_tblOfficeinfo reloadData];
}

- (void)didSelectAddNewCompany:(BOOL)isCompany
{
    strOfficeLat = @"";
    strOfficeLon = @"";
    
    _isOfficeFieldEnabled = YES;
    strOfficeId = @"0";
    [_tblOfficeinfo reloadData];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tblheader.txtOfficeName becomeFirstResponder];
    });
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    if (tblFooter == nil)
    {
        nibFooter = [[NSBundle mainBundle] loadNibNamed:@"welcomeFooter" owner:self options:nil];
        tblFooter = [[CellWelcomeFooter alloc] initWithFrame:CGRectMake(0, 0, self.tblOfficeinfo.frame.size.width, 320)];
        tblFooter = (CellWelcomeFooter *)[nibFooter objectAtIndex:0]; 
        tblFooter.cellWelcomeFooterDelegate=self;
        [tblFooter.brnSummaryRegister setTitle:@"UPDATE OFFICE INFO" forState:UIControlStateNormal];
    }
    
    tblFooter.heightvwWelocmeFooter.constant=0;
    tblFooter.heightOfficeFooter.constant=0;
    tblFooter.heightcmpnyFooter.constant=0;
    tblFooter.vwWelcomeFoooter.clipsToBounds=YES;
    tblFooter.vwFootercompany.clipsToBounds=YES;
    tblFooter.vwOfficeInfoFooter.clipsToBounds=YES;
    tblFooter.heightSummaryFooter.constant=150;
    
    return tblFooter;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    @try
    {
        if (indexPath.row == arrOfficeCellFieldHeading.count)
        {
            static NSString *cellIdentifier = @"idAdminChangeCell";
            
            AdminChangeCell *cell = (AdminChangeCell*)[_tblOfficeinfo dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AdminChangeCell class]) owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.lblTitle.text = @"Main Office Admin";
            
            cell.lblRequest.text = @"";
            cell.bottomLblRequest.constant = 0.0f;
            
            if (objCompanyAdmin != nil)
            {
                if ([objCompanyAdmin.isRequested isEqualToString:@"1"]) {
                    cell.btnChange.hidden = NO;
                    
                    cell.lblRequest.text = @"The request is pending";
                    cell.bottomLblRequest.constant = 10.5f;

                } else  {
                    cell.btnChange.hidden = NO;
                }
                
                cell.txtAdmin.text = objCompanyAdmin.primaryEmailId;
            }
            else
            {
                cell.btnChange.hidden = YES;
            }
            
            [cell.btnChange addTarget:self action:@selector(btnChangeClicked:) forControlEvents:UIControlEventTouchUpInside];

            return cell;
        }
        
        DOTDetails *objDot;
        
        if ([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData] != nil)
        {
            objDot = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData];
        }
        
        static NSString *cellIdentifier = @"CellTextfields";
        
        CellTextfields *cell = (CellTextfields*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.txtcellText.tag = 604 + indexPath.row;
        cell.lbltxtCellHeading.text = [arrOfficeCellFieldHeading objectAtIndex:indexPath.row];
        
        if ([cell.lbltxtCellHeading.text containsString:@"Office"])
        {
            cell.lbltxtCellHeading.textAlignment=NSTextAlignmentCenter;
            cell.txtcellText.userInteractionEnabled=YES;
            cell.txtcellText.keyboardType=UIKeyboardTypeNumberPad;
            cell.txtcellText.delegate=self;
        }
        else
        {
            cell.lbltxtCellHeading.textAlignment=NSTextAlignmentLeft;
            cell.txtcellText.userInteractionEnabled=NO;
            cell.txtcellText.keyboardType=UIKeyboardTypeASCIICapable;
        }
        cell.txtcellText.text=[arrOfficeCellText objectAtIndex:indexPath.row];
        
        if ((bool)objuserac.isOfficeAdmin)
        {
            
        }
        else
        {
            cell.txtcellText.enabled = _isOfficeFieldEnabled;
        }
        
        return cell;
    }
    @catch (NSException *exception)
    {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 800;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{
    return 150;
}

- (IBAction)btnOpetingAddressClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedSetWelcomeScreenAddress object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSelectedWelcomeLocation:) name:NCNamedSetWelcomeScreenAddress object:nil];
    [self.view endEditing:YES];
    SPGooglePlacesAutocompleteViewController *googlePlacesVC = [[SPGooglePlacesAutocompleteViewController alloc] init];
    googlePlacesVC.requestMapFor=@"WelcomeScreenOperatingAddress";
    CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
    [floatingController setFrameColor:[UIColor whiteColor]];
    UIWindow *window1 = [[UIApplication sharedApplication] keyWindow];
    UIView *rootView = [window1.rootViewController view];
    [floatingController showInView:rootView
         withContentViewController:googlePlacesVC
                          animated:YES];
}
-(void)setSelectedWelcomeLocation:(NSNotification *)anote
{
    NSDictionary *dict = anote.userInfo;
    NSString *requestAddressType=[NSString stringWithFormat:@"%@",[dict objectForKey:@"AddressType"]];
    if([requestAddressType isEqualToString:@"WelcomeScreenOperatingAddress"])
    {
        UITextView *textFieldDot = (UITextView*)[self.view viewWithTag:800];
        NSDictionary *dict = anote.userInfo;
        textFieldDot.text=[dict objectForKey:@"SelectedAddress"];
        addressOerating=textFieldDot.text;
        
        if ([dict objectForKey:@"AddressLatitude"])
        {
            strOfficeLat = [dict objectForKey:@"AddressLatitude"];
            strOfficeLon = [dict objectForKey:@"AddressLongitude"];
        }
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedSetWelcomeScreenAddress object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedDismissView object:self];
}

- (IBAction)btnSameAsCompanyCheckboxClicked:(id)sender
{
    if (!objuserac.isOfficeAdmin)
    {
        return;
    }
    
    UIButton *senderbtn=(UIButton*)sender;
    senderbtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    if([issameascompnay isEqualToString:@"1"])
    {
        [senderbtn setImage:imgNamed(@"checkboxsquare")  forState:UIControlStateNormal];
        senderbtn.accessibilityLabel=@"0";
        issameascompnay=@"0";
        
    }
    else
    {
        [senderbtn setImage:imgNamed(@"checkboxsquareselected")  forState:UIControlStateNormal];
        senderbtn.accessibilityLabel=@"1";
        issameascompnay=@"1";
    }
}
- (IBAction)btnSummaryRegisterClicked:(id)sender
{
    @try 
    {
        if(([issameascompnay isEqualToString:@"0"] || [issameascompnay isEqualToString:@""] || issameascompnay==nil) && ( [addressOerating isEqualToString:@""]||addressOerating==nil ) )
        {
            [AZNotification showNotificationWithTitle:RequiredChoiceAddress  controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
            return;
        }
        else
        {
            NSString *oadd;
            if(addressOerating.length==0)
            {
                oadd=objuserac.companyAddress;
            }
            else
            {
                oadd=addressOerating;
            }
            
            if ([strOfficeLat isEqualToString:@""] || !strOfficeLat)
            {
                [AZNotification showNotificationWithTitle:@"Please select place from location icon" controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
                return;
            }
            
            UITextField *officephone=(UITextField *)[self.view viewWithTag:604];
            if([self validateTxtLength:officephone.text withMessage:RequiredPhoneNumberForDot])
            {
                if([[NetworkAvailability instance]isReachable])
                {
                    @try
                    {
                        NSDictionary *dicCreateAccount = @{
                                                           Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                                           Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                                           Req_User_role:objuserac.role,
                                                           Req_Role:objuserac.role,
                                                           Req_City:objuserac.city,
                                                           Req_State:objuserac.state,
                                                           Req_Country:objuserac.country,
                                                           Req_DotNumber:objuserac.dotNumber,
                                                           Req_McNumber:objuserac.mcNumber,
                                                           Req_CloseTime:@"",
                                                           Req_OpenTime:@"",
                                                           Req_CmpnyPhoneNo:objuserac.cmpnyPhoneNo,
                                                           Req_Office_Phone:[arrOfficeCellText objectAtIndex:0],
                                                           Req_Phone_no:objuserac.phoneNo,
                                                           Req_CompanyName:objuserac.companyName,
                                                           Req_Office_name:objuserac.officeName,
                                                           Req_CompanyAddress:objuserac.companyAddress,
                                                           Req_OfficeAddress:oadd,
                                                           Req_SecondaryEmailId:objuserac.secondaryEmailId,
                                                           Req_Ofiice_Fax:[arrOfficeCellText objectAtIndex:1],
                                                           Req_OperatingAddress:objuserac.operatingAddress,
                                                           Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                                           Req_profile:@"",
                                                           Req_cstreet:objuserac.companyStreet,
                                                           Req_czip:objuserac.companyZip,
                                                           Req_Pref_id:objuserac.internalBaseClassIdentifier,
                                                           Req_firstname:objuser.firstname,
                                                           Req_dotstatus:objuserac.dotnumStatus,
                                                           @"company_id" : objuserac.companyId,
                                                           @"office_id" : strOfficeId,
                                                           @"office_latitude" : strOfficeLat,
                                                           @"office_longitude" : strOfficeLon
                                                           };
                        
//                        [dicParam setValue:strOfficeLat forKey:@"office_latitude"];
//                        [dicParam setValue:strOfficeLon forKey:@"office_longitude"];

                        [[WebServiceConnector alloc]
                         init:URLUpdateRoleAccount
                         withParameters:dicCreateAccount
                         withObject:self
                         withSelector:@selector(getUpdateOfficeResponse:)
                         forServiceType:@"JSON"
                         showDisplayMsg:@"Updating Office Details"
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
    @catch (NSException *exception) {
        
    } 
}
-(IBAction)getUpdateOfficeResponse:(id)sender
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
            [_EditOfficeInfoVCProtocol reloadDetailsAfterEdit_Office];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
- (IBAction)btnSummaryBackClicked:(id)sender 
{
    [DefaultsValues removeObjectForKey:SavedDOTData];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnBackClicked:(id)sender 
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnDrawerClicked:(id)sender {
    [self.view endEditing:YES];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
@end
