//
//  AlertDetails.m
//
//  Created by c196  on 10/05/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "AlertDetails.h"


NSString *const kAlertDetailsPickupStateCode = @"pickup_state_code";
NSString *const kAlertDetailsModifiedDate = @"modified_date";
NSString *const kAlertDetailsAlertMsg = @"alert_msg";
NSString *const kAlertDetailsEquiName = @"equi_name";
NSString *const kAlertDetailsDeliveryStateCode = @"delivery_state_code";
NSString *const kAlertDetailsCreatedDate = @"created_date";
NSString *const kAlertDetailsEquiOwnerId = @"equi_owner_id";
NSString *const kAlertDetailsLoadId = @"load_id";
NSString *const kAlertDetailsLoadOwnerId = @"load_owner_id";
NSString *const kAlertDetailsIsDelete = @"is_delete";
NSString *const kAlertDetailsAlertId = @"alert_id";
NSString *const kAlertDetailsReceiverId = @"receiver_id";
NSString *const kAlertDetailsEquiId = @"equi_id";
NSString *const kAlertCount = @"Alert_count";

@interface AlertDetails ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AlertDetails

@synthesize pickupStateCode = _pickupStateCode;
@synthesize modifiedDate = _modifiedDate;
@synthesize alertMsg = _alertMsg;
@synthesize equiName = _equiName;
@synthesize deliveryStateCode = _deliveryStateCode;
@synthesize createdDate = _createdDate;
@synthesize equiOwnerId = _equiOwnerId;
@synthesize loadId = _loadId;
@synthesize loadOwnerId = _loadOwnerId;
@synthesize isDelete = _isDelete;
@synthesize alertId = _alertId;
@synthesize receiverId = _receiverId;
@synthesize equiId = _equiId;


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
            self.pickupStateCode = [self objectOrNilForKey:kAlertDetailsPickupStateCode fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kAlertDetailsModifiedDate fromDictionary:dict];
            self.alertMsg = [self objectOrNilForKey:kAlertDetailsAlertMsg fromDictionary:dict];
            self.equiName = [self objectOrNilForKey:kAlertDetailsEquiName fromDictionary:dict];
            self.deliveryStateCode = [self objectOrNilForKey:kAlertDetailsDeliveryStateCode fromDictionary:dict];
            self.createdDate = [self objectOrNilForKey:kAlertDetailsCreatedDate fromDictionary:dict];
            self.equiOwnerId = [self objectOrNilForKey:kAlertDetailsEquiOwnerId fromDictionary:dict];
            self.loadId = [self objectOrNilForKey:kAlertDetailsLoadId fromDictionary:dict];
            self.loadOwnerId = [self objectOrNilForKey:kAlertDetailsLoadOwnerId fromDictionary:dict];
            self.isDelete = [self objectOrNilForKey:kAlertDetailsIsDelete fromDictionary:dict];
            self.alertId = [self objectOrNilForKey:kAlertDetailsAlertId fromDictionary:dict];
            self.receiverId = [self objectOrNilForKey:kAlertDetailsReceiverId fromDictionary:dict];
            self.equiId = [self objectOrNilForKey:kAlertDetailsEquiId fromDictionary:dict];
         self.alertCount = [self objectOrNilForKey:kAlertCount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.pickupStateCode forKey:kAlertDetailsPickupStateCode];
    [mutableDict setValue:self.modifiedDate forKey:kAlertDetailsModifiedDate];
    [mutableDict setValue:self.alertMsg forKey:kAlertDetailsAlertMsg];
    [mutableDict setValue:self.equiName forKey:kAlertDetailsEquiName];
    [mutableDict setValue:self.deliveryStateCode forKey:kAlertDetailsDeliveryStateCode];
    [mutableDict setValue:self.createdDate forKey:kAlertDetailsCreatedDate];
    [mutableDict setValue:self.equiOwnerId forKey:kAlertDetailsEquiOwnerId];
    [mutableDict setValue:self.loadId forKey:kAlertDetailsLoadId];
    [mutableDict setValue:self.loadOwnerId forKey:kAlertDetailsLoadOwnerId];
    [mutableDict setValue:self.isDelete forKey:kAlertDetailsIsDelete];
    [mutableDict setValue:self.alertId forKey:kAlertDetailsAlertId];
    [mutableDict setValue:self.receiverId forKey:kAlertDetailsReceiverId];
    [mutableDict setValue:self.equiId forKey:kAlertDetailsEquiId];
 [mutableDict setValue:self.alertCount forKey:kAlertCount];
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


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.pickupStateCode = [aDecoder decodeObjectForKey:kAlertDetailsPickupStateCode];
    self.modifiedDate = [aDecoder decodeObjectForKey:kAlertDetailsModifiedDate];
    self.alertMsg = [aDecoder decodeObjectForKey:kAlertDetailsAlertMsg];
    self.equiName = [aDecoder decodeObjectForKey:kAlertDetailsEquiName];
    self.deliveryStateCode = [aDecoder decodeObjectForKey:kAlertDetailsDeliveryStateCode];
    self.createdDate = [aDecoder decodeObjectForKey:kAlertDetailsCreatedDate];
    self.equiOwnerId = [aDecoder decodeObjectForKey:kAlertDetailsEquiOwnerId];
    self.loadId = [aDecoder decodeObjectForKey:kAlertDetailsLoadId];
    self.loadOwnerId = [aDecoder decodeObjectForKey:kAlertDetailsLoadOwnerId];
    self.isDelete = [aDecoder decodeObjectForKey:kAlertDetailsIsDelete];
    self.alertId = [aDecoder decodeObjectForKey:kAlertDetailsAlertId];
    self.receiverId = [aDecoder decodeObjectForKey:kAlertDetailsReceiverId];
    self.equiId = [aDecoder decodeObjectForKey:kAlertDetailsEquiId];
     self.alertCount = [aDecoder decodeObjectForKey:kAlertCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pickupStateCode forKey:kAlertDetailsPickupStateCode];
    [aCoder encodeObject:_modifiedDate forKey:kAlertDetailsModifiedDate];
    [aCoder encodeObject:_alertMsg forKey:kAlertDetailsAlertMsg];
    [aCoder encodeObject:_equiName forKey:kAlertDetailsEquiName];
    [aCoder encodeObject:_deliveryStateCode forKey:kAlertDetailsDeliveryStateCode];
    [aCoder encodeObject:_createdDate forKey:kAlertDetailsCreatedDate];
    [aCoder encodeObject:_equiOwnerId forKey:kAlertDetailsEquiOwnerId];
    [aCoder encodeObject:_loadId forKey:kAlertDetailsLoadId];
    [aCoder encodeObject:_loadOwnerId forKey:kAlertDetailsLoadOwnerId];
    [aCoder encodeObject:_isDelete forKey:kAlertDetailsIsDelete];
    [aCoder encodeObject:_alertId forKey:kAlertDetailsAlertId];
    [aCoder encodeObject:_receiverId forKey:kAlertDetailsReceiverId];
    [aCoder encodeObject:_equiId forKey:kAlertDetailsEquiId];
     [aCoder encodeObject:_alertCount forKey:kAlertCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    AlertDetails *copy = [[AlertDetails alloc] init];
    
    if (copy) {

        copy.pickupStateCode = [self.pickupStateCode copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.alertMsg = [self.alertMsg copyWithZone:zone];
        copy.equiName = [self.equiName copyWithZone:zone];
        copy.deliveryStateCode = [self.deliveryStateCode copyWithZone:zone];
        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.equiOwnerId = [self.equiOwnerId copyWithZone:zone];
        copy.loadId = [self.loadId copyWithZone:zone];
        copy.loadOwnerId = [self.loadOwnerId copyWithZone:zone];
        copy.isDelete = [self.isDelete copyWithZone:zone];
        copy.alertId = [self.alertId copyWithZone:zone];
        copy.receiverId = [self.receiverId copyWithZone:zone];
        copy.equiId = [self.equiId copyWithZone:zone];
        copy.alertCount = [self.alertCount copyWithZone:zone];
    }
    
    return copy;
}


@end
