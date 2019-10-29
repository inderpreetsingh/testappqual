//
//  AddLoadPopupVC.h
//  Lodr
//
//  Created by C225 on 22/05/18.
//  Copyright © 2018 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostLoadVC.h"
#import "AllSavedLoadListVC.h"


@interface AddLoadPopupVC : UIViewController
- (IBAction)btnCreateNewLoadClicked:(UIButton *)sender;
- (IBAction)btnOpenSavedLoadClicked:(UIButton *)sender;

@end
