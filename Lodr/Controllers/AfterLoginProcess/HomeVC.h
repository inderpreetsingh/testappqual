//
//  HomeVC.h
//  Lodr
//
//  Created by Payal Umraliya on 15/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellCvHomeCounter.h"
#import "CellHomeScreenHeader.h"
#import "CellHomeScreenOptions.h"
#import "DispatchListVC.h"
#import "CellHomeSwitchOnOff.h"

@interface HomeVC : BaseVC<CellCvHomeCounterDelegate,CellHomeScreenHeaderDelegate,CellHomeScreenOptionsDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblHomeScreen;

@end
