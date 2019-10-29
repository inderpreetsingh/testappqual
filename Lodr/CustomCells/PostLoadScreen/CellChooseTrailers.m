//
//  CellChooseTrailers.m
//  Lodr
//
//  Created by c196 on 28/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellChooseTrailers.h"

@implementation CellChooseTrailers
-(void)awakeFromNib
{
    [super awakeFromNib];
   
}
- (IBAction)btnOpenSavedClicked:(id)sender {
    [self.cellChooseTrailersDelegate btnOpenSavedClicked:sender];
}
- (IBAction)btnChoosenTypeClicked:(id)sender {
     [self.cellChooseTrailersDelegate btnChoosenTypeClicked:sender];
}

- (IBAction)btnEditTrailersClicked:(id)sender {
     [self.cellChooseTrailersDelegate btnEditTrailersClicked:sender];
}
@end
