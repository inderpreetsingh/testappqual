//
//  CompanyRequestCell.h
//  Lodr
//
//  Created by C205 on 05/03/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyRequestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblRequestText;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnReject;

@end
