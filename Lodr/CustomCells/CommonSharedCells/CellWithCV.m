//
//  CellWithCV.m
//  Lodr
//
//  Created by Payal Umraliya on 19/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellWithCV.h"

@implementation CellWithCV

- (void)awakeFromNib 
{
    [super awakeFromNib];
   
    [self.cvPhotoes registerNib:[UINib nibWithNibName:@"CellCvPickedImage" bundle:nil] forCellWithReuseIdentifier:@"CellCvPickedImage"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
