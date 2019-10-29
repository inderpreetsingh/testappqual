//
//  CompanyDetails.h
//
//  Created by C205  on 18/12/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CompanyDetails : NSObject <NSCoding>

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *companyLongitude;
@property (nonatomic, strong) NSString *cmpnyPhoneNo;
@property (nonatomic, strong) NSString *companyLatitude;
@property (nonatomic, strong) NSString *companyAddress;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *companyStreet;
@property (nonatomic, strong) NSString *companyZip;
@property (nonatomic, assign) double companyId;
@property (nonatomic, assign) double adminId;
@property (nonatomic, assign) double isAdmin;
@property (nonatomic, strong) NSArray *officeDetails;

+ (CompanyDetails *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
