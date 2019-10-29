//
//  SearchCompanyVC.m
//  Lodr
//
//  Created by C205 on 18/12/18.
//  Copyright © 2018 checkmate. All rights reserved.
//

#import "SearchCompanyVC.h"

@interface SearchCompanyVC () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    User *objUser;
    
    NSMutableArray *arrCompanyResults;
}
@end

@implementation SearchCompanyVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    objUser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];

    switch (_selectedSearchType)
    {
        case SearchDetailsTypeCompany:
        {
            _searchCompany.placeholder = @"Search Company";
        }
            break;
            
        case SearchDetailsTypeOffice:
        {
            _lblTblPlaceholder.text = @"NO OFFICE FOUND";
            _searchCompany.placeholder = @"Search Office";
            
            if (_strCompanyId)
            {
                [self getAllOffices];
            }
        }
            break;
            
        default:
            break;
    }

    _tblCompany.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - WS Call

- (void)getAllOffices
{
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];
    [dicParam setValue:_strCompanyId forKey:@"company_id"];
    [dicParam setValue:objUser.internalBaseClassIdentifier forKey:@"user_id"];
    
    if ([[NetworkAvailability instance] isReachable])
    {
        [[WebServiceConnector alloc] init:URLFetchAllOffice
                           withParameters:dicParam
                               withObject:self
                             withSelector:@selector(getSearchResultsResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:@"Loading offices"
                             showProgress:NO];
    }
}

- (void)searchCompany:(NSString *)strSearchText
{
    NSString *strSearchUrl, *strMessage;
    
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] init];

    switch (_selectedSearchType)
    {
        case SearchDetailsTypeCompany:
        {
            strSearchUrl = URLSearchCompany;
            strMessage = @"Searching Companies";
            [dicParam setValue:strSearchText forKey:@"company_name"];
            [dicParam setValue:objUser.internalBaseClassIdentifier forKey:@"user_id"];
        }
            break;
            
        case SearchDetailsTypeOffice:
        {
            strSearchUrl = URLSearchOffice;
            strMessage = @"Searching Offices";
            [dicParam setValue:strSearchText forKey:@"office_name"];
            
            if (objUser.userAccount.count > 0)
            {
                UserAccount *objAccount = objUser.userAccount[0];
                [dicParam setValue:objAccount.companyId forKey:@"company_id"];
            }
            
            [dicParam setValue:objUser.internalBaseClassIdentifier forKey:@"user_id"];
        }
            break;
            
        default:
        {
            return;
        }
            break;
    }
    
    if ([[NetworkAvailability instance] isReachable])
    {
        [[WebServiceConnector alloc] init:strSearchUrl
                           withParameters:dicParam
                               withObject:self
                             withSelector:@selector(getSearchResultsResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:strMessage
                             showProgress:NO];
    }
    else
    {
        [self dismissHUD];
        [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

- (IBAction)getSearchResultsResponse:(id)sender
{
    arrCompanyResults = [[NSMutableArray alloc] initWithArray:[sender responseArray]];
    
    _lblTblPlaceholder.hidden = arrCompanyResults.count > 0;
    _tblCompany.hidden = arrCompanyResults.count == 0;
    
    [_tblCompany reloadData];
}

#pragma mark - UISearchBar Delegate Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0)
    {
        arrCompanyResults = [[NSMutableArray alloc] init];
        
        _lblTblPlaceholder.hidden = YES;
        _tblCompany.hidden = NO;

        [_tblCompany reloadData];
    }
    else
    {
        [self searchCompany:searchText];
    }
}

#pragma mark - Button Click Events

- (IBAction)btnBackClicked:(id)sender
{
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnCompanyClicked:(id)sender
{
    [self.view endEditing:YES];
    
    if ([_delegate respondsToSelector:@selector(didSelectAddNewCompany:)])
    {
        [_delegate didSelectAddNewCompany:_selectedSearchType == SearchDetailsTypeCompany];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrCompanyResults.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(didSelectCompany:)])
    {
        [_delegate didSelectCompany:arrCompanyResults[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *cellId = @"idCompanyDetailsCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UITableViewCell class]) bundle:nil] forCellReuseIdentifier:cellId];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([UITableViewCell class]) owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    switch (_selectedSearchType)
    {
        case SearchDetailsTypeCompany:
        {
            CompanyDetails *objCompany = arrCompanyResults[indexPath.row];
            cell.textLabel.text = objCompany.companyName;
        }
            break;
            
        case SearchDetailsTypeOffice:
        {
            OfficeDetails *objCompany = arrCompanyResults[indexPath.row];
            cell.textLabel.text = objCompany.officeName;
        }
            break;
            
        default:
            break;
    }

    return cell;
}

@end
