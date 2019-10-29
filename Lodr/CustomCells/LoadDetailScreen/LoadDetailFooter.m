//
//  LoadDetailFooter.m
//  Lodr
//
//  Created by Payal Umraliya on 14/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "LoadDetailFooter.h"

@implementation LoadDetailFooter

- (IBAction)btnmakepublishclicked:(id)sender {
    [self.loadDetailFooterDelegate btnmakepublishclicked:sender];
}

- (IBAction)btnmarkascancelclicked:(id)sender {
       [self.loadDetailFooterDelegate btnmarkascancelclicked:sender];
}

- (IBAction)btneditloadclicked:(id)sender {
       [self.loadDetailFooterDelegate btneditloadclicked:sender];
}

- (IBAction)btnlinkscheduleconfirmclicked:(id)sender {
       [self.loadDetailFooterDelegate btnlinkscheduleconfirmclicked:sender];
}
- (IBAction)btnnotinterestedclicked:(id)sender {
    [self.loadDetailFooterDelegate btnnotinterestedclicked:sender];
}
@end
