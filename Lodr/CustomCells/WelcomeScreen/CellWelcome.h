//
//  CellWelcome.h
//  Lodr
//
//  Created by Payal Umraliya on 27/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellWelcome : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblHeadingText;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldValue;
@property (weak, nonatomic) IBOutlet UILabel *lblInstructions;

@end
