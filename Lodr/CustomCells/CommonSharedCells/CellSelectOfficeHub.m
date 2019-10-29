//
//  CellSelectOfficeHub.m
//  Lodr
//
//  Created by C205 on 14/05/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import "CellSelectOfficeHub.h"

@implementation CellSelectOfficeHub

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _txtOfficeHub.layer.cornerRadius=1.5f;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    [_txtOfficeHub setLeftViewMode:UITextFieldViewModeAlways];
    [_txtOfficeHub setLeftView:paddingView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
