//
//  CellDriverStatus.m
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellDriverStatus.h"

@implementation CellDriverStatus

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btnStatusNameClicked:(id)sender {
    [self.cellDriverStatusDelegate btnStatusNameClicked:sender];
}
@end
