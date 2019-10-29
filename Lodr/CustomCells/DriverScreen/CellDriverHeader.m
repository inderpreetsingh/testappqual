//
//  CellDriverHeader.m
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellDriverHeader.h"
@implementation CellDriverHeader
- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds      = YES;
    self.layer.borderWidth        = 0.3;
    self.layer.borderColor        = [UIColor lightGrayColor].CGColor;
    NSArray *arr=[NSArray arrayWithObjects:_btnStatusSort,_btnLocationSort, nil];
    for (UIButton *btn in arr) 
    {
        btn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        btn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        btn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    }
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"CellDriverHeader"
                                                         owner:self
                                                       options:nil];
        UIView *nibView = [objects firstObject];
        UIView *contentView = self.contentView;
        CGSize contentViewSize = contentView.frame.size;
        nibView.frame = CGRectMake(0, 0, contentViewSize.width, contentViewSize.height);
        [contentView addSubview:nibView];
        
    }
    return self;
}
- (IBAction)btnExpandCollapseClicked:(id)sender
{
    [self.cellDriverHeaderDelegate btnExpandCollapseClicked:sender];
}

- (IBAction)btnSwitchToMapClicked:(id)sender 
{
    [self.cellDriverHeaderDelegate btnSwitchToMapClicked:sender];
}
- (IBAction)btnSwitchToListClicked:(id)sender 
{
    [self.cellDriverHeaderDelegate btnSwitchToListClicked:sender];
}
- (IBAction)btnMyProfileClicked:(id)sender 
{
    [self.cellDriverHeaderDelegate btnMyProfileClicked:sender];
}

- (IBAction)btnSortByLocationClicked:(id)sender 
{
    [self.cellDriverHeaderDelegate btnSortByLocationClicked:sender];
}

- (IBAction)btnSortByStatusClicked:(id)sender 
{
    [self.cellDriverHeaderDelegate btnSortByStatusClicked:sender];
}
@end
