//
//  CellPostDriverHeader.h
//  Lodr
//
//  Created by c196 on 12/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellPostDriverHeaderDelegate
@optional
- (IBAction)btnOpenSavedDrvierClicked:(id)sender;
- (IBAction)btnDriverAddressClicked:(id)sender;
- (IBAction)btndriverVisibilityClicked:(id)sender;
@end

@interface CellPostDriverHeader : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblHeadingText;
@property (weak, nonatomic) IBOutlet UIView *vwPostDriverHeader;
@property (weak, nonatomic) IBOutlet UIView *vwHeadings;
@property (weak, nonatomic) IBOutlet UIButton *btnOpenSavedDrvier;
@property (weak, nonatomic) IBOutlet UIView *vwDriverDetails;
@property (weak, nonatomic) IBOutlet UITextField *txtDriverName;
@property (weak, nonatomic) IBOutlet UIButton *btnDriverAddrss;
@property (weak, nonatomic) IBOutlet UITextField *txtDriverPhone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVwheading;
@property (weak, nonatomic) IBOutlet UIButton *btnDriverVisiblility;
@property (nonatomic, weak) id <CellPostDriverHeaderDelegate> cellPostDriverHeaderDelegate;
- (IBAction)btnOpenSavedDrvierClicked:(id)sender;
- (IBAction)btnDriverAddressClicked:(id)sender;
- (IBAction)btndriverVisibilityClicked:(id)sender;
@end
