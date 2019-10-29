//
//  MyNetwork.m
//
//  Created by c196  on 08/06/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "MyNetwork.h"
#import "Matches.h"


NSString *const kMyNetworkIsDelete = @"is_delete";
NSString *const kMyNetworkCreatedDate = @"created_date";
NSString *const kMyNetworkId = @"id";
NSString *const kMyNetworkUserLatitude = @"user_latitude";
NSString *const kMyNetworkCountry = @"country";
NSString *const kMyNetworkCompanyAddress = @"company_address";
NSString *const kMyNetworkUserprefId = @"userpref_id";
NSString *const kMyNetworkState = @"state";
NSString *const kMyNetworkModifiedDate = @"modified_date";
NSString *const kMyNetworkMcNumber = @"mc_number";
NSString *const kMyNetworkPrimaryEmailId = @"primary_email_id";
NSString *const kMyNetworkUserName = @"user_name";
NSString *const kMyNetworkOpentime = @"opentime";
NSString *const kMyNetworkOfficeAddress = @"office_address";
NSString *const kMyNetworkOfficePhoneNo = @"office_phone_no";
NSString *const kMyNetworkIsTest = @"is_test";
NSString *const kMyNetworkRole = @"role";
NSString *const kMyNetworkSecondaryEmailId = @"secondary_email_id";
NSString *const kMyNetworkOfficeLongitude = @"office_longitude";
NSString *const kMyNetworkUserLongitude = @"user_longitude";
NSString *const kMyNetworkOfficeFaxNo = @"office_fax_no";
NSString *const kMyNetworkCmpnyPhoneNo = @"cmpny_phone_no";
NSString *const kMyNetworkOfficeName = @"office_name";
NSString *const kMyNetworkMatches = @"matches";
NSString *const kMyNetworkCity = @"city";
NSString *const kMyNetworkProfilePicture = @"profile_picture";
NSString *const kMyNetworkCompanyLongitude = @"company_longitude";
NSString *const kMyNetworkClosetime = @"closetime";
NSString *const kMyNetworkUserId = @"user_id";
NSString *const kMyNetworkLastname = @"lastname";
NSString *const kMyNetworkDriverId = @"driver_id";
NSString *const kMyNetworkDotNumber = @"dot_number";
NSString *const kMyNetworkCompanyLatitude = @"company_latitude";
NSString *const kMyNetworkFirstname = @"firstname";
NSString *const kMyNetworkOfficeLatitude = @"office_latitude";
NSString *const kMyNetworkCompanyName = @"company_name";
NSString *const kMyNetworkPhoneNo = @"phone_no";
NSString *const kMyNetworkOP = @"operating_address";
NSString *const kMyNetworkcs = @"company_street";
NSString *const kMyNetworkcz = @"company_zip";

@interface MyNetwork ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MyNetwork

