//
//  Orders.h
//
//  Created by c196  on 03/06/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Orders : NSObject

@property (nonatomic, strong) NSString *orderFromId;
@property (nonatomic, assign) double equiId;
@property (nonatomic, assign) double orderType;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *orderToId;
@property (nonatomic, assign) double loadId;
@property (nonatomic, assign) double isDelete;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, assign) double isTest;
@property (nonatomic, assign) double driverId;
@property (nonatomic, assign) NSString *subassetid;
@property (nonatomic, strong) NSString *pickupDate;
@property (nonatomic, strong) NSString *delieveryDate;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
