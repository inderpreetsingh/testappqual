//
//  SettingsVC.m
//  Lodr
//
//  Created by c196 on 24/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "SettingsVC.h"

@interface SettingsVC ()
{
    NSArray *arrSettingMenu;
}
@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowNetworkIndicator(NO);
    arrSettingMenu=[NSArray arrayWithObjects:@"Change Radius", nil];
}
#pragma mark - tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{ 
    return arrSettingMenu.count; 
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 45.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
//    static NSString *cellIdentifier = @"CellMenu";
//    CellMenu *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell) 
//    { 
//        cell = [[CellMenu alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
//    }
//    cell.lblMenuName.text=[arrMenus objectAtIndex:indexPath.row];
    
    return nil; 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)btnDrawerClciekd:(id)sender {
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
@end
