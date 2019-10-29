// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDEspecialEquiList.h instead.

#import <CoreData/CoreData.h>

extern const struct CDEspecialEquiListAttributes {
__unsafe_unretained	 NSString *createdDate;
__unsafe_unretained	 NSString *eName;
__unsafe_unretained	 NSString *internalBaseClassIdentifier;
__unsafe_unretained	 NSString *isDelete;
__unsafe_unretained	 NSString *isTest;
__unsafe_unretained	 NSString *modifiedDate;
} CDEspecialEquiListAttributes;

@interface CDEspecialEquiListID : NSManagedObjectID {}
@end

@interface _CDEspecialEquiList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDEspecialEquiListID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* eName;

//- (BOOL)validateEName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* internalBaseClassIdentifier;

//- (BOOL)validateInternalBaseClassIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isDelete;

//- (BOOL)validateIsDelete:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isTest;

//- (BOOL)validateIsTest:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@end

@interface _CDEspecialEquiList (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveEName;
- (void)setPrimitiveEName:(NSString*)value;

- (NSString*)primitiveInternalBaseClassIdentifier;
- (void)setPrimitiveInternalBaseClassIdentifier:(NSString*)value;

- (NSString*)primitiveIsDelete;
- (void)setPrimitiveIsDelete:(NSString*)value;

- (NSString*)primitiveIsTest;
- (void)setPrimitiveIsTest:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

@end
