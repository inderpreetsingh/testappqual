//
//  CellAssetFooter.m
//  Lodr
//
//  Created by c196 on 03/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellAssetFooter.h"

@implementation CellAssetFooter

- (IBAction)btnPublishClicked:(id)sender {
    [self.cellAssetFooterDelegate btnPublishClicked:sender];
}
- (IBAction)btnEditAssetClicked:(id)sender {
    [self.cellAssetFooterDelegate btnEditAssetClicked:sender];
}

- (IBAction)btnDeleteAssetClicked:(id)sender {
    [self.cellAssetFooterDelegate btnDeleteAssetClicked:sender];
}
- (IBAction)btnUpdateStatusClicked:(id)sender {
    [self.cellAssetFooterDelegate btnUpdateStatusClicked:sender];
}

@end
