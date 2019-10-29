//
//  CellCvHomeCounter.h
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellCvHomeCounterDelegate
@optional

- (void)btnCounterClicked:(id)sender;

@end
@interface CellCvHomeCounter : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnCounter;

- (IBAction)btnCounterClicked:(id)sender;

@property (nonatomic, weak) id <CellCvHomeCounterDelegate> cellCvHomeCounterDelegate;
@end
