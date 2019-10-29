//
//  CellWelcome.m
//  Lodr
//
//  Created by Payal Umraliya on 27/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellWelcome.h"

@implementation CellWelcome

- (void)awakeFromNib {
    [super awakeFromNib];
    self.txtFieldValue.layer.borderWidth=1.0f;
    self.txtFieldValue.layer.cornerRadius=1.0f;
    self.txtFieldValue.layer.borderColor=[UIColor lightGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
