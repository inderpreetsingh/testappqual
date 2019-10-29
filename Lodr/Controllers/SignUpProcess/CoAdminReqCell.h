//
//  CoAdminReqCell.h
//  Lodr
//
//  Created by C205 on 26/06/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoAdminReqCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
@property (weak, nonatomic) IBOutlet UIButton *btnIgnore;

@end
