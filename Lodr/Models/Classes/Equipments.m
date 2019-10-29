//
//  Equipments.m
//
//  Created by Payal Umraliya  on 04/04/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Equipments.h"
#import "Matches.h"
#import "Medialist.h"

NSString *const kEquipmentsEloadId = @"eload_id";
NSString *const kEquipmentsEloadStatus = @"eload_status";//eload_status
NSString *const kEquipmentsisAssetDeleted = @"is_asset_deleted";
NSString *const kEquipmentsModifiedDate = @"modified_date";
NSString *const kEquipmentsUserId = @"user_id";
NSString *const kEquipmentsMedialist = @"medialist";
NSString *const kEquipmentsEsId = @"es_id";
NSString *const kEquipmentsEquiLongitude = @"equi_longitude";
NSString *const kEquipmentsEquiWeight = @"equi_weight";
NSString *const kEquipmentsEquiHeight = @"equi_height";
NSString *const kEquipmentsCreatedDate = @"created_date";
NSString *const kEquipmentsVisibleTo = @"visible_to";
NSString *const kEquipmentsEquiName = @"equi_name";
NSString *const kEquipmentsEId = @"e_id";
NSString *const kEquipmentsId = @"id";
NSString *const kEquipmentsEquiLatitude = @"equi_latitude";
NSString *const kEquipmentsEquiAvailablity = @"equi_availablity";
NSString *const kEquipmentsAllocatedLoadId = @"allocated_load_id";
NSString *const kEquipmentsEquiLength = @"equi_length";
NSString *const kEquipmentsEquiWidth = @"equi_width";
NSString *const kEquipmentsEquiNotes = @"equi_notes";
NSString *const kEquipmentsMatches = @"matches";
NSString *const kEquipmentsIsDelete = @"is_delete";
NSString *const kEquipmentsIsTest = @"is_test";
NSString *const kEquipmentsIsPublish = @"is_publish";
NSString *const kEquipmentsaddressequi = @"last_equi_address";
NSString *const kEquipmentsIsequistatecode = @"last_equi_statecode";
NSString *const kEquipmentsequistatus = @"equi_status";
NSString *const kEquipmentscapacityvalue = @"capacity_value";
NSString *const kequipmentsOrderFromId = @"order_from_id";
NSString *const kequipmentsOrderToId = @"order_to_id";
NSString *const kequipmentsEquiId = @"equi_id";
NSString *const kequipmentsDriverId = @"driver_id";
NSString *const kequipmentsOrderid = @"order_id";
NSString *const kequipmentsLoadId = @"load_id";
NSString *const kequipmentsOrderType = @"order_type";
NSString *const kassetTypeId = @"asset_type_id";
NSString *const kassetAbilityId = @"asset_ability_id";
NSString *const kassetEmptyWeight = @"equi_empty_weight";
NSString *const kassetisavailable = @"isavailable";
NSString *const kscheduledLoadWeight = @"scheduledLoadWeight";

