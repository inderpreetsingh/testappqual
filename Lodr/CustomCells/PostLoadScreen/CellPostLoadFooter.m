//
//  CellPostLoadFooter.m
//  Lodr
//
//  Created by Payal Umraliya on 19/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellPostLoadFooter.h"

@implementation CellPostLoadFooter
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _txtFooterNotes.layer.cornerRadius=1.5f;
    _btnSaveLoad.layer.cornerRadius=1.5;
    _btnloadUpdate.layer.cornerRadius=1.5;
    _btnPublishLoad.layer.cornerRadius=1.5;
    _txtFooterNotes.placeholder=@"Enter Notes for the load.";
    _txtFooterNotes.placeholderColor=[UIColor lightGrayColor];
    
}

- (IBAction)btnPublishLoadClicked:(id)sender {
    [self.cellPostLoadFooterDelegate btnPublishLoadClicked:sender];
}

- (IBAction)btnSaveLoadClicekd:(id)sender {
     [self.cellPostLoadFooterDelegate btnSaveLoadClicekd:sender];
}
- (IBAction)btnUpdateLoadClicked:(id)sender {
     [self.cellPostLoadFooterDelegate btnUpdateLoadClicked:sender];
}
@end
