//
//  CellChooseTrailers.h
//  Lodr
//
//  Created by c196 on 28/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellChooseTrailersDelegate
@optional
- (IBAction)btnOpenSavedClicked:(id)sender;
- (IBAction)btnChoosenTypeClicked:(id)sender;
- (IBAction)btnEditTrailersClicked:(id)sender;
@end
@interface CellChooseTrailers : UIView
@property (weak, nonatomic) IBOutlet UIView *vwHeading;
@property (weak, nonatomic) IBOutlet UILabel *lblCreateLoad;
@property (weak, nonatomic) IBOutlet UILabel *lblHeadingDesc;
@property (weak, nonatomic) IBOutlet UIView *vwOpenSavedButtons;
@property (weak, nonatomic) IBOutlet UIView *vwChoosenType;
@property (weak, nonatomic) IBOutlet UIButton *btnOpenSaved;
- (IBAction)btnOpenSavedClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseTrailers;
- (IBAction)btnChoosenTypeClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblChoosenType;
@property (weak, nonatomic) IBOutlet UIButton *btnChoosenType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightChoosentype;
- (IBAction)btnEditTrailersClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *vwEditTrailers;
@property (weak, nonatomic) IBOutlet UIButton *btnEditTrailers;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightEditTrtailer;
@property (weak, nonatomic) IBOutlet UILabel *lblShippingType;
@property (nonatomic, weak) id <CellChooseTrailersDelegate> cellChooseTrailersDelegate;
@end
