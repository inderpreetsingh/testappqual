//
//  DotRegistrationVC.h
//  Lodr
//
//  Created by c196 on 26/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellAccountHeader.h"
#import "CellWelcome.h"
#import "CellMyAccountData.h"
#import "CellTextfields.h"
#import "CellWelcomeSummary.h"
#import "CellWelcomeFooter.h"
#import "DOTDetails.h"
#import "CellListWithCheckBox.h"
#import "CellWelcomeUserInfo.h"
#import "Function.h"
#import "ZSYPopoverListView.h"

@interface DotRegistrationVC : BaseVC <UITableViewDelegate, UITableViewDataSource, CellAccountHeaderDelegate, CellWelcomeFooterDelegate, UITextViewDelegate, CellListWithCheckBoxDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CellMyAccountDataDelegate, ZSYPopoverListDelegate, ZSYPopoverListDatasource, CellWelcomeUserInfoDelegate>

@property (assign, nonatomic) BOOL isCompanyFieldEnabled;
@property (assign, nonatomic) BOOL isOfficeFieldEnabled;

@property (weak, nonatomic) IBOutlet UIView *vwNavbar;
@property (weak, nonatomic) IBOutlet UIButton *btnWelcomeBack;
@property (weak, nonatomic) IBOutlet UITableView *tblWelcome;
@property (weak, nonatomic) IBOutlet UIButton *btnNavbarDrawer;
@property (weak, nonatomic) IBOutlet UITableView *tblCompanyInfo;
@property (weak, nonatomic) IBOutlet UITableView *tblOfficeInfo;
@property (weak, nonatomic) IBOutlet UITableView *tblUserinfo;
@property (weak, nonatomic) IBOutlet UITableView *tblSummary;
@property (weak, nonatomic) NSString *redirectfrom;

- (IBAction)btnNavBarBackClicked:(id)sender;
- (IBAction)btnNavbarDrawerClicked:(id)sender;

@end
