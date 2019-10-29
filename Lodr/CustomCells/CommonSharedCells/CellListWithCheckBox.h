//
//  CellListWithCheckBox.h
//  Lodr
//
//  Created by Payal Umraliya on 23/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellListWithCheckBoxDelegate
@optional
- (IBAction)btnCellClicked:(id)sender;

@end
@interface CellListWithCheckBox : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadinglbl;
@property (weak, nonatomic) IBOutlet UIView *vwCellMain;
@property (strong, nonatomic) IBOutlet UILabel *lblsubtext;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthbtncb;
@property (strong, nonatomic) IBOutlet UIView *vwCheckboxsubtext;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckbox;
@property (weak, nonatomic) IBOutlet UILabel *lblListName;
@property (weak, nonatomic) IBOutlet UIButton *btnCellClick;
- (IBAction)btnCellClicked:(id)sender;
@property (nonatomic, weak) id <CellListWithCheckBoxDelegate> cellListWithCheckBoxDelegate;
@end
