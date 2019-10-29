// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDLoads.m instead.

#import "_CDLoads.h"

const struct CDLoadsAttributes CDLoadsAttributes = {
	.createdDate = @"createdDate",
	.delieveryDate = @"delieveryDate",
	.deliveryAddress = @"deliveryAddress",
	.deliveryCity = @"deliveryCity",
	.deliveryCountry = @"deliveryCountry",
	.deliveryLatitude = @"deliveryLatitude",
	.deliveryLongitude = @"deliveryLongitude",
	.deliveryState = @"deliveryState",
	.deliveryTime = @"deliveryTime",
	.distance = @"distance",
	.eId = @"eId",
	.esId = @"esId",
	.isAllowComment = @"isAllowComment",
	.isBestoffer = @"isBestoffer",
	.isPublish = @"isPublish",
	.is_delete = @"is_delete",
	.loadCode = @"loadCode",
	.loadDescription = @"loadDescription",
	.loadHeight = @"loadHeight",
	.loadLength = @"loadLength",
	.loadWeight = @"loadWeight",
	.loadWidth = @"loadWidth",
	.loadid = @"loadid",
	.modifiedDate = @"modifiedDate",
	.notes = @"notes",
	.offerRate = @"offerRate",
	.pickupAddress = @"pickupAddress",
	.pickupCity = @"pickupCity",
	.pickupCountry = @"pickupCountry",
	.pickupDate = @"pickupDate",
	.pickupLatitude = @"pickupLatitude",
	.pickupLongitude = @"pickupLongitude",
	.pickupState = @"pickupState",
	.pickupTime = @"pickupTime",
	.userId = @"userId",
	.visiableTo = @"visiableTo",
};

@implementation CDLoadsID
@end

@implementation _CDLoads

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDLoads" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDLoads";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDLoads" inManagedObjectContext:moc_];
}

- (CDLoadsID*)objectID {
	return (CDLoadsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic delieveryDate;

@dynamic deliveryAddress;

@dynamic deliveryCity;

@dynamic deliveryCountry;

@dynamic deliveryLatitude;

@dynamic deliveryLongitude;

@dynamic deliveryState;

@dynamic deliveryTime;

@dynamic distance;

@dynamic eId;

@dynamic esId;

@dynamic isAllowComment;

@dynamic isBestoffer;

@dynamic isPublish;

@dynamic is_delete;

@dynamic loadCode;

@dynamic loadDescription;

@dynamic loadHeight;

@dynamic loadLength;

@dynamic loadWeight;

@dynamic loadWidth;

@dynamic loadid;

@dynamic modifiedDate;

@dynamic notes;

@dynamic offerRate;

@dynamic pickupAddress;

@dynamic pickupCity;

@dynamic pickupCountry;

@dynamic pickupDate;

@dynamic pickupLatitude;

@dynamic pickupLongitude;

@dynamic pickupState;

@dynamic pickupTime;

@dynamic userId;

@dynamic visiableTo;

@end

