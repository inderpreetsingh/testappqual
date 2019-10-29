//
//  Drivers.m
//
//  Created by c196  on 03/06/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Drivers.h"


NSString *const kDriversCreatedDate = @"created_date";
NSString *const kDriversDriverLatitude = @"driver_latitude";
NSString *const kDriversDriverLongitude = @"driver_longitude";
NSString *const kDriversId = @"id";
NSString *const kDriversDutyStatus = @"duty_status";
NSString *const kDriversIsDelete = @"is_delete";
NSString *const kDriversModifiedDate = @"modified_date";
NSString *const kDriversIsTest = @"is_test";
NSString *const kDriversUserId = @"user_id";
NSString *const kDriversLastLocation = @"last_location";
NSString *const kDriversUserprefId = @"userpref_id";


@interface Drivers ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Drivers

@synthesize createdDate = _createdDate;
@synthesize driverLatitude = _driverLatitude;
@synthesize driverLongitude = _driverLongitude;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize dutyStatus = _dutyStatus;
@synthesize isDelete = _isDelete;
@synthesize modifiedDate = _modifiedDate;
@synthesize isTest = _isTest;
@synthesize userId = _userId;
@synthesize lastLocation = _lastLocation;
@synthesize userprefId = _userprefId;


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
            self.createdDate = [self objectOrNilForKey:kDriversCreatedDate fromDictionary:dict];
            self.driverLatitude = [self objectOrNilForKey:kDriversDriverLatitude fromDictionary:dict];
            self.driverLongitude = [self objectOrNilForKey:kDriversDriverLongitude fromDictionary:dict];
            self.internalBaseClassIdentifier = [self objectOrNilForKey:kDriversId fromDictionary:dict];
            self.dutyStatus = [self objectOrNilForKey:kDriversDutyStatus fromDictionary:dict];
            self.isDelete = [self objectOrNilForKey:kDriversIsDelete fromDictionary:dict] ;
            self.modifiedDate = [self objectOrNilForKey:kDriversModifiedDate fromDictionary:dict];
            self.isTest = [self objectOrNilForKey:kDriversIsTest fromDictionary:dict];
            self.userId =[self objectOrNilForKey:kDriversUserId fromDictionary:dict];
            self.lastLocation = [self objectOrNilForKey:kDriversLastLocation fromDictionary:dict];
        self.userprefId = [self objectOrNilForKey:kDriversUserprefId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kDriversCreatedDate];
    [mutableDict setValue:self.driverLatitude forKey:kDriversDriverLatitude];
    [mutableDict setValue:self.driverLongitude forKey:kDriversDriverLongitude];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kDriversId];
    [mutableDict setValue:self.dutyStatus forKey:kDriversDutyStatus];
    [mutableDict setValue:self.isDelete forKey:kDriversIsDelete];
    [mutableDict setValue:self.modifiedDate forKey:kDriversModifiedDate];
    [mutableDict setValue:self.isTest forKey:kDriversIsTest];
    [mutableDict setValue:self.userId forKey:kDriversUserId];
    [mutableDict setValue:self.lastLocation forKey:kDriversLastLocation];
    [mutableDict setValue:self.userprefId forKey:kDriversUserprefId];

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

    self.createdDate = [aDecoder decodeObjectForKey:kDriversCreatedDate];
    self.driverLatitude = [aDecoder decodeObjectForKey:kDriversDriverLatitude];
    self.driverLongitude = [aDecoder decodeObjectForKey:kDriversDriverLongitude];
    self.internalBaseClassIdentifier = [aDecoder decodeObjectForKey:kDriversId];
    self.dutyStatus = [aDecoder decodeObjectForKey:kDriversDutyStatus];
    self.isDelete = [aDecoder decodeObjectForKey:kDriversIsDelete];
    self.modifiedDate = [aDecoder decodeObjectForKey:kDriversModifiedDate];
    self.isTest = [aDecoder decodeObjectForKey:kDriversIsTest];
    self.userId = [aDecoder decodeObjectForKey:kDriversUserId];
    self.lastLocation = [aDecoder decodeObjectForKey:kDriversLastLocation];
    self.userprefId = [aDecoder decodeObjectForKey:kDriversUserprefId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kDriversCreatedDate];
    [aCoder encodeObject:_driverLatitude forKey:kDriversDriverLatitude];
    [aCoder encodeObject:_driverLongitude forKey:kDriversDriverLongitude];
    [aCoder encodeObject:_internalBaseClassIdentifier forKey:kDriversId];
    [aCoder encodeObject:_dutyStatus forKey:kDriversDutyStatus];
    [aCoder encodeObject:_isDelete forKey:kDriversIsDelete];
    [aCoder encodeObject:_modifiedDate forKey:kDriversModifiedDate];
    [aCoder encodeObject:_isTest forKey:kDriversIsTest];
    [aCoder encodeObject:_userId forKey:kDriversUserId];
    [aCoder encodeObject:_lastLocation forKey:kDriversLastLocation];
    [aCoder encodeObject:_userprefId forKey:kDriversUserprefId];
}

- (id)copyWithZone:(NSZone *)zone
{
    Drivers *copy = [[Drivers alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.driverLatitude = [self.driverLatitude copyWithZone:zone];
        copy.driverLongitude = [self.driverLongitude copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.dutyStatus = [self.dutyStatus copyWithZone:zone];
        copy.isDelete = self.isDelete;
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.isTest = self.isTest;
        copy.userId = self.userId;
        copy.lastLocation = [self.lastLocation copyWithZone:zone];
        copy.userprefId = self.userprefId;
    }
    
    return copy;
}


@end
