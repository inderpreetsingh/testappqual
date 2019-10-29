//
//  CellSideMenuSection.h
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellSideMenuSectionDelegate
@optional
- (void)btnMenuClicked:(id)sender;
@end
@interface CellSideMenuSection : UIView

- (IBAction)btnMenuClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMenuName;
@property (nonatomic, weak) id <CellSideMenuSectionDelegate> cellSideMenuSectionDelegate;
@end
