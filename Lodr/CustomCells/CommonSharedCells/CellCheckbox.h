//
//  CellCheckbox.h
//  Lodr
//
//  Created by c196 on 26/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellCheckBoxDelegate
@optional
- (IBAction)btnCellClicked:(id)sender;

@end
@interface CellCheckbox : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwCellMain;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckbox;
@property (weak, nonatomic) IBOutlet UILabel *lblListName;
@property (weak, nonatomic) IBOutlet UIButton *btnCellClick;
- (IBAction)btnCellClicked:(id)sender;
@property (nonatomic, weak) id <CellCheckBoxDelegate> cellCheckBoxDelegate;
@end
