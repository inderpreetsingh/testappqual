//
//  CompanyRequest.m
//
//  Created by C205  on 05/03/19
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "CompanyRequest.h"


NSString *const kCompanyRequestModifiedDate = @"modified_date";
NSString *const kCompanyRequestRequesId = @"reques_id";
NSString *const kCompanyRequestLastname = @"lastname";
NSString *const kCompanyRequestProfilePicture = @"profile_picture";
NSString *const kCompanyRequestCreatedDate = @"created_date";
NSString *const kCompanyRequestFirstname = @"firstname";
NSString *const kCompanyRequestReceiverUserid = @"receiver_userid";
NSString *const kCompanyRequestPreviosOffice = @"previos_office";
NSString *const kCompanyRequestIsDelete = @"is_delete";
NSString *const kCompanyRequestRequestedCompany = @"requested_company";
NSString *const kCompanyRequestPreviousCompany = @"previous_company";
NSString *const kCompanyRequestSenderUserid = @"sender_userid";
NSString *const kCompanyRequestUserId = @"user_id";
NSString *const kCompanyRequestRequestStatus = @"request_status";
NSString *const kCompanyRequestIsTestdata = @"is_testdata";


@interface CompanyRequest ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CompanyRequest

@synthesize modifiedDate = _modifiedDate;
@synthesize requesId = _requesId;
@synthesize lastname = _lastname;
@synthesize profilePicture = _profilePicture;
@synthesize createdDate = _createdDate;
@synthesize firstname = _firstname;
@synthesize receiverUserid = _receiverUserid;
@synthesize previosOffice = _previosOffice;
@synthesize isDelete = _isDelete;
@synthesize requestedCompany = _requestedCompany;
@synthesize previousCompany = _previousCompany;
@synthesize senderUserid = _senderUserid;
@synthesize userId = _userId;
@synthesize requestStatus = _requestStatus;
@synthesize isTestdata = _isTestdata;


