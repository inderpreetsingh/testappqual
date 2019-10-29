//
//  User.h
//
//  Created by Payal Umraliya  on 16/03/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface User : NSObject

@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *guid;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSString *securePassword;
@property (nonatomic, strong) NSString *isVerified;
@property (nonatomic, strong) NSArray *userAccount;
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *facebookId;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *primaryEmailId;
@property (nonatomic, strong) NSString *accesscode;
@property (nonatomic, strong) NSString *isDelete;
@property (nonatomic, strong) NSString *googleId;
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSString *userRole;
@property (nonatomic, strong) NSString *isTest;
@property (nonatomic, strong) NSString *userName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
