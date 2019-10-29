// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDEspecialEquiList.m instead.

#import "_CDEspecialEquiList.h"

const struct CDEspecialEquiListAttributes CDEspecialEquiListAttributes = {
	.createdDate = @"createdDate",
	.eName = @"eName",
	.internalBaseClassIdentifier = @"internalBaseClassIdentifier",
	.isDelete = @"isDelete",
	.isTest = @"isTest",
	.modifiedDate = @"modifiedDate",
};

@implementation CDEspecialEquiListID
@end

@implementation _CDEspecialEquiList

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDEspecialEquiList" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDEspecialEquiList";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDEspecialEquiList" inManagedObjectContext:moc_];
}

- (CDEspecialEquiListID*)objectID {
	return (CDEspecialEquiListID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic eName;

@dynamic internalBaseClassIdentifier;

@dynamic isDelete;

@dynamic isTest;

@dynamic modifiedDate;

@end

