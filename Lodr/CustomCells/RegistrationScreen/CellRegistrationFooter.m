//
//  CellRegistrationFooter.m
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellRegistrationFooter.h"

@implementation CellRegistrationFooter

- (IBAction)btnSignUpClicked:(id)sender {
    [self.delegate btnSignUpClicked:sender];
}
- (IBAction)btnTermsClicked:(id)sender {
      [self.delegate btnTermsClicked:sender];
}
@end
