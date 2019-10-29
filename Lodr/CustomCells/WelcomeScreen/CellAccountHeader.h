//
//  CellAccountHeader.h
//  Lodr
//
//  Created by Payal Umraliya on 14/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
@protocol CellAccountHeaderDelegate
@optional
- (IBAction)btnSameAsCompanyCheckboxClicked:(id)sender;
- (IBAction)btnmapviewclicked:(id)sender;
- (IBAction)btnOpetingAddressClicked:(id)sender;
@end
@interface CellAccountHeader : UIView
@property (weak, nonatomic) IBOutlet UIView *vwWithHeadingText;
@property (weak, nonatomic) IBOutlet UIView *vwHeaderOfficeInfo;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *txtOperatingAddress;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heigthlblpagename;
@property (weak, nonatomic) IBOutlet UITextView *txtvwAddressOffic;
@property (weak, nonatomic) IBOutlet UIButton *btnOperatingAddress;
- (IBAction)btnOpetingAddressClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeName;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@property (weak, nonatomic) IBOutlet UIButton *btnSameAsComapnyAddressCheckbox;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOperatingAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblLargeTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitleSmall;
- (IBAction)btnmapviewclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblOfiiceInfoText;
@property (weak, nonatomic) IBOutlet UIButton *lblmapmaker;

- (IBAction)btnSameAsCompanyCheckboxClicked:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightHeaderHeading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfficeIHeader;
@property (nonatomic, weak) id <CellAccountHeaderDelegate> cellAccountHeaderDelegate;
@end
