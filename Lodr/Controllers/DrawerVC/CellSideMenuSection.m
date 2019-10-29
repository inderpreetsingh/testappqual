//
//  CellSideMenuSection.m
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellSideMenuSection.h"

@implementation CellSideMenuSection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnMenuClicked:(id)sender {
    [_cellSideMenuSectionDelegate btnMenuClicked:sender];
}
@end
