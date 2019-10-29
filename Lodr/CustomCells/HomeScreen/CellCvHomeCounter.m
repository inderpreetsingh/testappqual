//
//  CellCvHomeCounter.m
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellCvHomeCounter.h"

@implementation CellCvHomeCounter
- (void)awakeFromNib 
{
    [super awakeFromNib];
   
}
- (IBAction)btnCounterClicked:(id)sender 
{
    [self.cellCvHomeCounterDelegate btnCounterClicked:sender];
}


@end
