//
//  CellAssetFooter.h
//  Lodr
//
//  Created by c196 on 03/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellAssetFooterDelegate
@optional
- (IBAction)btnUpdateStatusClicked:(id)sender;
- (IBAction)btnPublishClicked:(id)sender;
-(IBAction)btnEditAssetClicked:(id)sender;
- (IBAction)btnDeleteAssetClicked:(id)sender;

@end
@interface CellAssetFooter : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightFootersinglebtn;
@property (weak, nonatomic) IBOutlet UIView *vwNotesAndVisibility;
@property (weak, nonatomic) IBOutlet UILabel *lblVisibility;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightmultiplebtn;
@property (weak, nonatomic) IBOutlet UILabel *lblComments;
@property (weak, nonatomic) IBOutlet UIView *vwWithSIngleButton;
@property (weak, nonatomic) IBOutlet UIView *vwWithMultipleButtons;
- (IBAction)btnUpdateStatusClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateStatus;
- (IBAction)btnPublishClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPublish;
@property (weak, nonatomic) IBOutlet UIButton *btnEditAsset;
- (IBAction)btnEditAssetClicked:(id)sender;
- (IBAction)btnDeleteAssetClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblInstrtuctions;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteAsset;

@property (nonatomic, weak) id <CellAssetFooterDelegate> cellAssetFooterDelegate;
@end
