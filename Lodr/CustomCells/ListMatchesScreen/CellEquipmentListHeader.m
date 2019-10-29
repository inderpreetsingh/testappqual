//
//  CellEquipmentListHeader.m
//  Lodr
//
//  Created by Payal Umraliya on 07/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellEquipmentListHeader.h"

@implementation CellEquipmentListHeader
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"CellEquipmentListHeader"
                                                         owner:self
                                                       options:nil];
        UIView *nibView = [objects firstObject];
        UIView *contentView = self.contentView;
        CGSize contentViewSize = contentView.frame.size;
        nibView.frame = CGRectMake(0, 0, contentViewSize.width, contentViewSize.height);
        [contentView addSubview:nibView];
        self.layer.masksToBounds      = YES;
        self.layer.borderWidth        = 0.3;
        self.layer.borderColor        = [UIColor lightGrayColor].CGColor;
        self.lblOrangeCount.layer.cornerRadius=self.lblOrangeCount.frame.size.height/2;
        self.lblBlackCount.layer.cornerRadius=self.lblBlackCount.frame.size.height/2;
        self.lblBlackCount.clipsToBounds=YES;
        self.lblOrangeCount.clipsToBounds=YES;
        self.vwFieldsname.layer.borderWidth=1.0f;
        self.vwFieldsname.layer.borderColor=[UIColor lightGrayColor].CGColor;
        NSArray *arr=[NSArray arrayWithObjects:_btnRatesort,_btnstatussort,_btnLocationSort, nil];
        for (UIButton *btn in arr) 
        {
            btn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            btn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            btn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        }
    }
    return self;
}
- (IBAction)btnEquiNameClicked:(id)sender {
    [self.cellEquipmentListHeaderDelegate btnEquiNameClicked:sender];
}
- (IBAction)btnLocationSortClciekd:(id)sender {
    [self.cellEquipmentListHeaderDelegate btnLocationSortClciekd:sender];
}

- (IBAction)btnStatusSortClicked:(id)sender {
    [self.cellEquipmentListHeaderDelegate btnStatusSortClicked:sender];
}

- (IBAction)btnRateSortClicked:(id)sender {
    [self.cellEquipmentListHeaderDelegate btnRateSortClicked:sender];
}
- (IBAction)btnCollapseHeaderClicked:(id)sender {
    [self.cellEquipmentListHeaderDelegate btnCollapseHeaderClicked:sender];
}
- (IBAction)btnViewInMapClicked:(id)sender {
    [self.cellEquipmentListHeaderDelegate btnViewInMapClicked:sender];
}

- (IBAction)btnViewInListClicked:(id)sender {
    [self.cellEquipmentListHeaderDelegate btnViewInListClicked:sender];
}
- (IBAction)btnloadnameclicked:(id)sender {
    [self.cellEquipmentListHeaderDelegate btnloadnameclicked:sender];
}
@end
