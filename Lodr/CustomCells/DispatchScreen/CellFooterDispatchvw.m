//
//  CellFooterDispatchvw.m
//  Lodr
//
//  Created by c196 on 30/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellFooterDispatchvw.h"

@implementation CellFooterDispatchvw

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnaddmoreassetclicked:(id)sender
{
    [self.cellFooterDispatchvwDelegate btnaddmoreassetclicked:sender];
}
- (IBAction)btnscheduledclciekd:(id)sender 
{
     [self.cellFooterDispatchvwDelegate btnscheduledclciekd:sender];
}
- (IBAction)btnnotscheduleclicekd:(id)sender {
     [self.cellFooterDispatchvwDelegate btnnotscheduleclicekd:sender];
}
@end
