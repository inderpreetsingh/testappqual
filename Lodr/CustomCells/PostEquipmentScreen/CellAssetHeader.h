//
//  CellAssetHeader.h
//  Lodr
//
//  Created by c196 on 03/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellAssetHeader : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblNameOfTrailer;
@property (weak, nonatomic) IBOutlet UIView *vwAssetName;
@property (weak, nonatomic) IBOutlet UIView *vwAssetHeading;
@property (weak, nonatomic) IBOutlet UILabel *lblheadingtile;
@property (strong, nonatomic) IBOutlet UILabel *lbltypeofasset;
@property (strong, nonatomic) IBOutlet UILabel *lblAssetability;

@end
