// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDSubEspecialEquiList.h instead.

#import <CoreData/CoreData.h>

extern const struct CDSubEspecialEquiListAttributes {
__unsafe_unretained	 NSString *createdDate;
__unsafe_unretained	 NSString *esName;
__unsafe_unretained	 NSString *internalBaseClassIdentifier;
__unsafe_unretained	 NSString *isDelete;
__unsafe_unretained	 NSString *isTest;
__unsafe_unretained	 NSString *modifiedDate;
__unsafe_unretained	 NSString *parentId;
} CDSubEspecialEquiListAttributes;

@interface CDSubEspecialEquiListID : NSManagedObjectID {}
@end

@interface _CDSubEspecialEquiList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDSubEspecialEquiListID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* esName;

//- (BOOL)validateEsName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* internalBaseClassIdentifier;

//- (BOOL)validateInternalBaseClassIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isDelete;

//- (BOOL)validateIsDelete:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isTest;

//- (BOOL)validateIsTest:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* parentId;

//- (BOOL)validateParentId:(id*)value_ error:(NSError**)error_;

@end

@interface _CDSubEspecialEquiList (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveEsName;
- (void)setPrimitiveEsName:(NSString*)value;

- (NSString*)primitiveInternalBaseClassIdentifier;
- (void)setPrimitiveInternalBaseClassIdentifier:(NSString*)value;

- (NSString*)primitiveIsDelete;
- (void)setPrimitiveIsDelete:(NSString*)value;

- (NSString*)primitiveIsTest;
- (void)setPrimitiveIsTest:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveParentId;
- (void)setPrimitiveParentId:(NSString*)value;

@end
