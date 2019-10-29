//
//  Loads.m
//
//  Created by Payal Umraliya  on 17/04/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Loads.h"
#import "Medialist.h"
#import "Matches.h"
#import "Equipments.h"
#import "Driver.h"
#import "PowerAsset.h"
#import "SupportAsset.h"
#import "Comments.h"

NSString *const kLoadsComments = @"comments";
NSString *const kLoadsLoadPickedupDate = @"load_pickedup_date";
NSString *const kLoadsLoadPickedupTime = @"load_pickedup_time";
NSString *const kLoadsLoadDeliveredDate = @"load_delivered_date";
NSString *const kLoadsLoadDeliveredTime = @"load_delivered_time";
NSString *const kLoadsLoadNumber = @"load_number";
NSString *const kLoadsDriverLatitude = @"driver_latitude";
NSString *const kLoadsDriverLongitude = @"driver_longitude";
NSString *const kLoadsSupportAsset = @"support_asset";
NSString *const kLoadsPowerAsset = @"power_asset";
NSString *const kLoadsDriver = @"driver";
NSString *const kLoadsIsDelete = @"is_delete";
NSString *const kLoadsCreatedDate = @"created_date";
NSString *const kLoadsMedialist = @"medialist";
NSString *const kLoadsId = @"id";
NSString *const kLoadsLoadWidth = @"load_width";
NSString *const kLoadsPickupLatitude = @"pickup_latitude";
NSString *const kLoadsModifiedDate = @"modified_date";
NSString *const kLoadsDeliveryLongitude = @"delivery_longitude";
NSString *const kLoadsDeliveryCountry = @"delivery_country";
NSString *const kLoadsDeliveryTime = @"delivery_time";
NSString *const kLoadsOfferRate = @"offer_rate";
NSString *const kLoadsIsTest = @"is_test";
NSString *const kLoadsIsPublish = @"is_publish";
NSString *const kLoadsEsId = @"es_id";
NSString *const kLoadsDeliveryState = @"delivery_state";
NSString *const kLoadsPickupState = @"pickup_state";
NSString *const kLoadsPickupCity = @"pickup_city";
NSString *const kLoadsPickupAddress = @"pickup_address";
NSString *const kLoadsLoadLength = @"load_length";
NSString *const kLoadsPickupStateCode = @"pickup_state_code";
NSString *const kLoadsEId = @"e_id";
NSString *const kLoadsDistance = @"distance";
NSString *const kLoadsMatches = @"matches";
NSString *const kLoadsIsAllowComment = @"is_allow_comment";
NSString *const kLoadsLoadHeight = @"load_height";
NSString *const kLoadsPickupCountry = @"pickup_country";
NSString *const kLoadsUserId = @"user_id";
NSString *const kLoadsDeliveryLatitude = @"delivery_latitude";
NSString *const kLoadsPickupLongitude = @"pickup_longitude";
NSString *const kLoadsDelieveryDate = @"delievery_date";
NSString *const kLoadsLoadDescription = @"load_description";
NSString *const kLoadsDeliveryStateCode = @"delivery_state_code";
NSString *const kLoadsIsBestoffer = @"is_bestoffer";
NSString *const kLoadsDeliveryAddress = @"delivery_address";
NSString *const kLoadsVisiableTo = @"visiable_to";
NSString *const kLoadsLoadCode = @"load_code";
NSString *const kLoadsLoadWeight = @"load_weight";
NSString *const kLoadsDeliveryCity = @"delivery_city";
NSString *const kLoadsNotes = @"notes";
NSString *const kLoadsPickupDate = @"pickup_date";
NSString *const kLoadsPickupTime = @"pickup_time";
NSString *const kLoadsUserAccount = @"userAccount";
NSString *const kLoadsloadstatus = @"load_status";
NSString *const kLoadsEquipments = @"equipments";
NSString *const kLoadsOrderFromId = @"order_from_id";
NSString *const kLoadsDeliveredBy = @"delivered_by";
NSString *const kLoadsOrderToId = @"order_to_id";
NSString *const kLoadsLoadId = @"load_id";
NSString *const kLoadsEquiId = @"equi_id";
NSString *const kLoadsOrderId = @"order_id";
NSString *const kLoadsOrderType = @"order_type";
NSString *const kLoadsLoadName = @"load_name";
NSString *const kLoadsMeasureUnit = @"measure_unit";
NSString *const kLoadsQty = @"load_qty";
NSString *const kLoadsBolPod = @"bol_pod";
NSString *const kLoadsIsLoadIntrested = @"is_load_interested";
NSString *const kLoadsIsAssetIntrested = @"is_asset_interested";

