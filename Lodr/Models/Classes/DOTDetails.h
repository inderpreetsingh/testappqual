//
//  DOTDetails.h
//
//  Created by Payal Umraliya  on 27/03/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DOTDetails : NSObject

@property (nonatomic, strong) NSString *phyStreet;
@property (nonatomic, strong) NSString *phyCity;
@property (nonatomic, strong) NSString *dotNumber;
@property (nonatomic, strong) NSString *dotAddress;
@property (nonatomic, strong) NSString *mcNumber;
@property (nonatomic, strong) NSString *legalName;
@property (nonatomic, strong) NSString *phyState;
@property (nonatomic, strong) NSString *phyZipcode;
@property (nonatomic, strong) NSString *phyCountry;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *operatingStatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
