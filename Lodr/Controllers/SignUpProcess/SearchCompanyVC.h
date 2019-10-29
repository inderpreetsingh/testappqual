//
//  SearchCompanyVC.h
//  Lodr
//
//  Created by C205 on 18/12/18.
//  Copyright © 2018 checkmate. All rights reserved.
//

#import "BaseVC.h"
#import "CompanyDetails.h"
#import "OfficeDetails.h"

@protocol SearchCompanyVCDelegate <NSObject>

@optional

- (void)didSelectCompany:(id)companyDetails;
- (void)didSelectAddNewCompany:(BOOL)isCompany;

@end

@interface SearchCompanyVC : BaseVC

@property (weak, nonatomic) id<SearchCompanyVCDelegate> delegate;

@property (strong, nonatomic) NSString *strCompanyId;
@property (assign, nonatomic) SearchDetailsType selectedSearchType;

@property (weak, nonatomic) IBOutlet UISearchBar *searchCompany;
@property (weak, nonatomic) IBOutlet UITableView *tblCompany;
@property (weak, nonatomic) IBOutlet UIButton *btnCompany;
@property (weak, nonatomic) IBOutlet UILabel *lblTblPlaceholder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerBtnCompany;

@end
