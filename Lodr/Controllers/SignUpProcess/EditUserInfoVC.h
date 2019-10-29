//
//  EditUserInfoVC.h
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
#import "CellListWithCheckBox.h"
#import "DOTDetails.h"
#import "Base64.h"
#import "CellWelcomeUserInfo.h"
#import "SPGooglePlacesAutocompleteViewController.h"
#import "CQMFloatingController.h"
#import "Function.h"
@protocol EditUserInfoVCProtocol <NSObject>
@optional
-(void)reloadDetailsAfterEdit_User;
@end
@interface EditUserInfoVC : BaseVC<CellAccountHeaderDelegate,CellWelcomeFooterDelegate,
UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CellWelcomeUserInfoDelegate,CellListWithCheckBoxDelegate,UITextViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblUserinfo;
@property (strong, nonatomic) IBOutlet UIView *vwnavbar;
- (IBAction)btnbackclciked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnRightClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnRight;
@property(nonatomic,assign)id EditUserInfoVCProtocol;
@end
