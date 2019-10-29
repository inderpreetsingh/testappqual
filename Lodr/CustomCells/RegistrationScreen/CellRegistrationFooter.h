//
//  CellRegistrationFooter.h
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellRegistrationFooterDelegate
@optional
- (void)btnSignUpClicked:(id)sender;
- (void)btnTermsClicked:(id)sender;
@end
@interface CellRegistrationFooter : UIView
- (IBAction)btnSignUpClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
- (IBAction)btnTermsClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnTerms;
@property (nonatomic, weak) id <CellRegistrationFooterDelegate> delegate;
@end
