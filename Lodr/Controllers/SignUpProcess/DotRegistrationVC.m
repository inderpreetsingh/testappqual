//
//  DotRegistrationVC.m
//  Lodr
//
//  Created by c196 on 26/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "DotRegistrationVC.h"
#import "HomeVC.h"
#import "SPGooglePlacesAutocompleteViewController.h"
#import "CQMFloatingController.h"
#import "Base64.h"
#import "DotWarning.h"
#import "SearchCompanyVC.h"

@interface DotRegistrationVC () <SearchCompanyVCDelegate>
{
    BOOL isConditionVerified;
    
    NSString *strOfficeLat;
    NSString *strOfficeLon;
    
    NSString *strCompanyId;
    NSString *strOfficeId;
    
    NSString *strMCNumber;
    NSString *strDotNumber;
    
    NSString *strCompanyName;
    NSString *strCity;
    NSString *strStreet;
    NSString *strState;
    NSString *strPhone;
    NSString *strZip;
    
    NSString *strOfficeName;
    NSString *strOfficeAddress;
    NSString *strOfficeNo;
    NSString *strOfficeFax;
    
     UIView *overlay,*overlayview;
    ZSYPopoverListView *listView;
    NSArray *arrWelcomeCellFieldHeading,*arrWelcomeCellFieldInfo,*nibHeader,*nibFooter;
    NSArray *arrOfficeCellFieldHeading,*arrSummaryCellHeading,*arruserInfoOptionCellText;
    NSMutableArray *arrSummaryCellAddress,*arrSummaryCellPhone,*arrSummaryCellCname,*arrroleselected,*arrOfficeCellText;
    CellAccountHeader *tblheader;
    CellWelcomeFooter *tblFooter;
    User *objuser;
    NSString *phoneFromWelcometbl,*addressFromOfficetbl,*addressAddedManuallyOfficetbl,*officeFaxnum,*username,*userphone,*choosenstate,*roltext,*homephno,*addressOerating,*addUserinfoaddress;
    NSData *imageSelectedData;
    NSMutableArray  *stateSelected,*arrstatelist;
}
@end

@implementation DotRegistrationVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    strCompanyId = @"0";
    strOfficeId = @"0";
    
    addressFromOfficetbl=@"";
    addUserinfoaddress=@"";
    officeFaxnum=@"";
    phoneFromWelcometbl=@"";
    stateSelected=[NSMutableArray new];
    NavigationBarHidden(YES);
    [self.btnWelcomeBack setImage:imgNamed(@"") forState:UIControlStateNormal];
