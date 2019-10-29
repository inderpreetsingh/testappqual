//
//  AvailabilityCell.h
//  Lodr
//
//  Created by C205 on 09/07/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvailabilityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnAvailabilityUnlimited;
@property (weak, nonatomic) IBOutlet UIButton *btnAvailabilityUSCanada;
@property (weak, nonatomic) IBOutlet UIButton *btnAvailabilityInterstate;
@property (weak, nonatomic) IBOutlet UIButton *btnAvailabilityIntrastate;

@end
