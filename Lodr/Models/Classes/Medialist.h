//
//  Medialist.h
//
//  Created by Payal Umraliya  on 17/04/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Medialist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *isTest;
@property (nonatomic, strong) NSString *medialistIdentifier;
@property (nonatomic, strong) NSString *mediaName;
@property (nonatomic, strong) NSString *mediaType;
@property (nonatomic, strong) NSString *isDelete;
@property (nonatomic, strong) NSString *parentId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
