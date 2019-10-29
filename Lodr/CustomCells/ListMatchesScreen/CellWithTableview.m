//
//  CellWithTableview.m
//  Lodr
//
//  Created by c196 on 29/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellWithTableview.h"

@implementation CellWithTableview

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tblInsideCell.delegate=self;
    self.tblInsideCell.dataSource=self;
    self.tblInsideCell.estimatedRowHeight=400;
    self.tblInsideCell.rowHeight=UITableViewAutomaticDimension;
    self.tblInsideCell.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.tblInsideCell.scrollEnabled=false;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
    [super setSelected:selected animated:animated];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [self.cellWithTableviewDelegate cell_numberOfSectionsInTableView:tableView];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.cellWithTableviewDelegate cell_tableView:tableView viewForHeaderInSection:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [self.cellWithTableviewDelegate cell_tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellWithTableviewDelegate cell_tableView:tableView cellForRowAtIndexPath:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.cellWithTableviewDelegate cell_tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellWithTableviewDelegate cell_tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cellWithTableviewDelegate cell_tableView:tableView didSelectRowAtIndexPath:indexPath];
}
@end
