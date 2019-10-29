//
//  CompanyAdmin.m
//
//  Created by C205  on 18/06/19
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "CompanyAdmin.h"


NSString *const kCompanyAdminAdminId = @"admin_id";
NSString *const kCompanyAdminPrimaryEmailId = @"primary_email_id";
NSString *const kCompanyAdminIsRequested = @"is_requested";


@interface CompanyAdmin ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CompanyAdmin

@synthesize adminId = _adminId;
@synthesize primaryEmailId = _primaryEmailId;
@synthesize isRequested = _isRequested;

+ (CompanyAdmin *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CompanyAdmin *instance = [[CompanyAdmin alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.adminId = [[self objectOrNilForKey:kCompanyAdminAdminId fromDictionary:dict] doubleValue];
            self.primaryEmailId = [self objectOrNilForKey:kCompanyAdminPrimaryEmailId fromDictionary:dict];
        self.isRequested = [self objectOrNilForKey:kCompanyAdminIsRequested fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.adminId] forKey:kCompanyAdminAdminId];
    [mutableDict setValue:self.primaryEmailId forKey:kCompanyAdminPrimaryEmailId];
    [mutableDict setValue:self.isRequested forKey:kCompanyAdminIsRequested];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.adminId = [aDecoder decodeDoubleForKey:kCompanyAdminAdminId];
    self.primaryEmailId = [aDecoder decodeObjectForKey:kCompanyAdminPrimaryEmailId];
    self.isRequested = [aDecoder decodeObjectForKey:kCompanyAdminIsRequested];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_adminId forKey:kCompanyAdminAdminId];
    [aCoder encodeObject:_primaryEmailId forKey:kCompanyAdminPrimaryEmailId];
    [aCoder encodeObject:_isRequested forKey:kCompanyAdminIsRequested];
}


@end
