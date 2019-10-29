//
//  SavedLoadCell.h
//  Lodr
//
//  Created by C109 on 03/03/18.
//  Copyright © 2018 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedLoadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblMiles;
@property (weak, nonatomic) IBOutlet UILabel *lblRate;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusText;
@property (weak, nonatomic) IBOutlet UILabel *lblFromDate;
@property (weak, nonatomic) IBOutlet UILabel *lblToDate;
@property (weak, nonatomic) IBOutlet UILabel *lblFromTime;
@property (weak, nonatomic) IBOutlet UILabel *lblToTime;

@end
