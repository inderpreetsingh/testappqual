//
//  CellDispatchChooseAsset.m
//  Lodr
//
//  Created by c196 on 29/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellDispatchChooseAsset.h"

@implementation CellDispatchChooseAsset

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgofasset.layer.cornerRadius = self.imgofasset.frame.size.height/2;
    self.imgofasset.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imgofasset.layer.borderWidth = 0.8;
    self.imgofasset.clipsToBounds = YES;
    self.btndroplist.imageEdgeInsets = UIEdgeInsetsMake(0., (SCREEN_WIDTH - self.imgofasset.frame.size.width )-70, 0., 0.);
    self.btndroplist.titleEdgeInsets = UIEdgeInsetsMake(0., 0., 0., 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btncloseclicked:(id)sender {
    [self.cellCellDispatchChooseAssetDelegate btncloseclicked:sender];
}
- (IBAction)btndroplistclicked:(id)sender {
     [self.cellCellDispatchChooseAssetDelegate btndroplistclicked:sender];
}
@end
