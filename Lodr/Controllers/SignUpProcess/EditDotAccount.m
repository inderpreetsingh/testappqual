//
//  EditDotAccount.m
//  Lodr
//
//  Created by c196 on 10/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "EditDotAccount.h"
#import "User.h"
#import "UserAccount.h"
#import "EditUserInfoVC.h"
#import "EditOfficeInfoVC.h"
#import "EditCompanyInfoVC.h"

typedef enum
{
    AssetAvailabilityUnlimited = 2001,
    AssetAvailabilityUSCanada,
    AssetAvailabilityUSInterstate,
    AssetAvailabilityUSIntrastate
}AssetAvailability;

@interface EditDotAccount ()
{
    NSArray *arrSummaryCellHeading,*nibHeader,*nibFooter;
    NSMutableArray *arrSummaryCellAddress,*arrSummaryCellPhone,*arrSummaryCellCname;
    CellAccountHeader *tblheader;
    CellWelcomeFooter *tblFooter;
    UserAccount *objuserac;
    User *objuser;
    
    AssetAvailability selectedAvailability;
}
@end

@implementation EditDotAccount

#pragma mark - Life Cycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    NavigationBarHidden(YES);
    
    [self callDisplatAccountData];
    
    NSInteger intSelectedAvailablility = [DefaultsValues getIntegerValueFromUserDefaults_ForKey:SavedAvailability];
    selectedAvailability = ((AssetAvailability)intSelectedAvailablility) + AssetAvailabilityUnlimited;
}

- (void)callDisplatAccountData
{
    objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    
    if (objuser.userAccount.count > 0)
    {
        objuserac = [objuser.userAccount objectAtIndex:0];
    }
    
    arrSummaryCellHeading = [NSArray arrayWithObjects:@"COMPANY", @"OFFICE / HUB", @"USER INFO", nil];
    
    self.tblMyAccount.rowHeight = UITableViewAutomaticDimension;
    self.tblMyAccount.estimatedRowHeight = 195;
    
    arrSummaryCellPhone = [NSMutableArray new];
    [arrSummaryCellPhone addObject:objuserac.cmpnyPhoneNo];
    [arrSummaryCellPhone addObject:objuserac.officePhoneNo == nil ? @"" : objuserac.officePhoneNo];
    [arrSummaryCellPhone addObject:objuserac.phoneNo];
    
    arrSummaryCellAddress = [NSMutableArray new];
    [arrSummaryCellAddress addObject:objuserac.companyAddress];
    
    if (objuserac.officeAddress.length == 0)
    {
        [arrSummaryCellAddress addObject:objuserac.companyAddress];
    }
    else
    {
        [arrSummaryCellAddress addObject:objuserac.officeAddress];
    }
    
    if (objuserac.operatingAddress.length == 0)
    {
        [arrSummaryCellAddress addObject:[NSString stringWithFormat:@"%@\n\n%@", objuser.primaryEmailId, objuserac.companyAddress]];
    }
    else
    {
        [arrSummaryCellAddress addObject:[NSString stringWithFormat:@"%@\n\n%@", objuser.primaryEmailId, objuserac.operatingAddress]];
    }
    
    arrSummaryCellCname = [NSMutableArray new];
    [arrSummaryCellCname addObject:objuserac.companyName];
    [arrSummaryCellCname addObject:objuserac.officeName == nil ? @"" : objuserac.officeName];
    
    [arrSummaryCellCname addObject:[NSString stringWithFormat:@"%@ %@", [objuser.firstname capitalizedString], [objuser.lastname capitalizedString]]];
    [self.tblMyAccount reloadData];
}

- (void)reloadDetailsAfterEdit
{
    [self callDisplatAccountData];
}

- (void)reloadDetailsAfterEdit_Office
{
    [self callDisplatAccountData];
}

