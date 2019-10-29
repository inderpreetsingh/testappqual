//
//  PowerAsset.m
//
//  Created by C109  on 13/02/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "PowerAsset.h"


NSString *const kPowerAssetIsPublish = @"is_publish";
NSString *const kPowerAssetAssetAbilityId = @"asset_ability_id";
NSString *const kPowerAssetLastEquiStatecode = @"last_equi_statecode";
NSString *const kPowerAssetModifiedDate = @"modified_date";
NSString *const kPowerAssetUserId = @"user_id";
NSString *const kPowerAssetEsId = @"es_id";
NSString *const kPowerAssetEquiLongitude = @"equi_longitude";
NSString *const kPowerAssetEquiWeight = @"equi_weight";
NSString *const kPowerAssetEquiHeight = @"equi_height";
NSString *const kPowerAssetCreatedDate = @"created_date";
NSString *const kPowerAssetLastEquiAddress = @"last_equi_address";
NSString *const kPowerAssetVisibleTo = @"visible_to";
NSString *const kPowerAssetEquiName = @"equi_name";
NSString *const kPowerAssetEquiEmptyWeight = @"equi_empty_weight";
NSString *const kPowerAssetEquiLatitude = @"equi_latitude";
NSString *const kPowerAssetId = @"id";
NSString *const kPowerAssetScheduledLoadWeight = @"scheduledLoadWeight";
NSString *const kPowerAssetEId = @"e_id";
NSString *const kPowerAssetEquiAvailablity = @"equi_availablity";
NSString *const kPowerAssetEquiLength = @"equi_length";
NSString *const kPowerAssetEquiWidth = @"equi_width";
NSString *const kPowerAssetEquiNotes = @"equi_notes";
NSString *const kPowerAssetIsavailable = @"isavailable";
NSString *const kPowerAssetIsDelete = @"is_delete";
NSString *const kPowerAssetIsTest = @"is_test";
NSString *const kPowerAssetAssetTypeId = @"asset_type_id";


@interface PowerAsset ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PowerAsset

@synthesize isPublish = _isPublish;
@synthesize assetAbilityId = _assetAbilityId;
@synthesize lastEquiStatecode = _lastEquiStatecode;
@synthesize modifiedDate = _modifiedDate;
@synthesize userId = _userId;
@synthesize esId = _esId;
@synthesize equiLongitude = _equiLongitude;
@synthesize equiWeight = _equiWeight;
@synthesize equiHeight = _equiHeight;
@synthesize createdDate = _createdDate;
@synthesize lastEquiAddress = _lastEquiAddress;
@synthesize visibleTo = _visibleTo;
@synthesize equiName = _equiName;
@synthesize equiEmptyWeight = _equiEmptyWeight;
@synthesize equiLatitude = _equiLatitude;
@synthesize powerAssetIdentifier = _powerAssetIdentifier;
@synthesize scheduledLoadWeight = _scheduledLoadWeight;
@synthesize eId = _eId;
@synthesize equiAvailablity = _equiAvailablity;
@synthesize equiLength = _equiLength;
@synthesize equiWidth = _equiWidth;
@synthesize equiNotes = _equiNotes;
@synthesize isavailable = _isavailable;
@synthesize isDelete = _isDelete;
@synthesize isTest = _isTest;
@synthesize assetTypeId = _assetTypeId;


