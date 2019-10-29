//
//  OfficeDetails.h
//
//  Created by C205  on 03/01/19
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OfficeDetails : NSObject <NSCoding>

@property (nonatomic, strong) NSString *officeLongitude;
@property (nonatomic, strong) NSString *officeFaxNo;
@property (nonatomic, strong) NSString *officeAddress;
@property (nonatomic, strong) NSString *officeName;
@property (nonatomic, strong) NSString *officePhoneNo;
@property (nonatomic, strong) NSString *officeLatitude;
@property (nonatomic, assign) double adminId;
@property (nonatomic, assign) double companyId;
@property (nonatomic, assign) double officeId;

+ (OfficeDetails *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
