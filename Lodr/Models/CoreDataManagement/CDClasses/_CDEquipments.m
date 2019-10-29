// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDEquipments.m instead.

#import "_CDEquipments.h"

const struct CDEquipmentsAttributes CDEquipmentsAttributes = {
	.createdDate = @"createdDate",
	.eId = @"eId",
	.equiAvailablity = @"equiAvailablity",
	.equiHeight = @"equiHeight",
	.equiLatitude = @"equiLatitude",
	.equiLength = @"equiLength",
	.equiLongitude = @"equiLongitude",
	.equiName = @"equiName",
	.equiNotes = @"equiNotes",
	.equiWeight = @"equiWeight",
	.equiWidth = @"equiWidth",
	.esId = @"esId",
	.internalBaseClassIdentifier = @"internalBaseClassIdentifier",
	.isDelete = @"isDelete",
	.isPublish = @"isPublish",
	.isTest = @"isTest",
	.modifiedDate = @"modifiedDate",
	.userId = @"userId",
	.visibleTo = @"visibleTo",
};

@implementation CDEquipmentsID
@end

@implementation _CDEquipments

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDEquipments" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDEquipments";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDEquipments" inManagedObjectContext:moc_];
}

- (CDEquipmentsID*)objectID {
	return (CDEquipmentsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic eId;

@dynamic equiAvailablity;

@dynamic equiHeight;

@dynamic equiLatitude;

@dynamic equiLength;

@dynamic equiLongitude;

@dynamic equiName;

@dynamic equiNotes;

@dynamic equiWeight;

@dynamic equiWidth;

@dynamic esId;

@dynamic internalBaseClassIdentifier;

@dynamic isDelete;

@dynamic isPublish;

@dynamic isTest;

@dynamic modifiedDate;

@dynamic userId;

@dynamic visibleTo;

@end

