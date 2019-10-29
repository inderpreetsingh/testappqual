//
//  AssetAbility.h
//
//  Created by c196  on 27/07/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AssetAbility : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *assetAbilityIdentifier;
@property (nonatomic, strong) NSString *issueType;
@property (nonatomic, strong) NSString *capacityValue;
@property (nonatomic, strong) NSString *assetTypeId;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *isDelete;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