+ (PowerAsset *)modelObjectWithDictionary:(NSDictionary *)dict
{
    PowerAsset *instance = [[PowerAsset alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.isPublish = [[self objectOrNilForKey:kPowerAssetIsPublish fromDictionary:dict] doubleValue];
            self.assetAbilityId = [[self objectOrNilForKey:kPowerAssetAssetAbilityId fromDictionary:dict] doubleValue];
            self.lastEquiStatecode = [self objectOrNilForKey:kPowerAssetLastEquiStatecode fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kPowerAssetModifiedDate fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kPowerAssetUserId fromDictionary:dict];
            self.esId = [self objectOrNilForKey:kPowerAssetEsId fromDictionary:dict];
            self.equiLongitude = [self objectOrNilForKey:kPowerAssetEquiLongitude fromDictionary:dict];
            self.equiWeight = [[self objectOrNilForKey:kPowerAssetEquiWeight fromDictionary:dict] doubleValue];
            self.equiHeight = [[self objectOrNilForKey:kPowerAssetEquiHeight fromDictionary:dict] doubleValue];
            self.createdDate = [self objectOrNilForKey:kPowerAssetCreatedDate fromDictionary:dict];
            self.lastEquiAddress = [self objectOrNilForKey:kPowerAssetLastEquiAddress fromDictionary:dict];
            self.visibleTo = [[self objectOrNilForKey:kPowerAssetVisibleTo fromDictionary:dict] doubleValue];
            self.equiName = [self objectOrNilForKey:kPowerAssetEquiName fromDictionary:dict];
            self.equiEmptyWeight = [[self objectOrNilForKey:kPowerAssetEquiEmptyWeight fromDictionary:dict] doubleValue];
            self.equiLatitude = [self objectOrNilForKey:kPowerAssetEquiLatitude fromDictionary:dict];
            self.powerAssetIdentifier = [[self objectOrNilForKey:kPowerAssetId fromDictionary:dict] doubleValue];
            self.scheduledLoadWeight = [self objectOrNilForKey:kPowerAssetScheduledLoadWeight fromDictionary:dict];
            self.eId = [self objectOrNilForKey:kPowerAssetEId fromDictionary:dict];
            self.equiAvailablity = [[self objectOrNilForKey:kPowerAssetEquiAvailablity fromDictionary:dict] doubleValue];
            self.equiLength = [[self objectOrNilForKey:kPowerAssetEquiLength fromDictionary:dict] doubleValue];
            self.equiWidth = [[self objectOrNilForKey:kPowerAssetEquiWidth fromDictionary:dict] doubleValue];
            self.equiNotes = [self objectOrNilForKey:kPowerAssetEquiNotes fromDictionary:dict];
            self.isavailable = [self objectOrNilForKey:kPowerAssetIsavailable fromDictionary:dict];
            self.isDelete = [[self objectOrNilForKey:kPowerAssetIsDelete fromDictionary:dict] doubleValue];
            self.isTest = [[self objectOrNilForKey:kPowerAssetIsTest fromDictionary:dict] doubleValue];
            self.assetTypeId = [[self objectOrNilForKey:kPowerAssetAssetTypeId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isPublish] forKey:kPowerAssetIsPublish];
    [mutableDict setValue:[NSNumber numberWithDouble:self.assetAbilityId] forKey:kPowerAssetAssetAbilityId];
    [mutableDict setValue:self.lastEquiStatecode forKey:kPowerAssetLastEquiStatecode];
    [mutableDict setValue:self.modifiedDate forKey:kPowerAssetModifiedDate];
    [mutableDict setValue:self.userId forKey:kPowerAssetUserId];
    [mutableDict setValue:self.esId forKey:kPowerAssetEsId];
    [mutableDict setValue:self.equiLongitude forKey:kPowerAssetEquiLongitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiWeight] forKey:kPowerAssetEquiWeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiHeight] forKey:kPowerAssetEquiHeight];
    [mutableDict setValue:self.createdDate forKey:kPowerAssetCreatedDate];
    [mutableDict setValue:self.lastEquiAddress forKey:kPowerAssetLastEquiAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.visibleTo] forKey:kPowerAssetVisibleTo];
    [mutableDict setValue:self.equiName forKey:kPowerAssetEquiName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiEmptyWeight] forKey:kPowerAssetEquiEmptyWeight];
    [mutableDict setValue:self.equiLatitude forKey:kPowerAssetEquiLatitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.powerAssetIdentifier] forKey:kPowerAssetId];
    [mutableDict setValue:self.scheduledLoadWeight forKey:kPowerAssetScheduledLoadWeight];
    [mutableDict setValue:self.eId forKey:kPowerAssetEId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiAvailablity] forKey:kPowerAssetEquiAvailablity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiLength] forKey:kPowerAssetEquiLength];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiWidth] forKey:kPowerAssetEquiWidth];
    [mutableDict setValue:self.equiNotes forKey:kPowerAssetEquiNotes];
    [mutableDict setValue:self.isavailable forKey:kPowerAssetIsavailable];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDelete] forKey:kPowerAssetIsDelete];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isTest] forKey:kPowerAssetIsTest];
    [mutableDict setValue:[NSNumber numberWithDouble:self.assetTypeId] forKey:kPowerAssetAssetTypeId];

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
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.isPublish = [aDecoder decodeDoubleForKey:kPowerAssetIsPublish];
    self.assetAbilityId = [aDecoder decodeDoubleForKey:kPowerAssetAssetAbilityId];
    self.lastEquiStatecode = [aDecoder decodeObjectForKey:kPowerAssetLastEquiStatecode];
    self.modifiedDate = [aDecoder decodeObjectForKey:kPowerAssetModifiedDate];
    self.userId = [aDecoder decodeObjectForKey:kPowerAssetUserId];
    self.esId = [aDecoder decodeObjectForKey:kPowerAssetEsId];
    self.equiLongitude = [aDecoder decodeObjectForKey:kPowerAssetEquiLongitude];
    self.equiWeight = [aDecoder decodeDoubleForKey:kPowerAssetEquiWeight];
    self.equiHeight = [aDecoder decodeDoubleForKey:kPowerAssetEquiHeight];
    self.createdDate = [aDecoder decodeObjectForKey:kPowerAssetCreatedDate];
    self.lastEquiAddress = [aDecoder decodeObjectForKey:kPowerAssetLastEquiAddress];
    self.visibleTo = [aDecoder decodeDoubleForKey:kPowerAssetVisibleTo];
    self.equiName = [aDecoder decodeObjectForKey:kPowerAssetEquiName];
    self.equiEmptyWeight = [aDecoder decodeDoubleForKey:kPowerAssetEquiEmptyWeight];
    self.equiLatitude = [aDecoder decodeObjectForKey:kPowerAssetEquiLatitude];
    self.powerAssetIdentifier = [aDecoder decodeDoubleForKey:kPowerAssetId];
    self.scheduledLoadWeight = [aDecoder decodeObjectForKey:kPowerAssetScheduledLoadWeight];
    self.eId = [aDecoder decodeObjectForKey:kPowerAssetEId];
    self.equiAvailablity = [aDecoder decodeDoubleForKey:kPowerAssetEquiAvailablity];
    self.equiLength = [aDecoder decodeDoubleForKey:kPowerAssetEquiLength];
    self.equiWidth = [aDecoder decodeDoubleForKey:kPowerAssetEquiWidth];
    self.equiNotes = [aDecoder decodeObjectForKey:kPowerAssetEquiNotes];
    self.isavailable = [aDecoder decodeObjectForKey:kPowerAssetIsavailable];
    self.isDelete = [aDecoder decodeDoubleForKey:kPowerAssetIsDelete];
    self.isTest = [aDecoder decodeDoubleForKey:kPowerAssetIsTest];
    self.assetTypeId = [aDecoder decodeDoubleForKey:kPowerAssetAssetTypeId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_isPublish forKey:kPowerAssetIsPublish];
    [aCoder encodeDouble:_assetAbilityId forKey:kPowerAssetAssetAbilityId];
    [aCoder encodeObject:_lastEquiStatecode forKey:kPowerAssetLastEquiStatecode];
    [aCoder encodeObject:_modifiedDate forKey:kPowerAssetModifiedDate];
    [aCoder encodeObject:_userId forKey:kPowerAssetUserId];
    [aCoder encodeObject:_esId forKey:kPowerAssetEsId];
    [aCoder encodeObject:_equiLongitude forKey:kPowerAssetEquiLongitude];
    [aCoder encodeDouble:_equiWeight forKey:kPowerAssetEquiWeight];
    [aCoder encodeDouble:_equiHeight forKey:kPowerAssetEquiHeight];
    [aCoder encodeObject:_createdDate forKey:kPowerAssetCreatedDate];
    [aCoder encodeObject:_lastEquiAddress forKey:kPowerAssetLastEquiAddress];
    [aCoder encodeDouble:_visibleTo forKey:kPowerAssetVisibleTo];
    [aCoder encodeObject:_equiName forKey:kPowerAssetEquiName];
    [aCoder encodeDouble:_equiEmptyWeight forKey:kPowerAssetEquiEmptyWeight];
    [aCoder encodeObject:_equiLatitude forKey:kPowerAssetEquiLatitude];
    [aCoder encodeDouble:_powerAssetIdentifier forKey:kPowerAssetId];
    [aCoder encodeObject:_scheduledLoadWeight forKey:kPowerAssetScheduledLoadWeight];
    [aCoder encodeObject:_eId forKey:kPowerAssetEId];
    [aCoder encodeDouble:_equiAvailablity forKey:kPowerAssetEquiAvailablity];
    [aCoder encodeDouble:_equiLength forKey:kPowerAssetEquiLength];
    [aCoder encodeDouble:_equiWidth forKey:kPowerAssetEquiWidth];
    [aCoder encodeObject:_equiNotes forKey:kPowerAssetEquiNotes];
    [aCoder encodeObject:_isavailable forKey:kPowerAssetIsavailable];
    [aCoder encodeDouble:_isDelete forKey:kPowerAssetIsDelete];
    [aCoder encodeDouble:_isTest forKey:kPowerAssetIsTest];
    [aCoder encodeDouble:_assetTypeId forKey:kPowerAssetAssetTypeId];
}


@end
