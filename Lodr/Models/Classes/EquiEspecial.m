//
//  EquiEspecial.m
//
//  Created by Payal Umraliya  on 30/03/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "EquiEspecial.h"


NSString *const kEquiEspecialCreatedDate = @"created_date";
NSString *const kEquiEspecialId = @"id";
NSString *const kEquiEspecialEName = @"e_name";
NSString *const kEquiEspecialIsTest = @"is_test";
NSString *const kEquiEspecialModifiedDate = @"modified_date";
NSString *const kEquiEspecialIsDelete = @"is_delete";


@interface EquiEspecial ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EquiEspecial

@synthesize createdDate = _createdDate;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize eName = _eName;
@synthesize isTest = _isTest;
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
            self.createdDate = [self objectOrNilForKey:kEquiEspecialCreatedDate fromDictionary:dict];
            self.internalBaseClassIdentifier = [self objectOrNilForKey:kEquiEspecialId fromDictionary:dict];
            self.eName = [self objectOrNilForKey:kEquiEspecialEName fromDictionary:dict];
            self.isTest = [self objectOrNilForKey:kEquiEspecialIsTest fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kEquiEspecialModifiedDate fromDictionary:dict];
            self.isDelete = [self objectOrNilForKey:kEquiEspecialIsDelete fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kEquiEspecialCreatedDate];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kEquiEspecialId];
    [mutableDict setValue:self.eName forKey:kEquiEspecialEName];
    [mutableDict setValue:self.isTest forKey:kEquiEspecialIsTest];
    [mutableDict setValue:self.modifiedDate forKey:kEquiEspecialModifiedDate];
    [mutableDict setValue:self.isDelete forKey:kEquiEspecialIsDelete];

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
