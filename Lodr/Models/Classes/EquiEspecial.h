//
//  EquiEspecial.h
//
//  Created by Payal Umraliya  on 30/03/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EquiEspecial : NSObject

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, assign) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *eName;
@property (nonatomic, assign) NSString *isTest;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, assign) NSString *isDelete;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