+ (CompanyRequest *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CompanyRequest *instance = [[CompanyRequest alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.modifiedDate = [self objectOrNilForKey:kCompanyRequestModifiedDate fromDictionary:dict];
            self.requesId = [[self objectOrNilForKey:kCompanyRequestRequesId fromDictionary:dict] doubleValue];
            self.lastname = [self objectOrNilForKey:kCompanyRequestLastname fromDictionary:dict];
            self.profilePicture = [self objectOrNilForKey:kCompanyRequestProfilePicture fromDictionary:dict];
            self.createdDate = [self objectOrNilForKey:kCompanyRequestCreatedDate fromDictionary:dict];
            self.firstname = [self objectOrNilForKey:kCompanyRequestFirstname fromDictionary:dict];
            self.receiverUserid = [[self objectOrNilForKey:kCompanyRequestReceiverUserid fromDictionary:dict] doubleValue];
            self.previosOffice = [[self objectOrNilForKey:kCompanyRequestPreviosOffice fromDictionary:dict] doubleValue];
            self.isDelete = [[self objectOrNilForKey:kCompanyRequestIsDelete fromDictionary:dict] doubleValue];
            self.requestedCompany = [[self objectOrNilForKey:kCompanyRequestRequestedCompany fromDictionary:dict] doubleValue];
            self.previousCompany = [[self objectOrNilForKey:kCompanyRequestPreviousCompany fromDictionary:dict] doubleValue];
            self.senderUserid = [[self objectOrNilForKey:kCompanyRequestSenderUserid fromDictionary:dict] doubleValue];
        self.userId = [[self objectOrNilForKey:kCompanyRequestUserId fromDictionary:dict] doubleValue];
            self.requestStatus = [[self objectOrNilForKey:kCompanyRequestRequestStatus fromDictionary:dict] doubleValue];
            self.isTestdata = [[self objectOrNilForKey:kCompanyRequestIsTestdata fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.modifiedDate forKey:kCompanyRequestModifiedDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.requesId] forKey:kCompanyRequestRequesId];
    [mutableDict setValue:self.lastname forKey:kCompanyRequestLastname];
    [mutableDict setValue:self.profilePicture forKey:kCompanyRequestProfilePicture];
    [mutableDict setValue:self.createdDate forKey:kCompanyRequestCreatedDate];
    [mutableDict setValue:self.firstname forKey:kCompanyRequestFirstname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.receiverUserid] forKey:kCompanyRequestReceiverUserid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.previosOffice] forKey:kCompanyRequestPreviosOffice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDelete] forKey:kCompanyRequestIsDelete];
    [mutableDict setValue:[NSNumber numberWithDouble:self.requestedCompany] forKey:kCompanyRequestRequestedCompany];
    [mutableDict setValue:[NSNumber numberWithDouble:self.previousCompany] forKey:kCompanyRequestPreviousCompany];
    [mutableDict setValue:[NSNumber numberWithDouble:self.senderUserid] forKey:kCompanyRequestSenderUserid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.requestStatus] forKey:kCompanyRequestRequestStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kCompanyRequestUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isTestdata] forKey:kCompanyRequestIsTestdata];

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

    self.modifiedDate = [aDecoder decodeObjectForKey:kCompanyRequestModifiedDate];
    self.requesId = [aDecoder decodeDoubleForKey:kCompanyRequestRequesId];
    self.lastname = [aDecoder decodeObjectForKey:kCompanyRequestLastname];
    self.profilePicture = [aDecoder decodeObjectForKey:kCompanyRequestProfilePicture];
    self.createdDate = [aDecoder decodeObjectForKey:kCompanyRequestCreatedDate];
    self.firstname = [aDecoder decodeObjectForKey:kCompanyRequestFirstname];
    self.receiverUserid = [aDecoder decodeDoubleForKey:kCompanyRequestReceiverUserid];
    self.previosOffice = [aDecoder decodeDoubleForKey:kCompanyRequestPreviosOffice];
    self.isDelete = [aDecoder decodeDoubleForKey:kCompanyRequestIsDelete];
    self.requestedCompany = [aDecoder decodeDoubleForKey:kCompanyRequestRequestedCompany];
    self.previousCompany = [aDecoder decodeDoubleForKey:kCompanyRequestPreviousCompany];
    self.senderUserid = [aDecoder decodeDoubleForKey:kCompanyRequestSenderUserid];
    self.userId = [aDecoder decodeDoubleForKey:kCompanyRequestUserId];
    self.requestStatus = [aDecoder decodeDoubleForKey:kCompanyRequestRequestStatus];
    self.isTestdata = [aDecoder decodeDoubleForKey:kCompanyRequestIsTestdata];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_modifiedDate forKey:kCompanyRequestModifiedDate];
    [aCoder encodeDouble:_requesId forKey:kCompanyRequestRequesId];
    [aCoder encodeObject:_lastname forKey:kCompanyRequestLastname];
    [aCoder encodeObject:_profilePicture forKey:kCompanyRequestProfilePicture];
    [aCoder encodeObject:_createdDate forKey:kCompanyRequestCreatedDate];
    [aCoder encodeObject:_firstname forKey:kCompanyRequestFirstname];
    [aCoder encodeDouble:_receiverUserid forKey:kCompanyRequestReceiverUserid];
    [aCoder encodeDouble:_previosOffice forKey:kCompanyRequestPreviosOffice];
    [aCoder encodeDouble:_isDelete forKey:kCompanyRequestIsDelete];
    [aCoder encodeDouble:_requestedCompany forKey:kCompanyRequestRequestedCompany];
    [aCoder encodeDouble:_previousCompany forKey:kCompanyRequestPreviousCompany];
    [aCoder encodeDouble:_senderUserid forKey:kCompanyRequestSenderUserid];
    [aCoder encodeDouble:_userId forKey:kCompanyRequestUserId];
    [aCoder encodeDouble:_requestStatus forKey:kCompanyRequestRequestStatus];
    [aCoder encodeDouble:_isTestdata forKey:kCompanyRequestIsTestdata];
}


@end
