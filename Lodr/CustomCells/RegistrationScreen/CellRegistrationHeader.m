//
//  CellRegistrationHeader.m
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellRegistrationHeader.h"

@implementation CellRegistrationHeader

- (IBAction)btnFbClicked:(id)sender {
   [self.cellRegistrationHeaderDelegate btnFbClicked:sender];
}

- (IBAction)btnTwitClicked:(id)sender {
  [self.cellRegistrationHeaderDelegate btnTwitClicked:sender];
}

- (IBAction)btnGplusClicked:(id)sender {
   [self.cellRegistrationHeaderDelegate btnGplusClicked:sender];
}
@end
