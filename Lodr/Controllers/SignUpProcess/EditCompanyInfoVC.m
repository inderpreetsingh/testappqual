//
//  EditCompanyInfoVC.m
//  Lodr
//
//  Created by c196 on 11/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "EditCompanyInfoVC.h"
#import "SearchCompanyVC.h"
#import "CompanyAdminRequestVC.h"
#import "AdminChangeCell.h"
#import "CompanyAdmin.h"
#import "CompanyRequest.h"
#import "AvailabilityCell.h"

typedef enum
{
    AssetAvailabilityUnlimited = 2001,
    AssetAvailabilityUSCanada,
    AssetAvailabilityUSInterstate,
    AssetAvailabilityUSIntrastate
}AssetAvailability;

@interface EditCompanyInfoVC () <SearchCompanyVCDelegate, CompanyAdminRequestVCDelegate>
{
    NSMutableArray <CompanyRequest *>*arrRequests;
    
    NSString *strOldCompanyId, *strCompanyId;
    OfficeDetails *objOfficeDetails;
    
    NSArray *nibHeader, *nibFooter;
    CellAccountHeader *tblheader;
    CellWelcomeFooter *tblFooter;
    UserAccount *objuserac;
    User *objuser;
    CompanyAdmin *objCompanyAdmin;
    NSMutableArray *stateSelected, *arrstatelist, *arrroleselected;
    ZSYPopoverListView *listView;
    UIView *overlay, *overlayview;
    NSString *roltext;
    
    AssetAvailability selectedAvailability;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomVwRequests;
@property (weak, nonatomic) IBOutlet UILabel *lblRequestCaption;
@property (weak, nonatomic) IBOutlet UIButton *btnView;
@property (weak, nonatomic) IBOutlet UIButton *btnLater;

@end

@implementation EditCompanyInfoVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    NavigationBarHidden(YES);
    
    stateSelected = [NSMutableArray new];
    arrRequests = [[NSMutableArray alloc] init];
    
    NSInteger intSelectedAvailablility = [DefaultsValues getIntegerValueFromUserDefaults_ForKey:SavedAvailability];
    selectedAvailability = ((AssetAvailability)intSelectedAvailablility) + AssetAvailabilityUnlimited;
    
    _btnView.layer.cornerRadius = CGRectGetHeight(_btnView.frame) / 2;
    _btnView.clipsToBounds = YES;
    
    self.tblCompanyInfo.rowHeight = UITableViewAutomaticDimension;
    self.tblCompanyInfo.estimatedRowHeight = 960;
    
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    
    if (objuser.userAccount.count > 0)
    {
        objuserac = [objuser.userAccount objectAtIndex:0];
        
        strOldCompanyId = objuserac.companyId;
        strCompanyId = objuserac.companyId;

        if ((bool)objuserac.isCompanyAdmin)
        {
            [self fetchCompanyAdminRequests];
        }
        else
        {
            [self fetchCompanyDetails];
        }
    }
    
    roltext = objuserac.role;
    _strMcNumber = objuserac.mcNumber;
    
    arrroleselected = [NSMutableArray new];

