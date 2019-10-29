//
//  User.m
//
//  Created by Payal Umraliya  on 16/03/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "UserAccount.h"


NSString *const kUserLastname = @"lastname";
NSString *const kUserGuid = @"guid";
NSString *const kUserModifiedDate = @"modified_date";
NSString *const kUserFirstname = @"firstname";
NSString *const kUserCreatedDate = @"created_date";
NSString *const kUserTwitterId = @"twitter_id";
NSString *const kUserSecurePassword = @"secure_password";
NSString *const kUserIsVerified = @"is_verified";
NSString *const kUserUserAccount = @"userAccount";
NSString *const kUserDeviceToken = @"device_token";
NSString *const kUserId = @"id";
NSString *const kUserFacebookId = @"facebook_id";
NSString *const kUserProfilePicture = @"profile_picture";
NSString *const kUserPrimaryEmailId = @"primary_email_id";
NSString *const kUserAccesscode = @"accesscode";
NSString *const kUserIsDelete = @"is_delete";
NSString *const kUserGoogleId = @"google_id";
NSString *const kUserDeviceType = @"device_type";
NSString *const kUserUserRole = @"user_role";
NSString *const kUserIsTest = @"is_test";
NSString *const kUserUserName = @"user_name";


@interface User ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation User

@synthesize lastname = _lastname;
@synthesize guid = _guid;
@synthesize modifiedDate = _modifiedDate;
@synthesize firstname = _firstname;
@synthesize createdDate = _createdDate;
@synthesize twitterId = _twitterId;
@synthesize securePassword = _securePassword;
@synthesize isVerified = _isVerified;
@synthesize userAccount = _userAccount;
@synthesize deviceToken = _deviceToken;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize facebookId = _facebookId;
@synthesize profilePicture = _profilePicture;
@synthesize primaryEmailId = _primaryEmailId;
@synthesize accesscode = _accesscode;
@synthesize isDelete = _isDelete;
@synthesize googleId = _googleId;
@synthesize deviceType = _deviceType;
@synthesize userRole = _userRole;
@synthesize isTest = _isTest;
@synthesize userName = _userName;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.lastname = [self objectOrNilForKey:kUserLastname fromDictionary:dict];
            self.guid = [self objectOrNilForKey:kUserGuid fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kUserModifiedDate fromDictionary:dict];
            self.firstname = [self objectOrNilForKey:kUserFirstname fromDictionary:dict];
            self.createdDate = [self objectOrNilForKey:kUserCreatedDate fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kUserTwitterId fromDictionary:dict];
            self.securePassword = [self objectOrNilForKey:kUserSecurePassword fromDictionary:dict];
            self.isVerified = [self objectOrNilForKey:kUserIsVerified fromDictionary:dict] ;
    NSObject *receivedUserAccount = [dict objectForKey:kUserUserAccount];
    NSMutableArray *parsedUserAccount = [NSMutableArray array];
    if ([receivedUserAccount isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedUserAccount) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedUserAccount addObject:[UserAccount modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedUserAccount isKindOfClass:[NSDictionary class]]) {
       [parsedUserAccount addObject:[UserAccount modelObjectWithDictionary:(NSDictionary *)receivedUserAccount]];
    }

    self.userAccount = [NSArray arrayWithArray:parsedUserAccount];
            self.deviceToken = [self objectOrNilForKey:kUserDeviceToken fromDictionary:dict];
        self.internalBaseClassIdentifier = [self objectOrNilForKey:kUserId fromDictionary:dict];
            self.facebookId = [self objectOrNilForKey:kUserFacebookId fromDictionary:dict];
            self.profilePicture = [self objectOrNilForKey:kUserProfilePicture fromDictionary:dict];
            self.primaryEmailId = [self objectOrNilForKey:kUserPrimaryEmailId fromDictionary:dict];
            self.accesscode = [self objectOrNilForKey:kUserAccesscode fromDictionary:dict];
        self.isDelete = [self objectOrNilForKey:kUserIsDelete fromDictionary:dict] ;
            self.googleId = [self objectOrNilForKey:kUserGoogleId fromDictionary:dict];
            self.deviceType = [self objectOrNilForKey:kUserDeviceType fromDictionary:dict];
            self.userRole = [self objectOrNilForKey:kUserUserRole fromDictionary:dict];
            self.isTest = [self objectOrNilForKey:kUserIsTest fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kUserUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.lastname forKey:kUserLastname];
    [mutableDict setValue:self.guid forKey:kUserGuid];
    [mutableDict setValue:self.modifiedDate forKey:kUserModifiedDate];
    [mutableDict setValue:self.firstname forKey:kUserFirstname];
    [mutableDict setValue:self.createdDate forKey:kUserCreatedDate];
    [mutableDict setValue:self.twitterId forKey:kUserTwitterId];
    [mutableDict setValue:self.securePassword forKey:kUserSecurePassword];
    [mutableDict setValue:self.isVerified forKey:kUserIsVerified];
    NSMutableArray *tempArrayForUserAccount = [NSMutableArray array];
    for (NSObject *subArrayObject in self.userAccount) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForUserAccount addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForUserAccount addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForUserAccount] forKey:kUserUserAccount];
    [mutableDict setValue:self.deviceToken forKey:kUserDeviceToken];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kUserId];
    [mutableDict setValue:self.facebookId forKey:kUserFacebookId];
    [mutableDict setValue:self.profilePicture forKey:kUserProfilePicture];
    [mutableDict setValue:self.primaryEmailId forKey:kUserPrimaryEmailId];
    [mutableDict setValue:self.accesscode forKey:kUserAccesscode];
    [mutableDict setValue:self.isDelete forKey:kUserIsDelete];
    [mutableDict setValue:self.googleId forKey:kUserGoogleId];
    [mutableDict setValue:self.deviceType forKey:kUserDeviceType];
    [mutableDict setValue:self.userRole forKey:kUserUserRole];
    [mutableDict setValue:self.isTest forKey:kUserIsTest];
    [mutableDict setValue:self.userName forKey:kUserUserName];

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
    if([object isKindOfClass:[NSNumber class]])
    {
        object=[NSString stringWithFormat:@"%@",object];
    }
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
