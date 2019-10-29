//
//  CompanyRequest.h
//
//  Created by C205  on 05/03/19
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CompanyRequest : NSObject <NSCoding>

@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, assign) double requesId;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, assign) double receiverUserid;
@property (nonatomic, assign) double previosOffice;
@property (nonatomic, assign) double isDelete;
@property (nonatomic, assign) double requestedCompany;
@property (nonatomic, assign) double previousCompany;
@property (nonatomic, assign) double senderUserid;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double requestStatus;
@property (nonatomic, assign) double isTestdata;
//@property (nonatomic, strong) NSString *firstname;
//@property (nonatomic, strong) NSString *lastname;
//@property (nonatomic, strong) NSString *profilePicture;

+ (CompanyRequest *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
