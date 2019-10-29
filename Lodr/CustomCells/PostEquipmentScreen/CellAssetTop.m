//
//  CellAssetTop.m
//  Lodr
//
//  Created by c196 on 03/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellAssetTop.h"

@implementation CellAssetTop

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnPlaceTruckClicked:(id)sender 
{
    [self.cellAssetTopDelegate btnPlaceTruckClicked:sender];
}
@end
