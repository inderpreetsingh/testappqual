//
//  TWTRAPIClient.h
//
//  Copyright (c) 2015 Twitter. All rights reserved.
//

@class TWTRUser;
@class TWTRTweet;
@class TWTRAuthConfig;
@class TWTRGuestSession;
@protocol TWTRAuthSession;
@protocol TWTRSessionStore;
NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const TWTRTweetsNotLoadedKey;
typedef void (^TWTRLoadUserCompletion)(TWTRUser * _Nullable user, NSError * _Nullable error);

typedef void (^TWTRLoadTweetCompletion)(TWTRTweet * _Nullable tweet, NSError * _Nullable error);

typedef void (^TWTRLoadTweetsCompletion)(NSArray<TWTRTweet *> * _Nullable tweets, NSError * _Nullable error);
typedef void (^TWTRNetworkCompletion)(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError);

typedef void (^TWTRJSONRequestCompletion)(NSURLResponse * _Nullable response, id _Nullable responseObject, NSError * _Nullable error);
typedef void (^TWTRTweetActionCompletion)(TWTRTweet * _Nullable tweet, NSError * _Nullable error);


typedef void (^TWTRMediaUploadResponseCompletion)(NSString * _Nullable mediaID, NSError * _Nullable error);


typedef void(^TWTRRequestEmailCompletion)(NSString * _Nullable email, NSError * _Nullable error);

@interface TWTRAPIClient : NSObject

@property (nonatomic, copy, readonly, nullable) NSString *userID;

- (instancetype)initWithUserID:(nullable NSString *)userID;
+ (instancetype)clientWithCurrentUser;
- (NSURLRequest *)URLRequestWithMethod:(NSString *)method URL:(NSString *)URLString parameters:(nullable NSDictionary *)parameters error:(NSError **)error;


- (NSProgress *)sendTwitterRequest:(NSURLRequest *)request completion:(TWTRNetworkCompletion)completion;

- (void)loadUserWithID:(NSString *)userID completion:(TWTRLoadUserCompletion)completion;
- (void)loadTweetWithID:(NSString *)tweetID completion:(TWTRLoadTweetCompletion)completion;
- (void)loadTweetsWithIDs:(NSArray *)tweetIDStrings completion:(TWTRLoadTweetsCompletion)completion;

- (void)uploadMedia:(NSData *)media contentType:(NSString *)contentType completion:(TWTRMediaUploadResponseCompletion)completion;
- (void)requestEmailForCurrentUser:(TWTRRequestEmailCompletion)completion;

@end
NS_ASSUME_NONNULL_END
