//
//  CellMatchedLoadListForEquipment.h
//  Lodr
//
//  Created by Payal Umraliya on 07/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellMatchedLoadListForEquipmentDelegate
@optional
- (IBAction)btnsortpickupclicked:(id)sender;
- (IBAction)btnsortdelieverclicked:(id)sender;
- (IBAction)btnsortlenghtclicked:(id)sender;
- (IBAction)btnsortweightclicked:(id)sender;
- (IBAction)btnsortrateclciked:(id)sender;
@end
@interface CellMatchedLoadListForEquipment : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwMainBg;
@property (weak, nonatomic) IBOutlet UIView *vwCellHeader;
@property (weak, nonatomic) IBOutlet UIView *vwLoadDetails;
@property (weak, nonatomic) IBOutlet UIView *vwLoadLocationAndPrice;
@property (weak, nonatomic) IBOutlet UIView *vwPickup;
@property (weak, nonatomic) IBOutlet UIView *vwDelievery;
@property (weak, nonatomic) IBOutlet UIButton *btnIsContactd;
@property (weak, nonatomic) IBOutlet UILabel *btnMatchedCompnyname;
@property (weak, nonatomic) IBOutlet UILabel *lblLength;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (weak, nonatomic) IBOutlet UILabel *lblRate;
@property (weak, nonatomic) IBOutlet UIButton *btnisFav;
@property (weak, nonatomic) IBOutlet UILabel *lblPickupTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPickupDate;
@property (weak, nonatomic) IBOutlet UILabel *lblDeliveryDate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vwCellHeaderHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblPickupLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblDelieveryTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDelieveryLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnsortpickup;
- (IBAction)btnsortpickupclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnsortdeleivery;
- (IBAction)btnsortdelieverclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnsortlenght;
- (IBAction)btnsortlenghtclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnsortweight;
- (IBAction)btnsortweightclicked:(id)sender;
- (IBAction)btnoutofdateclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnsortrate;
- (IBAction)btnsortrateclciked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnOutOfDate;
@property (weak, nonatomic) IBOutlet UILabel *lblSep;
@property (weak, nonatomic) IBOutlet UILabel *lblSep1;
@property (weak, nonatomic) IBOutlet UIButton *btnArrow;
@property (nonatomic, weak) id <CellMatchedLoadListForEquipmentDelegate> cellMatchedLoadListForEquipmentDelegate;
@end
