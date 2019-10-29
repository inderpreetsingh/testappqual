//
//  MatchDetailView.h
//  Lodr
//
//  Created by Payal Umraliya on 20/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MatchDetailViewDelegate
@optional
- (void)btnStatusClicked:(id)sender;
- (void)btnLikeClicked:(id)sender;
- (void)btnFavClicked:(id)sender;
- (void)btnShareClicked:(id)sender;
- (void)btnHideClicked:(id)sender;
- (void)btnDetailMenuDrawerclicked:(id)sender;
- (void)btnCancelLoadClicked:(id)sender;
- (void)btnConatctOwnerClicked:(id)sender;
- (void)btnChatOwnerClicked:(id)sender;
- (void)handleMatchlblDistanceTap:(UITapGestureRecognizer *)tapRecognizer;
- (void)handleMatchlblAddressTap:(UITapGestureRecognizer *)tapRecognizer;
@end
@interface MatchDetailView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgBrandImage;
@property (weak, nonatomic) IBOutlet UIView *viewmatchedDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblcname;
@property (weak, nonatomic) IBOutlet UILabel *lblcaddress;
@property (weak, nonatomic) IBOutlet UILabel *lblownername;
@property (weak, nonatomic) IBOutlet UILabel *lblonwerphone;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;
- (IBAction)btnStatusClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbltimeopen;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
- (IBAction)btnLikeClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFav;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
- (IBAction)btnFavClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
- (IBAction)btnShareClicked:(id)sender;
- (IBAction)btnHideClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnHide;
- (IBAction)btnDetailMenuDrawerclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDetailMenuDrawer;
- (IBAction)btnCancelLoadClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelLoad;
@property (weak, nonatomic) IBOutlet UIButton *btnChatOwner;
- (IBAction)btnConatctOwnerClicked:(id)sender;
- (IBAction)btnChatOwnerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnConatctOwner;
@property (nonatomic, weak) id <MatchDetailViewDelegate> matchDetailViewDelegate;
@end
