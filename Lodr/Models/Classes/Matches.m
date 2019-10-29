//
//  Matches.m
//
//  Created by Payal Umraliya  on 07/04/17
//  Copyright (c) 2017 Payal Umraliya. All rights reserved.
//

#import "Matches.h"
#import "Medialist.h"
NSString *const kMatchesIsLoadIntrested = @"is_load_interested";
NSString *const kMatchesIsAssetIntrested = @"is_asset_interested";

//isAssetInterested
//isLoadInterested
NSString *const kMatchesDriverLatitude = @"driver_latitude";
NSString *const kMatchesDriverLongitude = @"driver_longitude";
NSString *const kMatchesUserRole = @"user_role";
NSString *const kMatchesMatchLoadid = @"match_loadid";
NSString *const kMatchesPickupLatitude = @"pickup_latitude";
NSString *const kMatchesParentId = @"parent_id";
NSString *const kMatchesId = @"id";
NSString *const kMatchesOfferRate = @"offer_rate";
NSString *const kMatchesModifiedDate = @"modified_date";
NSString *const kMatchesIsTest = @"is_test";
NSString *const kMatchesIsContacted = @"is_contacted";
NSString *const kMatchesPickupState = @"pickup_state";
NSString *const kMatchesUserId = @"user_id";
NSString *const kMatchesCompanyName = @"company_name";
NSString *const kMatchesState = @"state";
NSString *const kMatchesMatchEquiid = @"match_equiid";
NSString *const kMatchesMatchDistance = @"MatchDistance";
NSString *const kMatchesLoadLength = @"load_length";
NSString *const kMatchesNotes = @"notes";
NSString *const kMatchesMType = @"m_type";
NSString *const kMatchesProfilePicture = @"profile_picture";
NSString *const kMatchesDotNumber = @"dot_number";
NSString *const kMatchesIsFavourite = @"is_favourite";
NSString *const kMatchesDeliveryLongitude = @"delivery_longitude";
NSString *const kMatchesMatchId = @"match_id";
NSString *const kMatchesMcNumber = @"mc_number";
NSString *const kMatchesPickupCountry = @"pickup_country";
NSString *const kMatchesDeliveryAddress = @"delivery_address";
NSString *const kMatchesMatchOrderStatus = @"match_order_status";
NSString *const kMatchesUserLatitude = @"user_latitude";
NSString *const kMatchesAddress = @"address";
NSString *const kMatchesMatchToId = @"match_to_id";
NSString *const kMatchesOpentime = @"opentime";
NSString *const kMatchesSecondaryEmailId = @"secondary_email_id";
NSString *const kMatchesVisiableTo = @"visiable_to";
NSString *const kMatchesPickupTime = @"pickup_time";
NSString *const kMatchesMatchFromId = @"match_from_id";
NSString *const kMatchesRole = @"role";
NSString *const kMatchesIsPublish = @"is_publish";
NSString *const kMatchesPickupLongitude = @"pickup_longitude";
NSString *const kMatchesPickupCity = @"pickup_city";
NSString *const kMatchesDeliveryLatitude = @"delivery_latitude";
NSString *const kMatchesIsBestoffer = @"is_bestoffer";
NSString *const kMatchesDeliveryCountry = @"delivery_country";
NSString *const kMatchesPrimaryEmailId = @"primary_email_id";
NSString *const kMatchesCountry = @"country";
NSString *const kMatchesDeliveryState = @"delivery_state";
NSString *const kMatchesDistance = @"distance";
NSString *const kMatchesIsHide = @"is_hide";
NSString *const kMatchesLoadWidth = @"load_width";
NSString *const kMatchesPickupAddress = @"pickup_address";
NSString *const kMatchesIsLike = @"is_like";
NSString *const kMatchesUserPreferenceId = @"user_preference_id";
NSString *const kMatchesIsDelete = @"is_delete";
NSString *const kMatchesDotAddresses = @"dot_addresses";
NSString *const kMatchesDeliveryTime = @"delivery_time";
NSString *const kMatchesIsAllowComment = @"is_allow_comment";
NSString *const kMatchesCreatedDate = @"created_date";
NSString *const kMatchesLoadWeight = @"load_weight";
NSString *const kMatchesDelieveryDate = @"delievery_date";
NSString *const kMatchesFirstname = @"firstname";
NSString *const kMatchesDeliveryCity = @"delivery_city";
NSString *const kMatchesLoadCode = @"load_code";
NSString *const kMatchesLoadDescription = @"load_description";
NSString *const kMatchesPickupDate = @"pickup_date";
NSString *const kMatchesUserLongitude = @"user_longitude";
NSString *const kMatchesLoadHeight = @"load_height";
NSString *const kMatchesClosetime = @"closetime";
NSString *const kMatchesEId = @"e_id";
NSString *const kMatchesLastname = @"lastname";
NSString *const kMatchesCity = @"city";
NSString *const kMatchesUserName = @"user_name";
NSString *const kMatchesEsId = @"es_id";
NSString *const kMatchesPhoneNo = @"phone_no";
NSString *const kMatchesCmpnyPhoneNo = @"cmpny_phone_no";
NSString *const kMatchesPickupstatecode = @"pickup_state_code";
NSString *const kMatchesDelieverystatecode = @"delivery_state_code";
NSString *const kMatchesMedialist = @"medialist";
NSString *const kMatchesOfficePhone = @"office_phone_no";
NSString *const kMatchesOfficeLat = @"office_latitude";
NSString *const kMatchesOfficeLong = @"office_longitude";
NSString *const kMatchesCmpnyLong = @"company_longitude";
NSString *const kMatchesCmpnyLat = @"company_latitude";
NSString *const kMatchesOfficeAddress = @"office_address";
NSString *const kMatchesOfficeName = @"office_name";
NSString *const kMatchesCompanyAddress = @"company_address";
NSString *const kmatchesMatchOrderId = @"match_order_id";
NSString *const kmatchesEquiVisibility = @"equipment_visibility";
NSString *const kmatchesIslinkedWithMe = @"islinkedWithMe";

