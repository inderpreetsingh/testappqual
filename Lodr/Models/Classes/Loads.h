//
//  Loads.h
//
//  Created by Payal Umraliya  on 17/04/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Loads : NSObject 
@property (nonatomic, strong) NSString *loadNumber;
@property (nonatomic, strong) NSString *isLoadInterested;
@property (nonatomic, strong) NSString *isAssetInterested;
@property (nonatomic, strong) NSString *isDelete;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSArray *medialist;
@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *loadWidth;
@property (nonatomic, strong) NSString *pickupLatitude;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *deliveryLongitude;
@property (nonatomic, strong) NSString *deliveryCountry;
@property (nonatomic, strong) NSString *deliveryTime;
@property (nonatomic, strong) NSString *offerRate;
@property (nonatomic, strong) NSString *isTest;
@property (nonatomic, strong) NSString *isPublish;
@property (nonatomic, strong) NSString *esId;
@property (nonatomic, strong) NSString *deliveryState;
@property (nonatomic, strong) NSString *pickupState;
@property (nonatomic, strong) NSString *pickupCity;
@property (nonatomic, strong) NSString *pickupAddress;
@property (nonatomic, strong) NSString *loadLength;
@property (nonatomic, strong) NSString *pickupStateCode;
@property (nonatomic, strong) NSString *eId;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSArray *matches;
@property (nonatomic, strong) NSString *isAllowComment;
@property (nonatomic, strong) NSString *loadHeight;
@property (nonatomic, strong) NSString *pickupCountry;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *deliveryLatitude;
@property (nonatomic, strong) NSString *pickupLongitude;
@property (nonatomic, strong) NSString *delieveryDate;
@property (nonatomic, strong) NSString *loadDescription;
@property (nonatomic, strong) NSString *deliveryStateCode;
@property (nonatomic, strong) NSString *isBestoffer;
@property (nonatomic, strong) NSString *deliveryAddress;
@property (nonatomic, strong) NSString *visiableTo;
@property (nonatomic, strong) NSString *loadCode;
@property (nonatomic, strong) NSString *loadWeight;
@property (nonatomic, strong) NSString *deliveryCity;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *pickupDate;
@property (nonatomic, strong) NSString *pickupTime;
@property (nonatomic, strong) NSString *loadStatus;
@property (nonatomic, strong) NSArray *equipments;
@property (nonatomic, strong) NSArray *powerAsset;
@property (nonatomic, strong) NSArray *driver;
@property (nonatomic, strong) NSArray *supportAsset;
@property (nonatomic, strong) NSString *orderFromId;
@property (nonatomic, strong) NSString *deliveredBy;
@property (nonatomic, strong) NSString *orderToId;
@property (nonatomic, strong) NSString *loadId;
@property (nonatomic, strong) NSString *equiId;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderType;
@property (nonatomic, strong) NSString *loadQty;
@property (nonatomic, strong) NSString *measureUnit;
@property (nonatomic, strong) NSString *bolPod;
@property (nonatomic, strong) NSString *loadName;
@property (nonatomic, strong) NSString *driverLatitude;
@property (nonatomic, strong) NSString *driverLongitude;
@property (nonatomic, strong) NSString *loadPickedupDate;
@property (nonatomic, strong) NSString *loadPickedupTime;
@property (nonatomic, strong) NSString *loadDeliveredDate;
@property (nonatomic, strong) NSString *loadDeliveredTime;
@property (nonatomic, strong) NSArray *comments;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
