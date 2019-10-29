//
//  DotWarning.h
//  Lodr
//
//  Created by c196 on 25/07/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DotWarningDelegate
@optional
- (IBAction)btnsettingsclciked:(id)sender;
@end

@interface DotWarning : UIView
@property (strong, nonatomic) IBOutlet UIView *vwWarningPopUp;
@property (strong, nonatomic) IBOutlet UILabel *lblWarningtext;
@property (strong, nonatomic) IBOutlet UIButton *btnok;
- (IBAction)btnokclciked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnsettings;
- (IBAction)btnsettingsclciked:(id)sender;
@property (nonatomic, weak) id <DotWarningDelegate> dotWarningDelegate;
@end
