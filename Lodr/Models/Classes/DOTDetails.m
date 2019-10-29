//
//  DOTDetails.m
//
//  Created by Payal Umraliya  on 27/03/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "DOTDetails.h"


NSString *const kDOTDetailsPhyStreet = @"phyStreet";
NSString *const kDOTDetailsPhyCity = @"phyCity";
NSString *const kDOTDetailsDotNumber = @"dotNumber";
NSString *const kDOTDetailsDotAddress = @"dotAddress";
NSString *const kDOTDetailsMcNumber = @"mcNumber";
NSString *const kDOTDetailsLegalName = @"legalName";
NSString *const kDOTDetailsPhyState = @"phyState";
NSString *const kDOTDetailsPhyZipcode = @"phyZipcode";
NSString *const kDOTDetailsPhyCountry = @"phyCountry";
NSString *const kDOTDetailsPhoneNumber = @"phoneNumber";
NSString *const kDOTDetailsOs = @"OperatingStatus";

@interface DOTDetails ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DOTDetails

@synthesize phyStreet = _phyStreet;
@synthesize phyCity = _phyCity;
@synthesize dotNumber = _dotNumber;
@synthesize dotAddress = _dotAddress;
@synthesize mcNumber = _mcNumber;
@synthesize legalName = _legalName;
@synthesize phyState = _phyState;
@synthesize phyZipcode = _phyZipcode;
@synthesize phyCountry = _phyCountry;
@synthesize phoneNumber = _phoneNumber;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self && [dict isKindOfClass:[NSDictionary class]]) 
    {
        self.phyStreet = [self objectOrNilForKey:kDOTDetailsPhyStreet fromDictionary:dict];
        self.phyCity = [self objectOrNilForKey:kDOTDetailsPhyCity fromDictionary:dict];
        self.dotNumber = [self objectOrNilForKey:kDOTDetailsDotNumber fromDictionary:dict];
        self.dotAddress = [self objectOrNilForKey:kDOTDetailsDotAddress fromDictionary:dict];
        self.mcNumber = [self objectOrNilForKey:kDOTDetailsMcNumber fromDictionary:dict];
        self.legalName = [self objectOrNilForKey:kDOTDetailsLegalName fromDictionary:dict];
        self.phyState = [self objectOrNilForKey:kDOTDetailsPhyState fromDictionary:dict];
        self.phyZipcode = [self objectOrNilForKey:kDOTDetailsPhyZipcode fromDictionary:dict];
        self.phyCountry = [self objectOrNilForKey:kDOTDetailsPhyCountry fromDictionary:dict];
        self.phoneNumber = [self objectOrNilForKey:kDOTDetailsPhoneNumber fromDictionary:dict];
        self.operatingStatus = [self objectOrNilForKey:kDOTDetailsOs fromDictionary:dict];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.phyStreet forKey:kDOTDetailsPhyStreet];
    [mutableDict setValue:self.phyCity forKey:kDOTDetailsPhyCity];
    [mutableDict setValue:self.dotNumber forKey:kDOTDetailsDotNumber];
    [mutableDict setValue:self.dotAddress forKey:kDOTDetailsDotAddress];
    [mutableDict setValue:self.mcNumber forKey:kDOTDetailsMcNumber];
    [mutableDict setValue:self.legalName forKey:kDOTDetailsLegalName];
    [mutableDict setValue:self.phyState forKey:kDOTDetailsPhyState];
    [mutableDict setValue:self.phyZipcode forKey:kDOTDetailsPhyZipcode];
    [mutableDict setValue:self.phyCountry forKey:kDOTDetailsPhyCountry];
    [mutableDict setValue:self.phoneNumber forKey:kDOTDetailsPhoneNumber];
    [mutableDict setValue:self.operatingStatus forKey:kDOTDetailsOs];
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
