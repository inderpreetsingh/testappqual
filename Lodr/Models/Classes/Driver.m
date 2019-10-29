//
//  Driver.m
//
//  Created by C109  on 13/02/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "Driver.h"


NSString *const kDriverIsDelete = @"is_delete";
NSString *const kDriverCreatedDate = @"created_date";
NSString *const kDriverGoogleId = @"google_id";
NSString *const kDriverId = @"id";
NSString *const kDriverOperatingAddress = @"operating_address";
NSString *const kDriverUserLatitude = @"user_latitude";
NSString *const kDriverCountry = @"country";
NSString *const kDriverCompanyAddress = @"company_address";
NSString *const kDriverState = @"state";
NSString *const kDriverDotnumStatus = @"dotnum_status";
NSString *const kDriverModifiedDate = @"modified_date";
NSString *const kDriverMcNumber = @"mc_number";
NSString *const kDriverPrimaryEmailId = @"primary_email_id";
NSString *const kDriverUserName = @"user_name";
NSString *const kDriverOpentime = @"opentime";
NSString *const kDriverOfficeAddress = @"office_address";
NSString *const kDriverOfficePhoneNo = @"office_phone_no";
NSString *const kDriverIsTest = @"is_test";
NSString *const kDriverDeviceToken = @"device_token";
NSString *const kDriverRole = @"role";
NSString *const kDriverSecondaryEmailId = @"secondary_email_id";
NSString *const kDriverOfficeLongitude = @"office_longitude";
NSString *const kDriverTwitterId = @"twitter_id";
NSString *const kDriverCompanyStreet = @"company_street";
NSString *const kDriverOfficeFaxNo = @"office_fax_no";
NSString *const kDriverUserLongitude = @"user_longitude";
NSString *const kDriverAccesscode = @"accesscode";
NSString *const kDriverCmpnyPhoneNo = @"cmpny_phone_no";
NSString *const kDriverOfficeName = @"office_name";
NSString *const kDriverCity = @"city";
NSString *const kDriverCompanyZip = @"company_zip";
NSString *const kDriverProfilePicture = @"profile_picture";
NSString *const kDriverCompanyLongitude = @"company_longitude";
NSString *const kDriverClosetime = @"closetime";
NSString *const kDriverMatchRadius = @"match_radius";
NSString *const kDriverDeviceType = @"device_type";
NSString *const kDriverUserId = @"user_id";
NSString *const kDriverDriverId = @"driver_id";
NSString *const kDriverUserRole = @"user_role";
NSString *const kDriverDotNumber = @"dot_number";
NSString *const kDriverLastname = @"lastname";
NSString *const kDriverCompanyLatitude = @"company_latitude";
NSString *const kDriverFirstname = @"firstname";
NSString *const kDriverOfficeLatitude = @"office_latitude";
NSString *const kDriverFacebookId = @"facebook_id";
NSString *const kDriverIsVerified = @"is_verified";
NSString *const kDriverCompanyName = @"company_name";
NSString *const kDriverSecurePassword = @"secure_password";
NSString *const kDriverGuid = @"guid";
NSString *const kDriverPhoneNo = @"phone_no";


@interface Driver ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Driver

@synthesize isDelete = _isDelete;
@synthesize createdDate = _createdDate;
@synthesize googleId = _googleId;
@synthesize driverIdentifier = _driverIdentifier;
@synthesize operatingAddress = _operatingAddress;
@synthesize userLatitude = _userLatitude;
@synthesize country = _country;
@synthesize companyAddress = _companyAddress;
@synthesize state = _state;
@synthesize dotnumStatus = _dotnumStatus;
@synthesize modifiedDate = _modifiedDate;
@synthesize mcNumber = _mcNumber;
@synthesize primaryEmailId = _primaryEmailId;
@synthesize userName = _userName;
@synthesize opentime = _opentime;
@synthesize officeAddress = _officeAddress;
@synthesize officePhoneNo = _officePhoneNo;
@synthesize isTest = _isTest;
@synthesize deviceToken = _deviceToken;
@synthesize role = _role;
@synthesize secondaryEmailId = _secondaryEmailId;
@synthesize officeLongitude = _officeLongitude;
@synthesize twitterId = _twitterId;
@synthesize companyStreet = _companyStreet;
@synthesize officeFaxNo = _officeFaxNo;
@synthesize userLongitude = _userLongitude;
@synthesize accesscode = _accesscode;
@synthesize cmpnyPhoneNo = _cmpnyPhoneNo;
@synthesize officeName = _officeName;
@synthesize city = _city;
@synthesize companyZip = _companyZip;
@synthesize profilePicture = _profilePicture;
@synthesize companyLongitude = _companyLongitude;
@synthesize closetime = _closetime;
@synthesize matchRadius = _matchRadius;
@synthesize deviceType = _deviceType;
@synthesize userId = _userId;
@synthesize driverId = _driverId;
@synthesize userRole = _userRole;
@synthesize dotNumber = _dotNumber;
@synthesize lastname = _lastname;
@synthesize companyLatitude = _companyLatitude;
@synthesize firstname = _firstname;
@synthesize officeLatitude = _officeLatitude;
@synthesize facebookId = _facebookId;
@synthesize isVerified = _isVerified;
@synthesize companyName = _companyName;
@synthesize securePassword = _securePassword;
@synthesize guid = _guid;
@synthesize phoneNo = _phoneNo;


