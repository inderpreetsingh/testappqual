//
//  ChooseLoadTrailers.h
//  Lodr
//
//  Created by c196 on 28/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellWithBtns.h"
#import "CellWelcomeFooter.h"
#import "CellChooseTrailers.h"
#import "CellListWithCheckBox.h"
@interface ChooseLoadTrailers : BaseVC<UITableViewDelegate,UITableViewDataSource,CellWelcomeFooterDelegate,CellChooseTrailersDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwNavbar;
@property (weak, nonatomic) IBOutlet UITableView *tblChooseTrailer;
- (IBAction)btnSettingClicked:(id)sender;
- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblChooseSubTrailer;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;

@end
