//
//  TWTRCollectionTimelineDataSource.h
//  TwitterKit
//
//  Created by Steven Hepting on 2/10/15.
//  Copyright (c) 2015 Twitter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWTRTimelineDataSource.h"

@class TWTRAPIClient;
@class TWTRTimelineFilter;

NS_ASSUME_NONNULL_BEGIN

@interface TWTRCollectionTimelineDataSource : NSObject <TWTRTimelineDataSource>

/**
 *  The number of Tweets to request in each query to the Twitter Timeline API when fetching the next batch of Tweets.
 */
@property (nonatomic, readonly) NSInteger maxTweetsPerRequest;

/**
 *  ID of the collection.
 */
@property (nonatomic, copy, readonly) NSString *collectionID;

/*
 *  A filtering object that hides certain tweets.
 */
@property (nonatomic, copy, nullable) TWTRTimelineFilter *timelineFilter;

/**
 *  Convenience initializer.
 *
 *  @param collectionID (required) The ID of this collection. For example, the ID of this collection: https://twitter.com/TwitterMusic/timelines/393773266801659904 is @"393773266801659904"
 *
 *  @return An instance of TWTRCollectionTimelineDataSource or nil if any of the required parameters is missing.
 */
- (instancetype)initWithCollectionID:(NSString *)collectionID APIClient:(TWTRAPIClient *)client;

- (instancetype)initWithCollectionID:(NSString *)collectionID APIClient:(TWTRAPIClient *)client maxTweetsPerRequest:(NSUInteger)maxTweetsPerRequest NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
