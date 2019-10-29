// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDAllMatches.m instead.

#import "_CDAllMatches.h"

const struct CDAllMatchesAttributes CDAllMatchesAttributes = {
	.address = @"address",
	.city = @"city",
	.closetime = @"closetime",
	.cmpnyPhoneNo = @"cmpnyPhoneNo",
	.companyName = @"companyName",
	.country = @"country",
	.dotAddresses = @"dotAddresses",
	.dotNumber = @"dotNumber",
	.firstname = @"firstname",
	.isContacted = @"isContacted",
	.isFavourite = @"isFavourite",
	.isHide = @"isHide",
	.isLike = @"isLike",
	.lastname = @"lastname",
	.mType = @"mType",
	.matchDistance = @"matchDistance",
	.matchEquiid = @"matchEquiid",
	.matchFromId = @"matchFromId",
	.matchId = @"matchId",
	.matchLoadid = @"matchLoadid",
	.matchOrderStatus = @"matchOrderStatus",
	.matchToId = @"matchToId",
	.mcNumber = @"mcNumber",
	.opentime = @"opentime",
	.parentId = @"parentId",
	.phoneNo = @"phoneNo",
	.primaryEmailId = @"primaryEmailId",
	.profilePicture = @"profilePicture",
	.role = @"role",
	.secondaryEmailId = @"secondaryEmailId",
	.state = @"state",
	.userLatitude = @"userLatitude",
	.userLongitude = @"userLongitude",
	.userName = @"userName",
	.userPreferenceId = @"userPreferenceId",
	.userRole = @"userRole",
};

@implementation CDAllMatchesID
@end

@implementation _CDAllMatches

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDAllMatches" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDAllMatches";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDAllMatches" inManagedObjectContext:moc_];
}

- (CDAllMatchesID*)objectID {
	return (CDAllMatchesID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic address;

@dynamic city;

@dynamic closetime;

@dynamic cmpnyPhoneNo;

@dynamic companyName;

@dynamic country;

@dynamic dotAddresses;

@dynamic dotNumber;

@dynamic firstname;

@dynamic isContacted;

@dynamic isFavourite;

@dynamic isHide;

@dynamic isLike;

@dynamic lastname;

@dynamic mType;

@dynamic matchDistance;

@dynamic matchEquiid;

@dynamic matchFromId;

@dynamic matchId;

@dynamic matchLoadid;

@dynamic matchOrderStatus;

@dynamic matchToId;

@dynamic mcNumber;

@dynamic opentime;

@dynamic parentId;

@dynamic phoneNo;

@dynamic primaryEmailId;

@dynamic profilePicture;

@dynamic role;

@dynamic secondaryEmailId;

@dynamic state;

@dynamic userLatitude;

@dynamic userLongitude;

@dynamic userName;

@dynamic userPreferenceId;

@dynamic userRole;

@end

