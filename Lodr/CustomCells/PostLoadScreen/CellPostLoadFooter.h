//
//  CellPostLoadFooter.h
//  Lodr
//
//  Created by Payal Umraliya on 19/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
@protocol CellPostLoadFooterDelegate
@optional
- (IBAction)btnPublishLoadClicked:(id)sender;
- (IBAction)btnSaveLoadClicekd:(id)sender;
- (IBAction)btnUpdateLoadClicked:(id)sender;
@end
@interface CellPostLoadFooter : UIView
@property (weak, nonatomic) IBOutlet UIView *vwfooter;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *txtFooterNotes;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveLoad;
@property (weak, nonatomic) IBOutlet UIButton *btnPublishLoad;
@property (weak, nonatomic) IBOutlet UIButton *btnloadUpdate;

- (IBAction)btnPublishLoadClicked:(id)sender;
- (IBAction)btnSaveLoadClicekd:(id)sender;
- (IBAction)btnUpdateLoadClicked:(id)sender;

@property (nonatomic, weak) id <CellPostLoadFooterDelegate> cellPostLoadFooterDelegate;

@end
