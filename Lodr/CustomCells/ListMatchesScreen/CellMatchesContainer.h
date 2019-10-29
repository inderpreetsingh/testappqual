//
//  CellMatchesContainer.h
//  PUNestedTable
//
//  Created by Payal Umraliya on 09/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellMatchesContainerDelegate
@optional
- (IBAction)btnCloseMatchListClicked:(id)sender;
- (IBAction)btnFavClicke:(id)sender;
- (IBAction)btnMailClicked:(id)sender;
- (IBAction)btnMenuFilterClicked:(id)sender;
@end
@interface CellMatchesContainer : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwCellBg;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchName;
@property (weak, nonatomic) IBOutlet UILabel *lblMiles;
- (IBAction)btnCloseMatchListClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFav;
- (IBAction)btnFavClicke:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCloseMatchList;
- (IBAction)btnMailClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMail;
- (IBAction)btnMenuFilterClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMenuFilter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (nonatomic, weak) id <CellMatchesContainerDelegate> cellMatchesContainerDelegate;
@property (weak, nonatomic) IBOutlet UILabel *lblSeperator;
@end
