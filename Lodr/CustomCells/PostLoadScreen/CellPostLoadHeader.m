//
//  CellPostLoadHeader.m
//  Lodr
//
//  Created by Payal Umraliya on 19/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellPostLoadHeader.h"

@implementation CellPostLoadHeader
-(void)awakeFromNib
{
    [super awakeFromNib];
    for(UIView *vws in _viewSubDetails.subviews)
    {
        vws.layer.cornerRadius=1.5f;
    }
    _txtPostLoadvwLoadDesc.placeholder=@"What are we shipping?";
    _txtPostLoadvwLoadDesc.placeholderColor=[UIColor lightGrayColor];
    
    NSArray *arr=[NSArray arrayWithObjects:_btnLoadPostVisibility,_btnLoadPostPickUpTime,_btnLoadPostDelievryTime,_btnLoadPostEquipmentList, _btnUnitMeasure,nil];
    for (UIButton *btnLoadPost in arr) 
    {
        if(btnLoadPost ==_btnLoadPostVisibility)
        {
            btnLoadPost.imageEdgeInsets = UIEdgeInsetsMake(0., (SCREEN_WIDTH/2)-40, 0., 0.);
            btnLoadPost.titleEdgeInsets = UIEdgeInsetsMake(0., 0., 0., 20);
        }
        else if(btnLoadPost ==_btnUnitMeasure)
        {
            btnLoadPost.imageEdgeInsets = UIEdgeInsetsMake(0., (SCREEN_WIDTH/2)-50, 0., 0.);
            btnLoadPost.titleEdgeInsets = UIEdgeInsetsMake(0., 0., 0., 20);
        }
        else
        {
            btnLoadPost.imageEdgeInsets = UIEdgeInsetsMake(0., SCREEN_WIDTH - (40), 0., 0.);
            btnLoadPost.titleEdgeInsets = UIEdgeInsetsMake(0., 0., 0., 20);
        }
    }
    for (UIView *vw in _viewSubDetails.subviews)
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
- (IBAction)btnLoadPostEquiListClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostEquiListClicked:sender];
}
- (IBAction)btnLoadPostAddEspecialEquiClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostAddEspecialEquiClicked:sender];
}

- (IBAction)btnLoadPostOpenSavedClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostOpenSavedClicked:sender];
}

- (IBAction)btnLoadPostBestOfferClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostBestOfferClicked:sender];
}

- (IBAction)btnLoadPostPickupcityStateClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostPickupcityStateClicked:sender];
}

- (IBAction)btnLoadPostPickupMapPinClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostPickupMapPinClicked:sender];
}

- (IBAction)btnLoadPostPickUpTimeClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostPickUpTimeClicked:sender];
}

- (IBAction)btnLoadPostPickUpAddressClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostPickUpAddressClicked:sender];
}

- (IBAction)btnLoadPostDelievrycityStateClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostDelievrycityStateClicked:sender];
}

- (IBAction)btnLoadPostDelievryTimeClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostDelievryTimeClicked:sender];
}

- (IBAction)btnLoadPostDelievryCityStateMapPinClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostDelievryCityStateMapPinClicked:sender];
}

- (IBAction)btnLoadPostPickupAddressMapClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostPickupAddressMapClicked:sender];
}

- (IBAction)btnLoadPostDelieveryAddressClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostDelieveryAddressClicked:sender];
}

- (IBAction)btnLoadPostVisibilityClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostVisibilityClicked:sender];
}

- (IBAction)btnLoadPostAllowCommentClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostAllowCommentClicked:sender];
}

- (IBAction)btnLoadPostDelieveryAddressMapClicked:(id)sender
{
    [self.cellPostLoadHeaderDelegate btnLoadPostDelieveryAddressMapClicked:sender];
}
- (IBAction)btnUnitMeasureclicked:(id)sender {
    [self.cellPostLoadHeaderDelegate btnUnitMeasureclicked:sender];
}
@end
