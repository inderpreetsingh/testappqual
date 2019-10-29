//
//  CellWithCV.h
//  Lodr
//
//  Created by Payal Umraliya on 19/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellWithCV : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwMainBg;
@property (weak, nonatomic) IBOutlet UILabel *lblNoData;
@property (weak, nonatomic) IBOutlet UICollectionView *cvPhotoes;
@property (weak, nonatomic) IBOutlet UILabel *lblAllphoto;

@end
