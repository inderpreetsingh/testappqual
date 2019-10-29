//
//  CellCalenderHeader.h
//  Lodr
//
//  Created by c196 on 25/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellCalenderHeaderDelegate
@optional
- (IBAction)btnGotoDetailClicked:(id)sender;
- (IBAction)btnSectionTapped:(id)sender;
- (IBAction)btnTrcukDetailClicked:(id)sender;
- (IBAction)btnSectionOpenClicked:(id)sender;
@end

@interface CellCalenderHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIView *vwMainView;
@property (weak, nonatomic) IBOutlet UIView *vwResoureceDetails;
@property (weak, nonatomic) IBOutlet UIView *vwForNames;
@property (weak, nonatomic) IBOutlet UIButton *btnRedirectToDetail;

@property (weak, nonatomic) IBOutlet UILabel *lblResourceName;
@property (weak, nonatomic) IBOutlet UILabel *lblResouceSubdetailName;
@property (weak, nonatomic) IBOutlet UIView *vwTimeDetails;
@property (weak, nonatomic) IBOutlet UIView *vwAmountDetails;
@property (weak, nonatomic) IBOutlet UIView *vwDistance1;
@property (weak, nonatomic) IBOutlet UIView *vwDistance2;
@property (weak, nonatomic) IBOutlet UIButton *btnSection;
@property (weak, nonatomic) IBOutlet UILabel *lblAmountName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate1;
@property (weak, nonatomic) IBOutlet UILabel *lblTime1;
@property (weak, nonatomic) IBOutlet UILabel *lblDate2;
@property (weak, nonatomic) IBOutlet UILabel *lblTime2;
@property (weak, nonatomic) IBOutlet UIView *vwLocationOftruck;
@property (weak, nonatomic) IBOutlet UILabel *lblTruckname;
@property (weak, nonatomic) IBOutlet UIView *vwTruckList;
@property (weak, nonatomic) IBOutlet UIView *vwTruckStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnViewTruckDetails;
@property (weak, nonatomic) IBOutlet UIView *vwDetailOfTruck;
@property (weak, nonatomic) IBOutlet UILabel *lblDestinationsName;
@property (weak, nonatomic) IBOutlet UIButton *btnExpandColl;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
- (IBAction)btnGotoDetailClicked:(id)sender;
- (IBAction)btnSectionTapped:(id)sender;
- (IBAction)btnTrcukDetailClicked:(id)sender;
- (IBAction)btnSectionOpenClicked:(id)sender;
@property (nonatomic, weak) id <CellCalenderHeaderDelegate> cellCalenderHeaderDelegate;



@end
