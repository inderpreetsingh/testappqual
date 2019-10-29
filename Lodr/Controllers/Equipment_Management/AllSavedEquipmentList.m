//
//  AllSavedEquipmentList.m
//  Lodr
//
//  Created by Payal Umraliya on 14/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "AllSavedEquipmentList.h"

@interface AllSavedEquipmentList ()

@end

@implementation AllSavedEquipmentList

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - click event

- (IBAction)btnsavedequibackclicked:(id)sender 
{
     [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnsavedequidrawerClicked:(id)sender {
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
@end
