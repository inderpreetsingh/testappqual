//
//  CellCalenderEvent.h
//  PUCalender
//
//  Created by c196 on 07/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *CollectionViewCellIdentifier = @"CellEventView";
@protocol CellCalenderEventDelegate <NSObject>
@optional
- (IBAction)btnResourceDetailClicked:(id)sender;
@end
@interface CellCalenderEvent : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mainVw;
@property (weak, nonatomic) IBOutlet UIView *vwResouceNames;
@property (weak, nonatomic) IBOutlet UIView *vwCollectionvw;
@property (weak, nonatomic) IBOutlet UICollectionView *collAllEvents;
@property (weak, nonatomic) IBOutlet UILabel *lblNameResoutce;
@property (weak, nonatomic) IBOutlet UILabel *lblmilesdata;
- (IBAction)btnResourceDetailClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnResoutcedetail;
@property (nonatomic,strong) id<CellCalenderEventDelegate> cellCalenderEventDelegate;
@end
