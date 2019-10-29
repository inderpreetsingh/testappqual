//
//  TWTRTweetTableViewCell.h
//
//  Copyright (c) 2015 Twitter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWTRTweetView.h"

@class TWTRTweet;

NS_ASSUME_NONNULL_BEGIN

/**
 *  A table view cell subclass which displays a Tweet.
 */
@interface TWTRTweetTableViewCell : UITableViewCell

/**
 *  The Tweet view inside this cell. Holds all relevant text and images.
 */
@property (nonatomic, readonly) TWTRTweetView *tweetView;

/**
 *  Configures the existing Tweet view with a Tweet. Updates labels, images, and thumbnails.
 *
 *  @param tweet The `TWTRTweet` model object for the Tweet to display.
 */
- (void)configureWithTweet:(TWTRTweet *)tweet;
+ (CGFloat)heightForTweet:(TWTRTweet *)tweet style:(TWTRTweetViewStyle)style width:(CGFloat)width showingActions:(BOOL)showActions;

@end

NS_ASSUME_NONNULL_END