NSString *const kmatchesOrderId = @"order_id";
NSString *const kmatchesOrderloadId= @"load_id";
NSString *const kmatchesOrderEquiId = @"equi_id";
NSString *const kmatchesOrderFromId = @"order_from_id";
NSString *const kmatchesOrdertToId = @"order_to_id";
NSString *const kmatchesOrderType = @"order_type";
NSString *const kmatchesOdriverId = @"driver_id";
NSString *const kmatchesOP = @"operating_address";
NSString *const kmatchesSubAssetId = @"sub_asset_id";
NSString *const kmatchesAssetTypeId = @"asset_type_id";
NSString *const kMatchesLastEquiStatecode = @"last_equi_statecode";
NSString *const kMatchesEquiLongitude = @"equi_longitude";
NSString *const kMatchesEquiWeight = @"equi_weight";
NSString *const kMatchesEquiHeight = @"equi_height";
NSString *const kMatchesLastEquiAddress = @"last_equi_address";
NSString *const kMatchesVisibleTo = @"visible_to";
NSString *const kMatchesEquiName = @"equi_name";
NSString *const kMatchesEquiLatitude = @"equi_latitude";
NSString *const kMatchesEquiAvailablity = @"equi_availablity";
NSString *const kMatchesEquiLength = @"equi_length";
NSString *const kMatchesEquiWidth = @"equi_width";
NSString *const kMatchesEquiNotes = @"equi_notes";
NSString *const kmatchecs = @"company_street";
NSString *const kmatchecz= @"company_zip";
@interface Matches ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Matches

@synthesize driverLatitude = _driverLatitude;
@synthesize driverLongitude = _driverLongitude;

