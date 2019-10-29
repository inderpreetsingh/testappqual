//
//  CellAssetMiddle.h
//  Lodr
//
//  Created by c196 on 03/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellAssetMiddle : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwMiddle;
@property (weak, nonatomic) IBOutlet UILabel *lblassetlength;
@property (weak, nonatomic) IBOutlet UILabel *lblassetwidth;
@property (weak, nonatomic) IBOutlet UILabel *lblassetweight;
@property (weak, nonatomic) IBOutlet UILabel *lblassetheight;
@property (strong, nonatomic) IBOutlet UILabel *lblassetempthweight;

@end
