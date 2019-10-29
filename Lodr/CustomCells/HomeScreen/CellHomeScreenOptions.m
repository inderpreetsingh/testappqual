//
//  CellHomeScreenOptions.m
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellHomeScreenOptions.h"

@implementation CellHomeScreenOptions

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnHomeScreenOption.layer.cornerRadius=3.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnHomeScreenOptionClicked:(id)sender {
    [self.cellHomeScreenOptionsDelegate btnHomeScreenOptionClicked:sender];
}
@end
