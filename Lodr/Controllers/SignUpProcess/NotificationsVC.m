//
//  NotificationsVC.m
//  Lodr
//
//  Created by C205 on 05/03/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import "NotificationsVC.h"
#import "CompanyRequestCell.h"
#import "CompanyRequest.h"

typedef enum
{
    RequestActionConfirm = 0,
    RequestActionReject
}RequestAction;

@interface NotificationsVC () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *arrRequests;
    
    UserAccount *objUserAccount;
}
@end

@implementation NotificationsVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NavigationBarHidden(YES);

    _tblRequests.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    User *objUser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
    
    if (objUser.userAccount.count > 0)
    {
        objUserAccount = objUser.userAccount[0];
        
        if ((BOOL)objUserAccount.isCompanyAdmin)
        {
            [self fetchRequestsWithLoader:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:@"Only admins can accept/reject requests" controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Web Service Call

- (void)fetchRequestsWithLoader:(BOOL)showLoader
{
    if ([[NetworkAvailability instance] isReachable])
    {
        NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
        [dicParam setValue:objUserAccount.companyId forKey:@"company_id"];
        
        [[WebServiceConnector alloc] init:URLGetCompanyRequest
                           withParameters:dicParam
                               withObject:self
                             withSelector:@selector(handleRequestsResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:@"Fetching Requests"
                             showProgress:showLoader];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

- (IBAction)handleRequestsResponse:(id)sender
{
    [self dismissHUD];
    
    if ([sender serviceResponseCode] != 100)
    {
        if ([sender serviceResponseCode] == -1005 || [sender serviceResponseCode] == -1001)
        {
            
        }
        else
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
    else
    {
        if ([APIResponseStatus isEqualToString:APISuccess])
        {
            arrRequests = [[NSMutableArray alloc] initWithArray:[sender responseArray]];
            [_tblRequests reloadData];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

#pragma mark - Button Click Events

- (IBAction)btnBackClicked:(id)sender
{
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnMenuClicked:(id)sender
{
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (IBAction)btnConfirmClicked:(id)sender
{
    [self.view endEditing:YES];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self handleRequestAction:RequestActionConfirm forSender:sender];
    });
}

- (IBAction)btnRejectClicked:(id)sender
{
    [self.view endEditing:YES];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self handleRequestAction:RequestActionReject forSender:sender];
    });
}

- (void)handleRequestAction:(RequestAction)reqAction forSender:(id)sender
{
    CompanyRequestCell *cell = (CompanyRequestCell *)[self getCellForClassName:NSStringFromClass([CompanyRequestCell class]) withSender:sender];
    NSIndexPath *idPath = [_tblRequests indexPathForCell:cell];
    CompanyRequest *objRequest = [arrRequests objectAtIndex:idPath.row];
    
    if ([[NetworkAvailability instance] isReachable])
    {
        NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
        [dicParam setValue:[NSString stringWithFormat:@"%ld", (NSInteger)objRequest.requesId] forKey:@"request_id"];
        [dicParam setValue:reqAction == RequestActionConfirm ? @"1" : @"2" forKey:@"request_status"];
        
        [[WebServiceConnector alloc] init:URLAcceptRejectRequest
                           withParameters:dicParam
                               withObject:self
                             withSelector:@selector(handleRequestActionResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:@"Please wait"
                             showProgress:YES];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

- (IBAction)handleRequestActionResponse:(id)sender
{
    [self dismissHUD];
    
    if ([sender serviceResponseCode] != 100)
    {
        if ([sender serviceResponseCode] == -1005 || [sender serviceResponseCode] == -1001)
        {
            
        }
        else
        {
            [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
    else
    {
        if ([APIResponseStatus isEqualToString:APISuccess])
        {
            [self fetchRequestsWithLoader:YES];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

- (UIView *)getCellForClassName:(NSString *)classname
                     withSender:(id)sender
{
    UIView *superview = [sender superview];
    
    while (![superview isKindOfClass:NSClassFromString(classname)])
    {
        superview = [superview superview];
    }
    
    return superview;
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrRequests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCompanyRequestCell"];
    
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CompanyRequestCell class]) bundle:nil] forCellReuseIdentifier:@"idCompanyRequestCell"];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CompanyRequestCell class]) owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    CompanyRequest *objRequest = [arrRequests objectAtIndex:indexPath.row];
    
    NSString *strProfileUrl;
    
    if ([objRequest.profilePicture containsString:@"http://"] || [objRequest.profilePicture containsString:@"https://"])
    {
        strProfileUrl = [NSString stringWithFormat:@"%@", objRequest.profilePicture];
    }
    else
    {
        strProfileUrl = [NSString stringWithFormat:@"%@%@", URLProfileImage, objRequest.profilePicture];
    }
    
    NSURL *imgurl = [NSURL URLWithString:strProfileUrl];
    [cell.imgProfile sd_setImageWithURL:imgurl
                       placeholderImage:nil
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  if (image != nil)
                                  {
                                      cell.imgProfile.image = image;
                                  }
                              }];

    
    NSString *strUserName = @"";
    if (objRequest.firstname.length > 0)
    {
        strUserName = [NSString stringWithFormat:@"%@", objRequest.firstname];
        
        if (objRequest.lastname.length > 0)
        {
            strUserName = [strUserName stringByAppendingString:@" "];
        }
    }
    
    if (objRequest.lastname.length > 0)
    {
        strUserName = [strUserName stringByAppendingString:objRequest.lastname];
    }
    cell.lblRequestText.text = [NSString stringWithFormat:@"%@ belongs to your company?", strUserName];
    
    [cell.btnConfirm addTarget:self action:@selector(btnConfirmClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnReject addTarget:self action:@selector(btnRejectClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

@end
