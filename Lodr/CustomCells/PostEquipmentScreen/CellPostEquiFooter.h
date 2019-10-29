//
//  CellPostEquiFooter.h
//  Lodr
//
//  Created by Payal Umraliya on 20/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
@protocol CellPostEquiFooterDelegate
@optional
- (IBAction)btnPublishEquiClicked:(id)sender;
- (IBAction)btnSaveEquiClicekd:(id)sender;
- (IBAction)btnUpdateEquiClicked:(id)sender;
@end
@interface CellPostEquiFooter : UIView
@property (weak, nonatomic) IBOutlet UIView *vwfooter;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *txtFooterNotes;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveEqui;
@property (weak, nonatomic) IBOutlet UIButton *btnPublishEqui;
@property (weak, nonatomic) IBOutlet UIButton *btnEquiUpdate;
- (IBAction)btnPublishEquiClicked:(id)sender;
- (IBAction)btnSaveEquiClicekd:(id)sender;
- (IBAction)btnUpdateEquiClicked:(id)sender;
@property (nonatomic, weak) id <CellPostEquiFooterDelegate> cellPostEquiFooterDelegate;
@end
