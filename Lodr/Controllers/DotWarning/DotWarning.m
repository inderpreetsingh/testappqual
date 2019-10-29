//
//  DotWarning.m
//  Lodr
//
//  Created by c196 on 25/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "DotWarning.h"
#import "EditDotAccount.h"
@implementation DotWarning
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.vwWarningPopUp.layer.cornerRadius=3.0f;
    self.vwWarningPopUp.clipsToBounds=YES;
    UITapGestureRecognizer *singleFingerTap = 
    [[UITapGestureRecognizer alloc] initWithTarget:self 
                                            action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleFingerTap];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self removeFromSuperview];
}
- (IBAction)btnokclciked:(id)sender
{
    [self removeFromSuperview];
}
- (IBAction)btnsettingsclciked:(id)sender
{
     [self removeFromSuperview];
    [self.dotWarningDelegate btnsettingsclciked:sender];
//    EditDotAccount *obdriverList=initVCToRedirect(SBMAIN,EDITDOTACCOUNTVC);
//    AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:obdriverList];
//    [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
//    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
     [self removeFromSuperview];
}
@end
