//
//  SettingsVC.h
//  Lodr
//
//  Created by c196 on 24/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsVC : BaseVC<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tblSettings;
@property (strong, nonatomic) IBOutlet UIView *vwnavbar;
- (IBAction)btnDrawerClciekd:(id)sender;

@end
