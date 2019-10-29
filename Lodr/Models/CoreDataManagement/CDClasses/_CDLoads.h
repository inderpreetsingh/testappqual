// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDLoads.h instead.

#import <CoreData/CoreData.h>

extern const struct CDLoadsAttributes {
    __unsafe_unretained  NSString *createdDate;
    __unsafe_unretained  NSString *delieveryDate;
    __unsafe_unretained  NSString *deliveryAddress;
    __unsafe_unretained  NSString *deliveryCity;
    __unsafe_unretained  NSString *deliveryCountry;
    __unsafe_unretained  NSString *deliveryLatitude;
    __unsafe_unretained  NSString *deliveryLongitude;
    __unsafe_unretained  NSString *deliveryState;
    __unsafe_unretained  NSString *deliveryTime;
    __unsafe_unretained  NSString *distance;
    __unsafe_unretained  NSString *eId;
    __unsafe_unretained  NSString *esId;
    __unsafe_unretained  NSString *isAllowComment;
    __unsafe_unretained  NSString *isBestoffer;
    __unsafe_unretained  NSString *isPublish;
    __unsafe_unretained  NSString *is_delete;
    __unsafe_unretained  NSString *loadCode;
    __unsafe_unretained  NSString *loadDescription;
    __unsafe_unretained  NSString *loadHeight;
    __unsafe_unretained  NSString *loadLength;
    __unsafe_unretained  NSString *loadWeight;
    __unsafe_unretained  NSString *loadWidth;
    __unsafe_unretained  NSString *loadid;
    __unsafe_unretained  NSString *modifiedDate;
    __unsafe_unretained  NSString *notes;
    __unsafe_unretained  NSString *offerRate;
    __unsafe_unretained  NSString *pickupAddress;
    __unsafe_unretained  NSString *pickupCity;
    __unsafe_unretained  NSString *pickupCountry;
    __unsafe_unretained  NSString *pickupDate;
    __unsafe_unretained  NSString *pickupLatitude;
    __unsafe_unretained  NSString *pickupLongitude;
    __unsafe_unretained  NSString *pickupState;
    __unsafe_unretained  NSString *pickupTime;
    __unsafe_unretained  NSString *userId;
    __unsafe_unretained  NSString *visiableTo;
} CDLoadsAttributes;

@interface CDLoadsID : NSManagedObjectID {}
@end

@interface _CDLoads : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDLoadsID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* delieveryDate;

//- (BOOL)validateDelieveryDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deliveryAddress;

//- (BOOL)validateDeliveryAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deliveryCity;

//- (BOOL)validateDeliveryCity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deliveryCountry;

//- (BOOL)validateDeliveryCountry:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deliveryLatitude;

//- (BOOL)validateDeliveryLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deliveryLongitude;

//- (BOOL)validateDeliveryLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deliveryState;

//- (BOOL)validateDeliveryState:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deliveryTime;

//- (BOOL)validateDeliveryTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* distance;

//- (BOOL)validateDistance:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* eId;

//- (BOOL)validateEId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* esId;

//- (BOOL)validateEsId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isAllowComment;

//- (BOOL)validateIsAllowComment:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isBestoffer;

//- (BOOL)validateIsBestoffer:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isPublish;

//- (BOOL)validateIsPublish:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* is_delete;

//- (BOOL)validateIs_delete:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* loadCode;

//- (BOOL)validateLoadCode:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* loadDescription;

//- (BOOL)validateLoadDescription:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* loadHeight;

//- (BOOL)validateLoadHeight:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* loadLength;

//- (BOOL)validateLoadLength:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* loadWeight;

//- (BOOL)validateLoadWeight:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* loadWidth;

//- (BOOL)validateLoadWidth:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* loadid;

//- (BOOL)validateLoadid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* notes;

//- (BOOL)validateNotes:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* offerRate;

//- (BOOL)validateOfferRate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* pickupAddress;

//- (BOOL)validatePickupAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* pickupCity;

//- (BOOL)validatePickupCity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* pickupCountry;

//- (BOOL)validatePickupCountry:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* pickupDate;

//- (BOOL)validatePickupDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* pickupLatitude;

