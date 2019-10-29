//
//  AddCommentCell.h
//  Lodr
//
//  Created by C225 on 14/05/18.
//  Copyright © 2018 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textViewAddComment;
@property (weak, nonatomic) IBOutlet UIButton *btnAddComment;
@property (weak, nonatomic) IBOutlet UIButton *btnPublish;
@property (weak, nonatomic) IBOutlet UIButton *btnEditLoad;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteLoad;
@property (weak, nonatomic) IBOutlet UIView *viewEditLoad;
@property (weak, nonatomic) IBOutlet UIView *viewNotInterested;
@property (weak, nonatomic) IBOutlet UIButton *btnNotInterested;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelLoad;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnNotIntHeightConstraints;
//@property (weak, nonatomic) IBOutlet UIView *viewReportStatus;
@property (weak, nonatomic) IBOutlet UIView *viewReportStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHeightConstant;

@end
