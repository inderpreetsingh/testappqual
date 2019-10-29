//
//  CompanyRequestCell.m
//  Lodr
//
//  Created by C205 on 05/03/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import "CompanyRequestCell.h"

@implementation CompanyRequestCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgProfile.layer.cornerRadius = CGRectGetWidth(_imgProfile.frame) / 2.0;
    _imgProfile.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
