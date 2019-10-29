//
//  AdminChangeCell.h
//  Lodr
//
//  Created by C205 on 13/06/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminChangeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnChange;
@property (weak, nonatomic) IBOutlet UITextField *txtAdmin;
@property (weak, nonatomic) IBOutlet UILabel *lblRequest;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLblRequest;

@end
