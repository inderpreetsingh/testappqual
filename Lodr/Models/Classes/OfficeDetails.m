//
//  OfficeDetails.m
//
//  Created by C205  on 03/01/19
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "OfficeDetails.h"


NSString *const kOfficeDetailsOfficeLongitude = @"office_longitude";
NSString *const kOfficeDetailsOfficeFaxNo = @"office_fax_no";
NSString *const kOfficeDetailsOfficeAddress = @"office_address";
NSString *const kOfficeDetailsOfficeName = @"office_name";
NSString *const kOfficeDetailsOfficePhoneNo = @"office_phone_no";
NSString *const kOfficeDetailsOfficeLatitude = @"office_latitude";
NSString *const kOfficeDetailsAdminId = @"admin_id";
NSString *const kOfficeDetailsCompanyId = @"company_id";
NSString *const kOfficeDetailsOfficeId = @"office_id";


@interface OfficeDetails ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OfficeDetails

@synthesize officeLongitude = _officeLongitude;
@synthesize officeFaxNo = _officeFaxNo;
@synthesize officeAddress = _officeAddress;
@synthesize officeName = _officeName;
@synthesize officePhoneNo = _officePhoneNo;
@synthesize officeLatitude = _officeLatitude;
@synthesize adminId = _adminId;
@synthesize companyId = _companyId;
@synthesize officeId = _officeId;


+ (OfficeDetails *)modelObjectWithDictionary:(NSDictionary *)dict
{
    OfficeDetails *instance = [[OfficeDetails alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.officeLongitude = [self objectOrNilForKey:kOfficeDetailsOfficeLongitude fromDictionary:dict];
            self.officeFaxNo = [self objectOrNilForKey:kOfficeDetailsOfficeFaxNo fromDictionary:dict];
            self.officeAddress = [self objectOrNilForKey:kOfficeDetailsOfficeAddress fromDictionary:dict];
            self.officeName = [self objectOrNilForKey:kOfficeDetailsOfficeName fromDictionary:dict];
            self.officePhoneNo = [self objectOrNilForKey:kOfficeDetailsOfficePhoneNo fromDictionary:dict];
            self.officeLatitude = [self objectOrNilForKey:kOfficeDetailsOfficeLatitude fromDictionary:dict];
        self.adminId = [[self objectOrNilForKey:kOfficeDetailsAdminId fromDictionary:dict] doubleValue];
        self.companyId = [[self objectOrNilForKey:kOfficeDetailsCompanyId fromDictionary:dict] doubleValue];
        self.officeId = [[self objectOrNilForKey:kOfficeDetailsOfficeId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.officeLongitude forKey:kOfficeDetailsOfficeLongitude];
    [mutableDict setValue:self.officeFaxNo forKey:kOfficeDetailsOfficeFaxNo];
    [mutableDict setValue:self.officeAddress forKey:kOfficeDetailsOfficeAddress];
    [mutableDict setValue:self.officeName forKey:kOfficeDetailsOfficeName];
    [mutableDict setValue:self.officePhoneNo forKey:kOfficeDetailsOfficePhoneNo];
    [mutableDict setValue:self.officeLatitude forKey:kOfficeDetailsOfficeLatitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.adminId] forKey:kOfficeDetailsAdminId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.companyId] forKey:kOfficeDetailsCompanyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.officeId] forKey:kOfficeDetailsOfficeId];

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

    self.officeLongitude = [aDecoder decodeObjectForKey:kOfficeDetailsOfficeLongitude];
    self.officeFaxNo = [aDecoder decodeObjectForKey:kOfficeDetailsOfficeFaxNo];
    self.officeAddress = [aDecoder decodeObjectForKey:kOfficeDetailsOfficeAddress];
    self.officeName = [aDecoder decodeObjectForKey:kOfficeDetailsOfficeName];
    self.officePhoneNo = [aDecoder decodeObjectForKey:kOfficeDetailsOfficePhoneNo];
    self.officeLatitude = [aDecoder decodeObjectForKey:kOfficeDetailsOfficeLatitude];
    self.adminId = [aDecoder decodeDoubleForKey:kOfficeDetailsAdminId];
    self.companyId = [aDecoder decodeDoubleForKey:kOfficeDetailsCompanyId];
    self.officeId = [aDecoder decodeDoubleForKey:kOfficeDetailsOfficeId];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_officeLongitude forKey:kOfficeDetailsOfficeLongitude];
    [aCoder encodeObject:_officeFaxNo forKey:kOfficeDetailsOfficeFaxNo];
    [aCoder encodeObject:_officeAddress forKey:kOfficeDetailsOfficeAddress];
    [aCoder encodeObject:_officeName forKey:kOfficeDetailsOfficeName];
    [aCoder encodeObject:_officePhoneNo forKey:kOfficeDetailsOfficePhoneNo];
    [aCoder encodeObject:_officeLatitude forKey:kOfficeDetailsOfficeLatitude];
    [aCoder encodeDouble:_adminId forKey:kOfficeDetailsAdminId];
    [aCoder encodeDouble:_companyId forKey:kOfficeDetailsCompanyId];
    [aCoder encodeDouble:_officeId forKey:kOfficeDetailsOfficeId];

}


@end
