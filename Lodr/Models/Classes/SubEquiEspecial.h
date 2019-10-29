//
//  SubEquiEspecial.h
//
//  Created by Payal Umraliya  on 31/03/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SubEquiEspecial : NSObject

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *isDelete;
@property (nonatomic, strong) NSString *esName;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *isTest;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *capability;
@property (nonatomic, strong) NSArray *assetAbility;
@property (nonatomic, strong) NSString *abilityId;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
