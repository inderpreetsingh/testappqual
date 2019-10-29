//
//  CellDriverProfileHeader.m
//  Lodr
//
//  Created by c196 on 11/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellDriverProfileHeader.h"

@implementation CellDriverProfileHeader
-(void)awakeFromNib
{
    [super awakeFromNib];
    _imgDriverPic.layer.borderColor=[UIColor lightGrayColor].CGColor;
     _imgDriverPic.layer.borderWidth=1.0f;
    _imgDriverPic.layer.cornerRadius=_imgDriverPic.frame.size.height/2;
    _imgDriverPic.clipsToBounds=YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
