//
//  EditDotAccount.h
//  Lodr
//
//  Created by c196 on 10/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellWelcomeFooter.h"
#import "CellWelcomeSummary.h"
#import "CellAccountHeader.h"
#import "DOTDetails.h"

@interface EditDotAccount : BaseVC<CellWelcomeSummaryDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblMyAccount;
@property (strong, nonatomic) IBOutlet UIView *vwnavbar;
- (IBAction)btnDrawerClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnDrawer;

@end