//    if([_redirectfrom isEqualToString:@"APPDELEGATE"])
//    {`
//        [self.btnWelcomeBack setImage:imgNamed(@"") forState:UIControlStateNormal];
//    }
//    else
//    {
//        [self.btnWelcomeBack setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
//    }
    [self.btnNavbarDrawer setImage:imgNamed(iconDrawer2) forState:UIControlStateNormal];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    arrOfficeCellText=[NSMutableArray new];
    arrWelcomeCellFieldHeading=[NSArray arrayWithObjects:@"Type in your Phone Number:",@"Type in your DOT Number:",@"Type in your MC Number:", nil];
    arrWelcomeCellFieldInfo=[NSArray arrayWithObjects:@"Phone number",@"If you plan to transport loads you will need to provide a  DOT number(you can do this later)",@"MC numbers are used mainly for brokers", nil];
    arrOfficeCellFieldHeading=[NSArray arrayWithObjects:@"Office Phone Number",@"Office Fax Number",nil];
    arrSummaryCellHeading=[NSArray arrayWithObjects:@"COMPANY",@"OFFICE",@"USER",nil];
    arruserInfoOptionCellText=[NSArray arrayWithObjects:@"I WILL BE DRIVING",@"MY COMPANY IS A CARRIER",@"MY COMPANY CREATES LOADS",nil];
   objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    arrroleselected=[NSMutableArray new];
    self.tblWelcome.rowHeight = UITableViewAutomaticDimension;
    self.tblWelcome.estimatedRowHeight = 120.0; 
    
    self.tblCompanyInfo.rowHeight=UITableViewAutomaticDimension;
    self.tblCompanyInfo.estimatedRowHeight=964;
    
    self.tblOfficeInfo.rowHeight=UITableViewAutomaticDimension;
    self.tblOfficeInfo.estimatedRowHeight=105;
    
    self.tblUserinfo.rowHeight=UITableViewAutomaticDimension;
    self.tblUserinfo.estimatedRowHeight=50;
    
    self.tblSummary.rowHeight=UITableViewAutomaticDimension;
    self.tblSummary.estimatedRowHeight=195;
    
    self.tblSummary.hidden=YES;
    self.tblCompanyInfo.hidden=YES;
    self.tblUserinfo.hidden=YES;
    self.tblOfficeInfo.hidden=YES;
    
    arrSummaryCellPhone =[NSMutableArray new];
    [arrSummaryCellPhone addObject:@""];
    [arrSummaryCellPhone addObject:@""];
    [arrSummaryCellPhone addObject:@""];
    arrSummaryCellAddress =[NSMutableArray new];
    [arrSummaryCellAddress addObject:@""];
    [arrSummaryCellAddress addObject:@""];
    [arrSummaryCellAddress addObject:@""];
    arrSummaryCellCname=[NSMutableArray new];
    [arrSummaryCellCname addObject:@""];
    [arrSummaryCellCname addObject:@""];
    [arrSummaryCellCname addObject:@""];
    for(int i=0;i<2;i++)
    {
         [arrOfficeCellText addObject:@""];
    }
   addUserinfoaddress=@"1";
    addressFromOfficetbl=@"1";
   
}
-(void)dismissKeyboard 
{
    [self.view endEditing:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Tableview delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    return 1; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    if(tableView==_tblWelcome)
    {
        return arrWelcomeCellFieldHeading.count;
    }
    else if(tableView==_tblCompanyInfo)
    {
        return 1;
    }
    else if(tableView==_tblOfficeInfo)
    {
        return arrOfficeCellFieldHeading.count;
    }
    else if(tableView==_tblUserinfo)
    {
        return 4;
    }
    else
    {
        return arrSummaryCellHeading.count + 1;
    }
}

- (IBAction)textFieldDidChange:(UITextField *)sender
{
    strOfficeName = sender.text;
}

- (IBAction)btnSearchClicked:(id)sender
{
    SearchCompanyVC *vc = initVCToRedirect(SBSEARCH, SEARCHCOMPANYVC);
    vc.delegate = self;
    vc.strCompanyId = strCompanyId;
    vc.selectedSearchType = SearchDetailsTypeOffice;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    nibHeader = [[NSBundle mainBundle] loadNibNamed:@"CellAccountHeader" owner:self options:nil];
    
    tblheader = [[CellAccountHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblWelcome.frame.size.width, 520)];
    tblheader = (CellAccountHeader *)[nibHeader objectAtIndex:1];
    
   
    tblheader.cellAccountHeaderDelegate=self;
    
    if(tableView==_tblWelcome)
    {
         tblheader.heightOperatingAddress.constant=0;
        tblheader.lblLargeTitle.text=@"Welcome";
        tblheader.lblSubtitleSmall.text=@"Setup your account";
        tblheader.heigthlblpagename.constant=0;
        tblheader.lblOfiiceInfoText.clipsToBounds=YES;
        tblheader.heightHeaderHeading.constant=105;
        tblheader.heightOfficeIHeader.constant=0;     
        tblheader.vwHeaderOfficeInfo.clipsToBounds=YES;        
        return tblheader;
    }
    else if(tableView==_tblCompanyInfo)
    {
         tblheader.heightOperatingAddress.constant=0;
        tblheader.heigthlblpagename.constant=50;
        tblheader.lblOfiiceInfoText.clipsToBounds=YES;
        tblheader.lblLargeTitle.text=@"My Account";
        tblheader.lblSubtitleSmall.text=@"Setup your account information";
        tblheader.lblOfiiceInfoText.text=@"YOUR COMPANY INFO";
        tblheader.heightHeaderHeading.constant=165;
        tblheader.heightOfficeIHeader.constant=0;
        tblheader.vwHeaderOfficeInfo.clipsToBounds=YES;
        return tblheader;
    }
    else if(tableView==_tblOfficeInfo)
    {
        tblheader.heigthlblpagename.constant=50;
        tblheader.lblOfiiceInfoText.clipsToBounds=YES;
        tblheader.heightHeaderHeading.constant=165;
        tblheader.heightOfficeIHeader.constant=255;
        tblheader.vwHeaderOfficeInfo.clipsToBounds=YES;
        tblheader.vwWithHeadingText.clipsToBounds=YES;
        tblheader.lblLargeTitle.text=@"My Account";
        tblheader.lblSubtitleSmall.text=@"Setup your account information";
        tblheader.lblOfiiceInfoText.text=@"YOUR OFFICE INFO";
        
         tblheader.txtOperatingAddress.tag=800;
        tblheader.btnSameAsComapnyAddressCheckbox.tag=701;
        tblheader.txtvwAddressOffic.delegate=self;

        [tblheader.btnSearch addTarget:self action:@selector(btnSearchClicked:) forControlEvents:UIControlEventTouchUpInside];
        tblheader.txtOfficeName.text = strOfficeName;
        [tblheader.txtOfficeName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidEnd];

        if(addressOerating.length>0)
        {
            tblheader.txtOperatingAddress.text=addressOerating;
        }
        if([addressFromOfficetbl isEqualToString:@"0"] || [addressFromOfficetbl isEqualToString:@""])
        {
             tblheader.heightOperatingAddress.constant=80;
             [ tblheader.btnSameAsComapnyAddressCheckbox setImage:imgNamed(@"checkboxsquare")  forState:UIControlStateNormal];
        }
        else
        {
             tblheader.heightOperatingAddress.constant=0;
             [ tblheader.btnSameAsComapnyAddressCheckbox setImage:imgNamed(@"checkboxsquareselected")  forState:UIControlStateNormal];
        }
        
            tblheader.txtOfficeName.enabled = _isOfficeFieldEnabled;
            tblheader.txtOperatingAddress.editable = _isOfficeFieldEnabled;

        return tblheader;
    }
    else if(tableView==_tblUserinfo)
    {
        tblheader.heightOperatingAddress.constant=0;
        tblheader.lblLargeTitle.text=@"My Account";
        tblheader.lblOfiiceInfoText.text=@"USER INFO";
        tblheader.lblSubtitleSmall.text=@"Setup your account information";
        tblheader.heightHeaderHeading.constant=165;
        tblheader.heightOfficeIHeader.constant=0;
        tblheader.vwHeaderOfficeInfo.clipsToBounds=YES;
        tblheader.heigthlblpagename.constant=50;
        tblheader.lblOfiiceInfoText.clipsToBounds=YES;
      
        return tblheader;
    }
    else
    {
         tblheader.heightOperatingAddress.constant=0;
        tblheader.lblLargeTitle.text=@"My Account";
        tblheader.lblSubtitleSmall.text=@"Setup your account";
        tblheader.heigthlblpagename.constant=0;
        tblheader.lblOfiiceInfoText.clipsToBounds=YES;
        tblheader.heightHeaderHeading.constant=105;
        tblheader.heightOfficeIHeader.constant=0;     
        tblheader.vwHeaderOfficeInfo.clipsToBounds=YES;
        
        return tblheader;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    nibFooter = [[NSBundle mainBundle] loadNibNamed:@"welcomeFooter" owner:self options:nil];
    tblFooter = [[CellWelcomeFooter alloc] initWithFrame:CGRectMake(0, 0, self.tblWelcome.frame.size.width, 320)];
    tblFooter = (CellWelcomeFooter *)[nibFooter objectAtIndex:0]; 
    tblFooter.cellWelcomeFooterDelegate=self;
    if(tableView==_tblWelcome)
    {
        tblFooter.heightSummaryFooter.constant=0;
        tblFooter.heightcmpnyFooter.constant=0;
        tblFooter.heightOfficeFooter.constant=0;
        tblFooter.vwSummaryFooter.clipsToBounds=YES;
        tblFooter.vwFootercompany.clipsToBounds=YES;
        tblFooter.vwOfficeInfoFooter.clipsToBounds=YES;
        tblFooter.heightvwWelocmeFooter.constant=100;
        return tblFooter;
    }
    else if(tableView==_tblCompanyInfo)
    {
        tblFooter.heightvwWelocmeFooter.constant=0;
        tblFooter.heightOfficeFooter.constant=0;
        tblFooter.heightSummaryFooter.constant=0;
        tblFooter.vwSummaryFooter.clipsToBounds=YES;
        tblFooter.vwFootercompany.clipsToBounds=YES;
        tblFooter.vwOfficeInfoFooter.clipsToBounds=YES;
        tblFooter.heightcmpnyFooter.constant=150;
        tblFooter.btncmpnynext.tag=777;
        tblFooter.btncmpnayback.tag=555;
        return tblFooter;
    }
    else if(tableView==_tblOfficeInfo)
    {
        tblFooter.heightvwWelocmeFooter.constant=0;
        tblFooter.heightOfficeFooter.constant=0;
        tblFooter.heightSummaryFooter.constant=0;
        tblFooter.vwSummaryFooter.clipsToBounds=YES;
        tblFooter.vwFootercompany.clipsToBounds=YES;
        tblFooter.vwOfficeInfoFooter.clipsToBounds=YES;
        tblFooter.heightcmpnyFooter.constant=150;
        tblFooter.btncmpnynext.tag=111;
        tblFooter.btncmpnayback.tag=222;
        return tblFooter;
    }
    else if(tableView==_tblUserinfo)
    {
        tblFooter.heightvwWelocmeFooter.constant=0;
        tblFooter.heightOfficeFooter.constant=0;
        tblFooter.heightSummaryFooter.constant=0;
        tblFooter.vwSummaryFooter.clipsToBounds=YES;
        tblFooter.vwFootercompany.clipsToBounds=YES;
        tblFooter.vwOfficeInfoFooter.clipsToBounds=YES;
        tblFooter.heightcmpnyFooter.constant=150;
        tblFooter.btncmpnynext.tag=888;
        tblFooter.btncmpnayback.tag=666;
        return tblFooter;
    }
    else
    {
        tblFooter.heightvwWelocmeFooter.constant=0;
        tblFooter.heightcmpnyFooter.constant=0;
        tblFooter.heightOfficeFooter.constant=0;
        tblFooter.heightSummaryFooter.constant=150;
        tblFooter.vwWelcomeFoooter.clipsToBounds=YES;
        tblFooter.vwFootercompany.clipsToBounds=YES;
        tblFooter.vwOfficeInfoFooter.clipsToBounds=YES;
        return tblFooter;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    @try {
        DOTDetails *objDot;
        
        if ([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData] != nil)
        {
            objDot = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData];
        }
        
        if (tableView==_tblWelcome)
        {
            static NSString *cellIdentifier = @"CellWelcome";
            CellWelcome *cell = (CellWelcome*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.lblHeadingText.text=[arrWelcomeCellFieldHeading objectAtIndex:indexPath.row];
            cell.lblInstructions.text=[arrWelcomeCellFieldInfo objectAtIndex:indexPath.row];
            cell.txtFieldValue.tag=500+indexPath.row;
            cell.lblInstructions.numberOfLines=0;
            [cell.lblInstructions sizeToFit];
            if(indexPath.row == 0)
            {
                cell.backgroundColor=[UIColor blackColor];
                cell.lblHeadingText.textColor=[UIColor whiteColor];
                cell.lblInstructions.textColor=[UIColor blackColor];
            }    
            else 
            {
                cell.backgroundColor=[UIColor whiteColor];
                cell.lblHeadingText.textColor=[UIColor blackColor];
                cell.lblInstructions.textColor=[UIColor lightGrayColor];
            }
            if([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData] !=nil)
            {
                if(indexPath.row == 0)
                {
                    cell.txtFieldValue.text=[NSString stringWithFormat:@"%@",@""];
                }
                else if(indexPath.row == 1)
                {
                    cell.txtFieldValue.text=[NSString stringWithFormat:@"%@",objDot.dotNumber];
                }
                else
                {
                    cell.txtFieldValue.text=[NSString stringWithFormat:@"%@",objDot.mcNumber];
                }
            }
            return cell; 
        }
        else if(tableView==_tblCompanyInfo)
        {
            static NSString *cellIdentifier = @"CellMyAccountData";
            CellMyAccountData *cell = (CellMyAccountData*)[_tblCompanyInfo dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) 
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            } 
            cell.btnEditdot.hidden=YES;
            [cell.btnEditdot removeFromSuperview];
            cell.btnEditMC.hidden=YES;
            [cell.btnEditMC removeFromSuperview];

            cell.cellMyAccountDataDelegate=self;
            if([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData] !=nil)
            {
                cell.txtDotNumber.text=objDot.dotNumber;
                cell.txtmcnumber.text=objDot.mcNumber;
                cell.txtCompanyName.text=objDot.legalName;
                cell.txtstreet.text=objDot.phyStreet;
                cell.txtcity.text=objDot.phyCity;
                cell.txtzip.text=objDot.phyZipcode;
                cell.txtPhone.text=objDot.phoneNumber;
                cell.txtstate.text=objDot.phyState;
                [cell.btnStatename setTitle:objDot.phyState forState:UIControlStateNormal];
            }
            else
            {
                cell.txtDotNumber.text=strDotNumber;
                cell.txtmcnumber.text=strMCNumber;
                cell.txtCompanyName.text=strCompanyName;
                cell.txtstreet.text=strStreet;
                cell.txtcity.text=strCity;
                cell.txtzip.text=strZip;
                cell.txtPhone.text=strPhone;
                cell.txtstate.text=choosenstate;
//                [cell.btnStatename setTitle:@"" forState:UIControlStateNormal];
                [cell.btnStatename setTitle:choosenstate forState:UIControlStateNormal];

            }
            
            if ([arrroleselected containsObject:[NSIndexPath indexPathForRow:3 inSection:0]])
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
            
            if ([arrroleselected containsObject:[NSIndexPath indexPathForRow:2 inSection:0]])
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
            cell.txtstreet.enabled = _isCompanyFieldEnabled;
            cell.txtcity.enabled = _isCompanyFieldEnabled;
            cell.txtstate.enabled = _isCompanyFieldEnabled;
            cell.txtzip.enabled = _isCompanyFieldEnabled;
            cell.txtPhone.enabled = _isCompanyFieldEnabled;
            cell.btnStatename.enabled = _isCompanyFieldEnabled;
            
            return cell;
        }
        else if(tableView==_tblOfficeInfo)
        {
            static NSString *cellIdentifier = @"CellTextfields";
            CellTextfields *cell = (CellTextfields*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.txtcellText.tag=604+indexPath.row;
            
            cell.lbltxtCellHeading.text=[arrOfficeCellFieldHeading objectAtIndex:indexPath.row];
            if([cell.lbltxtCellHeading.text containsString:@"Office"])
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
            
            return cell; 
        }
        else if(tableView==_tblUserinfo)
        {
            if(indexPath.row == 0)
            {
                static NSString *customTableIdentifier = @"CellWelcomeUserInfo";
                CellWelcomeUserInfo  *cell=(CellWelcomeUserInfo *)[_tblUserinfo dequeueReusableCellWithIdentifier:customTableIdentifier];
                
                
                if (nil == cell)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellWelcomeUserInfo" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(openSelectionforimage:)];
                    tapGesture1.numberOfTapsRequired = 1;
                    [cell.imgUserPhoto addGestureRecognizer:tapGesture1];
                }
                cell.cellWelcomeUserInfoDelegate=self;
                if(addressAddedManuallyOfficetbl.length>0)
                {
                  cell.txtUserInfoAddress.text=addressAddedManuallyOfficetbl;
                }
                if([addUserinfoaddress isEqualToString:@"0"] || [addUserinfoaddress isEqualToString:@""])
                {
                    [ cell.btnuserinfocmpanyaddr setImage:imgNamed(@"checkboxsquare")  forState:UIControlStateNormal];
                }
                else
                {
                    [ cell.btnuserinfocmpanyaddr setImage:imgNamed(@"checkboxsquareselected")  forState:UIControlStateNormal];
                }
                cell.txtEmail.text = objuser.primaryEmailId;
                
                cell.txtEmail.enabled = NO;
                cell.txtPassword.enabled = NO;
                
                cell.txtyourname.text=username;
                 UITextField *textFieldphone = (UITextField*)[self.view viewWithTag:500];
                cell.txtphonenumber.text=textFieldphone.text;
                return cell;
            }
            else
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
        }
        else
        {
            if (indexPath.row == 3)
            {
                static NSString *customTableIdentifier = @"CellListWithCheckBox";
                
                CellListWithCheckBox *cell = (CellListWithCheckBox *)[tableView dequeueReusableCellWithIdentifier:customTableIdentifier];
                
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
                cell.lblListName.text = @"I agree to terms & conditions";
                
                cell.btnCellClick.tag = 60001;
                
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
            
            static NSString *cellIdentifier = @"CellWelcomeSummary";
            CellWelcomeSummary *cell = (CellWelcomeSummary*)[_tblCompanyInfo dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) 
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            if (indexPath.row == 2)
            {
                cell.heightimage.constant = 150;
                cell.heightroles.constant = 150;
                cell.imguserimage.image = [UIImage imageWithData:imageSelectedData];
                
                if ([roltext containsString:@"1"])
                {
                    [cell.btndriver setImage:[UIImage imageNamed:@"orangecorrect"] forState:UIControlStateNormal];
                }
                else
                {
                    [cell.btndriver setImage:[UIImage imageNamed:@"grayclose"] forState:UIControlStateNormal];
                    
                }
                
                if ([roltext containsString:@"2"])
                {
                    [cell.btncarrier setImage:[UIImage imageNamed:@"orangecorrect"] forState:UIControlStateNormal];
                }
                else
                {
                    [cell.btncarrier setImage:[UIImage imageNamed:@"grayclose"] forState:UIControlStateNormal];
                }
                
                if ([roltext containsString:@"3"])
                {
                    [cell.btnshipper setImage:[UIImage imageNamed:@"orangecorrect"] forState:UIControlStateNormal];
                }
                else
                {
                    [cell.btnshipper setImage:[UIImage imageNamed:@"grayclose"] forState:UIControlStateNormal];
                }
            }
            else
            {
                cell.heightimage.constant = 0;
                cell.heightroles.constant = 0;
            }
            
            if (indexPath.row == 0)
            {
                if ([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData] != nil)
                {
                    cell.lblsummarydot.text = [NSString stringWithFormat:@"DOT#%@",objDot.dotNumber];
                    cell.heightDotNumber.constant = 22;
                }
                else
                {
                    cell.lblsummarydot.text = @"";
                    cell.heightDotNumber.constant = 0;
                }
            }
            else
            {
                cell.lblsummarydot.text = @"";
                cell.heightDotNumber.constant = 0;
                
            }
            
            cell.lblSummaryHeading.text=[arrSummaryCellHeading objectAtIndex:indexPath.row];
//            cell.lblsummaryOfficename.text=[arrSummaryCellCname objectAtIndex:indexPath.row];
            cell.lblsummaryOfficename.text = strOfficeName;
            cell.lblsummaryaddress.text=[arrSummaryCellAddress objectAtIndex:indexPath.row];
            cell.lblsummaryaddress.numberOfLines=0;
            [cell.lblsummaryaddress sizeToFit];
            cell.lblsummaryphone.text=[arrSummaryCellPhone objectAtIndex:indexPath.row];
            return cell;
        }
    } @catch (NSException *exception) {
        
    } 
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    if(tableView==_tblWelcome)
    {
        return 115;
    }
    else if(tableView==_tblCompanyInfo)
    {
        return 165;
    }
    else if(tableView==_tblOfficeInfo)
    {
//        if([addressFromOfficetbl isEqualToString:@"1"])
//        {
//             return 420;
//        }
//        else
//        {
//             return 500;
//        return 800;
        return 600;
       // }
    }
    else if(tableView==_tblUserinfo)
    {
        return 165;
    }
    else
    {
        return 115;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{
    if(tableView==_tblWelcome)
    {
        return 100;
    }
    else if(tableView==_tblCompanyInfo)
    {
        return 150;
    }
    else if(tableView==_tblOfficeInfo)
    {
        return 150;
    }
    else if(tableView==_tblUserinfo)
    {
        return 150;
    }
    else
    {
        return 150;
    }
}

- (IBAction)btnShipperClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    id superView = [sender superview];
    sender = [superView viewWithTag:2001];
    
    if (sender)
    {
        if ([arrroleselected containsObject:[NSIndexPath indexPathForRow:3 inSection:0]])
        {
            [sender setImage:nil forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor whiteColor];
            sender.layer.borderWidth = 1.0f;
            [arrroleselected removeObject:[NSIndexPath indexPathForRow:3 inSection:0]];
        }
        else
        {
            [sender setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor orangeColor];
            sender.layer.borderWidth = 0.0f;
            [arrroleselected addObject:[NSIndexPath indexPathForRow:3 inSection:0]];
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
        if ([arrroleselected containsObject:[NSIndexPath indexPathForRow:2 inSection:0]])
        {
            [sender setImage:nil forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor whiteColor];
            sender.layer.borderWidth = 1.0f;
            [arrroleselected removeObject:[NSIndexPath indexPathForRow:2 inSection:0]];
        }
        else
        {
            [sender setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor orangeColor];
            sender.layer.borderWidth = 0.0f;
            [arrroleselected addObject:[NSIndexPath indexPathForRow:2 inSection:0]];
        }
    }
}

#pragma mark - textfield delegeate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 604)
    {
        phoneFromWelcometbl=textField.text;
        [arrOfficeCellText replaceObjectAtIndex:0 withObject:phoneFromWelcometbl];
    }
    else if(textField.tag == 605)
    {
        officeFaxnum=textField.text;
        [arrOfficeCellText replaceObjectAtIndex:1 withObject:officeFaxnum];
    }
    else if(textField.tag == 777)
    {
        username=textField.text;
    }
    else if(textField.tag == 500)
    {
        homephno=textField.text;
    }
    else
    {
        
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.tag==700)
    {
        addressAddedManuallyOfficetbl=textView.text;
    }
    else if (textView.tag==800)
    {
        addressOerating=textView.text;
    }
    else
    {
        
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

- (void)didSelectCompany:(id)companyDetails
{
    if ([companyDetails isKindOfClass:[CompanyDetails class]])
    {
        _isCompanyFieldEnabled = NO;
        strCompanyId = [NSString stringWithFormat:@"%ld", (NSInteger)((CompanyDetails *)companyDetails).companyId];
        strCompanyName = ((CompanyDetails *)companyDetails).companyName;
        strStreet = ((CompanyDetails *)companyDetails).companyStreet;
        strCity = ((CompanyDetails *)companyDetails).city;
        choosenstate = ((CompanyDetails *)companyDetails).state;
        strZip = ((CompanyDetails *)companyDetails).companyZip;
        strPhone = ((CompanyDetails *)companyDetails).cmpnyPhoneNo;
        [_tblCompanyInfo reloadData];
    }
    else
    {
        if ([((OfficeDetails *)companyDetails).officeLatitude isEqualToString:@""])
        {
            strOfficeLat = @"";
            strOfficeLon = @"";

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [AZNotification showNotificationWithTitle:@"Please select place from location icon" controller:self notificationType:AZNotificationTypeError];
            });
        }
        else
        {
            strOfficeLat = ((OfficeDetails *)companyDetails).officeLatitude;
            strOfficeLon = ((OfficeDetails *)companyDetails).officeLongitude;
        }
        
        _isOfficeFieldEnabled = NO;
        strOfficeId = [NSString stringWithFormat:@"%ld", (NSInteger)((OfficeDetails *)companyDetails).officeId];
        addressOerating = ((OfficeDetails *)companyDetails).officeAddress;
        if (((OfficeDetails *)companyDetails).officePhoneNo)
        {
            [arrOfficeCellText replaceObjectAtIndex:0 withObject:((OfficeDetails *)companyDetails).officePhoneNo];
        }
        strOfficeName = ((OfficeDetails *)companyDetails).officeName;
        [arrOfficeCellText replaceObjectAtIndex:1 withObject:((OfficeDetails *)companyDetails).officeFaxNo];

        [_tblOfficeInfo reloadData];
    }
}

- (void)didSelectAddNewCompany:(BOOL)isCompany
{
    if (isCompany) {
        strCompanyId = @"0";
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
    else
    {
        strOfficeLat = @"";
        strOfficeLon = @"";

        _isOfficeFieldEnabled = YES;
        strOfficeId = @"0";
        [_tblOfficeInfo reloadData];
    }
}


#pragma mark - cell list box
- (IBAction)btnCellClicked:(id)sender
{
   if ([sender tag] == 60001)
   {
       CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblSummary];
       NSIndexPath *indexPath = [self.tblSummary indexPathForRowAtPoint:buttonPosition];
       
       CellListWithCheckBox *cell=(CellListWithCheckBox*)[self.tblSummary cellForRowAtIndexPath:indexPath];
       
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
    else
    {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblUserinfo];
        NSIndexPath *indexPath = [self.tblUserinfo indexPathForRowAtPoint:buttonPosition];
        CellListWithCheckBox *cell=(CellListWithCheckBox*)[self.tblUserinfo cellForRowAtIndexPath:indexPath];
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
    
    
}

#pragma mark Account Header Delegate
- (IBAction)btnmapviewclicked:(id)sender
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
- (IBAction)btnSameAsCompanyCheckboxClicked:(id)sender
{
    UIButton *senderbtn=(UIButton*)sender;
    senderbtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    if([addressFromOfficetbl isEqualToString:@"1"])
    {
         [senderbtn setImage:imgNamed(@"checkboxsquare")  forState:UIControlStateNormal];
        senderbtn.accessibilityLabel=@"0";
        addressFromOfficetbl=@"0";
        
    }
    else
    {
         [senderbtn setImage:imgNamed(@"checkboxsquareselected")  forState:UIControlStateNormal];
        senderbtn.accessibilityLabel=@"1";
         addressFromOfficetbl=@"1";
    }
     //[self.tblOfficeInfo reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - custom method

-(void)viewSlideInFromRightToLeft:(UIView *)views
{
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 0.5;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromRight;
    
    [views.layer addAnimation:transition forKey:nil];
}
-(void)viewSlideInFromLeftToRight:(UIView *)views
{
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 0.5;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromLeft;
    [views.layer addAnimation:transition forKey:nil];
}
#pragma mark Account Footer Delagate
- (IBAction)btntblWelcomeNextClicked:(id)sender
{
    @try {
        UITextField *textFieldphone = (UITextField*)[self.view viewWithTag:500];
        UITextField *textFieldDot = (UITextField*)[self.view viewWithTag:501];
        UITextField *textFieldMC = (UITextField*)[self.view viewWithTag:502];
        
        strDotNumber = textFieldDot.text;
        strMCNumber = textFieldMC.text;
        
        if (textFieldDot.text == nil || textFieldDot.text.length == 0)
        {
            if ([self validateTxtLength:textFieldphone.text withMessage:RequiredPhoneNumberForDot])
            {
                [DefaultsValues removeObjectForKey:SavedDOTData];
                [self.tblCompanyInfo reloadData];
                self.tblWelcome.hidden=true;
                self.tblCompanyInfo.hidden=false;
                [self.tblCompanyInfo setContentOffset:CGPointZero animated:NO];
            }
        }
        else
        {
            DOTDetails *objDot;
            if ([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData] != nil)
            {
                objDot = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData];
                if ([objDot.dotNumber isEqualToString:textFieldDot.text])
                {
                    if ([self validateTxtLength:textFieldphone.text withMessage:RequiredPhoneNumberForDot])
                    {
                        self.tblWelcome.hidden=true;
                        self.tblCompanyInfo.hidden=false;
                        [self.tblCompanyInfo setContentOffset:CGPointZero animated:NO];
                    }
                }
                else
                {
                    [self.tblCompanyInfo setContentOffset:CGPointZero animated:NO];
                    [self.tblCompanyInfo reloadData];
                    [arrOfficeCellText removeAllObjects];
                    [arrOfficeCellText addObject:phoneFromWelcometbl];
                    [arrOfficeCellText addObject:officeFaxnum];
                    [self.tblOfficeInfo reloadData];
                    self.tblCompanyInfo.hidden=false;
                    self.tblWelcome.hidden=true;

                    //[self registerWithDot];
                }
            }
            else
            {
                [self.tblCompanyInfo setContentOffset:CGPointZero animated:NO];
                [self.tblCompanyInfo reloadData];
                [arrOfficeCellText removeAllObjects];
                [arrOfficeCellText addObject:phoneFromWelcometbl];
                [arrOfficeCellText addObject:officeFaxnum];
                [self.tblOfficeInfo reloadData];
                self.tblCompanyInfo.hidden=false;
                self.tblWelcome.hidden=true;

                //[self registerWithDot];
            }
        }
    } @catch (NSException *exception) {
        [self dismissHUD];
    } 
}

- (IBAction)btnOfficeInfoBackClicked:(id)sender
{
 
}
- (IBAction)btnOfficeInfoNextClciked:(id)sender
{
  
}

- (IBAction)btncmpnybackclicked:(id)sender
{
    if([sender tag] == 555)
    {
        self.tblCompanyInfo.hidden=YES;
        self.tblWelcome.hidden=NO;
        [self.tblCompanyInfo setContentOffset:CGPointZero animated:NO];
    }
    else if([sender tag] == 666)
    {
        self.tblUserinfo.hidden=YES;
        self.tblOfficeInfo.hidden=NO;
        [self.tblOfficeInfo setContentOffset:CGPointZero animated:NO];
    }
    else
    {
        self.tblCompanyInfo.hidden=NO;
        self.tblOfficeInfo.hidden=YES;
        [self.tblCompanyInfo setContentOffset:CGPointZero animated:NO];
    }
}
- (IBAction)btncmpnynextclicked:(id)sender
{
    if([sender tag] == 777)
    {
        CellMyAccountData *cell=(CellMyAccountData*)[_tblCompanyInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        if([self validateTxtLength:cell.txtCompanyName.text withMessage:RequiredCompanyname] &&[self validateTxtLength:cell.txtstreet.text withMessage:RequiredStreetName] && [self validateTxtLength:cell.txtcity.text withMessage:RequiredCityname] && [self validateTxtLength:cell.btnStatename.titleLabel.text withMessage:RequiredStatename] && [self validateTxtLength:cell.txtzip.text withMessage:RequiredZipcode] && [self validateTxtLength:cell.txtPhone.text withMessage:RequiredPhoneNumberForDot] )
        {
            if(phoneFromWelcometbl == nil || phoneFromWelcometbl.length==0)
            {
                phoneFromWelcometbl = cell.txtPhone.text;
            }
            
            [arrOfficeCellText removeAllObjects];
            //             [arrOfficeCellText addObject:cell.txtstreet.text];
            //             [arrOfficeCellText addObject:cell.txtcity.text];
            //             [arrOfficeCellText addObject:cell.btnStatename.titleLabel.text];
            //             [arrOfficeCellText addObject:cell.txtzip.text];
            [arrOfficeCellText addObject:phoneFromWelcometbl];
            [arrOfficeCellText addObject:officeFaxnum];
            [self.tblOfficeInfo reloadData];
            self.tblCompanyInfo.hidden=YES;
            self.tblOfficeInfo.hidden=NO;
            [self.tblOfficeInfo setContentOffset:CGPointZero animated:NO];
        }
    }
    else if([sender tag] == 888)
    {
        if(([addUserinfoaddress isEqualToString:@"0"] || [addUserinfoaddress isEqualToString:@""] || addUserinfoaddress==nil) && ( [addressAddedManuallyOfficetbl isEqualToString:@""]||addressAddedManuallyOfficetbl==nil ) )
        {
            [AZNotification showNotificationWithTitle:RequiredUserChoiceAddress  controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
            return;
        }
        if(arrroleselected.count == 0)
        {
            [AZNotification showNotificationWithTitle:RoleSelectionRequired controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            return;
        }
        
        [self gatherAllAdedDataSummary];
    }
    else
    {
        
        if(([addressFromOfficetbl isEqualToString:@"0"] || [addressFromOfficetbl isEqualToString:@""] || addressFromOfficetbl==nil) && ( [addressOerating isEqualToString:@""]||addressOerating==nil ) )
        {
            [AZNotification showNotificationWithTitle:RequiredChoiceAddress  controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
            return;
        }
        else
        {
            UITextField *officephone=(UITextField *)[self.view viewWithTag:604];
            if([self validateTxtLength:officephone.text withMessage:RequiredPhoneNumberForDot])
            {
                if ([strOfficeLat isEqualToString:@""] || !strOfficeLat)
                {
                    [AZNotification showNotificationWithTitle:@"Please select place from location icon" controller:ROOTVIEW notificationType:AZNotificationTypeWarning];
                    return;
                }
                self.tblOfficeInfo.hidden=YES;
                self.tblUserinfo.hidden=NO;
                [self.tblUserinfo setContentOffset:CGPointZero animated:NO];
                if(username.length==0)
                {
                    username=[NSString stringWithFormat:@"%@ %@",objuser.firstname,objuser.lastname];
                }
                [self.tblUserinfo reloadData];
            }
        }
    }
}
- (IBAction)btnSummaryBackClicked:(id)sender
{
    self.tblUserinfo.hidden=NO;
    self.tblSummary.hidden=YES;
        [self.tblUserinfo setContentOffset:CGPointZero animated:NO];
}
- (IBAction)btnSummaryRegisterClicked:(id)sender
{
    @try {
    
    if([[NetworkAvailability instance]isReachable])
    {
        DOTDetails *objDot;
//        if([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData] !=nil)
//        {
//            objDot=[DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData];
//        }
//        else
//        {
//           
//        }
        CellMyAccountData *cellacdata=[_tblCompanyInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        objDot=[DOTDetails new];
        objDot.phyCity=cellacdata.txtcity.text;
        objDot.phyState=cellacdata.btnStatename.titleLabel.text;
        objDot.phyCountry=@"US";
        objDot.dotNumber=cellacdata.txtDotNumber.text;
        objDot.mcNumber=cellacdata.txtmcnumber.text;
        objDot.phyStreet=cellacdata.txtstreet.text;
        objDot.phyZipcode=cellacdata.txtzip.text;
        NSString *imgstr=@"";
        if(imageSelectedData!=nil)
        {
            imgstr=[Base64 encode:imageSelectedData];
        }
        else
        {
            imgstr=@"";
        }
        NSString *opadd=@"",*oadd;
        if ([addressFromOfficetbl isEqualToString:@"1"])
        {
            opadd=[arrSummaryCellAddress objectAtIndex:0];
        }
        else
        {
            opadd=addressOerating;
        }
        if(addressAddedManuallyOfficetbl==nil || addressAddedManuallyOfficetbl.length==0 || [addressAddedManuallyOfficetbl isEqualToString:@""])
        {
            oadd=[arrSummaryCellAddress objectAtIndex:0];;
        }
        else
        {
            oadd=addressAddedManuallyOfficetbl;
        }
        
        if (!isConditionVerified)
        {
            [AZNotification showNotificationWithTitle:@"Please agree to terms and conditions before making changes" controller:ROOTVIEW notificationType:AZNotificationTypeError];
            return;
        }

        @try
        {
            NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
            [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey] forKey:Req_secret_key];
            [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey] forKey:Req_access_key];
            [dicParam setValue:roltext forKey:Req_User_role];
            [dicParam setValue:roltext forKey:Req_Role];
            [dicParam setValue:objDot.phyCity forKey:Req_City];
            [dicParam setValue:objDot.phyState forKey:Req_State];
            [dicParam setValue:objDot.phyCountry forKey:Req_Country];
            [dicParam setValue:objDot.dotNumber forKey:Req_DotNumber];
            [dicParam setValue:objDot.mcNumber forKey:Req_McNumber];
            [dicParam setValue:@"" forKey:Req_CloseTime];
            [dicParam setValue:@"" forKey:Req_OpenTime];
            [dicParam setValue:[arrSummaryCellPhone objectAtIndex:0] forKey:Req_CmpnyPhoneNo];
            [dicParam setValue:[arrSummaryCellPhone objectAtIndex:1] forKey:Req_Office_Phone];
            [dicParam setValue:[arrSummaryCellPhone objectAtIndex:2] forKey:Req_Phone_no];
            [dicParam setValue:[arrSummaryCellCname objectAtIndex:0] forKey:Req_CompanyName];
            [dicParam setValue:strOfficeName forKey:Req_Office_name];
            [dicParam setValue:[arrSummaryCellAddress objectAtIndex:0] forKey:Req_CompanyAddress];
            [dicParam setValue:opadd forKey:Req_OfficeAddress];
            [dicParam setValue:objuser.primaryEmailId forKey:Req_SecondaryEmailId];
            [dicParam setValue:officeFaxnum forKey:Req_Ofiice_Fax];
            [dicParam setValue:oadd forKey:Req_OperatingAddress];
            [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:Req_User_Id];
            [dicParam setValue:imgstr forKey:Req_profile];
            [dicParam setValue:objDot.phyStreet forKey:Req_cstreet];
            [dicParam setValue:objDot.phyZipcode forKey:Req_czip];
            [dicParam setValue:objDot.operatingStatus == nil ? @"2"  :  objDot.operatingStatus forKey:Req_dotstatus];
            [dicParam setValue:strCompanyId forKey:@"company_id"];
            [dicParam setValue:strOfficeId forKey:@"office_id"];
            [dicParam setValue:strOfficeLat forKey:@"office_latitude"];
            [dicParam setValue:strOfficeLon forKey:@"office_longitude"];
            [dicParam setValue:@"1" forKey:@"is_condition_verified"];
            
//            NSDictionary *dicCreateAccount = @{
//                                               Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
//                                               Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
//                                               Req_User_role:roltext,
//                                               Req_Role:roltext,
//                                               Req_City:objDot.phyCity,
//                                               Req_State:objDot.phyState,
//                                               Req_Country:objDot.phyCountry,
//                                               Req_DotNumber:objDot.dotNumber,
//                                               Req_McNumber:objDot.mcNumber,
//                                               Req_CloseTime:@"",
//                                               Req_OpenTime:@"",
//                                               Req_CmpnyPhoneNo:[arrSummaryCellPhone objectAtIndex:0],
//                                               Req_Office_Phone:[arrSummaryCellPhone objectAtIndex:1],
//                                               Req_Phone_no:[arrSummaryCellPhone objectAtIndex:2],
//                                               Req_CompanyName:[arrSummaryCellCname objectAtIndex:0],
//                                               Req_Office_name:strOfficeName,
//                                               Req_CompanyAddress:[arrSummaryCellAddress objectAtIndex:0],
//                                               Req_OfficeAddress:opadd,
//                                               Req_SecondaryEmailId:objuser.primaryEmailId,
//                                               Req_Ofiice_Fax:officeFaxnum,
//                                               Req_OperatingAddress:oadd,
//                                               Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
//                                               Req_profile:imgstr,
//                                               Req_cstreet:objDot.phyStreet,
//                                               Req_czip:objDot.phyZipcode,
//                                               Req_dotstatus:objDot.operatingStatus == nil ? @"2"  :  objDot.operatingStatus,
//                                               @"company_id" : strCompanyId,
//                                               @"office_id" : strOfficeId
//                                               };
            [[WebServiceConnector alloc]
             init:URLCreateRoleAccount
             withParameters:dicParam
             withObject:self
             withSelector:@selector(getCreateAccountResponse:)
             forServiceType:@"JSON"
             showDisplayMsg:@"Processing"
             showProgress:YES];
        }
        @catch (NSException *exception) {
//            HomeVC *objHomeVC =initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
//            [AppInstance setDrawerWithCenterViewNamed:objHomeVC];
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
#pragma mark- click Events

- (IBAction)btnNavBarBackClicked:(id)sender 
{
    if(self.tblCompanyInfo.hidden==NO)
    {
        self.tblWelcome.hidden=NO;
        self.tblCompanyInfo.hidden=YES;
    }
    else if(self.tblOfficeInfo.hidden==NO)
    {
        self.tblCompanyInfo.hidden=NO;
        self.tblOfficeInfo.hidden=YES;
    }
    else if(self.tblUserinfo.hidden==NO)
    {
        self.tblOfficeInfo.hidden=NO;
        self.tblUserinfo.hidden=YES;
    }
    else if(self.tblSummary.hidden==NO)
    {
        self.tblUserinfo.hidden=NO;
        self.tblSummary.hidden=YES;
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)btnNavbarDrawerClicked:(id)sender 
{
        [self.view endEditing:YES];
     [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
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
        addressAddedManuallyOfficetbl=textFieldDot.text;
    }
    else
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
-(void)gatherAllAdedDataSummary
{
    @try {
        UITextField *txtofficephone = (UITextField*)[self.view viewWithTag:604];
        UITextField *txtofficefx = (UITextField*)[self.view viewWithTag:605];
        UITextField *txtcompanyname= (UITextField*)[self.view viewWithTag:31];
        UITextField *txtstrreet= (UITextField*)[self.view viewWithTag:34];
        UITextField *txtcity= (UITextField*)[self.view viewWithTag:35];
        UITextField *txtczip= (UITextField*)[self.view viewWithTag:37];
        //UITextField *txtcstate= (UITextField*)[self.view viewWithTag:36];
        UIButton *bnt=(UIButton *)[self.view viewWithTag:360];
        UITextField *txtcompanyphone= (UITextField*)[self.view viewWithTag:38];
        CellWelcomeUserInfo *cellselected=(CellWelcomeUserInfo*)[_tblUserinfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [arrSummaryCellCname replaceObjectAtIndex:0 withObject:txtcompanyname.text];
        [arrSummaryCellCname replaceObjectAtIndex:1 withObject:txtcompanyname.text];
        NSString *str=[NSString stringWithFormat:@"%@",cellselected.txtyourname.text];
        [arrSummaryCellCname replaceObjectAtIndex:2 withObject:str];
        [arrSummaryCellPhone replaceObjectAtIndex:0 withObject:txtcompanyphone.text];
        [arrSummaryCellPhone replaceObjectAtIndex:1 withObject:txtofficephone.text];
        [arrSummaryCellPhone replaceObjectAtIndex:2 withObject:cellselected.txtphonenumber.text];
        NSString *copmanyaddress=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",txtstrreet.text,txtcity.text,bnt.titleLabel.text,@"US",txtczip.text];
        
        NSString *officeAddStr=addressAddedManuallyOfficetbl;
        NSString *opAddress=addressOerating;
        if(addressAddedManuallyOfficetbl==nil || addressAddedManuallyOfficetbl.length==0 || [addressAddedManuallyOfficetbl isEqualToString:@""])
        {
            officeAddStr=copmanyaddress;
        }
        else
        {
            officeAddStr=addressAddedManuallyOfficetbl;
        }
        if(addressOerating==nil || addressOerating.length==0 || [addressOerating isEqualToString:@""])
        {
            opAddress=copmanyaddress;
        }
        else
        {
            opAddress=addressOerating;
        }
        [arrSummaryCellAddress replaceObjectAtIndex:0 withObject:copmanyaddress];
        [arrSummaryCellAddress replaceObjectAtIndex:1 withObject:opAddress];
        [arrSummaryCellAddress replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@\n\nOperating Address: \n\n %@",objuser.primaryEmailId,officeAddStr]];
        officeFaxnum=txtofficefx.text;
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
        if([roltext containsString:@"2"])
        {
            DOTDetails *objDot;
            if([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData] !=nil)
            {
                objDot=[DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDOTData];
                if([objDot.operatingStatus isEqualToString:@"0"])
                {
                   NSString *str= [NSString stringWithFormat:@"%@",@"You need to add active DOT information to post your asset.\n\nDo you want to update DOT information now ?"];
                    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"WARNING\nYour DOT# seems to be INACTIVE" message:str preferredStyle:UIAlertControllerStyleAlert];
                    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                                            {
                                                self.tblWelcome.hidden=NO;
                                                self.tblCompanyInfo.hidden=YES;
                                                self.tblOfficeInfo.hidden=YES;
                                                self.tblUserinfo.hidden=YES;
                                                self.tblSummary.hidden=YES;
                                            }]];       
                    [actionSheet addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                                            {
                                                [self dismissViewControllerAnimated:YES completion:^{}];
                                                self.tblSummary.hidden=NO;
                                                self.tblUserinfo.hidden=YES;
                                                [self.tblSummary setContentOffset:CGPointZero animated:NO];
                                                [self.tblSummary reloadData];
                                            }]];
                    [self presentViewController:actionSheet animated:YES completion:^{    }];
                }
                else
                {
                    [self dismissViewControllerAnimated:YES completion:^{}];
                    self.tblSummary.hidden=NO;
                    self.tblUserinfo.hidden=YES;
                    [self.tblSummary setContentOffset:CGPointZero animated:NO];
                    [self.tblSummary reloadData];
                }
            }
            else
            {
                self.tblSummary.hidden=NO;
                self.tblUserinfo.hidden=YES;
                [self.tblSummary setContentOffset:CGPointZero animated:NO];
                [self.tblSummary reloadData];
            }
        }
        else
        {
            self.tblSummary.hidden=NO;
            self.tblUserinfo.hidden=YES;
            [self.tblSummary setContentOffset:CGPointZero animated:NO];
            [self.tblSummary reloadData];
        }
    } @catch (NSException *exception) {
        
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

#pragma mark - webservice handling
-(void)registerWithDot
{
    UITextField *textFieldDot = (UITextField*)[self.view viewWithTag:501];
    UITextField *textFieldphone = (UITextField*)[self.view viewWithTag:500];
    if([self validateTxtLength:textFieldphone.text withMessage:RequiredPhoneNumberForDot] && [self validateTxtLength:textFieldDot.text withMessage:RequiredDotNumber])
    {
        [self showHUD:@"Requesting Details from DOT Number..."];
        if([[NetworkAvailability instance]isReachable])
        {
            NSDictionary *dicDotRequest = @{
                                            Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                            Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                            Req_DotNumber:textFieldDot.text
                                            };
            [[WebServiceConnector alloc]
             init:URLDotNumberDetail
             withParameters:dicDotRequest
             withObject:self
             withSelector:@selector(getDotResponse:)
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
-(IBAction)getDotResponse:(id)sender
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
            DOTDetails *userDotData= [[sender responseArray] objectAtIndex:0];
            NSString *dotnumber=[NSString stringWithFormat:@"%@",userDotData.dotNumber];
            userDotData.dotNumber=dotnumber;
            [DefaultsValues setCustomObjToUserDefaults:userDotData ForKey:SavedDOTData];
            [self.tblCompanyInfo setContentOffset:CGPointZero animated:NO];
            [self.tblCompanyInfo reloadData];
            [arrOfficeCellText removeAllObjects];
//            [arrOfficeCellText addObject:userDotData.phyStreet];
//             [arrOfficeCellText addObject:userDotData.phyCity];
//             [arrOfficeCellText addObject:userDotData.phyState];
//             [arrOfficeCellText addObject:userDotData.phyZipcode];
             [arrOfficeCellText addObject:phoneFromWelcometbl];
             [arrOfficeCellText addObject:officeFaxnum];
            [self.tblOfficeInfo reloadData];
            self.tblCompanyInfo.hidden=false;
            self.tblWelcome.hidden=true;           
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
-(IBAction)getCreateAccountResponse:(id)sender
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
            HomeVC *objHomeVC =initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
            [AppInstance setDrawerWithCenterViewNamed:objHomeVC];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}
-(ZSYPopoverListView *)showListView :(ZSYPopoverListView *)listviewname withSelectiontext :(NSString *)selectionm widthval:(CGFloat)w heightval :(CGFloat)h
{
    
    listviewname.backgroundColor=[UIColor whiteColor];
    listviewname = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0,0, w, h)];
    listviewname.center=self.view.center;
    listviewname.titleName.backgroundColor=[UIColor whiteColor];
    listviewname.titleName.text = [NSString stringWithFormat:@"%@",@"Select State"];
    listviewname.datasource = self;
    listviewname.delegate = self;
    listviewname.layer.cornerRadius=3.0f;
    listviewname.calledFor=@"Select State";
    listviewname.clipsToBounds=YES;
    
    [listviewname setDoneButtonWithTitle:@"" block:^{
        [overlayview removeFromSuperview];
    }];
    [listviewname setCancelButtonTitle:@"Done" block:^{
        [overlayview removeFromSuperview];
        CellMyAccountData *cell=[_tblCompanyInfo cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        for(NSIndexPath *index in stateSelected)
        {
            choosenstate=[arrstatelist objectAtIndex:index.row];
              [cell.btnStatename setTitle:choosenstate forState:UIControlStateNormal];
        }
    }];
    [self addOverlay];
    [self.view endEditing:YES];
    return listviewname;
}
- (IBAction)btnEditDotClicked:(id)sender
{
    
}
- (IBAction)btnstatenameclicked:(id)sender
{
    arrstatelist=[NSMutableArray new];
    arrstatelist=[self getUsStates];
    listView= [self showListView:listView withSelectiontext:@"Select State" widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT-100];
    [listView show];
}
-(void)addOverlay
{
    overlayview = [[UIView alloc] initWithFrame:CGRectMake(0,  0,self.view.frame.size.width, SCREEN_HEIGHT)];
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
#pragma mark -table view delegate datasource for popup view
-(CGFloat)popoverListView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 40;
}
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try {
        return arrstatelist.count;
    }
    @catch (NSException *exception) {
        
    }
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
- (IBAction)btnuserinfocmpanyaddrClicked:(id)sender 
{
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
@end
