//
//  LoadCommentsCell.h
//  Lodr
//
//  Created by C225 on 12/05/18.
//  Copyright © 2018 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadCommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteComment;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;

@end
