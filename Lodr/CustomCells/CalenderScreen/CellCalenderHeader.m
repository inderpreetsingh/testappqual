//
//  CellCalenderHeader.m
//  Lodr
//
//  Created by c196 on 25/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellCalenderHeader.h"

@implementation CellCalenderHeader
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.vwTruckList.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.vwTruckList.layer.borderWidth=0.5;
    self.vwMainView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.vwMainView.layer.borderWidth=0.5;
  
}

- (IBAction)btnGotoDetailClicked:(id)sender 
{
    [self.cellCalenderHeaderDelegate btnGotoDetailClicked:sender];
}
- (IBAction)btnSectionTapped:(id)sender
{
      [self.cellCalenderHeaderDelegate btnSectionTapped:sender];
}

- (IBAction)btnTrcukDetailClicked:(id)sender {
       [self.cellCalenderHeaderDelegate btnTrcukDetailClicked:sender];
}
- (IBAction)btnSectionOpenClicked:(id)sender {
       [self.cellCalenderHeaderDelegate btnSectionOpenClicked:sender];
}
@end
