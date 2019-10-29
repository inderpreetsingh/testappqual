//
//  CellCalenderSchedule.m
//  Lodr
//
//  Created by c196 on 25/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellCalenderSchedule.h"

@implementation CellCalenderSchedule

- (void)awakeFromNib {
    [super awakeFromNib];
    self.vwMain.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.vwMain.layer.borderWidth=0.3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnscheduledclicked:(id)sender {
    [self.cellCalenderScheduleDeleagate btnscheduledclicked:sender];
}
- (IBAction)btnAlternateEquiclicked:(id)sender {
     [self.cellCalenderScheduleDeleagate btnAlternateEquiclicked:sender];
}

- (IBAction)btnDriverScheduleclicked:(id)sender {
     [self.cellCalenderScheduleDeleagate btnDriverScheduleclicked:sender];
}
- (IBAction)btnVwDetailsClciked:(id)sender {
     [self.cellCalenderScheduleDeleagate btnVwDetailsClciked:sender];
}
@end