@interface Equipments ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Equipments
@synthesize eloadStatus = _eloadStatus;
@synthesize eloadId = _eloadId;
@synthesize allocatedLoadId = _allocatedLoadId;
@synthesize isAssetDeleted = _isAssetDeleted;
@synthesize modifiedDate = _modifiedDate;
@synthesize userId = _userId;
@synthesize esId = _esId;
@synthesize equiLongitude = _equiLongitude;
@synthesize equiWeight = _equiWeight;
@synthesize equiHeight = _equiHeight;
@synthesize createdDate = _createdDate;
@synthesize visibleTo = _visibleTo;
@synthesize equiName = _equiName;
@synthesize eId = _eId;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize equiLatitude = _equiLatitude;
@synthesize equiAvailablity = _equiAvailablity;
@synthesize equiLength = _equiLength;
@synthesize equiWidth = _equiWidth;
@synthesize equiNotes = _equiNotes;
@synthesize matches = _matches;
@synthesize isDelete = _isDelete;
@synthesize isTest = _isTest;
@synthesize isPublish = _isPublish;


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
        
            self.allocatedLoadId = [self objectOrNilForKey:kEquipmentsAllocatedLoadId fromDictionary:dict];
            self.isAssetDeleted = [self objectOrNilForKey:kEquipmentsisAssetDeleted fromDictionary:dict];
            self.eloadId = [self objectOrNilForKey:kEquipmentsEloadId fromDictionary:dict];
            self.eloadStatus = [self objectOrNilForKey:kEquipmentsEloadStatus fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kEquipmentsModifiedDate fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kEquipmentsUserId fromDictionary:dict];
            self.esId = [self objectOrNilForKey:kEquipmentsEsId fromDictionary:dict];
            self.equiLongitude = [self objectOrNilForKey:kEquipmentsEquiLongitude fromDictionary:dict];
            self.equiWeight = [self objectOrNilForKey:kEquipmentsEquiWeight fromDictionary:dict];
            self.equiHeight = [self objectOrNilForKey:kEquipmentsEquiHeight fromDictionary:dict];
            self.createdDate = [self objectOrNilForKey:kEquipmentsCreatedDate fromDictionary:dict];
            self.visibleTo = [self objectOrNilForKey:kEquipmentsVisibleTo fromDictionary:dict];
            self.equiName = [self objectOrNilForKey:kEquipmentsEquiName fromDictionary:dict];
            self.eId = [self objectOrNilForKey:kEquipmentsEId fromDictionary:dict];
            self.internalBaseClassIdentifier = [self objectOrNilForKey:kEquipmentsId fromDictionary:dict];
            self.equiLatitude = [self objectOrNilForKey:kEquipmentsEquiLatitude fromDictionary:dict];
            self.equiAvailablity = [self objectOrNilForKey:kEquipmentsEquiAvailablity fromDictionary:dict];
            self.equiLength = [self objectOrNilForKey:kEquipmentsEquiLength fromDictionary:dict];
            self.equiWidth = [self objectOrNilForKey:kEquipmentsEquiWidth fromDictionary:dict];
            self.equiNotes = [self objectOrNilForKey:kEquipmentsEquiNotes fromDictionary:dict];
            self.equiStatus = [self objectOrNilForKey:kEquipmentsequistatus fromDictionary:dict];
            self.equiEmptyWeight = [self objectOrNilForKey:kassetEmptyWeight fromDictionary:dict];
            self.lastEquiAddress = [self objectOrNilForKey:kEquipmentsaddressequi fromDictionary:dict];
            self.lastEquiStatecode = [self objectOrNilForKey:kEquipmentsIsequistatecode fromDictionary:dict];
            self.capacityValue = [self objectOrNilForKey:kEquipmentscapacityvalue fromDictionary:dict];
            self.isavailable = [self objectOrNilForKey:kassetisavailable fromDictionary:dict];
            self.scheduledLoadWeight = [self objectOrNilForKey:kscheduledLoadWeight fromDictionary:dict];
    NSObject *receivedMatches = [dict objectForKey:kEquipmentsMatches];
    NSMutableArray *parsedMatches = [NSMutableArray array];
    if ([receivedMatches isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMatches) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMatches addObject:[Matches modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMatches isKindOfClass:[NSDictionary class]]) {
       [parsedMatches addObject:[Matches modelObjectWithDictionary:(NSDictionary *)receivedMatches]];
    }

    self.matches = [NSArray arrayWithArray:parsedMatches];
        NSObject *receivedMedialist = [dict objectForKey:kEquipmentsMedialist];
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
        self.isDelete = [self objectOrNilForKey:kEquipmentsIsDelete fromDictionary:dict];
        self.isTest = [self objectOrNilForKey:kEquipmentsIsTest fromDictionary:dict];
        self.isPublish = [self objectOrNilForKey:kEquipmentsIsPublish fromDictionary:dict];
        self.orderFromId = [self objectOrNilForKey:kequipmentsOrderFromId fromDictionary:dict];
        self.orderToId = [self objectOrNilForKey:kequipmentsOrderToId fromDictionary:dict];
        self.equiId = [self objectOrNilForKey:kequipmentsEquiId fromDictionary:dict];
        self.driverId = [self objectOrNilForKey:kequipmentsDriverId fromDictionary:dict];
        self.orderid = [self objectOrNilForKey:kequipmentsOrderid fromDictionary:dict];
        self.loadId = [self objectOrNilForKey:kequipmentsLoadId fromDictionary:dict];
        self.orderType = [self objectOrNilForKey:kequipmentsOrderType fromDictionary:dict];
        self.assetTypeId = [self objectOrNilForKey:kassetTypeId fromDictionary:dict];
        self.assetAbilityId = [self objectOrNilForKey:kassetAbilityId fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.allocatedLoadId forKey:kEquipmentsAllocatedLoadId];
    [mutableDict setValue:self.isAssetDeleted forKey:kEquipmentsisAssetDeleted];
    [mutableDict setValue:self.eloadId forKey:kEquipmentsEloadId];
    [mutableDict setValue:self.eloadStatus forKey:kEquipmentsEloadStatus];
    [mutableDict setValue:self.modifiedDate forKey:kEquipmentsModifiedDate];
    [mutableDict setValue:[NSString stringWithFormat:@"%@",self.userId] forKey:kEquipmentsUserId];
    [mutableDict setValue:self.esId forKey:kEquipmentsEsId];
    [mutableDict setValue:self.equiLongitude forKey:kEquipmentsEquiLongitude];
    [mutableDict setValue:self.equiWeight forKey:kEquipmentsEquiWeight];
    [mutableDict setValue:self.equiHeight forKey:kEquipmentsEquiHeight];
    [mutableDict setValue:self.createdDate forKey:kEquipmentsCreatedDate];
    [mutableDict setValue:self.visibleTo forKey:kEquipmentsVisibleTo];
    [mutableDict setValue:self.isavailable forKey:kassetisavailable];
    [mutableDict setValue:self.equiName forKey:kEquipmentsEquiName];
    [mutableDict setValue:self.eId forKey:kEquipmentsEId];
    [mutableDict setValue:[NSString stringWithFormat:@"%@",self.internalBaseClassIdentifier] forKey:kEquipmentsId];
    [mutableDict setValue:self.equiLatitude forKey:kEquipmentsEquiLatitude];
    [mutableDict setValue:self.equiAvailablity forKey:kEquipmentsEquiAvailablity];
    [mutableDict setValue:self.equiLength forKey:kEquipmentsEquiLength];
    [mutableDict setValue:self.equiStatus forKey:kEquipmentsequistatus];
    [mutableDict setValue:self.equiWidth forKey:kEquipmentsEquiWidth];
    [mutableDict setValue:self.equiNotes forKey:kEquipmentsEquiNotes];
    [mutableDict setValue:self.assetTypeId forKey:kassetTypeId];
    [mutableDict setValue:self.capacityValue forKey:kEquipmentscapacityvalue];
    [mutableDict setValue:self.assetAbilityId forKey:kassetAbilityId];
    [mutableDict setValue:self.equiEmptyWeight forKey:kassetEmptyWeight];
    [mutableDict setValue:self.scheduledLoadWeight forKey:kscheduledLoadWeight];
    NSMutableArray *tempArrayForMedialist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.medialist) 
    {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) 
        {
            // This class is a model object
            [tempArrayForMedialist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } 
        else {
            // Generic object
            [tempArrayForMedialist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMedialist] forKey:kEquipmentsMedialist];
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
    
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMatches] forKey:kEquipmentsMatches];
    [mutableDict setValue:self.isDelete forKey:kEquipmentsIsDelete];
    [mutableDict setValue:self.isTest forKey:kEquipmentsIsTest];
    [mutableDict setValue:self.isPublish forKey:kEquipmentsIsPublish];
    [mutableDict setValue:self.orderFromId forKey:kequipmentsOrderFromId];
    [mutableDict setValue:self.orderToId forKey:kequipmentsOrderToId];
    [mutableDict setValue:self.equiId forKey:kequipmentsEquiId];
    [mutableDict setValue:self.driverId forKey:kequipmentsDriverId];
    [mutableDict setValue:self.orderid forKey:kequipmentsOrderid];
    [mutableDict setValue:self.loadId forKey:kequipmentsLoadId];
    [mutableDict setValue:self.orderType forKey:kequipmentsOrderType];
    [mutableDict setValue:self.lastEquiAddress forKey:kEquipmentsaddressequi];
    [mutableDict setValue:self.lastEquiStatecode forKey:kEquipmentsIsequistatecode];
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
    
    
    if([aKey isEqualToString:@"eload_status"]){
        
        
    }
    if([object isKindOfClass:[NSNumber class]])
    {
        object=[NSString stringWithFormat:@"%@",object];
    }
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
