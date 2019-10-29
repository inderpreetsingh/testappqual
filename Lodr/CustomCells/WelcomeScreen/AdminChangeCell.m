//
//  AdminChangeCell.m
//  Lodr
//
//  Created by C205 on 13/06/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import "AdminChangeCell.h"

@implementation AdminChangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _txtAdmin.layer.cornerRadius = 1.0f;
    _txtAdmin.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _txtAdmin.layer.borderWidth = 1.0f;
    
    _btnChange.layer.cornerRadius = 5.0f;
    _btnChange.clipsToBounds = YES;
    _btnChange.layer.borderColor = [UIColor blackColor].CGColor;
    _btnChange.layer.borderWidth = 2.0f;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
