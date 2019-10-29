//
//  Equipments.h
//
//  Created by Payal Umraliya  on 04/04/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Equipments : NSObject

@property (nonatomic, strong) NSString *eloadId;
@property (nonatomic, strong) NSString *eloadStatus;//eload_status
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *esId;
@property (nonatomic, strong) NSString *equiLongitude;
@property (nonatomic, strong) NSString *equiWeight;
@property (nonatomic, strong) NSString *equiHeight;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *visibleTo;
@property (nonatomic, strong) NSString *equiName;
@property (nonatomic, strong) NSString *eId;
@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *equiLatitude;
@property (nonatomic, strong) NSString *equiAvailablity;
@property (nonatomic, strong) NSString *equiLength;
@property (nonatomic, strong) NSString *equiWidth;
@property (nonatomic, strong) NSString *equiNotes;
@property (nonatomic, strong) NSArray *matches;
@property (nonatomic, strong) NSString *isDelete;
@property (nonatomic, strong) NSString *isTest;
@property (nonatomic, strong) NSString *isPublish;
@property (nonatomic, strong) NSString *lastEquiAddress;
@property (nonatomic, strong) NSString *lastEquiStatecode;
@property (nonatomic, strong) NSString *equiStatus;
@property (nonatomic, strong) NSString *capacityValue;
@property (nonatomic, strong) NSString *isavailable;
@property (nonatomic, strong) NSArray *medialist;
@property (nonatomic, strong) NSString *allocatedLoadId;
@property (nonatomic, strong) NSString *orderFromId;
@property (nonatomic, strong) NSString *orderToId;
@property (nonatomic, strong) NSString *equiId;
@property (nonatomic, strong) NSString *driverId;
@property (nonatomic, strong) NSString *orderid;
@property (nonatomic, strong) NSString *loadId;
@property (nonatomic, strong) NSString *orderType;
@property (nonatomic, strong) NSString *assetTypeId;
@property (nonatomic, strong) NSString *assetAbilityId;
@property (nonatomic, strong) NSString *equiEmptyWeight;
@property (nonatomic, strong) NSString *scheduledLoadWeight;
@property (nonatomic, strong) NSString *isAssetDeleted;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
