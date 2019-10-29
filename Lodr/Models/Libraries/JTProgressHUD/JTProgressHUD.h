#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JTProgressHUDStyle) {
	JTProgressHUDStyleDefault = 0,
	JTProgressHUDStyleGradient,
	JTProgressHUDStyleBlurLight,
	JTProgressHUDStyleBlurExtraLight,
	JTProgressHUDStyleBlurDark
};

typedef NS_ENUM(NSInteger, JTProgressHUDTransition) {
    JTProgressHUDTransitionDefault = 0,
    JTProgressHUDTransitionFade,
    JTProgressHUDTransitionNone
};

typedef NS_ENUM(NSInteger, JTProgressHUDView) {
    JTProgressHUDViewBuiltIn = 0 // Same as nil
};

@interface JTProgressHUD : UIView

+ (void)showWithView:(UIView *)view style:(JTProgressHUDStyle)style transition:(JTProgressHUDTransition)transition backgroundAlpha:(CGFloat)backgroundAlpha withtext:(NSString *)textdata;
+ (void)show;
+ (void)showWithView:(UIView *)view;
+ (void)showWithStyle:(JTProgressHUDStyle)style andText:(NSString *)textdata;
+ (void)showWithTransition:(JTProgressHUDTransition)transition andText:(NSString *)textdata;
+ (void)showWithBackgroundAlpha:(CGFloat)backgroundAlpha andText:(NSString *)textdata;

+ (void)hide;
+ (void)hideWithTransition:(JTProgressHUDTransition)transition;

+ (BOOL)isVisible;

@end
