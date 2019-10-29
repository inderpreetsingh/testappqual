//
//  CellWithTableview.h
//  Lodr
//
//  Created by c196 on 29/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellWithTableviewDelegate
@optional
- (NSInteger)cell_numberOfSectionsInTableView:(UITableView *)tableView;
-(UIView *)cell_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSInteger)cell_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)cell_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)cell_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)cell_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)cell_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface CellWithTableview : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblInsideCell;
@property (nonatomic, weak) id <CellWithTableviewDelegate> cellWithTableviewDelegate;
@end