@synthesize isDelete = _isDelete;
@synthesize createdDate = _createdDate;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize userLatitude = _userLatitude;
@synthesize country = _country;
@synthesize companyAddress = _companyAddress;
@synthesize userprefId = _userprefId;
@synthesize state = _state;
@synthesize modifiedDate = _modifiedDate;
@synthesize mcNumber = _mcNumber;
@synthesize primaryEmailId = _primaryEmailId;
@synthesize userName = _userName;
@synthesize opentime = _opentime;
@synthesize officeAddress = _officeAddress;
@synthesize officePhoneNo = _officePhoneNo;
@synthesize isTest = _isTest;
@synthesize role = _role;
@synthesize secondaryEmailId = _secondaryEmailId;
@synthesize officeLongitude = _officeLongitude;
@synthesize userLongitude = _userLongitude;
@synthesize officeFaxNo = _officeFaxNo;
@synthesize cmpnyPhoneNo = _cmpnyPhoneNo;
@synthesize officeName = _officeName;
@synthesize matches = _matches;
@synthesize city = _city;
@synthesize profilePicture = _profilePicture;
@synthesize companyLongitude = _companyLongitude;
@synthesize closetime = _closetime;
@synthesize userId = _userId;
@synthesize lastname = _lastname;
@synthesize driverId = _driverId;
@synthesize dotNumber = _dotNumber;
@synthesize companyLatitude = _companyLatitude;
@synthesize firstname = _firstname;
@synthesize officeLatitude = _officeLatitude;
@synthesize companyName = _companyName;
@synthesize phoneNo = _phoneNo;


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
        self.isDelete = [self objectOrNilForKey:kMyNetworkIsDelete fromDictionary:dict];
        self.createdDate = [self objectOrNilForKey:kMyNetworkCreatedDate fromDictionary:dict];
        self.internalBaseClassIdentifier = [self objectOrNilForKey:kMyNetworkId fromDictionary:dict];
        self.userLatitude = [self objectOrNilForKey:kMyNetworkUserLatitude fromDictionary:dict];
        self.country = [self objectOrNilForKey:kMyNetworkCountry fromDictionary:dict];
        self.companyAddress = [self objectOrNilForKey:kMyNetworkCompanyAddress fromDictionary:dict];
        self.userprefId = [self objectOrNilForKey:kMyNetworkUserprefId fromDictionary:dict];
        self.state = [self objectOrNilForKey:kMyNetworkState fromDictionary:dict];
        self.modifiedDate = [self objectOrNilForKey:kMyNetworkModifiedDate fromDictionary:dict];
        self.mcNumber = [self objectOrNilForKey:kMyNetworkMcNumber fromDictionary:dict];
        self.primaryEmailId = [self objectOrNilForKey:kMyNetworkPrimaryEmailId fromDictionary:dict];
        self.userName = [self objectOrNilForKey:kMyNetworkUserName fromDictionary:dict];
        self.opentime = [self objectOrNilForKey:kMyNetworkOpentime fromDictionary:dict];
        self.officeAddress = [self objectOrNilForKey:kMyNetworkOfficeAddress fromDictionary:dict];
        self.officePhoneNo = [self objectOrNilForKey:kMyNetworkOfficePhoneNo fromDictionary:dict];
        self.isTest = [self objectOrNilForKey:kMyNetworkIsTest fromDictionary:dict];
        self.role = [self objectOrNilForKey:kMyNetworkRole fromDictionary:dict];
        self.secondaryEmailId = [self objectOrNilForKey:kMyNetworkSecondaryEmailId fromDictionary:dict];
        self.officeLongitude = [self objectOrNilForKey:kMyNetworkOfficeLongitude fromDictionary:dict];
        self.userLongitude = [self objectOrNilForKey:kMyNetworkUserLongitude fromDictionary:dict];
        self.officeFaxNo = [self objectOrNilForKey:kMyNetworkOfficeFaxNo fromDictionary:dict];
        self.cmpnyPhoneNo = [self objectOrNilForKey:kMyNetworkCmpnyPhoneNo fromDictionary:dict];
        self.officeName = [self objectOrNilForKey:kMyNetworkOfficeName fromDictionary:dict];
        NSObject *receivedMatches = [dict objectForKey:kMyNetworkMatches];
        NSMutableArray *parsedMatches = [NSMutableArray array];
        if ([receivedMatches isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedMatches) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedMatches addObject:[Matches modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedMatches isKindOfClass:[NSDictionary class]]) {
            [parsedMatches addObject:[Matches modelObjectWithDictionary:(NSDictionary *)receivedMatches]];
        }
        
        self.matches = [NSArray arrayWithArray:parsedMatches];
        self.city = [self objectOrNilForKey:kMyNetworkCity fromDictionary:dict];
        self.profilePicture = [self objectOrNilForKey:kMyNetworkProfilePicture fromDictionary:dict];
        self.companyLongitude = [self objectOrNilForKey:kMyNetworkCompanyLongitude fromDictionary:dict];
        self.closetime = [self objectOrNilForKey:kMyNetworkClosetime fromDictionary:dict];
        self.userId = [self objectOrNilForKey:kMyNetworkUserId fromDictionary:dict];
        self.lastname = [self objectOrNilForKey:kMyNetworkLastname fromDictionary:dict];
        self.driverId = [self objectOrNilForKey:kMyNetworkDriverId fromDictionary:dict];
        self.dotNumber = [self objectOrNilForKey:kMyNetworkDotNumber fromDictionary:dict];
        self.companyLatitude = [self objectOrNilForKey:kMyNetworkCompanyLatitude fromDictionary:dict];
        self.firstname = [self objectOrNilForKey:kMyNetworkFirstname fromDictionary:dict];
        self.officeLatitude = [self objectOrNilForKey:kMyNetworkOfficeLatitude fromDictionary:dict];
        self.companyName = [self objectOrNilForKey:kMyNetworkCompanyName fromDictionary:dict];
        self.phoneNo = [self objectOrNilForKey:kMyNetworkPhoneNo fromDictionary:dict];
         self.operatingAddress = [self objectOrNilForKey:kMyNetworkOP fromDictionary:dict];
        self.companyStreet=[self objectOrNilForKey:kMyNetworkcs fromDictionary:dict];
        self.companyZip=[self objectOrNilForKey:kMyNetworkcz fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isDelete forKey:kMyNetworkIsDelete];
    [mutableDict setValue:self.createdDate forKey:kMyNetworkCreatedDate];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kMyNetworkId];
    [mutableDict setValue:self.userLatitude forKey:kMyNetworkUserLatitude];
    [mutableDict setValue:self.country forKey:kMyNetworkCountry];
    [mutableDict setValue:self.companyAddress forKey:kMyNetworkCompanyAddress];
    [mutableDict setValue:self.userprefId forKey:kMyNetworkUserprefId];
    [mutableDict setValue:self.state forKey:kMyNetworkState];
    [mutableDict setValue:self.modifiedDate forKey:kMyNetworkModifiedDate];
    [mutableDict setValue:self.mcNumber forKey:kMyNetworkMcNumber];
    [mutableDict setValue:self.primaryEmailId forKey:kMyNetworkPrimaryEmailId];
    [mutableDict setValue:self.userName forKey:kMyNetworkUserName];
    [mutableDict setValue:self.opentime forKey:kMyNetworkOpentime];
    [mutableDict setValue:self.officeAddress forKey:kMyNetworkOfficeAddress];
    [mutableDict setValue:self.officePhoneNo forKey:kMyNetworkOfficePhoneNo];
    [mutableDict setValue:self.isTest forKey:kMyNetworkIsTest];
    [mutableDict setValue:self.role forKey:kMyNetworkRole];
    [mutableDict setValue:self.secondaryEmailId forKey:kMyNetworkSecondaryEmailId];
    [mutableDict setValue:self.officeLongitude forKey:kMyNetworkOfficeLongitude];
    [mutableDict setValue:self.userLongitude forKey:kMyNetworkUserLongitude];
    [mutableDict setValue:self.officeFaxNo forKey:kMyNetworkOfficeFaxNo];
    [mutableDict setValue:self.cmpnyPhoneNo forKey:kMyNetworkCmpnyPhoneNo];
    [mutableDict setValue:self.officeName forKey:kMyNetworkOfficeName];
    NSMutableArray *tempArrayForMatches = [NSMutableArray array];
    for (NSObject *subArrayObject in self.matches) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMatches addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMatches addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMatches] forKey:kMyNetworkMatches];
    [mutableDict setValue:self.city forKey:kMyNetworkCity];
    [mutableDict setValue:self.profilePicture forKey:kMyNetworkProfilePicture];
    [mutableDict setValue:self.companyLongitude forKey:kMyNetworkCompanyLongitude];
    [mutableDict setValue:self.closetime forKey:kMyNetworkClosetime];
    [mutableDict setValue:self.userId forKey:kMyNetworkUserId];
    [mutableDict setValue:self.lastname forKey:kMyNetworkLastname];
    [mutableDict setValue:self.driverId forKey:kMyNetworkDriverId];
    [mutableDict setValue:self.dotNumber forKey:kMyNetworkDotNumber];
    [mutableDict setValue:self.companyLatitude forKey:kMyNetworkCompanyLatitude];
    [mutableDict setValue:self.firstname forKey:kMyNetworkFirstname];
    [mutableDict setValue:self.officeLatitude forKey:kMyNetworkOfficeLatitude];
    [mutableDict setValue:self.companyName forKey:kMyNetworkCompanyName];
    [mutableDict setValue:self.phoneNo forKey:kMyNetworkPhoneNo];
      [mutableDict setValue:self.operatingAddress forKey:kMyNetworkOP];
    [mutableDict setValue:self.companyZip forKey:kMyNetworkcz];
    [mutableDict setValue:self.companyStreet forKey:kMyNetworkcs];
    
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
