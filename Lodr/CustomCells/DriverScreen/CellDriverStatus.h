//
//  CellDriverStatus.h
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellDriverStatusDelegate
@optional
- (IBAction)btnStatusNameClicked:(id)sender;
@end
@interface CellDriverStatus : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblStatusDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnStatusName;
- (IBAction)btnStatusNameClicked:(id)sender;
@property (nonatomic, weak) id <CellDriverStatusDelegate> cellDriverStatusDelegate;
@end
