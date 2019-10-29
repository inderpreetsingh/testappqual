//
//  CellDisptachDateTime.h
//  Lodr
//
//  Created by c196 on 29/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellDisptachDateTimeDelegate
@optional
- (IBAction)btnstarttimeclciked:(id)sender;
- (IBAction)btnstartdateclicked:(id)sender;
- (IBAction)btnendtimeclicked:(id)sender;
- (IBAction)btnenddateclicked:(id)sender;
@end
@interface CellDisptachDateTime : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblestimatedtpickup;
@property (strong, nonatomic) IBOutlet UILabel *lblestimateddelievery;
@property (strong, nonatomic) IBOutlet UILabel *lbldutarion;
@property (strong, nonatomic) IBOutlet UILabel *lblheadingdatetime;
@property (strong, nonatomic) IBOutlet UIButton *btnstarttime;
@property (strong, nonatomic) IBOutlet UIButton *btnstartdate;
@property (strong, nonatomic) IBOutlet UIButton *btnendtime;
@property (strong, nonatomic) IBOutlet UIButton *btnenddate;
- (IBAction)btnstarttimeclciked:(id)sender;
- (IBAction)btnstartdateclicked:(id)sender;
- (IBAction)btnendtimeclicked:(id)sender;
- (IBAction)btnenddateclicked:(id)sender;

@property (nonatomic, weak) id <CellDisptachDateTimeDelegate> cellDisptachDateTimeDelegate;
@end