- (void)reloadDetailsAfterEdit_User
{
    [self callDisplatAccountData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrSummaryCellHeading.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tblheader == nil)
    {
        nibHeader = [[NSBundle mainBundle] loadNibNamed:@"CellAccountHeader" owner:self options:nil];
        tblheader = [[CellAccountHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblMyAccount.frame.size.width, 420)];
        tblheader = (CellAccountHeader *)[nibHeader objectAtIndex:0];
    }
    
    tblheader.heightOperatingAddress.constant = 0;
    tblheader.lblLargeTitle.text = @"My Account";
    tblheader.lblSubtitleSmall.text = @"Setup your account";
    tblheader.heigthlblpagename.constant = 0;
    tblheader.lblOfiiceInfoText.clipsToBounds = YES;
    tblheader.heightHeaderHeading.constant = 105;
    tblheader.heightOfficeIHeader.constant = 0;
    tblheader.vwHeaderOfficeInfo.clipsToBounds = YES;
    
    return tblheader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return tblFooter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellWelcomeSummary";
    CellWelcomeSummary *cell = (CellWelcomeSummary*)[_tblMyAccount dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) 
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.cellWelcomeSummaryDelegate = self;
    cell.btnEditAccount.hidden = NO;
    cell.btnEditAccount.tag = indexPath.row;
    
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
    [cell.imguserimage sd_setImageWithURL:imgurl
                         placeholderImage:nil
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    if(image !=nil)
                                    {
                                        cell.imguserimage.image=image;
                                    }
                                }];
    
    NSString *roltext = objuserac.role;
    
    if (indexPath.row == 0)
    {
        cell.heightimage.constant = 0;
        cell.heightroles.constant = 100;
        
        cell.btndriver.hidden = YES;
        cell.btncarrier.hidden = NO;
        cell.btnshipper.hidden = NO;
        
        cell.topBtnDriver.constant = 20.0f;
        cell.heightBtnDriver.constant = 0.0f;
        cell.topBtnLoads.constant = 0.0f;
        
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
    else if (indexPath.row == 1)
    {
        cell.heightimage.constant = 0;
        cell.heightroles.constant = 0;
        
        cell.btndriver.hidden = YES;
        cell.btncarrier.hidden = YES;
        cell.btnshipper.hidden = YES;
    }
    else if (indexPath.row == 2)
    {
        cell.heightimage.constant = 150;
        cell.heightroles.constant = 50;
        
        cell.btndriver.hidden = NO;
        cell.btncarrier.hidden = YES;
        cell.btnshipper.hidden = YES;
        
        cell.topBtnDriver.constant = 14.0f;
        
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
    else if (indexPath.row == 0)
    {
        cell.heightimage.constant = 0;
        cell.heightroles.constant = 0;
    }
    
    cell.vwAvailability.hidden = YES;
//    cell.vwAvailability.hidden = indexPath.row != 0;
    
    if (indexPath.row == 0)
    {
        cell.lblMcNumber.text = [NSString stringWithFormat:@"MC#%@", objuserac.mcNumber];
        cell.heightLblMcNumber.constant = 22.0f;
        cell.topLblMcNumber.constant = 5.0f;
        cell.topLblDotNumber.constant = 5.0f;
        cell.heightVwAvailability.constant = 0.0f;
//        cell.heightVwAvailability.constant = 210.0f;

        if (objuserac.dotNumber.length != 0 || objuserac.dotNumber != nil)
        {
            cell.lblsummarydot.text = [NSString stringWithFormat:@"DOT#%@", objuserac.dotNumber];
            cell.heightDotNumber.constant = 22;
        }
        else
        {
            cell.lblsummarydot.text = @"";
            cell.heightDotNumber.constant = 0;
        }
        
        [self clearAvailabilityForCell:cell];
        [self manageAvailability:selectedAvailability forCell:cell];

        [cell.btnAvailabilityUnlimited addTarget:self action:@selector(btnAvailabilityClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnAvailabilityUSCanada addTarget:self action:@selector(btnAvailabilityClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnAvailabilityInterstate addTarget:self action:@selector(btnAvailabilityClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnAvailabilityIntrastate addTarget:self action:@selector(btnAvailabilityClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        cell.lblsummarydot.text = @"";
        cell.lblMcNumber.text = @"";
        cell.heightDotNumber.constant = 0;
        cell.heightLblMcNumber.constant = 0.0f;
        cell.topLblMcNumber.constant = 0.0f;
        cell.topLblDotNumber.constant = 0.0f;
        
        cell.heightVwAvailability.constant = 0.0f;
    }
    
    [cell.contentView layoutIfNeeded];

    cell.lblSummaryHeading.text = [arrSummaryCellHeading objectAtIndex:indexPath.row];
    cell.lblsummaryOfficename.text = [arrSummaryCellCname objectAtIndex:indexPath.row];
    cell.lblsummaryaddress.text = [arrSummaryCellAddress objectAtIndex:indexPath.row];
    cell.lblsummaryaddress.numberOfLines = 0;
    [cell.lblsummaryaddress sizeToFit];
    cell.lblsummaryaddress.frame = CGRectMake(0, cell.lblsummaryaddress.frame.origin.y, SCREEN_WIDTH, cell.lblsummaryaddress.frame.size.height);
    cell.lblsummaryaddress.textAlignment = NSTextAlignmentCenter;
    cell.lblsummaryphone.text = [arrSummaryCellPhone objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{  
    return 0;
}

- (IBAction)btnAvailabilityClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    CellWelcomeSummary *cell = [_tblMyAccount cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [self clearAvailabilityForCell:cell];
    [self manageAvailability:(AssetAvailability)[sender tag] forCell:cell];
    
    selectedAvailability = (AssetAvailability)[sender tag] - AssetAvailabilityUnlimited;
    NSLog(@"%u", selectedAvailability);
//    dispatch_async(dispatch_get_main_queue(), ^{
        [DefaultsValues setIntegerValueToUserDefaults:selectedAvailability ForKey:SavedAvailability];
//    });
}

- (void)clearAvailabilityForCell:(CellWelcomeSummary *)cell
{
    UIButton *btn1 = ((UIButton *)[cell.vwAvailability viewWithTag:3001]);
    UIButton *btn2 = ((UIButton *)[cell.vwAvailability viewWithTag:3002]);
    UIButton *btn3 = ((UIButton *)[cell.vwAvailability viewWithTag:3003]);
    UIButton *btn4 = ((UIButton *)[cell.vwAvailability viewWithTag:3004]);
    
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

- (void)manageAvailability:(AssetAvailability)assetAvailability forCell:(CellWelcomeSummary *)cell
{
    UIButton *btnAvailability = ((UIButton *)[cell.vwAvailability viewWithTag:assetAvailability + 1000]);
    
    [btnAvailability setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
    btnAvailability.backgroundColor = [UIColor orangeColor];
    btnAvailability.layer.borderWidth = 0.0f;
}

#pragma mark - Button Click Events

- (IBAction)btnDrawerClicked:(id)sender
{
    [self.view endEditing:YES];
    
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (IBAction)btnEditProfileClicked:(id)sender 
{
    if ([sender tag] == 0)
    {
        EditCompanyInfoVC *objeDetail=initVCToRedirect(SBMAIN, EDITCOMPANYINFOVC);
        objeDetail.EditCompanyInfoVCProtocol = self;
        [self.navigationController pushViewController:objeDetail animated:YES];
    }
    else if ([sender tag] == 1)
    {
        EditOfficeInfoVC *objeDetail=initVCToRedirect(SBMAIN, EDITOFFICEINFOVC);
        objeDetail.EditOfficeInfoVCProtocol = self;
        [self.navigationController pushViewController:objeDetail animated:YES];
    }
    else
    {
        EditUserInfoVC *objeDetail=initVCToRedirect(SBMAIN, EDITUSERINFOVC);
        objeDetail.EditUserInfoVCProtocol = self;
        [self.navigationController pushViewController:objeDetail animated:YES];
    }
}
@end
