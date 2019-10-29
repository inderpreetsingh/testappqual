//
//  ChooseEquiTypesVC.h
//  Lodr
//
//  Created by c196 on 26/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellPostEquiHeader.h"
#import "CellPostEquiFooter.h"
#import "CellListWithCheckBox.h"
#import "CellWelcomeFooter.h"
@interface ChooseEquiTypesVC : BaseVC<UITableViewDelegate,UITableViewDataSource,
CellPostEquiHeaderDelegate,CellPostEquiFooterDelegate,CellWelcomeFooterDelegate,CellListWithCheckBoxDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwMain;
@property (weak, nonatomic) IBOutlet UIView *vwSubmain;
@property (weak, nonatomic) IBOutlet UITableView *tblEquiList;
@property (strong, nonatomic) IBOutlet UITableView *tblAbilityList;
- (IBAction)btnbackclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnback;
- (IBAction)btnDrawerclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btndrawer;
@property (weak, nonatomic) NSString *redirectfrom;
@end
