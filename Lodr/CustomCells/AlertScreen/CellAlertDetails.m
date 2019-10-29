//
//  CellAlertDetails.m
//  Lodr
//
//  Created by c196 on 09/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellAlertDetails.h"

@implementation CellAlertDetails

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)btnDltNotificationsClicked:(id)sender {
    [self.cellAlertDetailsDelegate btnDltNotificationsClicked:sender];
}
@end
