//
//  CellWelcomeSummary.m
//  Lodr
//
//  Created by c196 on 25/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellWelcomeSummary.h"

@implementation CellWelcomeSummary

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imguserimage.layer.cornerRadius=self.imguserimage.frame.size.height/2;
    self.imguserimage.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.imguserimage.layer.borderWidth=1.0f;
    self.imguserimage.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btnEditProfileClicked:(id)sender 
{
    [self.cellWelcomeSummaryDelegate btnEditProfileClicked:sender];
}
@end
