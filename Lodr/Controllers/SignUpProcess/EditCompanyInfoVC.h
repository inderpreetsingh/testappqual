//
//  EditCompanyInfoVC.h
//  Lodr
//
//  Created by c196 on 11/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellAccountHeader.h"
#import "CellWelcomeFooter.h"
#import "CellMyAccountData.h"
#import "User.h"
#import "UserAccount.h"
#import "ZSYPopoverListView.h"
#import "CellListWithCheckBox.h"
#import "DOTDetails.h"
@protocol EditCompanyInfoVCProtocol <NSObject>
@optional
-(void)reloadDetailsAfterEdit;
@end
@interface EditCompanyInfoVC : BaseVC <CellAccountHeaderDelegate,CellWelcomeFooterDelegate,CellMyAccountDataDelegate,UITableViewDelegate,UITableViewDataSource,ZSYPopoverListDelegate,ZSYPopoverListDatasource,CellListWithCheckBoxDelegate>

@property (assign, nonatomic) BOOL isCompanyFieldEnabled;
@property (strong, nonatomic) NSString *strMcNumber;
@property (strong, nonatomic) IBOutlet UITableView *tblCompanyInfo;
@property (strong, nonatomic) IBOutlet UIView *vwnavbar;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnDrawer;
@property(nonatomic,assign)id EditCompanyInfoVCProtocol;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnDrawerClicked:(id)sender;

@end
