//
//  AssetAbility.m
//
//  Created by c196  on 27/07/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "AssetAbility.h"


NSString *const kAssetAbilityId = @"id";
NSString *const kAssetAbilityIssueType = @"issue_type";
NSString *const kAssetAbilityCapacityValue = @"capacity_value";
NSString *const kAssetAbilityAssetTypeId = @"asset_type_id";
NSString *const kAssetAbilityModifiedDate = @"modified_date";
NSString *const kAssetAbilityIsDelete = @"is_delete";


@interface AssetAbility ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AssetAbility

@synthesize assetAbilityIdentifier = _assetAbilityIdentifier;
@synthesize issueType = _issueType;
@synthesize capacityValue = _capacityValue;
@synthesize assetTypeId = _assetTypeId;
@synthesize modifiedDate = _modifiedDate;
@synthesize isDelete = _isDelete;


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
            self.assetAbilityIdentifier = [self objectOrNilForKey:kAssetAbilityId fromDictionary:dict];
            self.issueType = [self objectOrNilForKey:kAssetAbilityIssueType fromDictionary:dict];
            self.capacityValue = [self objectOrNilForKey:kAssetAbilityCapacityValue fromDictionary:dict];
            self.assetTypeId = [self objectOrNilForKey:kAssetAbilityAssetTypeId fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kAssetAbilityModifiedDate fromDictionary:dict];
            self.isDelete = [self objectOrNilForKey:kAssetAbilityIsDelete fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.assetAbilityIdentifier forKey:kAssetAbilityId];
    [mutableDict setValue:self.issueType forKey:kAssetAbilityIssueType];
    [mutableDict setValue:self.capacityValue forKey:kAssetAbilityCapacityValue];
    [mutableDict setValue:self.assetTypeId forKey:kAssetAbilityAssetTypeId];
    [mutableDict setValue:self.modifiedDate forKey:kAssetAbilityModifiedDate];
    [mutableDict setValue:self.isDelete forKey:kAssetAbilityIsDelete];

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

    self.assetAbilityIdentifier = [aDecoder decodeObjectForKey:kAssetAbilityId];
    self.issueType = [aDecoder decodeObjectForKey:kAssetAbilityIssueType];
    self.capacityValue = [aDecoder decodeObjectForKey:kAssetAbilityCapacityValue];
    self.assetTypeId = [aDecoder decodeObjectForKey:kAssetAbilityAssetTypeId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kAssetAbilityModifiedDate];
    self.isDelete = [aDecoder decodeObjectForKey:kAssetAbilityIsDelete];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_assetAbilityIdentifier forKey:kAssetAbilityId];
    [aCoder encodeObject:_issueType forKey:kAssetAbilityIssueType];
    [aCoder encodeObject:_capacityValue forKey:kAssetAbilityCapacityValue];
    [aCoder encodeObject:_assetTypeId forKey:kAssetAbilityAssetTypeId];
    [aCoder encodeObject:_modifiedDate forKey:kAssetAbilityModifiedDate];
    [aCoder encodeObject:_isDelete forKey:kAssetAbilityIsDelete];
}

- (id)copyWithZone:(NSZone *)zone
{
    AssetAbility *copy = [[AssetAbility alloc] init];
    
    if (copy) {

        copy.assetAbilityIdentifier = [self.assetAbilityIdentifier copyWithZone:zone];
        copy.issueType = [self.issueType copyWithZone:zone];
        copy.capacityValue = [self.capacityValue copyWithZone:zone];
        copy.assetTypeId = [self.assetTypeId copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.isDelete = [self.isDelete copyWithZone:zone];
    }
    
    return copy;
}


@end
