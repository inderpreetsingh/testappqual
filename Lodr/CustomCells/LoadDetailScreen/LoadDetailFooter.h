//
//  LoadDetailFooter.h
//  Lodr
//
//  Created by Payal Umraliya on 14/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoadDetailFooterDelegate
@optional
- (void)btnmakepublishclicked:(id)sender;
- (void)btnmarkascancelclicked:(id)sender;
- (void)btneditloadclicked:(id)sender;
- (void)btnlinkscheduleconfirmclicked:(id)sender;
- (IBAction)btnnotinterestedclicked:(id)sender;
@end

@interface LoadDetailFooter : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblinstructions;
@property (weak, nonatomic) IBOutlet UIView *vwwithmultiplebtns;
@property (weak, nonatomic) IBOutlet UIView *vwwithsinglebutton;
@property (weak, nonatomic) IBOutlet UIButton *btnmakepublish;
@property (weak, nonatomic) IBOutlet UILabel *lblNotes;
@property (weak, nonatomic) IBOutlet UILabel *lblComments;
@property (weak, nonatomic) IBOutlet UIButton *btnAllowComment;

@property (weak, nonatomic) IBOutlet UIButton *btneditload;
- (IBAction)btnmakepublishclicked:(id)sender;
- (IBAction)btnmarkascancelclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnmarkascancel;
- (IBAction)btneditloadclicked:(id)sender;
- (IBAction)btnlinkscheduleconfirmclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnlinkscheduleconfirm;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightFootersinglebtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightmultiplebtn;
- (IBAction)btnnotinterestedclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnnotinterested;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightbtnnotinterested;
@property (nonatomic, weak) id <LoadDetailFooterDelegate> loadDetailFooterDelegate;

@end
