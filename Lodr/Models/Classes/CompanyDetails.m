//
//  CompanyDetails.m
//
//  Created by C205  on 18/12/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "CompanyDetails.h"
#import "OfficeDetails.h"

NSString *const kCompanyDetailsCompanyName = @"company_name";
NSString *const kCompanyDetailsCompanyLongitude = @"company_longitude";
NSString *const kCompanyDetailsCmpnyPhoneNo = @"cmpny_phone_no";
NSString *const kCompanyDetailsCompanyLatitude = @"company_latitude";
NSString *const kCompanyDetailsCompanyAddress = @"company_address";
NSString *const kCompanyDetailsCity = @"city";
NSString *const kCompanyDetailsState = @"state";
NSString *const kCompanyDetailsCountry = @"country";
NSString *const kCompanyDetailsCompanyStreet = @"company_street";
NSString *const kCompanyDetailsCompanyZip = @"company_zip";
NSString *const kCompanyDetailsCompanyId = @"company_id";
NSString *const kCompanyDetailsAdminId = @"admin_id";
NSString *const kCompanyDetailsIsAdmin = @"is_admin";
NSString *const kCompanyDetailsOfficeDetails = @"OfficeDetails";



@interface CompanyDetails ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CompanyDetails

@synthesize companyName = _companyName;
@synthesize companyLongitude = _companyLongitude;
@synthesize cmpnyPhoneNo = _cmpnyPhoneNo;
@synthesize companyLatitude = _companyLatitude;
@synthesize companyAddress = _companyAddress;
@synthesize officeDetails = _officeDetails;
@synthesize city = _city;
@synthesize state = _state;
@synthesize country = _country;
@synthesize companyStreet = _companyStreet;
@synthesize companyZip = _companyZip;
@synthesize companyId = _companyId;
@synthesize adminId = _adminId;
@synthesize isAdmin = _isAdmin;


