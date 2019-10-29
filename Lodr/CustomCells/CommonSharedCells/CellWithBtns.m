//
//  CellWithBtns.m
//  Lodr
//
//  Created by c196 on 28/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellWithBtns.h"

@implementation CellWithBtns

- (void)awakeFromNib
{
    [super awakeFromNib];
    _btnFieldValue.imageEdgeInsets = UIEdgeInsetsMake(0., SCREEN_WIDTH - (40), 0., 0.);
    _btnFieldValue.titleEdgeInsets = UIEdgeInsetsMake(0., 0., 0., 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnFiedlValueClicked:(id)sender {
    [self.cellWithBtnsDelegate btnFiedlValueClicked:sender];
}
@end
