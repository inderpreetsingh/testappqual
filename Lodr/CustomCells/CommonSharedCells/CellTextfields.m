//
//  CellTextfields.m
//  Lodr
//
//  Created by c196 on 26/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellTextfields.h"

@implementation CellTextfields

- (void)awakeFromNib {
    [super awakeFromNib];
    self.txtcellText.layer.borderWidth=1.0f;
    self.txtcellText.layer.cornerRadius=1.0f;
    self.txtcellText.layer.borderColor=[UIColor lightGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
