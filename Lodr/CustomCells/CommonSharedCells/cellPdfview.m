//
//  cellPdfview.m
//  Lodr
//
//  Created by Payal Umraliya on 19/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "cellPdfview.h"

@implementation cellPdfview

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btnPdfNameClicked:(id)sender {
    [self.cellPdfviewDelegate btnPdfNameClicked:sender];
}

- (IBAction)btnPdfDeleteClicked:(id)sender {
    [self.cellPdfviewDelegate btnPdfDeleteClicked:sender];
}
@end
