//
//  Drivers.h
//
//  Created by c196  on 03/06/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Drivers : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *driverLatitude;
@property (nonatomic, strong) NSString *driverLongitude;
@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *dutyStatus;
@property (nonatomic, strong) NSString *isDelete;
@property (nonatomic, strong) NSString * modifiedDate;
@property (nonatomic, strong) NSString *isTest;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *lastLocation;
@property (nonatomic, strong) NSString *userprefId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
