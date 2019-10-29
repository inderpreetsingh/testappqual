//
//  CellMatchedLoadListForEquipment.m
//  Lodr
//
//  Created by Payal Umraliya on 07/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellMatchedLoadListForEquipment.h"

@implementation CellMatchedLoadListForEquipment

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.vwCellHeader.layer.borderColor=[UIColor blackColor].CGColor;
    self.vwCellHeader.layer.borderWidth=0.7f;
    _btnsortrate.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    _btnsortrate.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    _btnsortrate.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.vwLoadDetails.layer.borderColor=[UIColor whiteColor].CGColor;
     self.vwLoadDetails.layer.borderWidth=0.3f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnsortpickupclicked:(id)sender
{
    [self.cellMatchedLoadListForEquipmentDelegate btnsortpickupclicked:sender];
}
- (IBAction)btnsortdelieverclicked:(id)sender 
{
     [self.cellMatchedLoadListForEquipmentDelegate btnsortdelieverclicked:sender];
}
- (IBAction)btnsortlenghtclicked:(id)sender
{
     [self.cellMatchedLoadListForEquipmentDelegate btnsortlenghtclicked:sender];
}
- (IBAction)btnsortweightclicked:(id)sender 
{
     [self.cellMatchedLoadListForEquipmentDelegate btnsortweightclicked:sender];
}

- (IBAction)btnoutofdateclicked:(id)sender {
}
- (IBAction)btnsortrateclciked:(id)sender 
{
     [self.cellMatchedLoadListForEquipmentDelegate btnsortrateclciked:sender];
}
@end
