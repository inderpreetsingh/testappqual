//
//  UserAccount.h
//
//  Created by c196  on 27/04/17
//  Copyright (c) 2017 Payal Umraliya. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserAccount : NSObject

@property (nonatomic, strong) NSString *officeLongitude;
@property (nonatomic, strong) NSString *companyLongitude;
@property (nonatomic, strong) NSString *officeFaxNo;
@property (nonatomic, strong) NSString *officeLatitude;
@property (nonatomic, strong) NSString *closetime;
@property (nonatomic, strong) NSString *officePhoneNo;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *officeAddress;
@property (nonatomic, strong) NSString *companyAddress;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *officeName;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *dotNumber;
@property (nonatomic, strong) NSString *phoneNo;
@property (nonatomic, strong) NSString *mcNumber;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *secondaryEmailId;
@property (nonatomic, strong) NSString *companyLatitude;
@property (nonatomic, strong) NSString *opentime;
@property (nonatomic, strong) NSString *isDelete;
@property (nonatomic, strong) NSString *isTest;
@property (nonatomic, strong) NSString *cmpnyPhoneNo;
@property (nonatomic, strong) NSString *driverId;
@property (nonatomic, strong) NSString *operatingAddress;
@property (nonatomic, strong) NSString *companyStreet;
@property (nonatomic, strong) NSString *companyZip;
@property (nonatomic, strong) NSString *dotnumStatus;
@property (nonatomic, strong) NSString *officeId;
@property (nonatomic, strong) NSString *companyId;
@property (nonatomic, strong) NSString *reqCompanyName;
@property (nonatomic, strong) NSString *oldCompanyName;
@property (nonatomic, assign) double isCompanyAdmin;
@property (nonatomic, assign) double isOfficeAdmin;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
