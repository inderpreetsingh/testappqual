//
//  AddLoadPopupVC.m
//  Lodr
//
//  Created by C225 on 22/05/18.
//  Copyright © 2018 checkmate. All rights reserved.
//

#import "AddLoadPopupVC.h"

@interface AddLoadPopupVC ()

@end

@implementation AddLoadPopupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:true completion:nil];
}


/*
 
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnCreateNewLoadClicked:(UIButton *)sender {
    
    
    [self dismissViewControllerAnimated:true completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:kPushCreateORSavedLoad object:@"0"];
        
    }];
    
//     PostLoadVC *objPostLoad=initVCToRedirect(SBAFTERSIGNUP, POSTLOADVC);
////    AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objPostLoad];
////    [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
////    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
//
//    UINavigationController *navControl = [[UINavigationController alloc]initWithRootViewController:objPostLoad];
//
//    [self.navigationController pushViewController:navControl animated:true];
    
}

- (IBAction)btnOpenSavedLoadClicked:(UIButton *)sender {
//    AllSavedLoadListVC *objsavedlist=initVCToRedirect(SBAFTERSIGNUP, ALLSAVEDLOADLIST);
//    UINavigationController *navControl = [[UINavigationController alloc]initWithRootViewController:objsavedlist];
//
//    [self.navigationController pushViewController:navControl animated:YES];
    [self dismissViewControllerAnimated:true completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:kPushCreateORSavedLoad object:@"1"];
        
    }];
    
}
@end
