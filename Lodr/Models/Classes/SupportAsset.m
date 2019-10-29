//
//  SupportAsset.m
//
//  Created by C109  on 16/02/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "SupportAsset.h"


NSString *const kSupportAssetIsPublish = @"is_publish";
NSString *const kSupportAssetAssetAbilityId = @"asset_ability_id";
NSString *const kSupportAssetLastEquiStatecode = @"last_equi_statecode";
NSString *const kSupportAssetModifiedDate = @"modified_date";
NSString *const kSupportAssetUserId = @"user_id";
NSString *const kSupportAssetEsId = @"es_id";
NSString *const kSupportAssetEquiLongitude = @"equi_longitude";
NSString *const kSupportAssetEquiWeight = @"equi_weight";
NSString *const kSupportAssetEquiHeight = @"equi_height";
NSString *const kSupportAssetCreatedDate = @"created_date";
NSString *const kSupportAssetLastEquiAddress = @"last_equi_address";
NSString *const kSupportAssetVisibleTo = @"visible_to";
NSString *const kSupportAssetEquiName = @"equi_name";
NSString *const kSupportAssetEquiEmptyWeight = @"equi_empty_weight";
NSString *const kSupportAssetEquiLatitude = @"equi_latitude";
NSString *const kSupportAssetId = @"id";
NSString *const kSupportAssetScheduledLoadWeight = @"scheduledLoadWeight";
NSString *const kSupportAssetEId = @"e_id";
NSString *const kSupportAssetEquiAvailablity = @"equi_availablity";
NSString *const kSupportAssetEquiLength = @"equi_length";
NSString *const kSupportAssetEquiWidth = @"equi_width";
NSString *const kSupportAssetEquiNotes = @"equi_notes";
NSString *const kSupportAssetIsavailable = @"isavailable";
NSString *const kSupportAssetIsDelete = @"is_delete";
NSString *const kSupportAssetIsTest = @"is_test";
NSString *const kSupportAssetAssetTypeId = @"asset_type_id";


@interface SupportAsset ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SupportAsset

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
@synthesize supportAssetIdentifier = _supportAssetIdentifier;
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


