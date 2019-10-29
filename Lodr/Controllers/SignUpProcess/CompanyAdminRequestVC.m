//
//  CompanyAdminRequestVC.m
//  Lodr
//
//  Created by C205 on 26/06/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import "CompanyAdminRequestVC.h"
#import "CoAdminReqCell.h"

typedef enum {
    RequestActionTypeAccept = 0,
    RequestActionTypeIgnore
}RequestActionType;

@interface CompanyAdminRequestVC () <UITableViewDataSource, UITableViewDelegate>
{
    CompanyRequest *objSelRequest;
    RequestActionType selActionType;
}
@end

@implementation CompanyAdminRequestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tblRequests.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

#pragma mark - Button Click Events

- (IBAction)btnBackClicked:(id)sender
{
    [self.view endEditing:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (IBAction)btnAcceptClicked:(id)sender
{
    [self.view endEditing:YES];
    
    selActionType = RequestActionTypeAccept;
    [self updateRequestStatusWithSender:sender];
}

- (IBAction)btnIgnoreClicked:(id)sender
{
    [self.view endEditing:YES];
    
    selActionType = RequestActionTypeIgnore;
    [self updateRequestStatusWithSender:sender];
}

- (void)updateRequestStatusWithSender:(UIButton *)sender
{
    CoAdminReqCell *cell = (CoAdminReqCell *)[self getCellForClassName:NSStringFromClass([CoAdminReqCell class]) withSender:sender];
    
    if (cell != nil)
    {
        NSIndexPath *idPath = [_tblRequests indexPathForCell:cell];
        objSelRequest = [_arrRequests objectAtIndex:idPath.row];
        
        [self showHUD:@"Fetching company admin requests"];
        
        if ([[NetworkAvailability instance] isReachable])
        {
            NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
            [dicParam setValue:selActionType == RequestActionTypeAccept ? @"1" : @"2" forKey:@"request_status"];
            [dicParam setValue:[NSString stringWithFormat:@"%ld", (NSInteger)objSelRequest.requesId] forKey:@"request_id"];
            [dicParam setValue:_strCompanyId forKey:@"company_id"];
            [dicParam setValue:[NSString stringWithFormat:@"%ld", (NSInteger)objSelRequest.userId] forKey:@"other_user_id"];
            [dicParam setValue:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId] forKey:@"user_id"];
            
            [[WebServiceConnector alloc] init:_selRequestType == RequestTypeCompany ? URLAcceptRejectCompanyAdmin : URLAcceptRejectOfficeAdmin
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
            if (selActionType == RequestActionTypeAccept) {
                
                User *objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
                
                if (objuser.userAccount.count > 0)
                {
                    UserAccount *objuserac = [objuser.userAccount objectAtIndex:0];
                    if (_selRequestType == RequestTypeCompany) {
                        objuserac.isCompanyAdmin = 0;
                    } else {
                        objuserac.isOfficeAdmin = 0;
                    }
                    objuser.userAccount = @[objuserac];
                    [DefaultsValues setCustomObjToUserDefaults:objuser ForKey:SavedUserData];
                    
                    if ([_delegate respondsToSelector:@selector(didAcceptRequest)]) {
                        [_delegate didAcceptRequest];
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                NSUInteger index = [_arrRequests indexOfObject:objSelRequest];
                [_arrRequests removeObject:objSelRequest];
                [_tblRequests beginUpdates];
                [_tblRequests deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
                [_tblRequests endUpdates];
                
                if (_arrRequests.count == 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
            }
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrRequests.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoAdminReqCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCoAdminReqCell"];
    
    CompanyRequest *objRequest = [_arrRequests objectAtIndex:indexPath.row];
    
    NSString *strImgUrl;
    
    if ([objRequest.profilePicture containsString:@"http://"] || [objRequest.profilePicture containsString:@"https://"])
    {
        strImgUrl = [NSString stringWithFormat:@"%@", objRequest.profilePicture];
    }
    else
    {
        strImgUrl = [NSString stringWithFormat:@"%@%@", URLProfileImage, objRequest.profilePicture];
    }
    
    [cell.imgProfile sd_setImageWithURL:[NSURL URLWithString:strImgUrl]
                       placeholderImage:[UIImage imageNamed:@"noimage"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  if(image != nil)
                                  {
                                      cell.imgProfile.image = image;
                                  }
                              }];
    
    cell.lblUsername.text = [NSString stringWithFormat:@"%@ %@", objRequest.firstname, objRequest.lastname];
    
    [cell.btnAccept addTarget:self action:@selector(btnAcceptClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnIgnore addTarget:self action:@selector(btnIgnoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return  cell;
}


@end
