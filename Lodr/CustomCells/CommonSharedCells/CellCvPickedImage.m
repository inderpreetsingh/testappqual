//
//  CellCvPickedImage.m
//  Lodr
//
//  Created by Payal Umraliya on 24/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellCvPickedImage.h"

@implementation CellCvPickedImage
- (void)awakeFromNib 
{
    [super awakeFromNib];
    self.imgLarge.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.imgLarge.layer.borderWidth=0.3;
    self.imgLarge.layer.cornerRadius=1.0f;
    self.imgLarge.clipsToBounds=YES;
    
}
- (IBAction)btnDeleteImageClicked:(id)sender {
    [self.cellCvPickedImageDelegate btnDeleteImageClicked:sender];
}
@end
