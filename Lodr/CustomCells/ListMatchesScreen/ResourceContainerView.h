//
//  ResourceContainerView.h
//  PUNestedTable
//
//  Created by Payal Umraliya on 09/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ResourceContainerViewDelegate
@optional
- (void)btnLoadDetailClicked:(id)sender;
- (void)btnDistanceSortClicked:(id)sender;
- (void)btnPickupSortClicked:(id)sender;
- (void)btnDelievrySortClicked:(id)sender;
- (void)btnRateSortClicked:(id)sender;
- (void)btnStatusSortClicked:(id)sender;
@end
@interface ResourceContainerView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *lbltitleDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblRate;
@property (weak, nonatomic) IBOutlet UIView *vwResource1;
@property (weak, nonatomic) IBOutlet UIView *vwSectionTitle;
- (IBAction)btnLoadDetailClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblReourceName;
@property (weak, nonatomic) IBOutlet UILabel *lblMiles;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblseparator1;
@property (weak, nonatomic) IBOutlet UIView *vwFromTime;
@property (weak, nonatomic) IBOutlet UILabel *lblFromTime;
@property (weak, nonatomic) IBOutlet UIView *vwStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vwheaderhight;
@property (weak, nonatomic) IBOutlet UIView *vwRate;
@property (weak, nonatomic) IBOutlet UIView *vwHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblToTime;
@property (weak, nonatomic) IBOutlet UIView *vwArrow;
@property (weak, nonatomic) IBOutlet UILabel *lblArrow;
@property (weak, nonatomic) IBOutlet UILabel *lblBlackBubble;
@property (weak, nonatomic) IBOutlet UIView *vwBelowHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblToDate;
@property (weak, nonatomic) IBOutlet UILabel *lblOrangeBubble;
@property (weak, nonatomic) IBOutlet UILabel *lblFromDate;
@property (weak, nonatomic) IBOutlet UIView *vwmainview;
@property (weak, nonatomic) IBOutlet UIButton *btnDelievery;
@property (weak, nonatomic) IBOutlet UILabel *lblTitlename;
@property (weak, nonatomic) IBOutlet UIButton *btnstatus;
@property (weak, nonatomic) IBOutlet UIButton *btnrate;
@property (weak, nonatomic) IBOutlet UIView *vwToTime;
@property (weak, nonatomic) IBOutlet UIButton *btnDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusText;
@property (weak, nonatomic) IBOutlet UIButton *btnpickup;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightSection;
@property (weak, nonatomic) IBOutlet UILabel *lblLoadNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblPickedUpTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPickedUpDate;
@property (weak, nonatomic) IBOutlet UIView *viewLoadHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnAddLoad;

- (IBAction)btnDistanceSortClicked:(id)sender;
- (IBAction)btnPickupSortClicked:(id)sender;
- (IBAction)btnDelievrySortClicked:(id)sender;
- (IBAction)btnRateSortClicked:(id)sender;
- (IBAction)btnStatusSortClicked:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewwithlablestatusHeight;
@property (weak, nonatomic) IBOutlet UIView *vwonlylabel;

@property (nonatomic, weak) id <ResourceContainerViewDelegate> resourceContainerViewDelegate;
@end
