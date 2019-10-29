//
//  SubEquiEspecial.m
//
//  Created by Payal Umraliya  on 31/03/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "SubEquiEspecial.h"
#import "AssetAbility.h"

NSString *const kSubEquiEspecialCreatedDate = @"created_date";
NSString *const kSubEquiEspecialId = @"id";
NSString *const kSubEquiEspecialIsDelete = @"is_delete";
NSString *const kSubEquiEspecialEsName = @"es_name";
NSString *const kSubEquiEspecialModifiedDate = @"modified_date";
NSString *const kSubEquiEspecialIsTest = @"is_test";
NSString *const kSubEquiparentId = @"parent_id";
NSString *const kSubEquicapability = @"capability";
NSString *const kSubEquiEspecialAssetAbility = @"asset_ability";
NSString *const kSubEquiEspecialAbilityId = @"ability_id";
@interface SubEquiEspecial ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SubEquiEspecial

@synthesize createdDate = _createdDate;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize isDelete = _isDelete;
@synthesize esName = _esName;
@synthesize modifiedDate = _modifiedDate;
@synthesize isTest = _isTest;


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
            self.createdDate = [self objectOrNilForKey:kSubEquiEspecialCreatedDate fromDictionary:dict];
            self.internalBaseClassIdentifier = [self objectOrNilForKey:kSubEquiEspecialId fromDictionary:dict];
            self.isDelete = [self objectOrNilForKey:kSubEquiEspecialIsDelete fromDictionary:dict];
            self.esName = [self objectOrNilForKey:kSubEquiEspecialEsName fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kSubEquiEspecialModifiedDate fromDictionary:dict];
            self.isTest = [self objectOrNilForKey:kSubEquiEspecialIsTest fromDictionary:dict];
        self.parentId = [self objectOrNilForKey:kSubEquiparentId fromDictionary:dict];
        self.capability = [self objectOrNilForKey:kSubEquicapability fromDictionary:dict];
        NSObject *receivedAssetAbility = [dict objectForKey:kSubEquiEspecialAssetAbility];
        NSMutableArray *parsedAssetAbility = [NSMutableArray array];
        if ([receivedAssetAbility isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedAssetAbility) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedAssetAbility addObject:[AssetAbility modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedAssetAbility isKindOfClass:[NSDictionary class]]) {
            [parsedAssetAbility addObject:[AssetAbility modelObjectWithDictionary:(NSDictionary *)receivedAssetAbility]];
        }
        
        self.assetAbility = [NSArray arrayWithArray:parsedAssetAbility];
         self.abilityId = [self objectOrNilForKey:kSubEquiEspecialAbilityId fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kSubEquiEspecialCreatedDate];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kSubEquiEspecialId];
    [mutableDict setValue:self.isDelete forKey:kSubEquiEspecialIsDelete];
    [mutableDict setValue:self.esName forKey:kSubEquiEspecialEsName];
    [mutableDict setValue:self.modifiedDate forKey:kSubEquiEspecialModifiedDate];
    [mutableDict setValue:self.isTest forKey:kSubEquiEspecialIsTest];
 [mutableDict setValue:self.parentId forKey:kSubEquiparentId];
    [mutableDict setValue:self.capability forKey:kSubEquicapability];
    NSMutableArray *tempArrayForAssetAbility = [NSMutableArray array];
    for (NSObject *subArrayObject in self.assetAbility) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAssetAbility addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAssetAbility addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAssetAbility] forKey:kSubEquiEspecialAssetAbility];
    [mutableDict setValue:self.abilityId forKey:kSubEquiEspecialAbilityId];
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
