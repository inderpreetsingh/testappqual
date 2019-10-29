//
//  UserAccount.m
//
//  Created by c196  on 27/04/17
//  Copyright (c) 2017 Payal Umraliya. All rights reserved.
//

#import "UserAccount.h"


NSString *const kUserAccountOfficeLongitude = @"office_longitude";
NSString *const kUserAccountCompanyLongitude = @"company_longitude";
NSString *const kUserAccountOfficeFaxNo = @"office_fax_no";
NSString *const kUserAccountOfficeLatitude = @"office_latitude";
NSString *const kUserAccountClosetime = @"closetime";
NSString *const kUserAccountOfficePhoneNo = @"office_phone_no";
NSString *const kUserAccountModifiedDate = @"modified_date";
NSString *const kUserAccountUserId = @"user_id";
NSString *const kUserAccountCompanyName = @"company_name";
NSString *const kUserAccountOfficeAddress = @"office_address";
NSString *const kUserAccountCompanyAddress = @"company_address";
NSString *const kUserAccountCreatedDate = @"created_date";
NSString *const kUserAccountCountry = @"country";
NSString *const kUserAccountOfficeName = @"office_name";
NSString *const kUserAccountCity = @"city";
NSString *const kUserAccountState = @"state";
NSString *const kUserAccountId = @"id";
NSString *const kUserAccountDotNumber = @"dot_number";
NSString *const kUserAccountPhoneNo = @"phone_no";
NSString *const kUserAccountMcNumber = @"mc_number";
NSString *const kUserAccountRole = @"role";
NSString *const kUserAccountSecondaryEmailId = @"secondary_email_id";
NSString *const kUserAccountCompanyLatitude = @"company_latitude";
NSString *const kUserAccountOpentime = @"opentime";
NSString *const kUserAccountIsDelete = @"is_delete";
NSString *const kUserAccountIsTest = @"is_test";
NSString *const kUserAccountCmpnyPhoneNo = @"cmpny_phone_no";
NSString *const kUserAccountDriverid = @"driver_id";
NSString *const kUserAccountOP = @"operating_address";
NSString *const kUserAccountcs = @"company_street";
NSString *const kUserAccountcz = @"company_zip";
NSString *const kUserAccountdotstatus = @"dotnum_status";
NSString *const kUserAccountOfficeId = @"office_id";
NSString *const kUserAccountIsOfficeAdmin = @"is_office_admin";
NSString *const kUserAccountCompanyId = @"company_id";
NSString *const kUserAccountIsCompanyAdmin = @"is_company_admin";
NSString *const kUserAccountReqCompanyName = @"new_com_name";
NSString *const kUserAccountOldCompanyName = @"old_com_name";

@interface UserAccount ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserAccount

