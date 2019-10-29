// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDEquipments.h instead.

#import <CoreData/CoreData.h>

extern const struct CDEquipmentsAttributes {
__unsafe_unretained	 NSString *createdDate;
__unsafe_unretained	 NSString *eId;
__unsafe_unretained	 NSString *equiAvailablity;
__unsafe_unretained	 NSString *equiHeight;
__unsafe_unretained	 NSString *equiLatitude;
__unsafe_unretained	 NSString *equiLength;
__unsafe_unretained	 NSString *equiLongitude;
__unsafe_unretained	 NSString *equiName;
__unsafe_unretained	 NSString *equiNotes;
__unsafe_unretained	 NSString *equiWeight;
__unsafe_unretained	 NSString *equiWidth;
__unsafe_unretained	 NSString *esId;
__unsafe_unretained	 NSString *internalBaseClassIdentifier;
__unsafe_unretained	 NSString *isDelete;
__unsafe_unretained	 NSString *isPublish;
__unsafe_unretained	 NSString *isTest;
__unsafe_unretained	 NSString *modifiedDate;
__unsafe_unretained	 NSString *userId;
__unsafe_unretained	 NSString *visibleTo;
} CDEquipmentsAttributes;

@interface CDEquipmentsID : NSManagedObjectID {}
@end

@interface _CDEquipments : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDEquipmentsID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* eId;

//- (BOOL)validateEId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* equiAvailablity;

//- (BOOL)validateEquiAvailablity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* equiHeight;

//- (BOOL)validateEquiHeight:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* equiLatitude;

//- (BOOL)validateEquiLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* equiLength;

//- (BOOL)validateEquiLength:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* equiLongitude;

//- (BOOL)validateEquiLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* equiName;

//- (BOOL)validateEquiName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* equiNotes;

//- (BOOL)validateEquiNotes:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* equiWeight;

//- (BOOL)validateEquiWeight:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* equiWidth;

//- (BOOL)validateEquiWidth:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* esId;

//- (BOOL)validateEsId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* internalBaseClassIdentifier;

//- (BOOL)validateInternalBaseClassIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isDelete;

//- (BOOL)validateIsDelete:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isPublish;

//- (BOOL)validateIsPublish:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isTest;

//- (BOOL)validateIsTest:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* userId;

//- (BOOL)validateUserId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* visibleTo;

//- (BOOL)validateVisibleTo:(id*)value_ error:(NSError**)error_;

@end

@interface _CDEquipments (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveEId;
- (void)setPrimitiveEId:(NSString*)value;

- (NSString*)primitiveEquiAvailablity;
- (void)setPrimitiveEquiAvailablity:(NSString*)value;

- (NSString*)primitiveEquiHeight;
- (void)setPrimitiveEquiHeight:(NSString*)value;

- (NSString*)primitiveEquiLatitude;
- (void)setPrimitiveEquiLatitude:(NSString*)value;

- (NSString*)primitiveEquiLength;
- (void)setPrimitiveEquiLength:(NSString*)value;

- (NSString*)primitiveEquiLongitude;
- (void)setPrimitiveEquiLongitude:(NSString*)value;

- (NSString*)primitiveEquiName;
- (void)setPrimitiveEquiName:(NSString*)value;

- (NSString*)primitiveEquiNotes;
- (void)setPrimitiveEquiNotes:(NSString*)value;

- (NSString*)primitiveEquiWeight;
- (void)setPrimitiveEquiWeight:(NSString*)value;

- (NSString*)primitiveEquiWidth;
- (void)setPrimitiveEquiWidth:(NSString*)value;

- (NSString*)primitiveEsId;
- (void)setPrimitiveEsId:(NSString*)value;

- (NSString*)primitiveInternalBaseClassIdentifier;
- (void)setPrimitiveInternalBaseClassIdentifier:(NSString*)value;

- (NSString*)primitiveIsDelete;
- (void)setPrimitiveIsDelete:(NSString*)value;

- (NSString*)primitiveIsPublish;
- (void)setPrimitiveIsPublish:(NSString*)value;

- (NSString*)primitiveIsTest;
- (void)setPrimitiveIsTest:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveUserId;
- (void)setPrimitiveUserId:(NSString*)value;

- (NSString*)primitiveVisibleTo;
- (void)setPrimitiveVisibleTo:(NSString*)value;

@end
