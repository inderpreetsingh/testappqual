//
//  PowerAsset.h
//
//  Created by C109  on 13/02/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PowerAsset : NSObject <NSCoding>

@property (nonatomic, assign) double isPublish;
@property (nonatomic, assign) double assetAbilityId;
@property (nonatomic, strong) NSString *lastEquiStatecode;
@property (nonatomic, assign) id modifiedDate;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *esId;
@property (nonatomic, strong) NSString *equiLongitude;
@property (nonatomic, assign) double equiWeight;
@property (nonatomic, assign) double equiHeight;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *lastEquiAddress;
@property (nonatomic, assign) double visibleTo;
@property (nonatomic, strong) NSString *equiName;
@property (nonatomic, assign) double equiEmptyWeight;
@property (nonatomic, strong) NSString *equiLatitude;
@property (nonatomic, assign) double powerAssetIdentifier;
@property (nonatomic, strong) NSString *scheduledLoadWeight;
@property (nonatomic, strong) NSString *eId;
@property (nonatomic, assign) double equiAvailablity;
@property (nonatomic, assign) double equiLength;
@property (nonatomic, assign) double equiWidth;
@property (nonatomic, strong) NSString *equiNotes;
@property (nonatomic, strong) NSString *isavailable;
@property (nonatomic, assign) double isDelete;
@property (nonatomic, assign) double isTest;
@property (nonatomic, assign) double assetTypeId;

+ (PowerAsset *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
