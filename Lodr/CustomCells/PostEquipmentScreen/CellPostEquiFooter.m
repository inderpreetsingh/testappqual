//
//  CellPostEquiFooter.m
//  Lodr
//
//  Created by Payal Umraliya on 20/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellPostEquiFooter.h"

@implementation CellPostEquiFooter
-(void)awakeFromNib
{
    [super awakeFromNib];
    _txtFooterNotes.layer.cornerRadius=1.5f;
    _btnSaveEqui.layer.cornerRadius=1.5;
    _btnEquiUpdate.layer.cornerRadius=1.5;
    _btnPublishEqui.layer.cornerRadius=1.5;
    _txtFooterNotes.placeholder=@"Enter Notes for the Asset";
    _txtFooterNotes.placeholderColor=[UIColor lightGrayColor];
    
}
- (IBAction)btnPublishEquiClicked:(id)sender {
    [self.cellPostEquiFooterDelegate btnPublishEquiClicked:sender];
}

- (IBAction)btnSaveEquiClicekd:(id)sender {
    [self.cellPostEquiFooterDelegate btnSaveEquiClicekd:sender];
}
- (IBAction)btnUpdateEquiClicked:(id)sender {
    [self.cellPostEquiFooterDelegate btnUpdateEquiClicked:sender];
}
@end