@interface Loads ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Loads

@synthesize comments = _comments;
@synthesize supportAsset = _supportAsset;
@synthesize driverLatitude = _driverLatitude;
@synthesize driverLongitude = _driverLongitude;
@synthesize driver = _driver;
@synthesize powerAsset = _powerAsset;
@synthesize isDelete = _isDelete;
@synthesize createdDate = _createdDate;
@synthesize medialist = _medialist;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize loadWidth = _loadWidth;
@synthesize pickupLatitude = _pickupLatitude;
@synthesize modifiedDate = _modifiedDate;
@synthesize deliveryLongitude = _deliveryLongitude;
@synthesize deliveryCountry = _deliveryCountry;
@synthesize deliveryTime = _deliveryTime;
@synthesize offerRate = _offerRate;
@synthesize isTest = _isTest;
@synthesize isPublish = _isPublish;
@synthesize esId = _esId;
@synthesize deliveryState = _deliveryState;
@synthesize pickupState = _pickupState;
@synthesize pickupCity = _pickupCity;
@synthesize pickupAddress = _pickupAddress;
@synthesize loadLength = _loadLength;
@synthesize pickupStateCode = _pickupStateCode;
@synthesize eId = _eId;
@synthesize distance = _distance;
@synthesize matches = _matches;
@synthesize isAllowComment = _isAllowComment;
@synthesize loadHeight = _loadHeight;
@synthesize pickupCountry = _pickupCountry;
@synthesize userId = _userId;
@synthesize deliveryLatitude = _deliveryLatitude;
@synthesize pickupLongitude = _pickupLongitude;
@synthesize delieveryDate = _delieveryDate;
@synthesize loadDescription = _loadDescription;
@synthesize deliveryStateCode = _deliveryStateCode;
@synthesize isBestoffer = _isBestoffer;
@synthesize deliveryAddress = _deliveryAddress;
@synthesize visiableTo = _visiableTo;
@synthesize loadCode = _loadCode;
@synthesize loadWeight = _loadWeight;
@synthesize deliveryCity = _deliveryCity;
@synthesize notes = _notes;
@synthesize pickupDate = _pickupDate;
@synthesize pickupTime = _pickupTime;
@synthesize isAssetInterested = _isAssetInterested;
@synthesize isLoadInterested = _isLoadInterested;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        
        NSObject *receivedComments = [dict objectForKey:kLoadsComments];
        NSMutableArray *parsedComments = [NSMutableArray array];
        if ([receivedComments isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedComments) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedComments addObject:[Comments modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedComments isKindOfClass:[NSDictionary class]]) {
            [parsedComments addObject:[Comments modelObjectWithDictionary:(NSDictionary *)receivedComments]];
        }
        
        self.comments = [NSArray arrayWithArray:parsedComments];
     
        
           self.loadPickedupDate = [self objectOrNilForKey:kLoadsLoadPickedupDate fromDictionary:dict];
           self.loadPickedupTime = [self objectOrNilForKey:kLoadsLoadPickedupTime fromDictionary:dict];
           self.loadDeliveredDate = [self objectOrNilForKey:kLoadsLoadDeliveredDate fromDictionary:dict];
           self.loadDeliveredTime = [self objectOrNilForKey:kLoadsLoadDeliveredTime fromDictionary:dict];
        
        self.loadNumber = [self objectOrNilForKey:kLoadsLoadNumber fromDictionary:dict];
        self.driverLongitude = [self objectOrNilForKey:kLoadsDriverLongitude fromDictionary:dict];
        self.driverLatitude = [self objectOrNilForKey:kLoadsDriverLatitude fromDictionary:dict];
        self.isLoadInterested = [self objectOrNilForKey:kLoadsIsLoadIntrested fromDictionary:dict];
        self.isAssetInterested = [self objectOrNilForKey:kLoadsIsAssetIntrested fromDictionary:dict];
        self.isDelete = [self objectOrNilForKey:kLoadsIsDelete fromDictionary:dict];
        self.createdDate = [self objectOrNilForKey:kLoadsCreatedDate fromDictionary:dict];
        NSObject *receivedMedialist = [dict objectForKey:kLoadsMedialist];
        NSMutableArray *parsedMedialist = [NSMutableArray array];
        if ([receivedMedialist isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedMedialist) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedMedialist addObject:[Medialist modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedMedialist isKindOfClass:[NSDictionary class]]) {
            [parsedMedialist addObject:[Medialist modelObjectWithDictionary:(NSDictionary *)receivedMedialist]];
        }
        
        self.medialist = [NSArray arrayWithArray:parsedMedialist];
        self.internalBaseClassIdentifier = [self objectOrNilForKey:kLoadsId fromDictionary:dict];
        self.loadWidth = [self objectOrNilForKey:kLoadsLoadWidth fromDictionary:dict];
        self.pickupLatitude = [self objectOrNilForKey:kLoadsPickupLatitude fromDictionary:dict];
        self.modifiedDate = [self objectOrNilForKey:kLoadsModifiedDate fromDictionary:dict];
        self.deliveryLongitude = [self objectOrNilForKey:kLoadsDeliveryLongitude fromDictionary:dict];
        self.deliveryCountry = [self objectOrNilForKey:kLoadsDeliveryCountry fromDictionary:dict];
        self.deliveryTime = [self objectOrNilForKey:kLoadsDeliveryTime fromDictionary:dict];
        self.offerRate = [self objectOrNilForKey:kLoadsOfferRate fromDictionary:dict];
        self.isTest = [self objectOrNilForKey:kLoadsIsTest fromDictionary:dict];
        self.isPublish = [self objectOrNilForKey:kLoadsIsPublish fromDictionary:dict];
        self.esId = [self objectOrNilForKey:kLoadsEsId fromDictionary:dict];
        self.deliveryState = [self objectOrNilForKey:kLoadsDeliveryState fromDictionary:dict];
        self.pickupState = [self objectOrNilForKey:kLoadsPickupState fromDictionary:dict];
        self.pickupCity = [self objectOrNilForKey:kLoadsPickupCity fromDictionary:dict];
        self.pickupAddress = [self objectOrNilForKey:kLoadsPickupAddress fromDictionary:dict];
        self.loadLength = [self objectOrNilForKey:kLoadsLoadLength fromDictionary:dict];
        self.pickupStateCode = [self objectOrNilForKey:kLoadsPickupStateCode fromDictionary:dict];
        self.eId = [self objectOrNilForKey:kLoadsEId fromDictionary:dict];
        self.distance = [self objectOrNilForKey:kLoadsDistance fromDictionary:dict];
         self.measureUnit = [self objectOrNilForKey:kLoadsMeasureUnit fromDictionary:dict];
         self.bolPod = [self objectOrNilForKey:kLoadsBolPod fromDictionary:dict];
         self.loadQty = [self objectOrNilForKey:kLoadsQty fromDictionary:dict];
         self.loadName = [self objectOrNilForKey:kLoadsLoadName fromDictionary:dict];
        
        NSObject *receivedDriver = [dict objectForKey:kLoadsDriver];
        NSMutableArray *parsedDriver = [NSMutableArray array];
        if ([receivedDriver isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedDriver) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedDriver addObject:[Driver modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedDriver isKindOfClass:[NSDictionary class]]) {
            [parsedDriver addObject:[Driver modelObjectWithDictionary:(NSDictionary *)receivedDriver]];
        }
        
        self.driver = [NSArray arrayWithArray:parsedDriver];
      
        NSObject *receivedPowerAsset = [dict objectForKey:kLoadsPowerAsset];
        NSMutableArray *parsedPowerAsset = [NSMutableArray array];
        if ([receivedPowerAsset isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedPowerAsset) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedPowerAsset addObject:[PowerAsset modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedPowerAsset isKindOfClass:[NSDictionary class]]) {
            [parsedPowerAsset addObject:[PowerAsset modelObjectWithDictionary:(NSDictionary *)receivedPowerAsset]];
        }
        
        self.powerAsset = [NSArray arrayWithArray:parsedPowerAsset];
        
        NSObject *receivedMatches = [dict objectForKey:kLoadsMatches];
        NSMutableArray *parsedMatches = [NSMutableArray array];
        if ([receivedMatches isKindOfClass:[NSArray class]]) 
        {
            for (NSDictionary *item in (NSArray *)receivedMatches)
            {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedMatches addObject:[Matches modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedMatches isKindOfClass:[NSDictionary class]]) {
            [parsedMatches addObject:[Matches modelObjectWithDictionary:(NSDictionary *)receivedMatches]];
        }
          self.matches = [NSArray arrayWithArray:parsedMatches];
        NSObject *receivedEquipments = [dict objectForKey:kLoadsEquipments];
        NSMutableArray *parsedEquipments = [NSMutableArray array];
        if ([receivedEquipments isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedEquipments) {
                if ([item isKindOfClass:[NSDictionary class]]) 
                {
                    [parsedEquipments addObject:[Equipments modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedEquipments isKindOfClass:[NSDictionary class]]) {
            [parsedEquipments addObject:[Equipments modelObjectWithDictionary:(NSDictionary *)receivedEquipments]];
        }
        
        self.equipments = [NSArray arrayWithArray:parsedEquipments];
      
        
        NSObject *receivedSupportAsset = [dict objectForKey:kLoadsSupportAsset];
        NSMutableArray *parsedSupportAsset = [NSMutableArray array];
        if ([receivedSupportAsset isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedSupportAsset) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedSupportAsset addObject:[SupportAsset modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedSupportAsset isKindOfClass:[NSDictionary class]]) {
            [parsedSupportAsset addObject:[SupportAsset modelObjectWithDictionary:(NSDictionary *)receivedSupportAsset]];
        }
        
        self.supportAsset = [NSArray arrayWithArray:parsedSupportAsset];
        
        self.isAllowComment = [self objectOrNilForKey:kLoadsIsAllowComment fromDictionary:dict];
        self.loadHeight = [self objectOrNilForKey:kLoadsLoadHeight fromDictionary:dict];
        self.pickupCountry = [self objectOrNilForKey:kLoadsPickupCountry fromDictionary:dict];
        self.userId = [self objectOrNilForKey:kLoadsUserId fromDictionary:dict];
        self.deliveryLatitude = [self objectOrNilForKey:kLoadsDeliveryLatitude fromDictionary:dict];
        self.pickupLongitude = [self objectOrNilForKey:kLoadsPickupLongitude fromDictionary:dict];
        self.delieveryDate = [self objectOrNilForKey:kLoadsDelieveryDate fromDictionary:dict];
        self.loadDescription = [self objectOrNilForKey:kLoadsLoadDescription fromDictionary:dict];
        self.deliveryStateCode = [self objectOrNilForKey:kLoadsDeliveryStateCode fromDictionary:dict];
        self.isBestoffer = [self objectOrNilForKey:kLoadsIsBestoffer fromDictionary:dict];
        self.deliveryAddress = [self objectOrNilForKey:kLoadsDeliveryAddress fromDictionary:dict];
        self.visiableTo = [self objectOrNilForKey:kLoadsVisiableTo fromDictionary:dict];
        self.loadCode = [self objectOrNilForKey:kLoadsLoadCode fromDictionary:dict];
        self.loadWeight = [self objectOrNilForKey:kLoadsLoadWeight fromDictionary:dict];
        self.deliveryCity = [self objectOrNilForKey:kLoadsDeliveryCity fromDictionary:dict];
        self.notes = [self objectOrNilForKey:kLoadsNotes fromDictionary:dict];
        self.pickupDate = [self objectOrNilForKey:kLoadsPickupDate fromDictionary:dict];
        self.pickupTime = [self objectOrNilForKey:kLoadsPickupTime fromDictionary:dict];
        
        self.loadStatus = [self objectOrNilForKey:kLoadsloadstatus fromDictionary:dict];
        self.orderFromId = [self objectOrNilForKey:kLoadsOrderFromId fromDictionary:dict];
        self.deliveredBy = [self objectOrNilForKey:kLoadsDeliveredBy fromDictionary:dict];
        self.loadId = [self objectOrNilForKey:kLoadsLoadId fromDictionary:dict];
        self.equiId = [self objectOrNilForKey:kLoadsEquiId fromDictionary:dict];
        self.orderId = [self objectOrNilForKey:kLoadsOrderId fromDictionary:dict];
        self.orderType = [self objectOrNilForKey:kLoadsOrderType fromDictionary:dict];
        self.orderToId = [self objectOrNilForKey:kLoadsOrderToId fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isDelete forKey:kLoadsIsDelete];
    [mutableDict setValue:self.createdDate forKey:kLoadsCreatedDate];
    NSMutableArray *tempArrayForMedialist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.medialist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMedialist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMedialist addObject:subArrayObject];
        }
    }
       [mutableDict setValue:self.loadPickedupDate forKey:kLoadsLoadPickedupDate];
       [mutableDict setValue:self.loadPickedupTime forKey:kLoadsLoadDeliveredTime];
       [mutableDict setValue:self.loadDeliveredTime forKey:kLoadsLoadDeliveredTime];
       [mutableDict setValue:self.loadDeliveredDate forKey:kLoadsLoadDeliveredDate];
    
    [mutableDict setValue:self.loadNumber forKey:kLoadsLoadNumber];
    [mutableDict setValue:self.driverLongitude forKey:kLoadsDriverLongitude];
    [mutableDict setValue:self.driverLatitude forKey:kLoadsDriverLatitude];
    [mutableDict setValue:self.isLoadInterested forKey:kLoadsIsLoadIntrested];
    [mutableDict setValue:self.isAssetInterested forKey:kLoadsIsAssetIntrested];
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMedialist] forKey:kLoadsMedialist];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kLoadsId];
    [mutableDict setValue:self.loadWidth forKey:kLoadsLoadWidth];
    [mutableDict setValue:self.pickupLatitude forKey:kLoadsPickupLatitude];
    [mutableDict setValue:self.modifiedDate forKey:kLoadsModifiedDate];
    [mutableDict setValue:self.deliveryLongitude forKey:kLoadsDeliveryLongitude];
    [mutableDict setValue:self.deliveryCountry forKey:kLoadsDeliveryCountry];
    [mutableDict setValue:self.deliveryTime forKey:kLoadsDeliveryTime];
    [mutableDict setValue:self.offerRate forKey:kLoadsOfferRate];
    [mutableDict setValue:self.isTest forKey:kLoadsIsTest];
    [mutableDict setValue:self.isPublish forKey:kLoadsIsPublish];
    [mutableDict setValue:self.esId forKey:kLoadsEsId];
    [mutableDict setValue:self.deliveryState forKey:kLoadsDeliveryState];
    [mutableDict setValue:self.pickupState forKey:kLoadsPickupState];
    [mutableDict setValue:self.pickupCity forKey:kLoadsPickupCity];
    [mutableDict setValue:self.pickupAddress forKey:kLoadsPickupAddress];
    [mutableDict setValue:self.loadLength forKey:kLoadsLoadLength];
    [mutableDict setValue:self.pickupStateCode forKey:kLoadsPickupStateCode];
    [mutableDict setValue:self.eId forKey:kLoadsEId];
    [mutableDict setValue:self.distance forKey:kLoadsDistance];
    
    NSMutableArray *tempArrayForComments = [NSMutableArray array];
    for (NSObject *subArrayObject in self.comments) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForComments addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForComments addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForComments] forKey:@"kLoadsComments"];
    
    NSMutableArray *tempArrayForMatches = [NSMutableArray array];
    for (NSObject *subArrayObject in self.matches) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMatches addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMatches addObject:subArrayObject];
        }
    }
    
    NSMutableArray *tempArrayForDriver = [NSMutableArray array];
    for (NSObject *subArrayObject in self.driver) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDriver addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDriver addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDriver] forKey:@"kLoadsDriver"];
    
    NSMutableArray *tempArrayForSupportAsset = [NSMutableArray array];
    for (NSObject *subArrayObject in self.supportAsset) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSupportAsset addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSupportAsset addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSupportAsset] forKey:@"kLoadsSupportAsset"];
    
    NSMutableArray *tempArrayForPowerAsset = [NSMutableArray array];
    for (NSObject *subArrayObject in self.powerAsset) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPowerAsset addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPowerAsset addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPowerAsset] forKey:@"kLoadsPowerAsset"];
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMatches] forKey:kLoadsMatches];
    [mutableDict setValue:self.isAllowComment forKey:kLoadsIsAllowComment];
    [mutableDict setValue:self.loadHeight forKey:kLoadsLoadHeight];
    [mutableDict setValue:self.pickupCountry forKey:kLoadsPickupCountry];
    [mutableDict setValue:self.userId forKey:kLoadsUserId];
    [mutableDict setValue:self.deliveryLatitude forKey:kLoadsDeliveryLatitude];
    [mutableDict setValue:self.pickupLongitude forKey:kLoadsPickupLongitude];
    [mutableDict setValue:self.delieveryDate forKey:kLoadsDelieveryDate];
    [mutableDict setValue:self.loadDescription forKey:kLoadsLoadDescription];
    [mutableDict setValue:self.deliveryStateCode forKey:kLoadsDeliveryStateCode];
    [mutableDict setValue:self.isBestoffer forKey:kLoadsIsBestoffer];
    [mutableDict setValue:self.deliveryAddress forKey:kLoadsDeliveryAddress];
    [mutableDict setValue:self.visiableTo forKey:kLoadsVisiableTo];
    [mutableDict setValue:self.loadCode forKey:kLoadsLoadCode];
    [mutableDict setValue:self.loadWeight forKey:kLoadsLoadWeight];
    [mutableDict setValue:self.deliveryCity forKey:kLoadsDeliveryCity];
    [mutableDict setValue:self.notes forKey:kLoadsNotes];
    [mutableDict setValue:self.pickupDate forKey:kLoadsPickupDate];
    [mutableDict setValue:self.pickupTime forKey:kLoadsPickupTime];
    [mutableDict setValue:self.loadStatus forKey:kLoadsloadstatus];
    NSMutableArray *tempArrayForEquipments = [NSMutableArray array];
    for (NSObject *subArrayObject in self.equipments) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForEquipments addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForEquipments addObject:subArrayObject];
        }
    }
    [mutableDict setValue:self.orderFromId forKey:kLoadsOrderFromId];
    [mutableDict setValue:self.deliveredBy forKey:kLoadsDeliveredBy];
    [mutableDict setValue:self.orderToId forKey:kLoadsOrderToId];
    [mutableDict setValue:self.loadId forKey:kLoadsLoadId];
    [mutableDict setValue:self.equiId forKey:kLoadsEquiId];
    [mutableDict setValue:self.orderId forKey:kLoadsOrderId];
    [mutableDict setValue:self.orderType forKey:kLoadsOrderType];
    [mutableDict setValue:self.loadName forKey:kLoadsLoadName];
    [mutableDict setValue:self.measureUnit forKey:kLoadsMeasureUnit];
    [mutableDict setValue:self.loadQty forKey:kLoadsQty];
    [mutableDict setValue:self.bolPod forKey:kLoadsBolPod];
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEquipments] forKey:kLoadsEquipments];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
    
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    if([object isKindOfClass:[NSNumber class]])
    {
        object=[NSString stringWithFormat:@"%@",object];
    }
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
