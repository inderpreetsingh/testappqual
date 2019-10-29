//
//  CellPostEquiHeader.m
//  Lodr
//
//  Created by Payal Umraliya on 20/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellPostEquiHeader.h"

@implementation CellPostEquiHeader
-(void)awakeFromNib
{
    [super awakeFromNib];
    for(UIView *vws in _vwSubDetails.subviews)
    {
        vws.layer.cornerRadius=1.5f;
    }
    
    NSArray *arr=[NSArray arrayWithObjects:_btnPostEquiVisiblity,_btnPostEquiList,_btnPostEquiAvailability, nil];
    for (UIButton *btnLoadPost in arr) 
    {
        
        if(btnLoadPost ==_btnPostEquiList )
        {
            btnLoadPost.imageEdgeInsets = UIEdgeInsetsMake(0., SCREEN_WIDTH - (40), 0., 0.);
            btnLoadPost.titleEdgeInsets = UIEdgeInsetsMake(0., 0., 0., 20);
        }
        else
        {
            btnLoadPost.imageEdgeInsets = UIEdgeInsetsMake(0., (SCREEN_WIDTH/2) - (40), 0., 0.);
            btnLoadPost.titleEdgeInsets = UIEdgeInsetsMake(0., 0., 0., 20);
        }
    }
    for (UIView *vw in _vwSubDetails.subviews)
    {
        if([vw isKindOfClass:[UITextField class]])
        {
            UITextField *txtPostLoadfield=(UITextField*)vw;
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
            [txtPostLoadfield setLeftViewMode:UITextFieldViewModeAlways];
            [txtPostLoadfield setLeftView:paddingView];
        }
    }
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    [_txtNameOfSubAsset setLeftViewMode:UITextFieldViewModeAlways];
    [_txtNameOfSubAsset setLeftView:paddingView];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    [_txtAssetEmptyWeight setLeftViewMode:UITextFieldViewModeAlways];
    [_txtAssetEmptyWeight setLeftView:paddingView2];
}
- (IBAction)btnPostEquiOpenSavedClicked:(id)sender {
    [self.cellPostEquiHeaderDelegate btnPostEquiOpenSavedClicked:sender];
}
- (IBAction)btnPostEquiListClicked:(id)sender {
    [self.cellPostEquiHeaderDelegate btnPostEquiListClicked:sender];
}
- (IBAction)btnPostEquiEspecialClicked:(id)sender {
    [self.cellPostEquiHeaderDelegate btnPostEquiEspecialClicked:sender];
}
- (IBAction)btnPostEquiVisibilityClicked:(id)sender {
    [self.cellPostEquiHeaderDelegate btnPostEquiVisibilityClicked:sender];
}
- (IBAction)btnPostEquiAvailabilityClicked:(id)sender {
    [self.cellPostEquiHeaderDelegate btnPostEquiAvailabilityClicked:sender];
}
@end
