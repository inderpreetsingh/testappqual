//
//  CompanyAdmin.h
//
//  Created by C205  on 18/06/19
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CompanyAdmin : NSObject <NSCoding>

@property (nonatomic, assign) double adminId;
@property (nonatomic, strong) NSString *primaryEmailId;
@property (nonatomic, strong) NSString *isRequested;

+ (CompanyAdmin *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
