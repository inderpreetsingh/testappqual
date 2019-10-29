//
//  Comments.m
//
//  Created by C225  on 15/05/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "Comments.h"


NSString *const kCommentsDriverId = @"driver_id";
NSString *const kCommentsCreatedDate = @"created_date";
NSString *const kCommentsIsMedia = @"is_media";
NSString *const kCommentsId = @"id";
NSString *const kCommentsIsTest = @"is_test";
NSString *const kCommentsLoadId = @"load_id";
NSString *const kCommentsIsDelete = @"is_delete";
NSString *const kCommentsCommentText = @"comment_text";
NSString *const kCommentsUserId = @"user_id";
NSString *const kCommentsModifiedDate = @"modified_date";
NSString *const kCommentsFirstname = @"firstname";


@interface Comments ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Comments

@synthesize driverId = _driverId;
@synthesize createdDate = _createdDate;
@synthesize isMedia = _isMedia;
@synthesize commentsIdentifier = _commentsIdentifier;
@synthesize isTest = _isTest;
@synthesize loadId = _loadId;
@synthesize isDelete = _isDelete;
@synthesize commentText = _commentText;
@synthesize userId = _userId;
@synthesize modifiedDate = _modifiedDate;
@synthesize firstname = _firstname;

+ (Comments *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Comments *instance = [[Comments alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.driverId = [[self objectOrNilForKey:kCommentsDriverId fromDictionary:dict] doubleValue];
            self.createdDate = [self objectOrNilForKey:kCommentsCreatedDate fromDictionary:dict];
            self.isMedia = [[self objectOrNilForKey:kCommentsIsMedia fromDictionary:dict] doubleValue];
            self.commentsIdentifier = [[self objectOrNilForKey:kCommentsId fromDictionary:dict] doubleValue];
            self.isTest = [[self objectOrNilForKey:kCommentsIsTest fromDictionary:dict] doubleValue];
            self.loadId = [[self objectOrNilForKey:kCommentsLoadId fromDictionary:dict] doubleValue];
            self.isDelete = [[self objectOrNilForKey:kCommentsIsDelete fromDictionary:dict] doubleValue];
            self.commentText = [self objectOrNilForKey:kCommentsCommentText fromDictionary:dict];
            self.userId = [[self objectOrNilForKey:kCommentsUserId fromDictionary:dict] doubleValue];
            self.modifiedDate = [self objectOrNilForKey:kCommentsModifiedDate fromDictionary:dict];
            self.firstname = [self objectOrNilForKey:kCommentsFirstname fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverId] forKey:kCommentsDriverId];
    [mutableDict setValue:self.createdDate forKey:kCommentsCreatedDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isMedia] forKey:kCommentsIsMedia];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentsIdentifier] forKey:kCommentsId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isTest] forKey:kCommentsIsTest];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loadId] forKey:kCommentsLoadId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDelete] forKey:kCommentsIsDelete];
    [mutableDict setValue:self.commentText forKey:kCommentsCommentText];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kCommentsUserId];
    [mutableDict setValue:self.modifiedDate forKey:kCommentsModifiedDate];
    [mutableDict setValue:self.firstname forKey:kCommentsFirstname];

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

    self.driverId = [aDecoder decodeDoubleForKey:kCommentsDriverId];
    self.createdDate = [aDecoder decodeObjectForKey:kCommentsCreatedDate];
    self.isMedia = [aDecoder decodeDoubleForKey:kCommentsIsMedia];
    self.commentsIdentifier = [aDecoder decodeDoubleForKey:kCommentsId];
    self.isTest = [aDecoder decodeDoubleForKey:kCommentsIsTest];
    self.loadId = [aDecoder decodeDoubleForKey:kCommentsLoadId];
    self.isDelete = [aDecoder decodeDoubleForKey:kCommentsIsDelete];
    self.commentText = [aDecoder decodeObjectForKey:kCommentsCommentText];
    self.userId = [aDecoder decodeDoubleForKey:kCommentsUserId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kCommentsModifiedDate];
    self.firstname = [aDecoder decodeObjectForKey:kCommentsFirstname];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:_driverId forKey:kCommentsDriverId];
    [aCoder encodeObject:_createdDate forKey:kCommentsCreatedDate];
    [aCoder encodeDouble:_isMedia forKey:kCommentsIsMedia];
    [aCoder encodeDouble:_commentsIdentifier forKey:kCommentsId];
    [aCoder encodeDouble:_isTest forKey:kCommentsIsTest];
    [aCoder encodeDouble:_loadId forKey:kCommentsLoadId];
    [aCoder encodeDouble:_isDelete forKey:kCommentsIsDelete];
    [aCoder encodeObject:_commentText forKey:kCommentsCommentText];
    [aCoder encodeDouble:_userId forKey:kCommentsUserId];
    [aCoder encodeObject:_modifiedDate forKey:kCommentsModifiedDate];
    [aCoder encodeObject:_firstname forKey:kCommentsFirstname];
}


@end
