//
//  CellListWithCheckBox.m
//  Lodr
//
//  Created by Payal Umraliya on 23/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellListWithCheckBox.h"

@implementation CellListWithCheckBox

- (void)awakeFromNib 
{
    [super awakeFromNib];
    
    self.btnCheckbox.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.btnCheckbox.layer.borderWidth = 1.0f;
    self.btnCheckbox.layer.cornerRadius = 1.5f;
    self.btnCheckbox.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnCellClicked:(id)sender
{
    [_cellListWithCheckBoxDelegate btnCellClicked:sender];
}
@end