    if ([roltext containsString:@"1"])
    {
        [arrroleselected addObject:@"1"];
    }
    if ([roltext containsString:@"2"])
    {
        [arrroleselected addObject:@"2"];
    }
    if ([roltext containsString:@"3"])
    {
        [arrroleselected addObject:@"3"];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)fetchCompanyAdminRequests
{
    if (strCompanyId == nil)
    {
        return;
    }
    
    [self showHUD:@"Fetching company admin requests"];
    
    if ([[NetworkAvailability instance] isReachable])
    {
        NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
        [dicParam setValue:strCompanyId forKey:@"company_id"];
        [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:@"user_id"];
        
        [[WebServiceConnector alloc] init:URLFetchCompanyAdminRequests
                           withParameters:dicParam
                               withObject:self
                             withSelector:@selector(getCompanyAdminRequestResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:@"Requesting company admin requests"
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
                _lblRequestCaption.text = [NSString stringWithFormat:@"You have %ld company admin change requests. Would you like to view same?", arrRequests.count];
                
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
        [dicParam setValue:strCompanyId forKey:@"company_id"];
        [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:@"user_id"];

        [[WebServiceConnector alloc] init:URLFetchCompanyAdmin
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
            [_tblCompanyInfo reloadData];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

- (IBAction)btnChangeClicked:(id)sender {
    [self.view endEditing:true];
    
    UIAlertController *alertConfirm = [UIAlertController alertControllerWithTitle:@"Main Company Admin"
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
        [dicParam setValue:strCompanyId forKey:@"company_id"];
        [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:@"user_id"];
        [dicParam setValue:objuser.primaryEmailId forKey:@"email"];
        
        [[WebServiceConnector alloc] init:URLRequestCompanyAdminChange
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
            UIAlertController *alertConfirm = [UIAlertController alertControllerWithTitle:@"Company Admin Change"
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
    vc.strCompanyId = strCompanyId;
    vc.selRequestType = RequestTypeCompany;
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

- (void)didAcceptRequest {
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    
    if (objuser.userAccount.count > 0)
    {
        objuserac = [objuser.userAccount objectAtIndex:0];
        objuserac.isCompanyAdmin = 0;
    }
    
    [self fetchCompanyDetails];
    
    [_tblCompanyInfo reloadData];
}

#pragma mark - Keyboard Events

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (objCompanyAdmin != nil)
    {
        NSNumber *adminId = [NSNumber numberWithDouble:objCompanyAdmin.adminId];
        
        if ([adminId stringValue] != objuser.internalBaseClassIdentifier)
        {
            return 3;
        }
    }
    
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    nibHeader = [[NSBundle mainBundle] loadNibNamed:@"CellAccountHeader" owner:self options:nil];
    
    tblheader = [[CellAccountHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblCompanyInfo.frame.size.width, 420)];
    tblheader = (CellAccountHeader *)[nibHeader objectAtIndex:0];
    
    tblheader.cellAccountHeaderDelegate = self;
    tblheader.heightOperatingAddress.constant = 0;
    tblheader.heigthlblpagename.constant = 50;
    tblheader.lblOfiiceInfoText.clipsToBounds = YES;
    tblheader.lblLargeTitle.text = @"My Account";
    tblheader.lblSubtitleSmall.text = @"Setup your account information";
    tblheader.lblOfiiceInfoText.text = @"YOUR COMPANY INFO";
    tblheader.heightHeaderHeading.constant = 165;
    tblheader.heightOfficeIHeader.constant = 0;
    tblheader.vwHeaderOfficeInfo.clipsToBounds = YES;
    
    return tblheader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    nibFooter = [[NSBundle mainBundle] loadNibNamed:@"welcomeFooter" owner:self options:nil];
    
    tblFooter = [[CellWelcomeFooter alloc] initWithFrame:CGRectMake(0, 0, self.tblCompanyInfo.frame.size.width, 320)];
    tblFooter = (CellWelcomeFooter *)[nibFooter objectAtIndex:0];
    
    tblFooter.cellWelcomeFooterDelegate = self;
    tblFooter.heightvwWelocmeFooter.constant = 0;
    tblFooter.heightOfficeFooter.constant = 0;
    tblFooter.heightcmpnyFooter.constant = 0;
    tblFooter.vwWelcomeFoooter.clipsToBounds = YES;
    tblFooter.vwFootercompany.clipsToBounds = YES;
    tblFooter.vwOfficeInfoFooter.clipsToBounds = YES;
    tblFooter.heightSummaryFooter.constant = 150;
    [tblFooter.brnSummaryRegister setTitle:@"UPDATE COMPANY INFO" forState:UIControlStateNormal];
    
    return tblFooter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        @try
        {
            DOTDetails *objDot;
            
            if ([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData] != nil)
            {
                objDot = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData];
            }
            
            static NSString *cellIdentifier = @"CellMyAccountData";
            
            CellMyAccountData *cell = (CellMyAccountData*)[_tblCompanyInfo dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.btnEditdot.hidden = false;
            cell.cellMyAccountDataDelegate = self;
            
            if ([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData] != nil)
            {
                cell.txtDotNumber.text = objDot.dotNumber;
                cell.txtmcnumber.text = objDot.mcNumber;
                cell.txtCompanyName.text = objDot.legalName;
                cell.txtstreet.text = objDot.phyStreet;
                cell.txtcity.text = objDot.phyCity;
                cell.txtzip.text = objDot.phyZipcode;
                cell.txtstate.text = objDot.phyState;
                cell.txtPhone.text = objDot.phoneNumber;
                [cell.btnStatename setTitle:objDot.phyState forState:UIControlStateNormal];
            }
            else
            {
                cell.txtDotNumber.text = objuserac.dotNumber;
                cell.txtmcnumber.text = objuserac.mcNumber;
                cell.txtCompanyName.text = objuserac.companyName;
                cell.txtstreet.text = objuserac.companyStreet;
                cell.txtcity.text = objuserac.city;
                cell.txtzip.text = objuserac.companyZip;
                cell.txtstate.text = objuserac.state;
                cell.txtPhone.text = objuserac.cmpnyPhoneNo;
                [cell.btnStatename setTitle:objuserac.state forState:UIControlStateNormal];
            }
            
            cell.txtmcnumber.text = _strMcNumber;
            
            if ([arrroleselected containsObject:@"3"])
            {
                [[cell.contentView viewWithTag:2001] setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                [cell.contentView viewWithTag:2001].backgroundColor=[UIColor orangeColor];
                [cell.contentView viewWithTag:2001].layer.borderWidth=0.0f;
            }
            else
            {
                [[cell.contentView viewWithTag:2001] setImage:nil forState:UIControlStateNormal];
                [cell.contentView viewWithTag:2001].backgroundColor=[UIColor whiteColor];
                [cell.contentView viewWithTag:2001].layer.borderWidth=1.0f;
            }
            
            if ([arrroleselected containsObject:@"2"])
            {
                [[cell.contentView viewWithTag:2002] setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                [cell.contentView viewWithTag:2002].backgroundColor=[UIColor orangeColor];
                [cell.contentView viewWithTag:2002].layer.borderWidth=0.0f;
            }
            else
            {
                [[cell.contentView viewWithTag:2002] setImage:nil forState:UIControlStateNormal];
                [cell.contentView viewWithTag:2002].backgroundColor=[UIColor whiteColor];
                [cell.contentView viewWithTag:2002].layer.borderWidth=1.0f;
            }
            
            
            [cell.btnShipper addTarget:self action:@selector(btnShipperClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnCarrier addTarget:self action:@selector(btnCarrierClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.txtCompanyName.enabled = _isCompanyFieldEnabled;
            
            if ((bool)objuserac.isCompanyAdmin)
            {
                cell.btnSearchCompany.hidden = YES;
            }
            else
            {
                cell.btnSearchCompany.hidden = NO;

                cell.txtstreet.enabled = _isCompanyFieldEnabled;
                cell.txtcity.enabled = _isCompanyFieldEnabled;
                cell.txtstate.enabled = _isCompanyFieldEnabled;
                cell.txtzip.enabled = _isCompanyFieldEnabled;
                cell.txtPhone.enabled = _isCompanyFieldEnabled;
                cell.btnStatename.enabled = _isCompanyFieldEnabled;
            }
            
            if (objuserac.reqCompanyName.length > 0)
            {
                cell.lblOldCompany.hidden = NO;
                cell.lblNewCompany.hidden = NO;
                cell.txtNewCompany.hidden = NO;
                cell.lblCompanyDesc.hidden = YES;
                cell.btnSearchCompany.hidden = YES;
                
                cell.txtCompanyName.text = objuserac.oldCompanyName;
                cell.txtNewCompany.text = objuserac.reqCompanyName;
            }
            else
            {
                cell.lblOldCompany.hidden = YES;
                cell.lblNewCompany.hidden = YES;
                cell.txtNewCompany.hidden = YES;
                cell.lblCompanyDesc.hidden = NO;
            }
            
            return cell;
        }
        @catch (NSException *exception) { }
    } else if (indexPath.row == 1) {
        static NSString *cellIdentifier = @"idAvailabilityCell";
        
        AvailabilityCell *cell = (AvailabilityCell*)[_tblCompanyInfo dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AvailabilityCell class]) owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [self clearAvailabilityForCell:cell];
        [self manageAvailability:selectedAvailability forCell:cell];
        
        [cell.btnAvailabilityUnlimited addTarget:self action:@selector(btnAvailabilityClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnAvailabilityUSCanada addTarget:self action:@selector(btnAvailabilityClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnAvailabilityInterstate addTarget:self action:@selector(btnAvailabilityClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnAvailabilityIntrastate addTarget:self action:@selector(btnAvailabilityClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    } else  {
        static NSString *cellIdentifier = @"idAdminChangeCell";
        
        AdminChangeCell *cell = (AdminChangeCell*)[_tblCompanyInfo dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AdminChangeCell class]) owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
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
}

- (IBAction)btnAvailabilityClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    AvailabilityCell *cell = [_tblCompanyInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    [self clearAvailabilityForCell:cell];
    [self manageAvailability:(AssetAvailability)[sender tag] forCell:cell];
    
    selectedAvailability = (AssetAvailability)[sender tag] - AssetAvailabilityUnlimited;
    NSLog(@"%u", selectedAvailability);
    //    dispatch_async(dispatch_get_main_queue(), ^{
    [DefaultsValues setIntegerValueToUserDefaults:selectedAvailability ForKey:SavedAvailability];
    //    });
}

- (void)manageAvailability:(AssetAvailability)assetAvailability forCell:(AvailabilityCell *)cell
{
    UIButton *btnAvailability = ((UIButton *)[cell.contentView viewWithTag:assetAvailability + 1000]);
    
    [btnAvailability setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
    btnAvailability.backgroundColor = [UIColor orangeColor];
    btnAvailability.layer.borderWidth = 0.0f;
}

- (void)clearAvailabilityForCell:(AvailabilityCell *)cell
{
    UIButton *btn1 = ((UIButton *)[cell.contentView viewWithTag:3001]);
    UIButton *btn2 = ((UIButton *)[cell.contentView viewWithTag:3002]);
    UIButton *btn3 = ((UIButton *)[cell.contentView viewWithTag:3003]);
    UIButton *btn4 = ((UIButton *)[cell.contentView viewWithTag:3004]);
    
    [btn1 setImage:nil forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor whiteColor];
    btn1.layer.borderWidth = 1.0f;
    
    [btn2 setImage:nil forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor whiteColor];
    btn2.layer.borderWidth = 1.0f;
    
    [btn3 setImage:nil forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor whiteColor];
    btn3.layer.borderWidth = 1.0f;
    
    [btn4 setImage:nil forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor whiteColor];
    btn4.layer.borderWidth = 1.0f;
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

- (IBAction)btnstatenameclicked:(id)sender
{
    arrstatelist = [NSMutableArray new];
    arrstatelist = [self getUsStates];
    listView = [self showListView:listView withSelectiontext:@"Select State" widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT-100];
    [listView show];
}

- (ZSYPopoverListView *)showListView:(ZSYPopoverListView *)listviewname withSelectiontext:(NSString *)selectionm widthval:(CGFloat)w heightval:(CGFloat)h
{
    listviewname.backgroundColor = [UIColor whiteColor];
    listviewname = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    listviewname.center = self.view.center;
    listviewname.titleName.backgroundColor = [UIColor whiteColor];
    listviewname.titleName.text = [NSString stringWithFormat:@"%@",@"Select State"];
    listviewname.datasource = self;
    listviewname.delegate = self;
    listviewname.layer.cornerRadius = 3.0f;
    listviewname.calledFor = @"Select State";
    listviewname.clipsToBounds = YES;
    
    [listviewname setDoneButtonWithTitle:@"" block:^{
        
        [overlayview removeFromSuperview];
    }];
    
    [listviewname setCancelButtonTitle:@"Done" block:^{
        
        [overlayview removeFromSuperview];
        
        CellMyAccountData *cell = [_tblCompanyInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        for (NSIndexPath *index in stateSelected)
        {
            [cell.btnStatename setTitle:[arrstatelist objectAtIndex:index.row] forState:UIControlStateNormal];
        }
    }];
    
    [self addOverlay];
    
    [self.view endEditing:YES];
    
    return listviewname;
}

- (void)addOverlay
{
    overlayview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT)];
    [overlayview setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    UITapGestureRecognizer *overlayTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(onOverlayTapped)];
    [overlayview addGestureRecognizer:overlayTap];
    [self.view.window addSubview:overlayview];
}
- (void)onOverlayTapped
{
    @try {
        [UIView animateWithDuration:0.2f animations:^{
            overlayview.alpha=0;
            [listView dismiss];
        }completion:^(BOOL finished) {
            [overlayview removeFromSuperview];
        }];
    } @catch (NSException *exception) {
        
    } 
    
}


- (IBAction)btnShipperClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    id superView = [sender superview];
    sender = [superView viewWithTag:2001];
    
    if (sender)
    {
        if ([arrroleselected containsObject:@"3"])
        {
            [sender setImage:nil forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor whiteColor];
            sender.layer.borderWidth = 1.0f;
            [arrroleselected removeObject:@"3"];
        }
        else
        {
            [sender setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor orangeColor];
            sender.layer.borderWidth = 0.0f;
            [arrroleselected addObject:@"3"];
        }
    }
}

- (IBAction)btnCarrierClicked:(UIButton *)sender
{
    [self.view endEditing:YES];

    id superView = [sender superview];
    
    sender = [superView viewWithTag:2002];
    
    if (sender)
    {
        if ([arrroleselected containsObject:@"2"])
        {
            [sender setImage:nil forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor whiteColor];
            sender.layer.borderWidth = 1.0f;
            [arrroleselected removeObject:@"2"];
        }
        else
        {
            [sender setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor orangeColor];
            sender.layer.borderWidth = 0.0f;
            [arrroleselected addObject:@"2"];
        }
    }
}

- (IBAction)btnSearchCompanyClicked:(id)sender
{
    [self.view endEditing:YES];
    
    SearchCompanyVC *vc = initVCToRedirect(SBSEARCH, SEARCHCOMPANYVC);
    vc.delegate = self;
    vc.selectedSearchType = SearchDetailsTypeCompany;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectCompany:(CompanyDetails *)companyDetails
{
    _isCompanyFieldEnabled = NO;
    CellMyAccountData *cell = [_tblCompanyInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.txtCompanyName.enabled = _isCompanyFieldEnabled;
    cell.txtstreet.enabled = _isCompanyFieldEnabled;
    cell.txtcity.enabled = _isCompanyFieldEnabled;
    cell.txtstate.enabled = _isCompanyFieldEnabled;
    cell.txtzip.enabled = _isCompanyFieldEnabled;
    cell.txtPhone.enabled = _isCompanyFieldEnabled;
    cell.btnStatename.enabled = _isCompanyFieldEnabled;

    strCompanyId = [NSString stringWithFormat:@"%ld", (NSInteger)companyDetails.companyId];
    objuserac.companyName = companyDetails.companyName;
    objuserac.city = companyDetails.city;
    objuserac.state = companyDetails.state;
    objuserac.country = companyDetails.country;
    objuserac.companyStreet = companyDetails.companyStreet;
    objuserac.companyZip = companyDetails.companyZip;
    
    if (companyDetails.officeDetails.count > 0)
    {
        objOfficeDetails = companyDetails.officeDetails[0];
    }
    else
    {
        objOfficeDetails = nil;
    }
    
    [_tblCompanyInfo reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didSelectAddNewCompany:(BOOL)isCompany
{
    strCompanyId = @"0";
    objOfficeDetails = nil;
    _isCompanyFieldEnabled = YES;
    
    CellMyAccountData *cell = [_tblCompanyInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    cell.txtCompanyName.enabled = _isCompanyFieldEnabled;
    cell.txtstreet.enabled = _isCompanyFieldEnabled;
    cell.txtcity.enabled = _isCompanyFieldEnabled;
    cell.txtstate.enabled = _isCompanyFieldEnabled;
    cell.txtzip.enabled = _isCompanyFieldEnabled;
    cell.txtPhone.enabled = _isCompanyFieldEnabled;
    cell.btnStatename.enabled = _isCompanyFieldEnabled;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [cell.txtCompanyName becomeFirstResponder];
    });
}

#pragma mark -table view delegate datasource for popup view
-(CGFloat)popoverListView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try
    {
        return arrstatelist.count;
    } @catch (NSException *exception) { }
}

- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        static NSString *customTableIdentifier = @"CellListWithCheckBox";
        CellListWithCheckBox *cell = (CellListWithCheckBox *)[tableView dequeueReusablePopoverCellWithIdentifier:customTableIdentifier];
        
        if (nil == cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellListWithCheckBox" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.vwCheckboxsubtext.hidden=YES;
        cell.lblsubtext.text=@"";
        [cell.lblsubtext sizeToFit];
        cell.cellListWithCheckBoxDelegate=self;
        [cell.btnCellClick removeFromSuperview];
        //cell.btnCellClick.userInteractionEnabled=YES;
        if ([stateSelected containsObject:indexPath])
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
        cell.lblListName.text=[arrstatelist objectAtIndex:indexPath.row];
        return cell;
    }
    @catch (NSException *exception) {
        
    }
    
}
- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([stateSelected containsObject:indexPath])
    {
        [stateSelected removeObject:indexPath];
    }
    else
    {
        [stateSelected removeAllObjects];
        [stateSelected addObject:indexPath];
    }
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([stateSelected containsObject:indexPath])
    {
        [stateSelected removeObject:indexPath];
    }
    else
    {
        [stateSelected removeAllObjects];
        [stateSelected addObject:indexPath];
    }  
}

- (IBAction)btnBackClicked:(id)sender 
{
    [DefaultsValues removeObjectForKey:SavedDOTData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDrawerClicked:(id)sender {
    [self.view endEditing:YES];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
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
        if(arrroleselected.count == 0)
        {
            [AZNotification showNotificationWithTitle:RoleSelectionUpdateRequired controller:ROOTVIEW notificationType:AZNotificationTypeError];
            return;
        }
        if([[NetworkAvailability instance]isReachable])
        {
            NSString *strRoles = [arrroleselected componentsJoinedByString:@","];
            
            DOTDetails *objDot;
            CellMyAccountData *cellacdata=[_tblCompanyInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            objDot=[DOTDetails new];
            objDot.phyCity=cellacdata.txtcity.text;
            objDot.phyState=cellacdata.btnStatename.titleLabel.text;
            objDot.phyCountry=@"US";
            objDot.dotNumber=cellacdata.txtDotNumber.text;
            objDot.mcNumber=cellacdata.txtmcnumber.text;
            objDot.phyStreet=cellacdata.txtstreet.text;
            objDot.phyZipcode=cellacdata.txtzip.text;
            objDot.phoneNumber=cellacdata.txtPhone.text;
            objDot.legalName=cellacdata.txtCompanyName.text;
            objDot.dotAddress=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",objDot.phyStreet,objDot.phyCity,objDot.phyState,@"US",objDot.phyZipcode];
            
            NSString *strOfficeId;
            NSString *strOfficeName;
            NSString *strOfficeAddress;
            NSString *strOfficePhoneNumber;
            NSString *strOfficeFax;
            
            if ([strCompanyId isEqualToString:@"0"])
            {
                strOfficeId = @"0";
                strOfficeName = objDot.legalName;
                strOfficeAddress = objDot.dotAddress;
                strOfficePhoneNumber = objDot.phoneNumber;
                strOfficeFax = @"";
            }
            else if (![objuserac.companyId isEqualToString:strCompanyId])
            {
                if (objOfficeDetails != nil)
                {
                    strOfficeId = [NSString stringWithFormat:@"%ld", (NSInteger)objOfficeDetails.officeId];
                    strOfficeName = objOfficeDetails.officeName;
                    strOfficeAddress = objOfficeDetails.officeAddress;
                    strOfficePhoneNumber = objOfficeDetails.officePhoneNo;
                    strOfficeFax = objOfficeDetails.officeFaxNo;
                }
                else
                {
                    strOfficeId = @"0";
                    strOfficeName = objDot.legalName;
                    strOfficeAddress = objDot.dotAddress;
                    strOfficePhoneNumber = objDot.phoneNumber;
                    strOfficeFax = @"";
                }
            }
            else
            {
                strOfficeId = objuserac.officeId;
                strOfficeName = objuserac.officeName;
                strOfficeAddress = objuserac.officeAddress;
                strOfficePhoneNumber = objuserac.officePhoneNo;
                strOfficeFax = objuserac.officeFaxNo;
            }
            
            
            @try
            {
                NSDictionary *dicCreateAccount = @{
                                                   Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                                   Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                                   Req_User_role:strRoles,
                                                   Req_Role:strRoles,
                                                   Req_City:objDot.phyCity,
                                                   Req_State:objDot.phyState,
                                                   Req_Country:objDot.phyCountry,
                                                   Req_DotNumber:objDot.dotNumber,
                                                   Req_McNumber:objDot.mcNumber,
                                                   Req_CloseTime:@"",
                                                   Req_OpenTime:@"",
                                                   Req_CmpnyPhoneNo:objDot.phoneNumber,
                                                   Req_Office_Phone:strOfficePhoneNumber,
                                                   Req_Phone_no:objuserac.phoneNo,
                                                   Req_CompanyName:objDot.legalName,
                                                   Req_Office_name:strOfficeName,
                                                   Req_OfficeAddress:strOfficeAddress,
                                                   Req_SecondaryEmailId:objuserac.secondaryEmailId,
                                                   Req_Ofiice_Fax:strOfficeFax,
                                                   Req_OperatingAddress:objuserac.operatingAddress,
                                                   Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                                   Req_profile:@"",
                                                   Req_cstreet:objDot.phyStreet,
                                                   Req_czip:objDot.phyZipcode,
                                                   Req_Pref_id:objuserac.internalBaseClassIdentifier,
                                                   Req_firstname:objuser.firstname,
                                                   Req_dotstatus:objuserac.dotnumStatus,
                                                   @"company_id" : strCompanyId,
                                                   @"previous_company_id" : strOldCompanyId,
                                                   @"office_id" : strOfficeId
                                                   };
                
//                NSError *error;
//                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicCreateAccount
//                                                                   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
//                                                                     error:&error];
//                
//                if (! jsonData) {
//                    NSLog(@"Got an error: %@", error);
//                } else {
//                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//                    NSLog(@"");
//                }
                [[WebServiceConnector alloc]
                 init:URLUpdateRoleAccount
                 withParameters:dicCreateAccount
                 withObject:self
                 withSelector:@selector(getUpdateAccountResponse:)
                 forServiceType:@"JSON"
                 showDisplayMsg:@"Updating Company Details"
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
    @catch (NSException *exception) {
        
    } 
}

-(IBAction)getUpdateAccountResponse:(id)sender
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
            [_EditCompanyInfoVCProtocol reloadDetailsAfterEdit];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
- (IBAction)btnEditDotClicked:(id)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:APPNAME
                                                                   message:@"Please enter your DOT number."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Update" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) 
                                    {
                                        UITextField *login = alert.textFields.firstObject;
                                        if([self validateTxtFieldLength:login withMessage:RequiredDotNumber])
                                        {
//                                            [self editDot:login.text];
                                            objuserac.dotNumber = login.text;
                                            CellMyAccountData *cell = [_tblCompanyInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                cell.txtDotNumber.text = objuserac.dotNumber;
                                            });
                                        }
                                    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) 
     {
         textField.keyboardAppearance=UIKeyboardAppearanceDark;
         textField.textAlignment=NSTextAlignmentCenter;
         textField.keyboardType = UIKeyboardTypeNumberPad;
         textField.placeholder = @"DOT Number";
     }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)btnEditMcClicked:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:APPNAME
                                                                   message:@"Please enter your MC number."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Update" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              UITextField *login = alert.textFields.firstObject;
                                                              _strMcNumber = login.text;
                                                              objuserac.mcNumber = login.text;
                                                              CellMyAccountData *cell = [_tblCompanyInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  cell.txtmcnumber.text = objuserac.mcNumber;
                                                              });
                                                          }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
         textField.keyboardAppearance=UIKeyboardAppearanceDark;
         textField.textAlignment=NSTextAlignmentCenter;
         textField.keyboardType = UIKeyboardTypeNumberPad;
         textField.placeholder = @"MC Number";
     }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)editDot:(NSString *)dott
{
//    if (objuserac.dotNumber.length>0)
    if (dott.length > 0)
    {
        [self showHUD:@"Requesting Details from DOT Number..."];
        
        if ([[NetworkAvailability instance]isReachable])
        {
            NSDictionary *dicDotRequest = @{
                                            Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                            Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                            Req_DotNumber:dott
                                            };
            [[WebServiceConnector alloc] init:URLDotNumberDetail
                               withParameters:dicDotRequest
                                   withObject:self
                                 withSelector:@selector(getDotResponse_edit:)
                               forServiceType:@"JSON"
                               showDisplayMsg:@"Requesting Details from DOT Number"
                                 showProgress:YES];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
- (IBAction)getDotResponse_edit:(id)sender
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
            DOTDetails *userDotData = [[sender responseArray] objectAtIndex:0];
            NSString *dotnumber = [NSString stringWithFormat:@"%@", userDotData.dotNumber];
            userDotData.dotNumber = dotnumber;
            [DefaultsValues setCustomObjToUserDefaults:userDotData ForKey:SavedDOTData];
            [self.tblCompanyInfo setContentOffset:CGPointZero animated:NO];
            [self.tblCompanyInfo reloadData];  
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
@end