+ (SupportAsset *)modelObjectWithDictionary:(NSDictionary *)dict
{
    SupportAsset *instance = [[SupportAsset alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.isPublish = [[self objectOrNilForKey:kSupportAssetIsPublish fromDictionary:dict] doubleValue];
            self.assetAbilityId = [[self objectOrNilForKey:kSupportAssetAssetAbilityId fromDictionary:dict] doubleValue];
            self.lastEquiStatecode = [self objectOrNilForKey:kSupportAssetLastEquiStatecode fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kSupportAssetModifiedDate fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSupportAssetUserId fromDictionary:dict];
            self.esId = [self objectOrNilForKey:kSupportAssetEsId fromDictionary:dict];
            self.equiLongitude = [self objectOrNilForKey:kSupportAssetEquiLongitude fromDictionary:dict];
            self.equiWeight = [[self objectOrNilForKey:kSupportAssetEquiWeight fromDictionary:dict] doubleValue];
            self.equiHeight = [[self objectOrNilForKey:kSupportAssetEquiHeight fromDictionary:dict] doubleValue];
            self.createdDate = [self objectOrNilForKey:kSupportAssetCreatedDate fromDictionary:dict];
            self.lastEquiAddress = [self objectOrNilForKey:kSupportAssetLastEquiAddress fromDictionary:dict];
            self.visibleTo = [[self objectOrNilForKey:kSupportAssetVisibleTo fromDictionary:dict] doubleValue];
            self.equiName = [self objectOrNilForKey:kSupportAssetEquiName fromDictionary:dict];
            self.equiEmptyWeight = [[self objectOrNilForKey:kSupportAssetEquiEmptyWeight fromDictionary:dict] doubleValue];
            self.equiLatitude = [self objectOrNilForKey:kSupportAssetEquiLatitude fromDictionary:dict];
            self.supportAssetIdentifier = [[self objectOrNilForKey:kSupportAssetId fromDictionary:dict] doubleValue];
            self.scheduledLoadWeight = [self objectOrNilForKey:kSupportAssetScheduledLoadWeight fromDictionary:dict];
            self.eId = [self objectOrNilForKey:kSupportAssetEId fromDictionary:dict];
            self.equiAvailablity = [[self objectOrNilForKey:kSupportAssetEquiAvailablity fromDictionary:dict] doubleValue];
            self.equiLength = [[self objectOrNilForKey:kSupportAssetEquiLength fromDictionary:dict] doubleValue];
            self.equiWidth = [[self objectOrNilForKey:kSupportAssetEquiWidth fromDictionary:dict] doubleValue];
            self.equiNotes = [self objectOrNilForKey:kSupportAssetEquiNotes fromDictionary:dict];
            self.isavailable = [self objectOrNilForKey:kSupportAssetIsavailable fromDictionary:dict];
            self.isDelete = [[self objectOrNilForKey:kSupportAssetIsDelete fromDictionary:dict] doubleValue];
            self.isTest = [[self objectOrNilForKey:kSupportAssetIsTest fromDictionary:dict] doubleValue];
            self.assetTypeId = [[self objectOrNilForKey:kSupportAssetAssetTypeId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isPublish] forKey:kSupportAssetIsPublish];
    [mutableDict setValue:[NSNumber numberWithDouble:self.assetAbilityId] forKey:kSupportAssetAssetAbilityId];
    [mutableDict setValue:self.lastEquiStatecode forKey:kSupportAssetLastEquiStatecode];
    [mutableDict setValue:self.modifiedDate forKey:kSupportAssetModifiedDate];
    [mutableDict setValue:self.userId forKey:kSupportAssetUserId];
    [mutableDict setValue:self.esId forKey:kSupportAssetEsId];
    [mutableDict setValue:self.equiLongitude forKey:kSupportAssetEquiLongitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiWeight] forKey:kSupportAssetEquiWeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiHeight] forKey:kSupportAssetEquiHeight];
    [mutableDict setValue:self.createdDate forKey:kSupportAssetCreatedDate];
    [mutableDict setValue:self.lastEquiAddress forKey:kSupportAssetLastEquiAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.visibleTo] forKey:kSupportAssetVisibleTo];
    [mutableDict setValue:self.equiName forKey:kSupportAssetEquiName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiEmptyWeight] forKey:kSupportAssetEquiEmptyWeight];
    [mutableDict setValue:self.equiLatitude forKey:kSupportAssetEquiLatitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.supportAssetIdentifier] forKey:kSupportAssetId];
    [mutableDict setValue:self.scheduledLoadWeight forKey:kSupportAssetScheduledLoadWeight];
    [mutableDict setValue:self.eId forKey:kSupportAssetEId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiAvailablity] forKey:kSupportAssetEquiAvailablity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiLength] forKey:kSupportAssetEquiLength];
    [mutableDict setValue:[NSNumber numberWithDouble:self.equiWidth] forKey:kSupportAssetEquiWidth];
    [mutableDict setValue:self.equiNotes forKey:kSupportAssetEquiNotes];
    [mutableDict setValue:self.isavailable forKey:kSupportAssetIsavailable];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDelete] forKey:kSupportAssetIsDelete];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isTest] forKey:kSupportAssetIsTest];
    [mutableDict setValue:[NSNumber numberWithDouble:self.assetTypeId] forKey:kSupportAssetAssetTypeId];

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

    self.isPublish = [aDecoder decodeDoubleForKey:kSupportAssetIsPublish];
    self.assetAbilityId = [aDecoder decodeDoubleForKey:kSupportAssetAssetAbilityId];
    self.lastEquiStatecode = [aDecoder decodeObjectForKey:kSupportAssetLastEquiStatecode];
    self.modifiedDate = [aDecoder decodeObjectForKey:kSupportAssetModifiedDate];
    self.userId = [aDecoder decodeObjectForKey:kSupportAssetUserId];
    self.esId = [aDecoder decodeObjectForKey:kSupportAssetEsId];
    self.equiLongitude = [aDecoder decodeObjectForKey:kSupportAssetEquiLongitude];
    self.equiWeight = [aDecoder decodeDoubleForKey:kSupportAssetEquiWeight];
    self.equiHeight = [aDecoder decodeDoubleForKey:kSupportAssetEquiHeight];
    self.createdDate = [aDecoder decodeObjectForKey:kSupportAssetCreatedDate];
    self.lastEquiAddress = [aDecoder decodeObjectForKey:kSupportAssetLastEquiAddress];
    self.visibleTo = [aDecoder decodeDoubleForKey:kSupportAssetVisibleTo];
    self.equiName = [aDecoder decodeObjectForKey:kSupportAssetEquiName];
    self.equiEmptyWeight = [aDecoder decodeDoubleForKey:kSupportAssetEquiEmptyWeight];
    self.equiLatitude = [aDecoder decodeObjectForKey:kSupportAssetEquiLatitude];
    self.supportAssetIdentifier = [aDecoder decodeDoubleForKey:kSupportAssetId];
    self.scheduledLoadWeight = [aDecoder decodeObjectForKey:kSupportAssetScheduledLoadWeight];
    self.eId = [aDecoder decodeObjectForKey:kSupportAssetEId];
    self.equiAvailablity = [aDecoder decodeDoubleForKey:kSupportAssetEquiAvailablity];
    self.equiLength = [aDecoder decodeDoubleForKey:kSupportAssetEquiLength];
    self.equiWidth = [aDecoder decodeDoubleForKey:kSupportAssetEquiWidth];
    self.equiNotes = [aDecoder decodeObjectForKey:kSupportAssetEquiNotes];
    self.isavailable = [aDecoder decodeObjectForKey:kSupportAssetIsavailable];
    self.isDelete = [aDecoder decodeDoubleForKey:kSupportAssetIsDelete];
    self.isTest = [aDecoder decodeDoubleForKey:kSupportAssetIsTest];
    self.assetTypeId = [aDecoder decodeDoubleForKey:kSupportAssetAssetTypeId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_isPublish forKey:kSupportAssetIsPublish];
    [aCoder encodeDouble:_assetAbilityId forKey:kSupportAssetAssetAbilityId];
    [aCoder encodeObject:_lastEquiStatecode forKey:kSupportAssetLastEquiStatecode];
    [aCoder encodeObject:_modifiedDate forKey:kSupportAssetModifiedDate];
    [aCoder encodeObject:_userId forKey:kSupportAssetUserId];
    [aCoder encodeObject:_esId forKey:kSupportAssetEsId];
    [aCoder encodeObject:_equiLongitude forKey:kSupportAssetEquiLongitude];
    [aCoder encodeDouble:_equiWeight forKey:kSupportAssetEquiWeight];
    [aCoder encodeDouble:_equiHeight forKey:kSupportAssetEquiHeight];
    [aCoder encodeObject:_createdDate forKey:kSupportAssetCreatedDate];
    [aCoder encodeObject:_lastEquiAddress forKey:kSupportAssetLastEquiAddress];
    [aCoder encodeDouble:_visibleTo forKey:kSupportAssetVisibleTo];
    [aCoder encodeObject:_equiName forKey:kSupportAssetEquiName];
    [aCoder encodeDouble:_equiEmptyWeight forKey:kSupportAssetEquiEmptyWeight];
    [aCoder encodeObject:_equiLatitude forKey:kSupportAssetEquiLatitude];
    [aCoder encodeDouble:_supportAssetIdentifier forKey:kSupportAssetId];
    [aCoder encodeObject:_scheduledLoadWeight forKey:kSupportAssetScheduledLoadWeight];
    [aCoder encodeObject:_eId forKey:kSupportAssetEId];
    [aCoder encodeDouble:_equiAvailablity forKey:kSupportAssetEquiAvailablity];
    [aCoder encodeDouble:_equiLength forKey:kSupportAssetEquiLength];
    [aCoder encodeDouble:_equiWidth forKey:kSupportAssetEquiWidth];
    [aCoder encodeObject:_equiNotes forKey:kSupportAssetEquiNotes];
    [aCoder encodeObject:_isavailable forKey:kSupportAssetIsavailable];
    [aCoder encodeDouble:_isDelete forKey:kSupportAssetIsDelete];
    [aCoder encodeDouble:_isTest forKey:kSupportAssetIsTest];
    [aCoder encodeDouble:_assetTypeId forKey:kSupportAssetAssetTypeId];
}


@end
