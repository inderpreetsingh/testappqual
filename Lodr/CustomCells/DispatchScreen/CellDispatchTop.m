//
//  CellDispatchTop.m
//  Lodr
//
//  Created by c196 on 29/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellDispatchTop.h"

@implementation CellDispatchTop

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblbolpod.layer.cornerRadius = 2.0f;
    self.lblbolpod.layer.borderWidth =1.0f;
    self.lblbolpod.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