+ (CompanyDetails *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CompanyDetails *instance = [[CompanyDetails alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.companyName = [self objectOrNilForKey:kCompanyDetailsCompanyName fromDictionary:dict];
            self.companyLongitude = [self objectOrNilForKey:kCompanyDetailsCompanyLongitude fromDictionary:dict];
            self.cmpnyPhoneNo = [self objectOrNilForKey:kCompanyDetailsCmpnyPhoneNo fromDictionary:dict];
            self.companyLatitude = [self objectOrNilForKey:kCompanyDetailsCompanyLatitude fromDictionary:dict];
            self.companyAddress = [self objectOrNilForKey:kCompanyDetailsCompanyAddress fromDictionary:dict];
        self.companyId = [[self objectOrNilForKey:kCompanyDetailsCompanyId fromDictionary:dict] doubleValue];
        self.adminId = [[self objectOrNilForKey:kCompanyDetailsAdminId fromDictionary:dict] doubleValue];
        NSObject *receivedOfficeDetails = [dict objectForKey:kCompanyDetailsOfficeDetails];
        NSMutableArray *parsedOfficeDetails = [NSMutableArray array];
        if ([receivedOfficeDetails isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedOfficeDetails) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedOfficeDetails addObject:[OfficeDetails modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedOfficeDetails isKindOfClass:[NSDictionary class]]) {
            [parsedOfficeDetails addObject:[OfficeDetails modelObjectWithDictionary:(NSDictionary *)receivedOfficeDetails]];
        }
        
        self.officeDetails = [NSArray arrayWithArray:parsedOfficeDetails];

        self.city = [self objectOrNilForKey:kCompanyDetailsCity fromDictionary:dict];
        self.state = [self objectOrNilForKey:kCompanyDetailsState fromDictionary:dict];
        self.country = [self objectOrNilForKey:kCompanyDetailsCountry fromDictionary:dict];
        self.companyStreet = [self objectOrNilForKey:kCompanyDetailsCompanyStreet fromDictionary:dict];
        self.companyZip = [self objectOrNilForKey:kCompanyDetailsCompanyZip fromDictionary:dict];
        self.isAdmin = [[self objectOrNilForKey:kCompanyDetailsIsAdmin fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.companyName forKey:kCompanyDetailsCompanyName];
    [mutableDict setValue:self.companyLongitude forKey:kCompanyDetailsCompanyLongitude];
    [mutableDict setValue:self.cmpnyPhoneNo forKey:kCompanyDetailsCmpnyPhoneNo];
    [mutableDict setValue:self.companyLatitude forKey:kCompanyDetailsCompanyLatitude];
    [mutableDict setValue:self.companyAddress forKey:kCompanyDetailsCompanyAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.companyId] forKey:kCompanyDetailsCompanyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.adminId] forKey:kCompanyDetailsAdminId];
    NSMutableArray *tempArrayForOfficeDetails = [NSMutableArray array];
    for (NSObject *subArrayObject in self.officeDetails) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOfficeDetails addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOfficeDetails addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOfficeDetails] forKey:@"kCompanyDetailsOfficeDetails"];

    [mutableDict setValue:self.city forKey:kCompanyDetailsCity];
    [mutableDict setValue:self.state forKey:kCompanyDetailsState];
    [mutableDict setValue:self.country forKey:kCompanyDetailsCountry];
    [mutableDict setValue:self.companyStreet forKey:kCompanyDetailsCompanyStreet];
    [mutableDict setValue:self.companyZip forKey:kCompanyDetailsCompanyZip];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAdmin] forKey:kCompanyDetailsIsAdmin];

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

    self.companyName = [aDecoder decodeObjectForKey:kCompanyDetailsCompanyName];
    self.companyLongitude = [aDecoder decodeObjectForKey:kCompanyDetailsCompanyLongitude];
    self.cmpnyPhoneNo = [aDecoder decodeObjectForKey:kCompanyDetailsCmpnyPhoneNo];
    self.companyLatitude = [aDecoder decodeObjectForKey:kCompanyDetailsCompanyLatitude];
    self.companyAddress = [aDecoder decodeObjectForKey:kCompanyDetailsCompanyAddress];
    self.companyId = [aDecoder decodeDoubleForKey:kCompanyDetailsCompanyId];
    self.adminId = [aDecoder decodeDoubleForKey:kCompanyDetailsAdminId];
    self.officeDetails = [aDecoder decodeObjectForKey:kCompanyDetailsOfficeDetails];

    self.city = [aDecoder decodeObjectForKey:kCompanyDetailsCity];
    self.state = [aDecoder decodeObjectForKey:kCompanyDetailsState];
    self.country = [aDecoder decodeObjectForKey:kCompanyDetailsCountry];
    self.companyStreet = [aDecoder decodeObjectForKey:kCompanyDetailsCompanyStreet];
    self.companyZip = [aDecoder decodeObjectForKey:kCompanyDetailsCompanyZip];
    self.isAdmin = [aDecoder decodeDoubleForKey:kCompanyDetailsIsAdmin];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_companyName forKey:kCompanyDetailsCompanyName];
    [aCoder encodeObject:_companyLongitude forKey:kCompanyDetailsCompanyLongitude];
    [aCoder encodeObject:_cmpnyPhoneNo forKey:kCompanyDetailsCmpnyPhoneNo];
    [aCoder encodeObject:_companyLatitude forKey:kCompanyDetailsCompanyLatitude];
    [aCoder encodeObject:_companyAddress forKey:kCompanyDetailsCompanyAddress];
    [aCoder encodeDouble:_companyId forKey:kCompanyDetailsCompanyId];
    [aCoder encodeDouble:_adminId forKey:kCompanyDetailsAdminId];
    [aCoder encodeDouble:_isAdmin forKey:kCompanyDetailsIsAdmin];
    [aCoder encodeObject:_officeDetails forKey:kCompanyDetailsOfficeDetails];

    [aCoder encodeObject:_city forKey:kCompanyDetailsCity];
    [aCoder encodeObject:_state forKey:kCompanyDetailsState];
    [aCoder encodeObject:_country forKey:kCompanyDetailsCountry];
    [aCoder encodeObject:_companyStreet forKey:kCompanyDetailsCompanyStreet];
    [aCoder encodeObject:_companyZip forKey:kCompanyDetailsCompanyZip];
}


@end
