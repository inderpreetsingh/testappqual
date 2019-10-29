//
//  CellDriverProfile.h
//  Lodr
//
//  Created by c196 on 11/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDriverProfile : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDriverDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblDriverFieldName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightseparator;

@end
