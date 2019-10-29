//
//  CellRegistrationHeader.h
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellRegistrationHeaderDelegate
@optional
- (void)btnTwitClicked:(id)sender;
- (void)btnFbClicked:(id)sender;
- (void)btnGplusClicked:(id)sender;
@end
@interface CellRegistrationHeader : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnFb;
@property (weak, nonatomic) IBOutlet UIButton *btnTwit;
@property (weak, nonatomic) IBOutlet UIButton *btnGplus;
- (IBAction)btnFbClicked:(id)sender;
- (IBAction)btnTwitClicked:(id)sender;
- (IBAction)btnGplusClicked:(id)sender;
@property (nonatomic, weak) id <CellRegistrationHeaderDelegate> cellRegistrationHeaderDelegate;
@end
