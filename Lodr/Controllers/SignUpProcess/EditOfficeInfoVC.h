//
//  EditOfficeInfoVC.h
//  Lodr
//
//  Created by c196 on 11/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellAccountHeader.h"
#import "CellWelcomeFooter.h"
#import "User.h"
#import "UserAccount.h"
#import "DOTDetails.h"
#import "SPGooglePlacesAutocompleteViewController.h"
#import "CQMFloatingController.h"
#import "CellTextfields.h"
@protocol EditOfficeInfoVCProtocol <NSObject>
@optional
-(void)reloadDetailsAfterEdit_Office;
@end

@interface EditOfficeInfoVC : BaseVC<CellAccountHeaderDelegate,CellWelcomeFooterDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>

@property (assign, nonatomic) BOOL isOfficeFieldEnabled;

@property (strong, nonatomic) IBOutlet UITableView *tblOfficeinfo;
@property (strong, nonatomic) IBOutlet UIView *vwnavabar;
- (IBAction)btnBackClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnDrawerClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnDrawer;
@property(nonatomic,assign)id EditOfficeInfoVCProtocol;

@end