@synthesize isLoadInterested = _isLoadInterested;
@synthesize isAssetInterested = _isAssetInterested;
@synthesize userRole = _userRole;
@synthesize matchLoadid = _matchLoadid;
@synthesize pickupLatitude = _pickupLatitude;
@synthesize parentId = _parentId;
@synthesize matchesIdentifier = _matchesIdentifier;
@synthesize offerRate = _offerRate;
@synthesize modifiedDate = _modifiedDate;
@synthesize isTest = _isTest;
@synthesize isContacted = _isContacted;
@synthesize pickupState = _pickupState;
@synthesize userId = _userId;
@synthesize companyName = _companyName;
@synthesize state = _state;
@synthesize matchEquiid = _matchEquiid;
@synthesize matchDistance = _matchDistance;
@synthesize loadLength = _loadLength;
@synthesize notes = _notes;
@synthesize mType = _mType;
@synthesize profilePicture = _profilePicture;
@synthesize dotNumber = _dotNumber;
@synthesize isFavourite = _isFavourite;
@synthesize deliveryLongitude = _deliveryLongitude;
@synthesize matchId = _matchId;
@synthesize mcNumber = _mcNumber;
@synthesize pickupCountry = _pickupCountry;
@synthesize deliveryAddress = _deliveryAddress;
@synthesize matchOrderStatus = _matchOrderStatus;
@synthesize userLatitude = _userLatitude;
@synthesize address = _address;
@synthesize matchToId = _matchToId;
@synthesize opentime = _opentime;
@synthesize secondaryEmailId = _secondaryEmailId;
@synthesize visiableTo = _visiableTo;
@synthesize pickupTime = _pickupTime;
@synthesize matchFromId = _matchFromId;
@synthesize role = _role;
@synthesize isPublish = _isPublish;
@synthesize pickupLongitude = _pickupLongitude;
@synthesize pickupCity = _pickupCity;
@synthesize deliveryLatitude = _deliveryLatitude;
@synthesize isBestoffer = _isBestoffer;
@synthesize deliveryCountry = _deliveryCountry;
@synthesize primaryEmailId = _primaryEmailId;
@synthesize country = _country;
@synthesize deliveryState = _deliveryState;
@synthesize distance = _distance;
@synthesize isHide = _isHide;
@synthesize loadWidth = _loadWidth;
@synthesize pickupAddress = _pickupAddress;
@synthesize isLike = _isLike;
@synthesize userPreferenceId = _userPreferenceId;
@synthesize isDelete = _isDelete;
@synthesize dotAddresses = _dotAddresses;
@synthesize deliveryTime = _deliveryTime;
@synthesize isAllowComment = _isAllowComment;
@synthesize createdDate = _createdDate;
@synthesize loadWeight = _loadWeight;
@synthesize delieveryDate = _delieveryDate;
@synthesize firstname = _firstname;
@synthesize deliveryCity = _deliveryCity;
@synthesize loadCode = _loadCode;
@synthesize loadDescription = _loadDescription;
@synthesize pickupDate = _pickupDate;
@synthesize userLongitude = _userLongitude;
@synthesize loadHeight = _loadHeight;
@synthesize closetime = _closetime;
@synthesize eId = _eId;
@synthesize lastname = _lastname;
@synthesize city = _city;
@synthesize userName = _userName;
@synthesize esId = _esId;
@synthesize phoneNo = _phoneNo;
@synthesize cmpnyPhoneNo = _cmpnyPhoneNo;
@synthesize medialist = _medialist;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        
        self.driverLongitude = [self objectOrNilForKey:kMatchesDriverLongitude fromDictionary:dict];
        self.driverLatitude = [self objectOrNilForKey:kMatchesDriverLatitude fromDictionary:dict];
        self.isLoadInterested = [self objectOrNilForKey:kMatchesIsLoadIntrested fromDictionary:dict];
        self.isAssetInterested = [self objectOrNilForKey:kMatchesIsAssetIntrested fromDictionary:dict];
        self.userRole = [self objectOrNilForKey:kMatchesUserRole fromDictionary:dict];
        self.matchLoadid = [self objectOrNilForKey:kMatchesMatchLoadid fromDictionary:dict];
        self.pickupLatitude = [self objectOrNilForKey:kMatchesPickupLatitude fromDictionary:dict];
        self.parentId = [self objectOrNilForKey:kMatchesParentId fromDictionary:dict];
        self.matchesIdentifier = [self objectOrNilForKey:kMatchesId fromDictionary:dict];
        self.offerRate = [self objectOrNilForKey:kMatchesOfferRate fromDictionary:dict];
        self.modifiedDate = [self objectOrNilForKey:kMatchesModifiedDate fromDictionary:dict];
        self.isTest = [self objectOrNilForKey:kMatchesIsTest fromDictionary:dict];
        self.isContacted = [self objectOrNilForKey:kMatchesIsContacted fromDictionary:dict];
        self.pickupState = [self objectOrNilForKey:kMatchesPickupState fromDictionary:dict];
        self.userId = [self objectOrNilForKey:kMatchesUserId fromDictionary:dict];
        self.companyName = [self objectOrNilForKey:kMatchesCompanyName fromDictionary:dict];
        self.state = [self objectOrNilForKey:kMatchesState fromDictionary:dict];
        self.matchEquiid = [self objectOrNilForKey:kMatchesMatchEquiid fromDictionary:dict];
        self.matchDistance = [self objectOrNilForKey:kMatchesMatchDistance fromDictionary:dict];
        self.loadLength = [self objectOrNilForKey:kMatchesLoadLength fromDictionary:dict];
        self.notes = [self objectOrNilForKey:kMatchesNotes fromDictionary:dict];
        self.mType = [self objectOrNilForKey:kMatchesMType fromDictionary:dict];
        self.profilePicture = [self objectOrNilForKey:kMatchesProfilePicture fromDictionary:dict];
        self.dotNumber = [self objectOrNilForKey:kMatchesDotNumber fromDictionary:dict];
        self.isFavourite = [self objectOrNilForKey:kMatchesIsFavourite fromDictionary:dict];
        self.deliveryLongitude = [self objectOrNilForKey:kMatchesDeliveryLongitude fromDictionary:dict];
        self.matchId = [self objectOrNilForKey:kMatchesMatchId fromDictionary:dict];
        self.mcNumber = [self objectOrNilForKey:kMatchesMcNumber fromDictionary:dict];
        self.pickupCountry = [self objectOrNilForKey:kMatchesPickupCountry fromDictionary:dict];
        self.deliveryAddress = [self objectOrNilForKey:kMatchesDeliveryAddress fromDictionary:dict];
        self.matchOrderStatus = [self objectOrNilForKey:kMatchesMatchOrderStatus fromDictionary:dict];
        self.userLatitude = [self objectOrNilForKey:kMatchesUserLatitude fromDictionary:dict];
        self.address = [self objectOrNilForKey:kMatchesAddress fromDictionary:dict];
        self.matchToId = [self objectOrNilForKey:kMatchesMatchToId fromDictionary:dict];
        self.opentime = [self objectOrNilForKey:kMatchesOpentime fromDictionary:dict];
        self.secondaryEmailId = [self objectOrNilForKey:kMatchesSecondaryEmailId fromDictionary:dict];
        self.operatingAddress = [self objectOrNilForKey:kmatchesOP fromDictionary:dict];
        self.visiableTo = [self objectOrNilForKey:kMatchesVisiableTo fromDictionary:dict];
        self.pickupTime = [self objectOrNilForKey:kMatchesPickupTime fromDictionary:dict];
        self.matchFromId = [self objectOrNilForKey:kMatchesMatchFromId fromDictionary:dict];
        self.role = [self objectOrNilForKey:kMatchesRole fromDictionary:dict];
        self.isPublish = [self objectOrNilForKey:kMatchesIsPublish fromDictionary:dict];
        self.pickupLongitude = [self objectOrNilForKey:kMatchesPickupLongitude fromDictionary:dict];
        self.pickupCity = [self objectOrNilForKey:kMatchesPickupCity fromDictionary:dict];
        self.deliveryLatitude = [self objectOrNilForKey:kMatchesDeliveryLatitude fromDictionary:dict];
        self.isBestoffer = [self objectOrNilForKey:kMatchesIsBestoffer fromDictionary:dict];
        self.deliveryCountry = [self objectOrNilForKey:kMatchesDeliveryCountry fromDictionary:dict];
        self.primaryEmailId = [self objectOrNilForKey:kMatchesPrimaryEmailId fromDictionary:dict];
        self.country = [self objectOrNilForKey:kMatchesCountry fromDictionary:dict];
        self.deliveryState = [self objectOrNilForKey:kMatchesDeliveryState fromDictionary:dict];
        self.distance = [self objectOrNilForKey:kMatchesDistance fromDictionary:dict];
        self.isHide = [self objectOrNilForKey:kMatchesIsHide fromDictionary:dict];
        self.loadWidth = [self objectOrNilForKey:kMatchesLoadWidth fromDictionary:dict];
        self.pickupAddress = [self objectOrNilForKey:kMatchesPickupAddress fromDictionary:dict];
        self.isLike = [self objectOrNilForKey:kMatchesIsLike fromDictionary:dict];
        self.userPreferenceId = [self objectOrNilForKey:kMatchesUserPreferenceId fromDictionary:dict];
        self.isDelete = [self objectOrNilForKey:kMatchesIsDelete fromDictionary:dict];
        self.dotAddresses = [self objectOrNilForKey:kMatchesDotAddresses fromDictionary:dict];
        self.deliveryTime = [self objectOrNilForKey:kMatchesDeliveryTime fromDictionary:dict];
        self.isAllowComment = [self objectOrNilForKey:kMatchesIsAllowComment fromDictionary:dict];
        self.createdDate = [self objectOrNilForKey:kMatchesCreatedDate fromDictionary:dict];
        self.loadWeight = [self objectOrNilForKey:kMatchesLoadWeight fromDictionary:dict];
        self.delieveryDate = [self objectOrNilForKey:kMatchesDelieveryDate fromDictionary:dict];
        self.firstname = [self objectOrNilForKey:kMatchesFirstname fromDictionary:dict];
        self.deliveryCity = [self objectOrNilForKey:kMatchesDeliveryCity fromDictionary:dict];
        self.loadCode = [self objectOrNilForKey:kMatchesLoadCode fromDictionary:dict];
        self.loadDescription = [self objectOrNilForKey:kMatchesLoadDescription fromDictionary:dict];
        self.pickupDate = [self objectOrNilForKey:kMatchesPickupDate fromDictionary:dict];
        self.userLongitude = [self objectOrNilForKey:kMatchesUserLongitude fromDictionary:dict];
        self.loadHeight = [self objectOrNilForKey:kMatchesLoadHeight fromDictionary:dict];
        self.closetime = [self objectOrNilForKey:kMatchesClosetime fromDictionary:dict];
        self.eId = [self objectOrNilForKey:kMatchesEId fromDictionary:dict];
        self.lastname = [self objectOrNilForKey:kMatchesLastname fromDictionary:dict];
        self.city = [self objectOrNilForKey:kMatchesCity fromDictionary:dict];
        self.userName = [self objectOrNilForKey:kMatchesUserName fromDictionary:dict];
        self.esId = [self objectOrNilForKey:kMatchesEsId fromDictionary:dict];
        self.phoneNo = [self objectOrNilForKey:kMatchesPhoneNo fromDictionary:dict];
        self.cmpnyPhoneNo = [self objectOrNilForKey:kMatchesCmpnyPhoneNo fromDictionary:dict];
        self.pickupStateCode = [self objectOrNilForKey:kMatchesPickupstatecode fromDictionary:dict];
        self.delievryStateCode = [self objectOrNilForKey:kMatchesDelieverystatecode fromDictionary:dict];
        self.matchOrderId = [self objectOrNilForKey:kmatchesMatchOrderId fromDictionary:dict];
        NSObject *receivedMedialist = [dict objectForKey:kMatchesMedialist];
        NSMutableArray *parsedMedialist = [NSMutableArray array];
        if ([receivedMedialist isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedMedialist) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedMedialist addObject:[Medialist modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedMedialist isKindOfClass:[NSDictionary class]]) {
            [parsedMedialist addObject:[Medialist modelObjectWithDictionary:(NSDictionary *)receivedMedialist]];
        }
        
        self.medialist = [NSArray arrayWithArray:parsedMedialist];
        self.delievryStateCode = [self objectOrNilForKey:kMatchesDelieverystatecode fromDictionary:dict];
        self.officePhoneNo=[self objectOrNilForKey:kMatchesOfficePhone fromDictionary:dict];
        self.officeLatitude=[self objectOrNilForKey:kMatchesOfficeLat fromDictionary:dict];
        self.officeLongitude=[self objectOrNilForKey:kMatchesOfficeLong fromDictionary:dict];
        self.companyLongitude=[self objectOrNilForKey:kMatchesCmpnyLong fromDictionary:dict];
        self.companyLatitude=[self objectOrNilForKey:kMatchesCmpnyLat fromDictionary:dict];
        self.officeAddress=[self objectOrNilForKey:kMatchesOfficeAddress fromDictionary:dict];
        self.officeName=[self objectOrNilForKey:kMatchesOfficeName fromDictionary:dict];
        self.companyAddress=[self objectOrNilForKey:kMatchesCompanyAddress fromDictionary:dict];
        self.equipmentVisibility=[self objectOrNilForKey:kmatchesEquiVisibility fromDictionary:dict];
         self.islinkedWithMyResource=[self objectOrNilForKey:kmatchesIslinkedWithMe fromDictionary:dict];
        
        self.orderId = [self objectOrNilForKey:kmatchesOrderId fromDictionary:dict];
        self.orderFromid = [self objectOrNilForKey:kmatchesOrderFromId fromDictionary:dict];
        self.orderToid = [self objectOrNilForKey:kmatchesOrdertToId fromDictionary:dict];
        self.orderType = [self objectOrNilForKey:kmatchesOrderType fromDictionary:dict];
        self.orderLoadid = [self objectOrNilForKey:kmatchesOrderloadId fromDictionary:dict];
        self.orderEquiid = [self objectOrNilForKey:kmatchesOrderEquiId fromDictionary:dict];
        self.driverId = [self objectOrNilForKey:kmatchesOdriverId fromDictionary:dict];
        self.assetTypeId=[self objectOrNilForKey:kmatchesAssetTypeId fromDictionary:dict];
         self.sub_asset_id=[self objectOrNilForKey:kmatchesSubAssetId fromDictionary:dict];
        self.lastEquiStatecode = [self objectOrNilForKey:kMatchesLastEquiStatecode fromDictionary:dict];
        self.equiLongitude = [self objectOrNilForKey:kMatchesEquiLongitude fromDictionary:dict];
        self.equiWeight = [self objectOrNilForKey:kMatchesEquiWeight fromDictionary:dict];
        self.equiHeight = [self objectOrNilForKey:kMatchesEquiHeight fromDictionary:dict];
        self.lastEquiAddress = [self objectOrNilForKey:kMatchesLastEquiAddress fromDictionary:dict];
        self.visibleTo = [self objectOrNilForKey:kMatchesVisibleTo fromDictionary:dict];
        self.equiName = [self objectOrNilForKey:kMatchesEquiName fromDictionary:dict];
        self.equiLatitude = [self objectOrNilForKey:kMatchesEquiLatitude fromDictionary:dict];
        self.equiAvailablity = [self objectOrNilForKey:kMatchesEquiAvailablity fromDictionary:dict];
        self.equiLength = [self objectOrNilForKey:kMatchesEquiLength fromDictionary:dict];
        self.equiWidth = [self objectOrNilForKey:kMatchesEquiWidth fromDictionary:dict];
        self.equiNotes = [self objectOrNilForKey:kMatchesEquiNotes fromDictionary:dict];
        self.companyStreet=[self objectOrNilForKey:kmatchecs fromDictionary:dict];
        self.companyZip=[self objectOrNilForKey:kmatchecz fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.driverLongitude forKey:kMatchesDriverLongitude];
    [mutableDict setValue:self.driverLatitude forKey:kMatchesDriverLatitude];
    
    [mutableDict setValue:self.isLoadInterested forKey:kMatchesIsLoadIntrested];
    [mutableDict setValue:self.isAssetInterested forKey:kMatchesIsAssetIntrested];
    [mutableDict setValue:self.userRole forKey:kMatchesUserRole];
    [mutableDict setValue:self.matchLoadid forKey:kMatchesMatchLoadid];
    [mutableDict setValue:self.pickupLatitude forKey:kMatchesPickupLatitude];
    [mutableDict setValue:self.parentId forKey:kMatchesParentId];
    [mutableDict setValue:self.matchesIdentifier forKey:kMatchesId];
    [mutableDict setValue:self.offerRate forKey:kMatchesOfferRate];
    [mutableDict setValue:self.modifiedDate forKey:kMatchesModifiedDate];
    [mutableDict setValue:self.isTest forKey:kMatchesIsTest];
    [mutableDict setValue:self.isContacted forKey:kMatchesIsContacted];
    [mutableDict setValue:self.pickupState forKey:kMatchesPickupState];
    [mutableDict setValue:self.userId forKey:kMatchesUserId];
    [mutableDict setValue:self.companyName forKey:kMatchesCompanyName];
    [mutableDict setValue:self.state forKey:kMatchesState];
    [mutableDict setValue:self.matchEquiid forKey:kMatchesMatchEquiid];
    [mutableDict setValue:self.matchDistance forKey:kMatchesMatchDistance];
    [mutableDict setValue:self.loadLength forKey:kMatchesLoadLength];
    [mutableDict setValue:self.notes forKey:kMatchesNotes];
    [mutableDict setValue:self.mType forKey:kMatchesMType];
    [mutableDict setValue:self.profilePicture forKey:kMatchesProfilePicture];
    [mutableDict setValue:self.dotNumber forKey:kMatchesDotNumber];
    [mutableDict setValue:self.isFavourite forKey:kMatchesIsFavourite];
    [mutableDict setValue:self.deliveryLongitude forKey:kMatchesDeliveryLongitude];
    [mutableDict setValue:self.matchId forKey:kMatchesMatchId];
    [mutableDict setValue:self.mcNumber forKey:kMatchesMcNumber];
    [mutableDict setValue:self.pickupCountry forKey:kMatchesPickupCountry];
    [mutableDict setValue:self.deliveryAddress forKey:kMatchesDeliveryAddress];
    [mutableDict setValue:self.matchOrderStatus forKey:kMatchesMatchOrderStatus];
    [mutableDict setValue:self.userLatitude forKey:kMatchesUserLatitude];
    [mutableDict setValue:self.address forKey:kMatchesAddress];
    [mutableDict setValue:self.matchToId forKey:kMatchesMatchToId];
    [mutableDict setValue:self.opentime forKey:kMatchesOpentime];
    [mutableDict setValue:self.secondaryEmailId forKey:kMatchesSecondaryEmailId];
    [mutableDict setValue:self.visiableTo forKey:kMatchesVisiableTo];
    [mutableDict setValue:self.pickupTime forKey:kMatchesPickupTime];
    [mutableDict setValue:self.matchFromId forKey:kMatchesMatchFromId];
    [mutableDict setValue:self.role forKey:kMatchesRole];
    [mutableDict setValue:self.isPublish forKey:kMatchesIsPublish];
    [mutableDict setValue:self.pickupLongitude forKey:kMatchesPickupLongitude];
    [mutableDict setValue:self.pickupCity forKey:kMatchesPickupCity];
    [mutableDict setValue:self.deliveryLatitude forKey:kMatchesDeliveryLatitude];
    [mutableDict setValue:self.isBestoffer forKey:kMatchesIsBestoffer];
    [mutableDict setValue:self.deliveryCountry forKey:kMatchesDeliveryCountry];
    [mutableDict setValue:self.primaryEmailId forKey:kMatchesPrimaryEmailId];
    [mutableDict setValue:self.country forKey:kMatchesCountry];
    [mutableDict setValue:self.deliveryState forKey:kMatchesDeliveryState];
    [mutableDict setValue:self.distance forKey:kMatchesDistance];
    [mutableDict setValue:self.isHide forKey:kMatchesIsHide];
    [mutableDict setValue:self.loadWidth forKey:kMatchesLoadWidth];
    [mutableDict setValue:self.pickupAddress forKey:kMatchesPickupAddress];
    [mutableDict setValue:self.isLike forKey:kMatchesIsLike];
    [mutableDict setValue:self.userPreferenceId forKey:kMatchesUserPreferenceId];
    [mutableDict setValue:self.isDelete forKey:kMatchesIsDelete];
    [mutableDict setValue:self.dotAddresses forKey:kMatchesDotAddresses];
    [mutableDict setValue:self.deliveryTime forKey:kMatchesDeliveryTime];
    [mutableDict setValue:self.isAllowComment forKey:kMatchesIsAllowComment];
    [mutableDict setValue:self.createdDate forKey:kMatchesCreatedDate];
    [mutableDict setValue:self.loadWeight forKey:kMatchesLoadWeight];
    [mutableDict setValue:self.delieveryDate forKey:kMatchesDelieveryDate];
    [mutableDict setValue:self.firstname forKey:kMatchesFirstname];
    [mutableDict setValue:self.deliveryCity forKey:kMatchesDeliveryCity];
    [mutableDict setValue:self.loadCode forKey:kMatchesLoadCode];
    [mutableDict setValue:self.loadDescription forKey:kMatchesLoadDescription];
    [mutableDict setValue:self.pickupDate forKey:kMatchesPickupDate];
    [mutableDict setValue:self.userLongitude forKey:kMatchesUserLongitude];
    [mutableDict setValue:self.loadHeight forKey:kMatchesLoadHeight];
    [mutableDict setValue:self.closetime forKey:kMatchesClosetime];
    [mutableDict setValue:self.eId forKey:kMatchesEId];
    [mutableDict setValue:self.lastname forKey:kMatchesLastname];
    [mutableDict setValue:self.city forKey:kMatchesCity];
    [mutableDict setValue:self.userName forKey:kMatchesUserName];
    [mutableDict setValue:self.esId forKey:kMatchesEsId];
    [mutableDict setValue:self.phoneNo forKey:kMatchesPhoneNo];
    [mutableDict setValue:self.cmpnyPhoneNo forKey:kMatchesCmpnyPhoneNo];
    [mutableDict setValue:self.delievryStateCode forKey:kMatchesDelieverystatecode];
    [mutableDict setValue:self.pickupStateCode forKey:kMatchesPickupstatecode];
    [mutableDict setValue:self.officePhoneNo forKey:kMatchesOfficePhone];
    [mutableDict setValue:self.officeLatitude forKey:kMatchesOfficeLat];
    [mutableDict setValue:self.officeLongitude forKey:kMatchesOfficeLong];
    [mutableDict setValue:self.companyLongitude forKey:kMatchesCmpnyLong];
    [mutableDict setValue:self.companyLatitude forKey:kMatchesCmpnyLat];
    [mutableDict setValue:self.officeAddress forKey:kMatchesOfficeAddress];
    [mutableDict setValue:self.officeName forKey:kMatchesOfficeName];
    [mutableDict setValue:self.companyAddress forKey:kMatchesCompanyAddress];
    [mutableDict setValue:self.matchOrderId forKey:kmatchesMatchOrderId];
    [mutableDict setValue:self.equipmentVisibility forKey:kmatchesEquiVisibility];
    [mutableDict setValue:self.islinkedWithMyResource forKey:kmatchesIslinkedWithMe];
    [mutableDict setValue:self.sub_asset_id forKey:kmatchesSubAssetId];
    [mutableDict setValue:self.assetTypeId forKey:kmatchesAssetTypeId];
    NSMutableArray *tempArrayForMedialist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.medialist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMedialist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMedialist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMedialist] forKey:kMatchesMedialist];
    
    [mutableDict setValue:self.orderEquiid forKey:kmatchesOrderEquiId];
    [mutableDict setValue:self.orderLoadid forKey:kmatchesOrderloadId];
    [mutableDict setValue:self.orderType forKey:kmatchesOrderType];
    [mutableDict setValue:self.orderFromid forKey:kmatchesOrderFromId];
    [mutableDict setValue:self.orderToid forKey:kmatchesOrdertToId];
    [mutableDict setValue:self.driverId forKey:kmatchesOdriverId];
    [mutableDict setValue:self.orderId forKey:kmatchesOrderId];
    [mutableDict setValue:self.operatingAddress forKey:kmatchesOP];
    [mutableDict setValue:self.lastEquiStatecode forKey:kMatchesLastEquiStatecode];
    [mutableDict setValue:self.equiLongitude forKey:kMatchesEquiLongitude];
    [mutableDict setValue:self.equiWeight forKey:kMatchesEquiWeight];
    [mutableDict setValue:self.equiHeight forKey:kMatchesEquiHeight];
    [mutableDict setValue:self.lastEquiAddress forKey:kMatchesLastEquiAddress];
    [mutableDict setValue:self.visibleTo forKey:kMatchesVisibleTo];
    [mutableDict setValue:self.equiName forKey:kMatchesEquiName];
    [mutableDict setValue:self.equiLatitude forKey:kMatchesEquiLatitude];
    [mutableDict setValue:self.equiAvailablity forKey:kMatchesEquiAvailablity];
    [mutableDict setValue:self.equiLength forKey:kMatchesEquiLength];
    [mutableDict setValue:self.equiWidth forKey:kMatchesEquiWidth];
    [mutableDict setValue:self.equiNotes forKey:kMatchesEquiNotes];
    [mutableDict setValue:self.companyZip forKey:kmatchecz];
    [mutableDict setValue:self.companyStreet forKey:kmatchecs];
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
    if([object isKindOfClass:[NSNumber class]])
    {
        object=[NSString stringWithFormat:@"%@",object];
    }
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