@synthesize officeLongitude = _officeLongitude;
@synthesize companyLongitude = _companyLongitude;
@synthesize officeFaxNo = _officeFaxNo;
@synthesize officeLatitude = _officeLatitude;
@synthesize closetime = _closetime;
@synthesize officePhoneNo = _officePhoneNo;
@synthesize modifiedDate = _modifiedDate;
@synthesize userId = _userId;
@synthesize companyName = _companyName;
@synthesize officeAddress = _officeAddress;
@synthesize companyAddress = _companyAddress;
@synthesize createdDate = _createdDate;
@synthesize country = _country;
@synthesize officeName = _officeName;
@synthesize city = _city;
@synthesize state = _state;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize dotNumber = _dotNumber;
@synthesize phoneNo = _phoneNo;
@synthesize mcNumber = _mcNumber;
@synthesize role = _role;
@synthesize secondaryEmailId = _secondaryEmailId;
@synthesize companyLatitude = _companyLatitude;
@synthesize opentime = _opentime;
@synthesize isDelete = _isDelete;
@synthesize isTest = _isTest;
@synthesize cmpnyPhoneNo = _cmpnyPhoneNo;
@synthesize officeId = _officeId;
@synthesize isOfficeAdmin = _isOfficeAdmin;
@synthesize companyId = _companyId;
@synthesize isCompanyAdmin = _isCompanyAdmin;
@synthesize reqCompanyName = _reqCompanyName;
@synthesize oldCompanyName = _oldCompanyName;

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
        self.officeLongitude = [self objectOrNilForKey:kUserAccountOfficeLongitude fromDictionary:dict];
        self.companyLongitude = [self objectOrNilForKey:kUserAccountCompanyLongitude fromDictionary:dict];
        self.officeFaxNo = [self objectOrNilForKey:kUserAccountOfficeFaxNo fromDictionary:dict];
        self.officeLatitude = [self objectOrNilForKey:kUserAccountOfficeLatitude fromDictionary:dict];
        self.closetime = [self objectOrNilForKey:kUserAccountClosetime fromDictionary:dict];
        self.officePhoneNo = [self objectOrNilForKey:kUserAccountOfficePhoneNo fromDictionary:dict];
        self.modifiedDate = [self objectOrNilForKey:kUserAccountModifiedDate fromDictionary:dict];
        self.userId = [self objectOrNilForKey:kUserAccountUserId fromDictionary:dict];
        self.companyName = [self objectOrNilForKey:kUserAccountCompanyName fromDictionary:dict];
        self.officeAddress = [self objectOrNilForKey:kUserAccountOfficeAddress fromDictionary:dict];
        self.companyAddress = [self objectOrNilForKey:kUserAccountCompanyAddress fromDictionary:dict];
        self.createdDate = [self objectOrNilForKey:kUserAccountCreatedDate fromDictionary:dict];
        self.country = [self objectOrNilForKey:kUserAccountCountry fromDictionary:dict];
        self.officeName = [self objectOrNilForKey:kUserAccountOfficeName fromDictionary:dict];
        self.city = [self objectOrNilForKey:kUserAccountCity fromDictionary:dict];
        self.state = [self objectOrNilForKey:kUserAccountState fromDictionary:dict];
         self.operatingAddress = [self objectOrNilForKey:kUserAccountOP fromDictionary:dict];
        self.internalBaseClassIdentifier = [self objectOrNilForKey:kUserAccountId fromDictionary:dict];
        self.dotNumber = [self objectOrNilForKey:kUserAccountDotNumber fromDictionary:dict];
        self.phoneNo = [self objectOrNilForKey:kUserAccountPhoneNo fromDictionary:dict];
        self.mcNumber = [self objectOrNilForKey:kUserAccountMcNumber fromDictionary:dict];
        self.role = [self objectOrNilForKey:kUserAccountRole fromDictionary:dict];
        self.secondaryEmailId = [self objectOrNilForKey:kUserAccountSecondaryEmailId fromDictionary:dict];
        self.companyLatitude = [self objectOrNilForKey:kUserAccountCompanyLatitude fromDictionary:dict];
        self.opentime = [self objectOrNilForKey:kUserAccountOpentime fromDictionary:dict];
        self.isDelete = [self objectOrNilForKey:kUserAccountIsDelete fromDictionary:dict];
        self.isTest = [self objectOrNilForKey:kUserAccountIsTest fromDictionary:dict];
        self.cmpnyPhoneNo = [self objectOrNilForKey:kUserAccountCmpnyPhoneNo fromDictionary:dict];
        self.driverId=[self objectOrNilForKey:kUserAccountDriverid fromDictionary:dict];
        self.companyStreet=[self objectOrNilForKey:kUserAccountcs fromDictionary:dict];
         self.companyZip=[self objectOrNilForKey:kUserAccountcz fromDictionary:dict];
        self.dotnumStatus=[self objectOrNilForKey:kUserAccountdotstatus fromDictionary:dict];
        self.officeId = [self objectOrNilForKey:kUserAccountOfficeId fromDictionary:dict];
        self.isOfficeAdmin = [[self objectOrNilForKey:kUserAccountIsOfficeAdmin fromDictionary:dict] doubleValue];
        self.companyId = [self objectOrNilForKey:kUserAccountCompanyId fromDictionary:dict];
        self.isCompanyAdmin = [[self objectOrNilForKey:kUserAccountIsCompanyAdmin fromDictionary:dict] doubleValue];
        self.reqCompanyName = [self objectOrNilForKey:kUserAccountReqCompanyName fromDictionary:dict];
        self.oldCompanyName = [self objectOrNilForKey:kUserAccountOldCompanyName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.officeLongitude forKey:kUserAccountOfficeLongitude];
    [mutableDict setValue:self.companyLongitude forKey:kUserAccountCompanyLongitude];
    [mutableDict setValue:self.officeFaxNo forKey:kUserAccountOfficeFaxNo];
    [mutableDict setValue:self.officeLatitude forKey:kUserAccountOfficeLatitude];
    [mutableDict setValue:self.closetime forKey:kUserAccountClosetime];
    [mutableDict setValue:self.officePhoneNo forKey:kUserAccountOfficePhoneNo];
    [mutableDict setValue:self.modifiedDate forKey:kUserAccountModifiedDate];
    [mutableDict setValue:self.userId forKey:kUserAccountUserId];
    [mutableDict setValue:self.companyName forKey:kUserAccountCompanyName];
    [mutableDict setValue:self.officeAddress forKey:kUserAccountOfficeAddress];
    [mutableDict setValue:self.companyAddress forKey:kUserAccountCompanyAddress];
    [mutableDict setValue:self.createdDate forKey:kUserAccountCreatedDate];
    [mutableDict setValue:self.country forKey:kUserAccountCountry];
    [mutableDict setValue:self.officeName forKey:kUserAccountOfficeName];
    [mutableDict setValue:self.city forKey:kUserAccountCity];
    [mutableDict setValue:self.state forKey:kUserAccountState];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kUserAccountId];
    [mutableDict setValue:self.dotNumber forKey:kUserAccountDotNumber];
    [mutableDict setValue:self.operatingAddress forKey:kUserAccountOP];
    [mutableDict setValue:self.phoneNo forKey:kUserAccountPhoneNo];
    [mutableDict setValue:self.mcNumber forKey:kUserAccountMcNumber];
    [mutableDict setValue:self.role forKey:kUserAccountRole];
    [mutableDict setValue:self.secondaryEmailId forKey:kUserAccountSecondaryEmailId];
    [mutableDict setValue:self.companyLatitude forKey:kUserAccountCompanyLatitude];
    [mutableDict setValue:self.opentime forKey:kUserAccountOpentime];
    [mutableDict setValue:self.isDelete forKey:kUserAccountIsDelete];
    [mutableDict setValue:self.isTest forKey:kUserAccountIsTest];
    [mutableDict setValue:self.cmpnyPhoneNo forKey:kUserAccountCmpnyPhoneNo];
     [mutableDict setValue:self.driverId forKey:kUserAccountDriverid];
     [mutableDict setValue:self.companyZip forKey:kUserAccountcz];
     [mutableDict setValue:self.companyStreet forKey:kUserAccountcs];
    [mutableDict setValue:self.dotnumStatus forKey:kUserAccountdotstatus];
    
    [mutableDict setValue:self.officeId forKey:kUserAccountOfficeId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isOfficeAdmin] forKey:kUserAccountIsOfficeAdmin];
    [mutableDict setValue:self.companyId forKey:kUserAccountCompanyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isCompanyAdmin] forKey:kUserAccountIsCompanyAdmin];
    [mutableDict setValue:self.reqCompanyName forKey:kUserAccountReqCompanyName];
    [mutableDict setValue:self.oldCompanyName forKey:kUserAccountOldCompanyName];

    
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
