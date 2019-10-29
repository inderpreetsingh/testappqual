//
//  MenuVC.h
//  Lodr
//
//  Created by Payal Umraliya on 16/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellSideMenuSection.h"
#import "ZSYPopoverListView.h"
@interface MenuVC : BaseVC<UITableViewDataSource,UITableViewDelegate,CellSideMenuSectionDelegate,ZSYPopoverListDelegate,ZSYPopoverListDatasource>
@property (weak, nonatomic) IBOutlet UITableView *tblMenu;
@property (weak, nonatomic) IBOutlet UILabel *lblLoggedUname;
@end
