// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDSubEspecialEquiList.m instead.

#import "_CDSubEspecialEquiList.h"

const struct CDSubEspecialEquiListAttributes CDSubEspecialEquiListAttributes = {
	.createdDate = @"createdDate",
	.esName = @"esName",
	.internalBaseClassIdentifier = @"internalBaseClassIdentifier",
	.isDelete = @"isDelete",
	.isTest = @"isTest",
	.modifiedDate = @"modifiedDate",
	.parentId = @"parentId",
};

@implementation CDSubEspecialEquiListID
@end

@implementation _CDSubEspecialEquiList

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDSubEspecialEquiList" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDSubEspecialEquiList";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDSubEspecialEquiList" inManagedObjectContext:moc_];
}

- (CDSubEspecialEquiListID*)objectID {
	return (CDSubEspecialEquiListID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic esName;

@dynamic internalBaseClassIdentifier;

@dynamic isDelete;

@dynamic isTest;

@dynamic modifiedDate;

@dynamic parentId;

@end

