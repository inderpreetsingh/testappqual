#import <UIKit/UIKit.h>

@interface UITableView (Placeholder)

#define kBOUNCE_DISTANCE  10.f
#define kWAVE_DURATION   .8f

typedef NS_ENUM(NSInteger,WaveAnimation) {
    LeftToRightWaveAnimation = -1,
    RightToLeftWaveAnimation = 1
};

- (void) tableFloatingFromBootomAnimation;

- (void) tableFloatingFromTopAnimation;

- (void) setLoaderAnimationWithText: (NSString*)string ;

- (void)setBlankPlaceHolderWithString : (NSString*)string ;

- (void)reloadDataAnimateWithWave:(WaveAnimation)animation;

- (void)reloadDataWithPlaceholderString:(NSString *)placeholderString;
- (void)reloadDataWithPlaceholderString:(NSString *)placeholderString withUIColor:(UIColor *)placeholderColor;
- (void)reloadDataWithPlaceholderImage:(UIImage *)placeholderImage;
- (void)reloadDataWithPlaceholderString:(NSString *)placeholderString lookupsection:(NSInteger)section;

- (void)visibleRowsBeginAnimation:(WaveAnimation)animation;
- (void)animationStart:(NSArray *)array;
- (void)setLoaderWithString : (NSString*)string;
- (void)reloadCellwithAnimation:(UITableViewCell *)cell;
- (void)setBlankPlaceHolderWithStringInFrame : (NSString*)string :(CGRect)frame;
- (void)setLoaderWithStringAccordingframe : (NSString*)string :(CGRect)frame;
-(void)setupThreeBounceAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color;
@end
