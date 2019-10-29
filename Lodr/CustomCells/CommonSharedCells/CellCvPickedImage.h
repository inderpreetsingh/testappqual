//
//  CellCvPickedImage.h
//  Lodr
//
//  Created by Payal Umraliya on 24/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellCvPickedImageDelegate
@optional
- (void)btnDeleteImageClicked:(id)sender;

@end
@interface CellCvPickedImage : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgLarge;
@property (weak, nonatomic) IBOutlet UIImageView *imgcancel;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteImage;
- (IBAction)btnDeleteImageClicked:(id)sender;
@property (nonatomic, weak) id <CellCvPickedImageDelegate> cellCvPickedImageDelegate;
@end
