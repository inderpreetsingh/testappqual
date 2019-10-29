//
//  Orders.m
//
//  Created by c196  on 03/06/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Orders.h"


NSString *const kOrdersOrderFromId = @"order_from_id";
NSString *const kOrdersEquiId = @"equi_id";
NSString *const kOrdersOrderType = @"order_type";
NSString *const kOrdersId = @"id";
NSString *const kOrdersOrderToId = @"order_to_id";
NSString *const kOrdersLoadId = @"load_id";
NSString *const kOrdersIsDelete = @"is_delete";
NSString *const kOrdersCreatedDate = @"created_date";
NSString *const kOrdersModifiedDate = @"modified_date";
NSString *const kOrdersIsTest = @"is_test";
NSString *const kOrdersDriverId = @"driver_id";
NSString *const kOrderspickupdate = @"pickup_date";
NSString *const kOrdersDelieverydate = @"delievery_date";
NSString *const kOrdersSubAssetId = @"sub_asset_id";
@interface Orders ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Orders

@synthesize orderFromId = _orderFromId;
@synthesize equiId = _equiId;
@synthesize orderType = _orderType;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize orderToId = _orderToId;
@synthesize loadId = _loadId;
@synthesize isDelete = _isDelete;
@synthesize createdDate = _createdDate;
@synthesize modifiedDate = _modifiedDate;
@synthesize isTest = _isTest;
@synthesize driverId = _driverId;


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
            self.orderFromId = [self objectOrNilForKey:kOrdersOrderFromId fromDictionary:dict];
            self.equiId = [[self objectOrNilForKey:kOrdersEquiId fromDictionary:dict] doubleValue];
            self.orderType = [[self objectOrNilForKey:kOrdersOrderType fromDictionary:dict] doubleValue];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kOrdersId fromDictionary:dict] doubleValue];
            self.orderToId = [self objectOrNilForKey:kOrdersOrderToId fromDictionary:dict];
            self.loadId = [[self objectOrNilForKey:kOrdersLoadId fromDictionary:dict] doubleValue];
            self.isDelete = [[self objectOrNilForKey:kOrdersIsDelete fromDictionary:dict] doubleValue];
            self.createdDate = [self objectOrNilForKey:kOrdersCreatedDate fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kOrdersModifiedDate fromDictionary:dict];
            self.isTest = [[self objectOrNilForKey:kOrdersIsTest fromDictionary:dict] doubleValue];
            self.driverId = [[self objectOrNilForKey:kOrdersDriverId fromDictionary:dict] doubleValue];
        self.pickupDate =[self objectOrNilForKey:kOrderspickupdate fromDictionary:dict];
        self.delieveryDate = [self objectOrNilForKey:kOrdersDelieverydate fromDictionary:dict];
         self.subassetid = [self objectOrNilForKey:kOrdersSubAssetId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.orderFromId forKey:kOrdersOrderFromId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiId] forKey:kOrdersEquiId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderType] forKey:kOrdersOrderType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kOrdersId];
    [mutableDict setValue:self.orderToId forKey:kOrdersOrderToId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loadId] forKey:kOrdersLoadId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDelete] forKey:kOrdersIsDelete];
    [mutableDict setValue:self.createdDate forKey:kOrdersCreatedDate];
    [mutableDict setValue:self.modifiedDate forKey:kOrdersModifiedDate];
    [mutableDict setValue:self.pickupDate forKey:kOrderspickupdate];
    [mutableDict setValue:self.delieveryDate forKey:kOrdersDelieverydate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isTest] forKey:kOrdersIsTest];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverId] forKey:kOrdersDriverId];
    [mutableDict setValue:self.subassetid forKey:kOrdersSubAssetId];

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
