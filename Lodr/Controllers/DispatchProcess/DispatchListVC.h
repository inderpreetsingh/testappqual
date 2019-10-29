//
//  DispatchListVC.h
//  Lodr
//
//  Created by c196 on 28/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellCalenderHeader.h"
#import "UITableView+Placeholder.h"

@interface DispatchListVC : BaseVC <UITableViewDelegate,UITableViewDataSource,CellCalenderHeaderDelegate>

@property (strong, nonatomic) IBOutlet UIView *vwnavbar;
@property (strong, nonatomic) IBOutlet UITableView *tbldispatchlist;
@property (strong, nonatomic) IBOutlet UIButton *btndrawer;
- (IBAction)btndrawerclicked:(id)sender;
@property  (strong, nonatomic) NSString *strRedirectFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBackClicked:(UIButton *)sender;

@end


