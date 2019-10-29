//
//  CellLoadDetailHeader.m
//  Lodr
//
//  Created by Payal Umraliya on 22/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellLoadDetailHeader.h"

@implementation CellLoadDetailHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnloaddetailheaderclicked:(id)sender {
    [self.cellLoadDetailHeaderDelegate btnloaddetailheaderclicked:sender];
}
- (IBAction)btnCurrentStatusClicked:(id)sender {
     [self.cellLoadDetailHeaderDelegate btnCurrentStatusClicked:sender];
}
@end
