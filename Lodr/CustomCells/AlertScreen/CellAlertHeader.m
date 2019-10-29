//
//  CellAlertHeader.m
//  Lodr
//
//  Created by c196 on 09/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellAlertHeader.h"

@implementation CellAlertHeader
- (IBAction)btnBackClicked:(id)sender 
{
    [self.cellAlertHeaderDelegate btnBackClicked:sender];
}
@end