//- (BOOL)validatePickupLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* pickupLongitude;

//- (BOOL)validatePickupLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* pickupState;

//- (BOOL)validatePickupState:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* pickupTime;

//- (BOOL)validatePickupTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* userId;

//- (BOOL)validateUserId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* visiableTo;

//- (BOOL)validateVisiableTo:(id*)value_ error:(NSError**)error_;

@end

@interface _CDLoads (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveDelieveryDate;
- (void)setPrimitiveDelieveryDate:(NSString*)value;

- (NSString*)primitiveDeliveryAddress;
- (void)setPrimitiveDeliveryAddress:(NSString*)value;

- (NSString*)primitiveDeliveryCity;
- (void)setPrimitiveDeliveryCity:(NSString*)value;

- (NSString*)primitiveDeliveryCountry;
- (void)setPrimitiveDeliveryCountry:(NSString*)value;

- (NSString*)primitiveDeliveryLatitude;
- (void)setPrimitiveDeliveryLatitude:(NSString*)value;

- (NSString*)primitiveDeliveryLongitude;
- (void)setPrimitiveDeliveryLongitude:(NSString*)value;

- (NSString*)primitiveDeliveryState;
- (void)setPrimitiveDeliveryState:(NSString*)value;

- (NSString*)primitiveDeliveryTime;
- (void)setPrimitiveDeliveryTime:(NSString*)value;

- (NSString*)primitiveDistance;
- (void)setPrimitiveDistance:(NSString*)value;

- (NSString*)primitiveEId;
- (void)setPrimitiveEId:(NSString*)value;

- (NSString*)primitiveEsId;
- (void)setPrimitiveEsId:(NSString*)value;

- (NSString*)primitiveIsAllowComment;
- (void)setPrimitiveIsAllowComment:(NSString*)value;

- (NSString*)primitiveIsBestoffer;
- (void)setPrimitiveIsBestoffer:(NSString*)value;

- (NSString*)primitiveIsPublish;
- (void)setPrimitiveIsPublish:(NSString*)value;

- (NSString*)primitiveIs_delete;
- (void)setPrimitiveIs_delete:(NSString*)value;

- (NSString*)primitiveLoadCode;
- (void)setPrimitiveLoadCode:(NSString*)value;

- (NSString*)primitiveLoadDescription;
- (void)setPrimitiveLoadDescription:(NSString*)value;

- (NSString*)primitiveLoadHeight;
- (void)setPrimitiveLoadHeight:(NSString*)value;

- (NSString*)primitiveLoadLength;
- (void)setPrimitiveLoadLength:(NSString*)value;

- (NSString*)primitiveLoadWeight;
- (void)setPrimitiveLoadWeight:(NSString*)value;

- (NSString*)primitiveLoadWidth;
- (void)setPrimitiveLoadWidth:(NSString*)value;

- (NSString*)primitiveLoadid;
- (void)setPrimitiveLoadid:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(NSString*)value;

- (NSString*)primitiveOfferRate;
- (void)setPrimitiveOfferRate:(NSString*)value;

- (NSString*)primitivePickupAddress;
- (void)setPrimitivePickupAddress:(NSString*)value;

- (NSString*)primitivePickupCity;
- (void)setPrimitivePickupCity:(NSString*)value;

- (NSString*)primitivePickupCountry;
- (void)setPrimitivePickupCountry:(NSString*)value;

- (NSString*)primitivePickupDate;
- (void)setPrimitivePickupDate:(NSString*)value;

- (NSString*)primitivePickupLatitude;
- (void)setPrimitivePickupLatitude:(NSString*)value;

- (NSString*)primitivePickupLongitude;
- (void)setPrimitivePickupLongitude:(NSString*)value;

- (NSString*)primitivePickupState;
- (void)setPrimitivePickupState:(NSString*)value;

- (NSString*)primitivePickupTime;
- (void)setPrimitivePickupTime:(NSString*)value;

- (NSString*)primitiveUserId;
- (void)setPrimitiveUserId:(NSString*)value;

- (NSString*)primitiveVisiableTo;
- (void)setPrimitiveVisiableTo:(NSString*)value;

@end
