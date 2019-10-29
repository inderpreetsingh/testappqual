//
//  CellDisptachDateTime.m
//  Lodr
//
//  Created by c196 on 29/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellDisptachDateTime.h"

@implementation CellDisptachDateTime

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnstarttimeclciked:(id)sender 
{
    [self.cellDisptachDateTimeDelegate btnstarttimeclciked:sender];
}
- (IBAction)btnstartdateclicked:(id)sender
{
    [self.cellDisptachDateTimeDelegate btnstartdateclicked:sender];
}
- (IBAction)btnendtimeclicked:(id)sender
{
    [self.cellDisptachDateTimeDelegate btnendtimeclicked:sender];
}
- (IBAction)btnenddateclicked:(id)sender
{
    [self.cellDisptachDateTimeDelegate btnenddateclicked:sender];
}
@end
