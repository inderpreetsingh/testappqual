//
//  AllSavedLoadListVC.h
//  Lodr
//
//  Created by Payal Umraliya on 14/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQMultistageTableView.h"
#import "ResourceContainerView.h"
#import "SavedLoadCell.h"
@interface AllSavedLoadListVC : BaseVC<TQTableViewDataSource,TQTableViewDelegate,ResourceContainerViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *vwnavbar;
//@property (strong, nonatomic) IBOutlet TQMultistageTableView *mTableView;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
- (IBAction)btnSavedLoadbackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnsavedloadback;
- (IBAction)btnsavedloaddrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnsavedloaddrawer;
- (IBAction)buttonSortDistanceAction:(UIButton *)sender;


- (IBAction)buttonSortStatusAction:(UIButton *)sender;
- (IBAction)buttonSortRateAction:(UIButton *)sender;

- (IBAction)buttonSortPickupAction:(UIButton *)sender;
- (IBAction)buttonSortDeliveryAction:(UIButton *)sender;


@end
