//
//  cellPdfview.h
//  Lodr
//
//  Created by Payal Umraliya on 19/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellPdfviewDelegate
@optional
- (IBAction)btnPdfNameClicked:(id)sender;
- (IBAction)btnPdfDeleteClicked:(id)sender;
@end
@interface cellPdfview : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnPdfName;
- (IBAction)btnPdfNameClicked:(id)sender;
- (IBAction)btnPdfDeleteClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPdfDelete;
@property (nonatomic, weak) id <CellPdfviewDelegate> cellPdfviewDelegate;
@end
