//
//  MatchDetailView.m
//  Lodr
//
//  Created by Payal Umraliya on 20/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "MatchDetailView.h"

@implementation MatchDetailView
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.imgBrandImage.layer.borderWidth=1.0f;
    self.imgBrandImage.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.imgBrandImage.layer.cornerRadius=1.0f;
    self.imgBrandImage.clipsToBounds=YES;
    self.lblcname.numberOfLines=0;
    [self.lblcname sizeToFit];
    self.lblcaddress.numberOfLines=0;
    [self.lblcaddress sizeToFit];
    self.lblownername.numberOfLines=0;
    [self.lblownername sizeToFit];
    self.lblonwerphone.numberOfLines=0;
    [self.lblonwerphone sizeToFit];
    self.lbltimeopen.numberOfLines=0;
    [self.lbltimeopen sizeToFit];
    self.lblDistance.numberOfLines=0;
    [self.lblDistance sizeToFit];
    UITapGestureRecognizer *singlelblDistanceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMatchlblDistanceTap:)];
      UITapGestureRecognizer *singlelblAddressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMatchlblAddressTap:)];
    UITapGestureRecognizer *singlelblphTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMatchlblphoneTap:)];
    [self.lblDistance addGestureRecognizer:singlelblDistanceTap];
    [self.lblcaddress addGestureRecognizer:singlelblAddressTap];
    [self.lblonwerphone addGestureRecognizer:singlelblphTap];
}

- (IBAction)btnStatusClicked:(id)sender {
    [self.matchDetailViewDelegate btnStatusClicked:sender];
}
- (IBAction)btnFavClicked:(id)sender {
     [self.matchDetailViewDelegate btnFavClicked:sender];
}
- (IBAction)btnLikeClicked:(id)sender {
     [self.matchDetailViewDelegate btnLikeClicked:sender];
}
- (IBAction)btnShareClicked:(id)sender {
     [self.matchDetailViewDelegate btnShareClicked:sender];
}

- (IBAction)btnHideClicked:(id)sender {
     [self.matchDetailViewDelegate btnHideClicked:sender];
}
- (IBAction)btnDetailMenuDrawerclicked:(id)sender {
     [self.matchDetailViewDelegate btnDetailMenuDrawerclicked:sender];
}
- (IBAction)btnCancelLoadClicked:(id)sender {
     [self.matchDetailViewDelegate btnCancelLoadClicked:sender];
}
- (IBAction)btnConatctOwnerClicked:(id)sender {
     [self.matchDetailViewDelegate btnConatctOwnerClicked:sender];
}

- (IBAction)btnChatOwnerClicked:(id)sender {
     [self.matchDetailViewDelegate btnChatOwnerClicked:sender];
}
- (void)handleMatchlblDistanceTap:(UITapGestureRecognizer *)tapRecognizer
{
    [self.matchDetailViewDelegate handleMatchlblDistanceTap:tapRecognizer];
}
- (void)handleMatchlblAddressTap:(UITapGestureRecognizer *)tapRecognizer
{
    [self.matchDetailViewDelegate handleMatchlblAddressTap:tapRecognizer];
}
- (void)handleMatchlblphoneTap:(UITapGestureRecognizer *)tapRecognizer
{
     UILabel *view =(UILabel *)tapRecognizer.view; 
    NSString *phNo = view.text;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } 
    else
    {
        [AZNotification showNotificationWithTitle:CallFacilityNotAvailable controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
    }
}
@end
