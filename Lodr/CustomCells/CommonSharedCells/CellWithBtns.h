//
//  CellWithBtns.h
//  Lodr
//
//  Created by c196 on 28/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellWithBtnsDelegate
@optional
- (void)btnFiedlValueClicked:(id)sender;

@end

@interface CellWithBtns : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblButtonHeading;
@property (weak, nonatomic) IBOutlet UIView *vwButtonValue;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightvwButtonValue;
@property (weak, nonatomic) IBOutlet UIButton *btnFieldValue;
- (IBAction)btnFiedlValueClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblFieldInstrtuctions;
@property (nonatomic, weak) id <CellWithBtnsDelegate> cellWithBtnsDelegate;
@end
