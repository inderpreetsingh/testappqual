//
//  CellCheckbox.m
//  Lodr
//
//  Created by c196 on 26/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellCheckbox.h"

@implementation CellCheckbox
- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnCheckbox.layer.borderColor=[UIColor whiteColor].CGColor;
    self.btnCheckbox.layer.borderWidth=1.0f;
    self.btnCheckbox.layer.cornerRadius=1.5f;
    self.btnCheckbox.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)btnCellClicked:(id)sender {
    [self.cellCheckBoxDelegate btnCellClicked:sender];
}


@end