+ (Driver *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Driver *instance = [[Driver alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.isDelete = [[self objectOrNilForKey:kDriverIsDelete fromDictionary:dict] doubleValue];
            self.createdDate = [self objectOrNilForKey:kDriverCreatedDate fromDictionary:dict];
            self.googleId = [self objectOrNilForKey:kDriverGoogleId fromDictionary:dict];
            self.driverIdentifier = [[self objectOrNilForKey:kDriverId fromDictionary:dict] doubleValue];
            self.operatingAddress = [self objectOrNilForKey:kDriverOperatingAddress fromDictionary:dict];
            self.userLatitude = [self objectOrNilForKey:kDriverUserLatitude fromDictionary:dict];
            self.country = [self objectOrNilForKey:kDriverCountry fromDictionary:dict];
            self.companyAddress = [self objectOrNilForKey:kDriverCompanyAddress fromDictionary:dict];
            self.state = [self objectOrNilForKey:kDriverState fromDictionary:dict];
            self.dotnumStatus = [[self objectOrNilForKey:kDriverDotnumStatus fromDictionary:dict] doubleValue];
            self.modifiedDate = [self objectOrNilForKey:kDriverModifiedDate fromDictionary:dict];
            self.mcNumber = [self objectOrNilForKey:kDriverMcNumber fromDictionary:dict];
            self.primaryEmailId = [self objectOrNilForKey:kDriverPrimaryEmailId fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kDriverUserName fromDictionary:dict];
            self.opentime = [self objectOrNilForKey:kDriverOpentime fromDictionary:dict];
            self.officeAddress = [self objectOrNilForKey:kDriverOfficeAddress fromDictionary:dict];
            self.officePhoneNo = [self objectOrNilForKey:kDriverOfficePhoneNo fromDictionary:dict];
            self.isTest = [[self objectOrNilForKey:kDriverIsTest fromDictionary:dict] doubleValue];
            self.deviceToken = [self objectOrNilForKey:kDriverDeviceToken fromDictionary:dict];
            self.role = [self objectOrNilForKey:kDriverRole fromDictionary:dict];
            self.secondaryEmailId = [self objectOrNilForKey:kDriverSecondaryEmailId fromDictionary:dict];
            self.officeLongitude = [self objectOrNilForKey:kDriverOfficeLongitude fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kDriverTwitterId fromDictionary:dict];
            self.companyStreet = [self objectOrNilForKey:kDriverCompanyStreet fromDictionary:dict];
            self.officeFaxNo = [self objectOrNilForKey:kDriverOfficeFaxNo fromDictionary:dict];
            self.userLongitude = [self objectOrNilForKey:kDriverUserLongitude fromDictionary:dict];
            self.accesscode = [self objectOrNilForKey:kDriverAccesscode fromDictionary:dict];
            self.cmpnyPhoneNo = [self objectOrNilForKey:kDriverCmpnyPhoneNo fromDictionary:dict];
            self.officeName = [self objectOrNilForKey:kDriverOfficeName fromDictionary:dict];
            self.city = [self objectOrNilForKey:kDriverCity fromDictionary:dict];
            self.companyZip = [self objectOrNilForKey:kDriverCompanyZip fromDictionary:dict];
            self.profilePicture = [self objectOrNilForKey:kDriverProfilePicture fromDictionary:dict];
            self.companyLongitude = [self objectOrNilForKey:kDriverCompanyLongitude fromDictionary:dict];
            self.closetime = [self objectOrNilForKey:kDriverClosetime fromDictionary:dict];
            self.matchRadius = [self objectOrNilForKey:kDriverMatchRadius fromDictionary:dict];
            self.deviceType = [[self objectOrNilForKey:kDriverDeviceType fromDictionary:dict] doubleValue];
            self.userId = [[self objectOrNilForKey:kDriverUserId fromDictionary:dict] doubleValue];
            self.driverId = [[self objectOrNilForKey:kDriverDriverId fromDictionary:dict] doubleValue];
            self.userRole = [self objectOrNilForKey:kDriverUserRole fromDictionary:dict];
            self.dotNumber = [self objectOrNilForKey:kDriverDotNumber fromDictionary:dict];
            self.lastname = [self objectOrNilForKey:kDriverLastname fromDictionary:dict];
            self.companyLatitude = [self objectOrNilForKey:kDriverCompanyLatitude fromDictionary:dict];
            self.firstname = [self objectOrNilForKey:kDriverFirstname fromDictionary:dict];
            self.officeLatitude = [self objectOrNilForKey:kDriverOfficeLatitude fromDictionary:dict];
            self.facebookId = [self objectOrNilForKey:kDriverFacebookId fromDictionary:dict];
            self.isVerified = [[self objectOrNilForKey:kDriverIsVerified fromDictionary:dict] doubleValue];
            self.companyName = [self objectOrNilForKey:kDriverCompanyName fromDictionary:dict];
            self.securePassword = [self objectOrNilForKey:kDriverSecurePassword fromDictionary:dict];
            self.guid = [self objectOrNilForKey:kDriverGuid fromDictionary:dict];
            self.phoneNo = [self objectOrNilForKey:kDriverPhoneNo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDelete] forKey:kDriverIsDelete];
    [mutableDict setValue:self.createdDate forKey:kDriverCreatedDate];
    [mutableDict setValue:self.googleId forKey:kDriverGoogleId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverIdentifier] forKey:kDriverId];
    [mutableDict setValue:self.operatingAddress forKey:kDriverOperatingAddress];
    [mutableDict setValue:self.userLatitude forKey:kDriverUserLatitude];
    [mutableDict setValue:self.country forKey:kDriverCountry];
    [mutableDict setValue:self.companyAddress forKey:kDriverCompanyAddress];
    [mutableDict setValue:self.state forKey:kDriverState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dotnumStatus] forKey:kDriverDotnumStatus];
    [mutableDict setValue:self.modifiedDate forKey:kDriverModifiedDate];
    [mutableDict setValue:self.mcNumber forKey:kDriverMcNumber];
    [mutableDict setValue:self.primaryEmailId forKey:kDriverPrimaryEmailId];
    [mutableDict setValue:self.userName forKey:kDriverUserName];
    [mutableDict setValue:self.opentime forKey:kDriverOpentime];
    [mutableDict setValue:self.officeAddress forKey:kDriverOfficeAddress];
    [mutableDict setValue:self.officePhoneNo forKey:kDriverOfficePhoneNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isTest] forKey:kDriverIsTest];
    [mutableDict setValue:self.deviceToken forKey:kDriverDeviceToken];
    [mutableDict setValue:self.role forKey:kDriverRole];
    [mutableDict setValue:self.secondaryEmailId forKey:kDriverSecondaryEmailId];
    [mutableDict setValue:self.officeLongitude forKey:kDriverOfficeLongitude];
    [mutableDict setValue:self.twitterId forKey:kDriverTwitterId];
    [mutableDict setValue:self.companyStreet forKey:kDriverCompanyStreet];
    [mutableDict setValue:self.officeFaxNo forKey:kDriverOfficeFaxNo];
    [mutableDict setValue:self.userLongitude forKey:kDriverUserLongitude];
    [mutableDict setValue:self.accesscode forKey:kDriverAccesscode];
    [mutableDict setValue:self.cmpnyPhoneNo forKey:kDriverCmpnyPhoneNo];
    [mutableDict setValue:self.officeName forKey:kDriverOfficeName];
    [mutableDict setValue:self.city forKey:kDriverCity];
    [mutableDict setValue:self.companyZip forKey:kDriverCompanyZip];
    [mutableDict setValue:self.profilePicture forKey:kDriverProfilePicture];
    [mutableDict setValue:self.companyLongitude forKey:kDriverCompanyLongitude];
    [mutableDict setValue:self.closetime forKey:kDriverClosetime];
    [mutableDict setValue:self.matchRadius forKey:kDriverMatchRadius];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deviceType] forKey:kDriverDeviceType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kDriverUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverId] forKey:kDriverDriverId];
    [mutableDict setValue:self.userRole forKey:kDriverUserRole];
    [mutableDict setValue:self.dotNumber forKey:kDriverDotNumber];
    [mutableDict setValue:self.lastname forKey:kDriverLastname];
    [mutableDict setValue:self.companyLatitude forKey:kDriverCompanyLatitude];
    [mutableDict setValue:self.firstname forKey:kDriverFirstname];
    [mutableDict setValue:self.officeLatitude forKey:kDriverOfficeLatitude];
    [mutableDict setValue:self.facebookId forKey:kDriverFacebookId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isVerified] forKey:kDriverIsVerified];
    [mutableDict setValue:self.companyName forKey:kDriverCompanyName];
    [mutableDict setValue:self.securePassword forKey:kDriverSecurePassword];
    [mutableDict setValue:self.guid forKey:kDriverGuid];
    [mutableDict setValue:self.phoneNo forKey:kDriverPhoneNo];

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

    self.isDelete = [aDecoder decodeDoubleForKey:kDriverIsDelete];
    self.createdDate = [aDecoder decodeObjectForKey:kDriverCreatedDate];
    self.googleId = [aDecoder decodeObjectForKey:kDriverGoogleId];
    self.driverIdentifier = [aDecoder decodeDoubleForKey:kDriverId];
    self.operatingAddress = [aDecoder decodeObjectForKey:kDriverOperatingAddress];
    self.userLatitude = [aDecoder decodeObjectForKey:kDriverUserLatitude];
    self.country = [aDecoder decodeObjectForKey:kDriverCountry];
    self.companyAddress = [aDecoder decodeObjectForKey:kDriverCompanyAddress];
    self.state = [aDecoder decodeObjectForKey:kDriverState];
    self.dotnumStatus = [aDecoder decodeDoubleForKey:kDriverDotnumStatus];
    self.modifiedDate = [aDecoder decodeObjectForKey:kDriverModifiedDate];
    self.mcNumber = [aDecoder decodeObjectForKey:kDriverMcNumber];
    self.primaryEmailId = [aDecoder decodeObjectForKey:kDriverPrimaryEmailId];
    self.userName = [aDecoder decodeObjectForKey:kDriverUserName];
    self.opentime = [aDecoder decodeObjectForKey:kDriverOpentime];
    self.officeAddress = [aDecoder decodeObjectForKey:kDriverOfficeAddress];
    self.officePhoneNo = [aDecoder decodeObjectForKey:kDriverOfficePhoneNo];
    self.isTest = [aDecoder decodeDoubleForKey:kDriverIsTest];
    self.deviceToken = [aDecoder decodeObjectForKey:kDriverDeviceToken];
    self.role = [aDecoder decodeObjectForKey:kDriverRole];
    self.secondaryEmailId = [aDecoder decodeObjectForKey:kDriverSecondaryEmailId];
    self.officeLongitude = [aDecoder decodeObjectForKey:kDriverOfficeLongitude];
    self.twitterId = [aDecoder decodeObjectForKey:kDriverTwitterId];
    self.companyStreet = [aDecoder decodeObjectForKey:kDriverCompanyStreet];
    self.officeFaxNo = [aDecoder decodeObjectForKey:kDriverOfficeFaxNo];
    self.userLongitude = [aDecoder decodeObjectForKey:kDriverUserLongitude];
    self.accesscode = [aDecoder decodeObjectForKey:kDriverAccesscode];
    self.cmpnyPhoneNo = [aDecoder decodeObjectForKey:kDriverCmpnyPhoneNo];
    self.officeName = [aDecoder decodeObjectForKey:kDriverOfficeName];
    self.city = [aDecoder decodeObjectForKey:kDriverCity];
    self.companyZip = [aDecoder decodeObjectForKey:kDriverCompanyZip];
    self.profilePicture = [aDecoder decodeObjectForKey:kDriverProfilePicture];
    self.companyLongitude = [aDecoder decodeObjectForKey:kDriverCompanyLongitude];
    self.closetime = [aDecoder decodeObjectForKey:kDriverClosetime];
    self.matchRadius = [aDecoder decodeObjectForKey:kDriverMatchRadius];
    self.deviceType = [aDecoder decodeDoubleForKey:kDriverDeviceType];
    self.userId = [aDecoder decodeDoubleForKey:kDriverUserId];
    self.driverId = [aDecoder decodeDoubleForKey:kDriverDriverId];
    self.userRole = [aDecoder decodeObjectForKey:kDriverUserRole];
    self.dotNumber = [aDecoder decodeObjectForKey:kDriverDotNumber];
    self.lastname = [aDecoder decodeObjectForKey:kDriverLastname];
    self.companyLatitude = [aDecoder decodeObjectForKey:kDriverCompanyLatitude];
    self.firstname = [aDecoder decodeObjectForKey:kDriverFirstname];
    self.officeLatitude = [aDecoder decodeObjectForKey:kDriverOfficeLatitude];
    self.facebookId = [aDecoder decodeObjectForKey:kDriverFacebookId];
    self.isVerified = [aDecoder decodeDoubleForKey:kDriverIsVerified];
    self.companyName = [aDecoder decodeObjectForKey:kDriverCompanyName];
    self.securePassword = [aDecoder decodeObjectForKey:kDriverSecurePassword];
    self.guid = [aDecoder decodeObjectForKey:kDriverGuid];
    self.phoneNo = [aDecoder decodeObjectForKey:kDriverPhoneNo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_isDelete forKey:kDriverIsDelete];
    [aCoder encodeObject:_createdDate forKey:kDriverCreatedDate];
    [aCoder encodeObject:_googleId forKey:kDriverGoogleId];
    [aCoder encodeDouble:_driverIdentifier forKey:kDriverId];
    [aCoder encodeObject:_operatingAddress forKey:kDriverOperatingAddress];
    [aCoder encodeObject:_userLatitude forKey:kDriverUserLatitude];
    [aCoder encodeObject:_country forKey:kDriverCountry];
    [aCoder encodeObject:_companyAddress forKey:kDriverCompanyAddress];
    [aCoder encodeObject:_state forKey:kDriverState];
    [aCoder encodeDouble:_dotnumStatus forKey:kDriverDotnumStatus];
    [aCoder encodeObject:_modifiedDate forKey:kDriverModifiedDate];
    [aCoder encodeObject:_mcNumber forKey:kDriverMcNumber];
    [aCoder encodeObject:_primaryEmailId forKey:kDriverPrimaryEmailId];
    [aCoder encodeObject:_userName forKey:kDriverUserName];
    [aCoder encodeObject:_opentime forKey:kDriverOpentime];
    [aCoder encodeObject:_officeAddress forKey:kDriverOfficeAddress];
    [aCoder encodeObject:_officePhoneNo forKey:kDriverOfficePhoneNo];
    [aCoder encodeDouble:_isTest forKey:kDriverIsTest];
    [aCoder encodeObject:_deviceToken forKey:kDriverDeviceToken];
    [aCoder encodeObject:_role forKey:kDriverRole];
    [aCoder encodeObject:_secondaryEmailId forKey:kDriverSecondaryEmailId];
    [aCoder encodeObject:_officeLongitude forKey:kDriverOfficeLongitude];
    [aCoder encodeObject:_twitterId forKey:kDriverTwitterId];
    [aCoder encodeObject:_companyStreet forKey:kDriverCompanyStreet];
    [aCoder encodeObject:_officeFaxNo forKey:kDriverOfficeFaxNo];
    [aCoder encodeObject:_userLongitude forKey:kDriverUserLongitude];
    [aCoder encodeObject:_accesscode forKey:kDriverAccesscode];
    [aCoder encodeObject:_cmpnyPhoneNo forKey:kDriverCmpnyPhoneNo];
    [aCoder encodeObject:_officeName forKey:kDriverOfficeName];
    [aCoder encodeObject:_city forKey:kDriverCity];
    [aCoder encodeObject:_companyZip forKey:kDriverCompanyZip];
    [aCoder encodeObject:_profilePicture forKey:kDriverProfilePicture];
    [aCoder encodeObject:_companyLongitude forKey:kDriverCompanyLongitude];
    [aCoder encodeObject:_closetime forKey:kDriverClosetime];
    [aCoder encodeObject:_matchRadius forKey:kDriverMatchRadius];
    [aCoder encodeDouble:_deviceType forKey:kDriverDeviceType];
    [aCoder encodeDouble:_userId forKey:kDriverUserId];
    [aCoder encodeDouble:_driverId forKey:kDriverDriverId];
    [aCoder encodeObject:_userRole forKey:kDriverUserRole];
    [aCoder encodeObject:_dotNumber forKey:kDriverDotNumber];
    [aCoder encodeObject:_lastname forKey:kDriverLastname];
    [aCoder encodeObject:_companyLatitude forKey:kDriverCompanyLatitude];
    [aCoder encodeObject:_firstname forKey:kDriverFirstname];
    [aCoder encodeObject:_officeLatitude forKey:kDriverOfficeLatitude];
    [aCoder encodeObject:_facebookId forKey:kDriverFacebookId];
    [aCoder encodeDouble:_isVerified forKey:kDriverIsVerified];
    [aCoder encodeObject:_companyName forKey:kDriverCompanyName];
    [aCoder encodeObject:_securePassword forKey:kDriverSecurePassword];
    [aCoder encodeObject:_guid forKey:kDriverGuid];
    [aCoder encodeObject:_phoneNo forKey:kDriverPhoneNo];
}


@end
