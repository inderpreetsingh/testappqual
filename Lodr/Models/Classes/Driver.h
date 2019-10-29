//
//  Driver.h
//
//  Created by C109  on 13/02/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Driver : NSObject <NSCoding>

@property (nonatomic, assign) double isDelete;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *googleId;
@property (nonatomic, assign) double driverIdentifier;
@property (nonatomic, strong) NSString *operatingAddress;
@property (nonatomic, strong) NSString *userLatitude;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *companyAddress;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, assign) double dotnumStatus;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *mcNumber;
@property (nonatomic, strong) NSString *primaryEmailId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *opentime;
@property (nonatomic, strong) NSString *officeAddress;
@property (nonatomic, strong) NSString *officePhoneNo;
@property (nonatomic, assign) double isTest;
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *secondaryEmailId;
@property (nonatomic, strong) NSString *officeLongitude;
@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSString *companyStreet;
@property (nonatomic, strong) NSString *officeFaxNo;
@property (nonatomic, strong) NSString *userLongitude;
@property (nonatomic, strong) NSString *accesscode;
@property (nonatomic, strong) NSString *cmpnyPhoneNo;
@property (nonatomic, strong) NSString *officeName;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *companyZip;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *companyLongitude;
@property (nonatomic, strong) NSString *closetime;
@property (nonatomic, strong) NSString *matchRadius;
@property (nonatomic, assign) double deviceType;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double driverId;
@property (nonatomic, strong) NSString *userRole;
@property (nonatomic, strong) NSString *dotNumber;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *companyLatitude;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *officeLatitude;
@property (nonatomic, strong) NSString *facebookId;
@property (nonatomic, assign) double isVerified;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *securePassword;
@property (nonatomic, strong) NSString *guid;
@property (nonatomic, strong) NSString *phoneNo;

+ (Driver *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
