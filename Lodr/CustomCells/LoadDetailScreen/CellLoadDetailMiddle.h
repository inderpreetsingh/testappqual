//
//  CellLoadDetailMiddle.h
//  Lodr
//
//  Created by Payal Umraliya on 20/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@protocol CellLoadDetailMiddleDelegate
@optional
-(IBAction)btnContactClicked:(id)sender;
- (IBAction)btnsmsclicked:(id)sender;
@end

@interface CellLoadDetailMiddle : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwWithContactBtn;
@property (weak, nonatomic) IBOutlet UIButton *btnContact;
- (IBAction)btnContactClicked:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapDirectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoadDirection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContactBtns;
@property (weak, nonatomic) IBOutlet UILabel *lblLoadDirection;
@property (nonatomic, weak) id <CellLoadDetailMiddleDelegate> cellLoadDetailMiddleDelegate;
@property (weak, nonatomic) IBOutlet UIButton *btnsms;
@property (weak, nonatomic) IBOutlet UIView *viewMapHidden;
- (IBAction)btnsmsclicked:(id)sender;
@end
