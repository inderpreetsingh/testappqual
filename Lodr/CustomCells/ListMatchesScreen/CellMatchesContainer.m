//
//  CellMatchesContainer.m
//  PUNestedTable
//
//  Created by Payal Umraliya on 09/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellMatchesContainer.h"

@implementation CellMatchesContainer


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnFavClicke:(id)sender {
    [self.cellMatchesContainerDelegate btnFavClicke:sender];

}
- (IBAction)btnMailClicked:(id)sender {
    [self.cellMatchesContainerDelegate btnMailClicked:sender];

}
- (IBAction)btnMenuFilterClicked:(id)sender 
{
    [self.cellMatchesContainerDelegate btnMenuFilterClicked:sender];
}
- (IBAction)btnCloseMatchListClicked:(id)sender {
     [self.cellMatchesContainerDelegate btnCloseMatchListClicked:sender];
}
@end
