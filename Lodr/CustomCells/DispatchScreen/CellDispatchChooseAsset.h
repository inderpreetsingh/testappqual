//
//  CellDispatchChooseAsset.h
//  Lodr
//
//  Created by c196 on 29/08/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellCellDispatchChooseAssetDelegate
@optional
- (IBAction)btncloseclicked:(id)sender;
- (IBAction)btndroplistclicked:(id)sender;
@end

@interface CellDispatchChooseAsset : UITableViewCell
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightlbl;
@property (strong, nonatomic) IBOutlet UILabel *lblchooseheading;
@property (strong, nonatomic) IBOutlet UIView *vwContents;
@property (strong, nonatomic) IBOutlet UIButton *btnclose;
- (IBAction)btncloseclicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btndroplist;
- (IBAction)btndroplistclicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgofasset;
@property (strong, nonatomic) IBOutlet UILabel *lblnoasset;
@property (strong, nonatomic) IBOutlet UIButton *btnredirect;
@property (strong, nonatomic) IBOutlet UILabel *lblnameofproperty;
@property (nonatomic, weak) id <CellCellDispatchChooseAssetDelegate> cellCellDispatchChooseAssetDelegate;
@end
