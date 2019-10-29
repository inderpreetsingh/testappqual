//
//  ResourceContainerView.m
//  PUNestedTable
//
//  Created by Payal Umraliya on 09/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "ResourceContainerView.h"

@implementation ResourceContainerView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"ResourceContainerView"
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
        self.lblOrangeBubble.layer.cornerRadius=self.lblOrangeBubble.frame.size.height/2;
        self.lblBlackBubble.layer.cornerRadius=self.lblBlackBubble.frame.size.height/2;
        self.lblBlackBubble.clipsToBounds=YES;
        self.lblOrangeBubble.clipsToBounds=YES;
        self.vwHeader.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.vwHeader.layer.borderWidth=0.8f;
        NSArray *arr=[NSArray arrayWithObjects:_btnrate,_btnDistance,_btnpickup,_btnDelievery,_btnstatus, nil];
        for (UIButton *btn in arr) 
        {
            btn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            btn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            btn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        }
    }
    return self;
}

- (IBAction)btnLoadDetailClicked:(id)sender {
    [self.resourceContainerViewDelegate btnLoadDetailClicked:sender];
}
- (IBAction)btnDistanceSortClicked:(id)sender {
    [self.resourceContainerViewDelegate btnDistanceSortClicked:sender];
}

- (IBAction)btnPickupSortClicked:(id)sender {
    [self.resourceContainerViewDelegate btnPickupSortClicked:sender];
}

- (IBAction)btnDelievrySortClicked:(id)sender {
    [self.resourceContainerViewDelegate btnDelievrySortClicked:sender];
}

- (IBAction)btnRateSortClicked:(id)sender {
    [self.resourceContainerViewDelegate btnRateSortClicked:sender];
}

- (IBAction)btnStatusSortClicked:(id)sender {
    [self.resourceContainerViewDelegate btnStatusSortClicked:sender];
}
@end
