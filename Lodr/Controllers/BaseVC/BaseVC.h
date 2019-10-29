//
//  BaseVC.h
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "Drivers.h"

typedef enum
{
    SearchDetailsTypeCompany = 0,
    SearchDetailsTypeOffice
}SearchDetailsType;

@interface BaseVC : UIViewController<MFMessageComposeViewControllerDelegate>
-(BOOL)validateTxtFieldLength :(UITextField*)txtVal withMessage :(NSString *)msg;
-(BOOL)validateEmail :(UITextField*)txtVal withMessage :(NSString *)msg;
-(BOOL)validateEmailText :(NSString*)txtVal withMessage :(NSString *)msg;
-(BOOL)validatePassword :(UITextField*)txtVal confirmpassword :(UITextField *)txtVal2 withMessage :(NSString *)msg;
-(BOOL)validateVerifyText :(NSString*)txtVal confirmpassword :(NSString *)txtVal2 withMessage :(NSString *)msg;
-(void)changePlaceholderColor :(UIView *)vname :(UIColor *)cname;
-(void)addBorderToView :(UIView *)vwname withColor :(UIColor*)cname withBorderWidth :(CGFloat)width withRadius :(CGFloat)radious;
-(BOOL)validateTxtLength :(NSString*)txtVal withMessage :(NSString *)msg;
-(void)leftViewPaddingForTextfield :(UITextField *)txtfield :(UIImage*)imgname withWidth:(CGFloat)w andHeight:(CGFloat)h withOriginY:(CGFloat)y;
-(void)cornerRadiousSettingforView :(UIView *)vwnm withCornerNameOne:(UIRectCorner)corner1 withCornerNameTwo:(UIRectCorner)corner2 withCornerNameThree:(UIRectCorner)corner3 withsize:(CGFloat)sizeval;
-(NSString *)checkDevToken;
-(void)setbuttonimageRightSide:(UIButton *)btn;
-(void)cornerRadiousSettingforView :(UIView *)vwnm withCornerNameOne:(UIRectCorner)corner1 withCornerNameTwo:(UIRectCorner)corner2 withsize:(CGFloat)sizeval;
-(void)cornerRadiousSettingforView :(UIView *)vwnm withCornerNameOne:(UIRectCorner)corner1 withCornerNameTwo:(UIRectCorner)corner2 withsize:(CGFloat)sizeval withColor1:(UIColor*)colorone withColor2:(UIColor*)colortwo;
-(void)showHUD :(NSString *)str;
-(void)dismissHUD;
-(void)getAllEquipmentsBase;
- (void)drawRect:(CGRect)rect :(UILabel *)textval;
- (NSArray*)splitTextToLines:(NSUInteger)maxLines Tolable:(UILabel *)lbl;
-(void)viewWithAnimationFormView:(UIView *)v1 Toview:(UIView *)v2 transitionType:(NSString *)typenm withAnimation:(BOOL)animationEnable;
- (UIImage*) drawText:(NSString*) text
              inImage:(UIImage*)  image
              atPoint:(CGPoint)   point
               color :(UIColor *)colorname;
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients;
-(NSMutableArray *)getUsStates;
-(void)updateUserLocation;
- (UIImage*) drawTextStatus:(NSString*) text
                    inImage:(UIImage*)  image
                    atPoint:(CGPoint)   point
                     color :(UIColor *)colorname;
-(void)crashReporter:(NSString *)reportText;
@end
