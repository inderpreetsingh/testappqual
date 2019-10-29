//
//  AllSavedEquipmentList.h
//  Lodr
//
//  Created by Payal Umraliya on 14/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQMultistageTableView.h"
@interface AllSavedEquipmentList : UIViewController
@property (weak, nonatomic) IBOutlet UIView *vwnavbar;
- (IBAction)btnsavedequibackclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnsavedequiback;
- (IBAction)btnsavedequidrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnsavedequidrawer;
@property (weak, nonatomic) IBOutlet TQMultistageTableView *mTableView;

@end
