//
//  CellHomeScreenOptions.h
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellHomeScreenOptionsDelegate
@optional
- (void)btnHomeScreenOptionClicked:(id)sender;
@end
@interface CellHomeScreenOptions : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnHomeScreenOption;
- (IBAction)btnHomeScreenOptionClicked:(id)sender;
@property (nonatomic, weak) id <CellHomeScreenOptionsDelegate> cellHomeScreenOptionsDelegate;
@end
