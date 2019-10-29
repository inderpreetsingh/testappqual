//
//  Medialist.m
//
//  Created by Payal Umraliya  on 17/04/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Medialist.h"


NSString *const kMedialistCreatedDate = @"created_date";
NSString *const kMedialistIsTest = @"is_test";
NSString *const kMedialistId = @"id";
NSString *const kMedialistMediaName = @"media_name";
NSString *const kMedialistMediaType = @"media_type";
NSString *const kMedialistIsDelete = @"is_delete";
NSString *const kMedialistParentId = @"parent_id";


@interface Medialist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Medialist

@synthesize createdDate = _createdDate;
@synthesize isTest = _isTest;
@synthesize medialistIdentifier = _medialistIdentifier;
@synthesize mediaName = _mediaName;
@synthesize mediaType = _mediaType;
@synthesize isDelete = _isDelete;
@synthesize parentId = _parentId;


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
            self.createdDate = [self objectOrNilForKey:kMedialistCreatedDate fromDictionary:dict];
            self.isTest = [self objectOrNilForKey:kMedialistIsTest fromDictionary:dict];
            self.medialistIdentifier = [self objectOrNilForKey:kMedialistId fromDictionary:dict];
            self.mediaName = [self objectOrNilForKey:kMedialistMediaName fromDictionary:dict];
            self.mediaType = [self objectOrNilForKey:kMedialistMediaType fromDictionary:dict];
            self.isDelete = [self objectOrNilForKey:kMedialistIsDelete fromDictionary:dict];
            self.parentId = [self objectOrNilForKey:kMedialistParentId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kMedialistCreatedDate];
    [mutableDict setValue:self.isTest forKey:kMedialistIsTest];
    [mutableDict setValue:self.medialistIdentifier forKey:kMedialistId];
    [mutableDict setValue:self.mediaName forKey:kMedialistMediaName];
    [mutableDict setValue:self.mediaType forKey:kMedialistMediaType];
    [mutableDict setValue:self.isDelete forKey:kMedialistIsDelete];
    [mutableDict setValue:self.parentId forKey:kMedialistParentId];

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

    self.createdDate = [aDecoder decodeObjectForKey:kMedialistCreatedDate];
    self.isTest = [aDecoder decodeObjectForKey:kMedialistIsTest];
    self.medialistIdentifier = [aDecoder decodeObjectForKey:kMedialistId];
    self.mediaName = [aDecoder decodeObjectForKey:kMedialistMediaName];
    self.mediaType = [aDecoder decodeObjectForKey:kMedialistMediaType];
    self.isDelete = [aDecoder decodeObjectForKey:kMedialistIsDelete];
    self.parentId = [aDecoder decodeObjectForKey:kMedialistParentId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kMedialistCreatedDate];
    [aCoder encodeObject:_isTest forKey:kMedialistIsTest];
    [aCoder encodeObject:_medialistIdentifier forKey:kMedialistId];
    [aCoder encodeObject:_mediaName forKey:kMedialistMediaName];
    [aCoder encodeObject:_mediaType forKey:kMedialistMediaType];
    [aCoder encodeObject:_isDelete forKey:kMedialistIsDelete];
    [aCoder encodeObject:_parentId forKey:kMedialistParentId];
}

- (id)copyWithZone:(NSZone *)zone
{
    Medialist *copy = [[Medialist alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.isTest = [self.isTest copyWithZone:zone];
        copy.medialistIdentifier = [self.medialistIdentifier copyWithZone:zone];
        copy.mediaName = [self.mediaName copyWithZone:zone];
        copy.mediaType = [self.mediaType copyWithZone:zone];
        copy.isDelete = [self.isDelete copyWithZone:zone];
        copy.parentId = [self.parentId copyWithZone:zone];
    }
    
    return copy;
}


@end
