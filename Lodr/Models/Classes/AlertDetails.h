//
//  AlertDetails.h
//
//  Created by c196  on 10/05/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AlertDetails : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *pickupStateCode;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *alertMsg;
@property (nonatomic, strong) NSString *equiName;
@property (nonatomic, strong) NSString *deliveryStateCode;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *equiOwnerId;
@property (nonatomic, strong) NSString *loadId;
@property (nonatomic, strong) NSString *loadOwnerId;
@property (nonatomic, strong) NSString *isDelete;
@property (nonatomic, strong) NSString *alertId;
@property (nonatomic, strong) NSString *receiverId;
@property (nonatomic, strong) NSString *equiId;
@property (nonatomic, strong) NSString *alertCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
