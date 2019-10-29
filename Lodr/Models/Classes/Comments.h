//
//  Comments.h
//
//  Created by C225  on 15/05/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Comments : NSObject <NSCoding>

@property (nonatomic, assign) double driverId;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, assign) double isMedia;
@property (nonatomic, assign) double commentsIdentifier;
@property (nonatomic, assign) double isTest;
@property (nonatomic, assign) double loadId;
@property (nonatomic, assign) double isDelete;
@property (nonatomic, strong) NSString *commentText;
@property (nonatomic, assign) double userId;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *firstname;

+ (Comments *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
