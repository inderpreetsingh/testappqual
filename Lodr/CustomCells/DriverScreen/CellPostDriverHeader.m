//
//  CellPostDriverHeader.m
//  Lodr
//
//  Created by c196 on 12/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellPostDriverHeader.h"

@implementation CellPostDriverHeader
- (void)awakeFromNib 
{
    [super awakeFromNib];
    for(UIView *vws in _vwDriverDetails.subviews)
    {
        vws.layer.cornerRadius=1.5f;
    }
    self.btnDriverVisiblility.imageEdgeInsets = UIEdgeInsetsMake(0., (SCREEN_WIDTH)-40, 0., 0.);
   self.btnDriverVisiblility.titleEdgeInsets = UIEdgeInsetsMake(0., 0., 0., 20);
    for (UIView *vw in _vwDriverDetails.subviews)
    {
        if([vw isKindOfClass:[UITextField class]])
        {
            UITextField *txtPostLoadfield=(UITextField*)vw;
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
            [txtPostLoadfield setLeftViewMode:UITextFieldViewModeAlways];
            [txtPostLoadfield setLeftView:paddingView];
        }
    }

}

- (IBAction)btnOpenSavedDrvierClicked:(id)sender {
    [self.cellPostDriverHeaderDelegate btnOpenSavedDrvierClicked:sender];
}
- (IBAction)btnDriverAddressClicked:(id)sender {
    [self.cellPostDriverHeaderDelegate btnDriverAddressClicked:sender];
}
- (IBAction)btndriverVisibilityClicked:(id)sender {
    [self.cellPostDriverHeaderDelegate btndriverVisibilityClicked:sender];
}
@end
