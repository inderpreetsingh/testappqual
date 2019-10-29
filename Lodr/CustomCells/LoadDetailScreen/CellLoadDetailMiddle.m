//
//  CellLoadDetailMiddle.m
//  Lodr
//
//  Created by Payal Umraliya on 20/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellLoadDetailMiddle.h"

@implementation CellLoadDetailMiddle

- (void)awakeFromNib 
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btnContactClicked:(id)sender 
{
    [self.cellLoadDetailMiddleDelegate btnContactClicked:sender];
}
- (IBAction)btnsmsclicked:(id)sender {
    [self.cellLoadDetailMiddleDelegate btnsmsclicked:sender];
}
@end
