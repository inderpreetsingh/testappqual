//
//  CoAdminReqCell.m
//  Lodr
//
//  Created by C205 on 26/06/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import "CoAdminReqCell.h"

@implementation CoAdminReqCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgProfile.layer.cornerRadius = CGRectGetHeight(_imgProfile.frame) / 2;
    _imgProfile.clipsToBounds = YES;
    
    _btnAccept.layer.cornerRadius = CGRectGetHeight(_btnAccept.frame) / 2;
    _btnAccept.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
