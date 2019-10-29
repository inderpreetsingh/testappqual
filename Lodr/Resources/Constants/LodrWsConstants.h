//
//  LodrWsConstants.h
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#ifndef LodrWsConstants_h
#define LodrWsConstants_h

//#define WSURL  @"http://clientapp.narola.online/pg/LodrApp/LodrService.php?Service="
//#define WSURL  @"http://europa.narola.online/pg/LodrApp/LodrService.php?Service="

//#define WSURL  @"https://api.lodrapp.com/LodrService.php?Service="  ==>old url
//#define WSURL  @"http://app.lodrapp.com/narolaFTP/API/LodrService.php?Service="

#define WSURL  @"http://app.lodrapp.com/narolaFTP/API/LodrService.php?Service="
//64.202.188.195

//
#define TermsPrivacyUrl @"https://www.google.com/policies/terms/"
//
//#pragma mark Image Url
//
//#define URLThumbImage @"https://api.lodrapp.com/Images/ThumbnailImages/"
//#define URLEquipmentImage @"https://api.lodrapp.com/Images/EqiupmentPic/"
//#define URLDriverImage @"https://api.lodrapp.com/Images/DriverPic/"
//#define URLLoadImage @"https://api.lodrapp.com/Images/LoadPic/"
#define URLThumbImage @"https://app.lodrapp.com/narolaFTP/API/Images/ThumbnailImages/"
#define URLEquipmentImage @"https://app.lodrapp.com/narolaFTP/API/Images/EqiupmentPic/"
#define URLDriverImage @"https://app.lodrapp.com/narolaFTP/API/Images/DriverPic/"
#define URLLoadImage @"https://app.lodrapp.com/narolaFTP/API/Images/LoadPic/"

//#define URLProfileImage @"https://api.lodrapp.com/Images/ProfilePic/"
#define URLProfileImage @"https://app.lodrapp.com/narolaFTP/API/Images/ProfilePic/"

//#define URLThumbImage @"http://clientapp.narola.online/pg/LodrApp/Images/ThumbnailImages/"
//#define URLEquipmentImage @"http://clientapp.narola.online/pg/LodrApp/Images/EqiupmentPic/"
//#define URLDriverImage @"http://clientapp.narola.online/pg/LodrApp/Images/DriverPic/"
//#define URLLoadImage @"http://clientapp.narola.online/pg/LodrApp/Images/LoadPic/"
//#define URLProfileImage @"http://clientapp.narola.online/pg/LodrApp/Images/ProfilePic/"
#pragma mark - Registration/Login Functionalities ws

#define URLGetTempToken                  [NSString stringWithFormat:@"%@refreshToken",WSURL]
#define URLUpdateUserToken              [NSString stringWithFormat:@"%@updateTokenforUser",WSURL]
#define URLLoginWithSocialMedia       [NSString stringWithFormat:@"%@LoginWithSocialMedia",WSURL]
#define URLLogin                                  [NSString stringWithFormat:@"%@Login",WSURL]
#define URLRegistration                        [NSString stringWithFormat:@"%@Register",WSURL]
#define URLForgotPassword                 [NSString stringWithFormat:@"%@ForgotPassword",WSURL]
#define URLVerificationEmail                 [NSString stringWithFormat:@"%@SendVerificationEmail",WSURL]
#define URLDotNumberDetail              [NSString stringWithFormat:@"%@DotNumberDetail",WSURL]
#define URLCreateRoleAccount            [NSString stringWithFormat:@"%@CreateRoleAccount",WSURL]
#define URLUpdateRoleAccount            [NSString stringWithFormat:@"%@UpdateRoleAccount",WSURL]
#define URLSearchCompany            [NSString stringWithFormat:@"%@SearchCompany",WSURL]
#define URLSearchOffice            [NSString stringWithFormat:@"%@SearchOffice",WSURL]
#define URLFetchAllOffice            [NSString stringWithFormat:@"%@fetchAllOffices",WSURL]
#define URLFetchCompanyAdmin            [NSString stringWithFormat:@"%@FetchCompanyAdmin",WSURL]
#define URLFetchOfficeAdmin            [NSString stringWithFormat:@"%@FetchOfficeAdmin",WSURL]
#define URLFetchCompanyAdminRequests            [NSString stringWithFormat:@"%@FetchCompanyAdminRequests",WSURL]
#define URLFetchOfficeAdminRequests            [NSString stringWithFormat:@"%@FetchOfficeAdminRequests",WSURL]
#define URLRequestCompanyAdminChange    [NSString stringWithFormat:@"%@RequestCompanyAdminChange",WSURL]
#define URLRequestOfficeAdminChange    [NSString stringWithFormat:@"%@RequestOfficeAdminChange",WSURL]
#define URLAcceptRejectCompanyAdmin    [NSString stringWithFormat:@"%@AcceptRejectCompanyAdmin",WSURL]
#define URLAcceptRejectOfficeAdmin    [NSString stringWithFormat:@"%@AcceptRejectOfficeAdmin",WSURL]



#pragma mark - Load Functionalities ws
#define URLCheckImageUplaod       [NSString stringWithFormat:@"%@uplaodMultipleImages",WSURL]
#define URLPostNewLoad                 [NSString stringWithFormat:@"%@PostNewLoad",WSURL]
#define URLUpdateLoadDetails        [NSString stringWithFormat:@"%@UpdateLoad",WSURL]
#define URLDeleteLoad                    [NSString stringWithFormat:@"%@DeleteLoad",WSURL]
//#define URLGetAllLoadByUserId      [NSString stringWithFormat:@"%@GetAllLoadByUserId",WSURL]
#define URLGetAllLoadByUserId      [NSString stringWithFormat:@"%@GetAllLoadByUserId",WSURL]

#define URLFetchAllLoadByUserId   [NSString stringWithFormat:@"%@FetchAllLoadByUserId",WSURL]
#define URLLinkOrder                      [NSString stringWithFormat:@"%@LinkOrder",WSURL]
#define URLUpdateOrderStatus       [NSString stringWithFormat:@"%@UpdateOrderStatus",WSURL]
#define URLCancelOrder                  [NSString stringWithFormat:@"%@CancelOrder",WSURL]
#define URLMakePublishLoad          [NSString stringWithFormat:@"%@PublishUnpublishLoad",WSURL]

#define URLPOSTNEWCOMMENT  [NSString stringWithFormat:@"%@PostNewComment",WSURL]
#define URLGETMORECOMMENT  [NSString stringWithFormat:@"%@GetMoreComments",WSURL]
#define URLDELETECOMMENT  [NSString stringWithFormat:@"%@DeleteComment",WSURL]

#pragma mark - Equipment Functionalities ws

#define URLPostNewEquipment                [NSString stringWithFormat:@"%@PostNewEquipment",WSURL]
#define URLUpdateEquipment                  [NSString stringWithFormat:@"%@UpdateEquipment",WSURL]
#define URLGetEquipmentEspecial           [NSString stringWithFormat:@"%@GetAssetEspecial",WSURL]
#define URLGetEquipmentSubEspecial     [NSString stringWithFormat:@"%@GetAssetSubEspecial",WSURL]
#define URLGetAssetEspecial                    [NSString stringWithFormat:@"%@GetAssetEspecial",WSURL]
#define URLGetAssetSubEspecial              [NSString stringWithFormat:@"%@GetAssetSubEspecial",WSURL]
#define URLFetchAllEquipmentByUserId   [NSString stringWithFormat:@"%@FetchAllEquipmentByUserId",WSURL]
#define URLGetAllEquipmentByUserId      [NSString stringWithFormat:@"%@GetAllEquipmentByUserId",WSURL]
#define URLMakePublishEquipment          [NSString stringWithFormat:@"%@PublishUnpublishEquipment",WSURL]
#define URLDeleteAsset                             [NSString stringWithFormat:@"%@DeleteEquipment",WSURL]
#pragma mark - Chat Functionalities ws
#define URLGetAllEquiSubTypes         [NSString stringWithFormat:@"%@GetAllEquiSubTypes",WSURL]
#pragma mark - Other Functionalities ws
#define URLTotalServay                      [NSString stringWithFormat:@"%@TotalServay",WSURL]
#define URLIsHideMatch                    [NSString stringWithFormat:@"%@IsHideMatch",WSURL]
#define URLMarkAsFavourite             [NSString stringWithFormat:@"%@MarkAsFavourite",WSURL]
#define URLIsLikeMatch                     [NSString stringWithFormat:@"%@IsLikeMatch",WSURL]
#define URLIsContactMtach               [NSString stringWithFormat:@"%@IsContactMtach",WSURL]
#define URLGetAllAlertsbyUserId      [NSString stringWithFormat:@"%@GetAllAlertsbyUserId",WSURL]
#define URLUpdateDriverDuty      [NSString stringWithFormat:@"%@UpdateDriverDuty",WSURL]
#define URLUpdateUserLocation      [NSString stringWithFormat:@"%@UpdateUserLocation",WSURL]

#define URLUpdateLocationForTruck      [NSString stringWithFormat:@"%@UpdateLocationForTruck",WSURL]
#define URLGetCompanyRequest      [NSString stringWithFormat:@"%@getCompanyRequest",WSURL]
#define URLAcceptRejectRequest      [NSString stringWithFormat:@"%@acceptRejectRequest",WSURL]


#define URLUpdateLoadStatus  [NSString stringWithFormat:@"%@UpdateLoadStatusProcess",WSURL]


#define URLGetAVailableDriversByCompany  [NSString stringWithFormat:@"%@GetAVailableDriversByCompany",WSURL]

#define URLGetDriverDetail [NSString stringWithFormat:@"%@GetDriverDetail",WSURL]
#define URLSelectAlternateEquipment [NSString stringWithFormat:@"%@SelectAlternateEquipment",WSURL]
#define URLScheduleDriver [NSString stringWithFormat:@"%@ScheduleDriver",WSURL]
#define URLScheduleSubAsset [NSString stringWithFormat:@"%@ScheduleSubAsset",WSURL]
#define URLScheduleSupportAsset [NSString stringWithFormat:@"%@ScheduleSupportAsset",WSURL]
#define URLGetAlternateEquipmentList [NSString stringWithFormat:@"%@GetAlternateEquipmentList",WSURL]

#define URLGetPoweredAssetsCalender [NSString stringWithFormat:@"%@GetPoweredAssetsCalender",WSURL]
#define URLGetSupportAssetsCalender [NSString stringWithFormat:@"%@GetSupportAssetsCalender",WSURL]

#pragma mark - celander
#define URLDeleteAlertByUserId       [NSString stringWithFormat:@"%@DeleteNotificationsByUserId",WSURL]
#define URLGetAllAssetsSheduledByMonth      [NSString stringWithFormat:@"%@GetAllAssetsSheduledByMonth",WSURL]
#define URLGetScheduledDatesAccordingToYear      [NSString stringWithFormat:@"%@GetScheduledDatesAccordingToYear",WSURL]

#define URLGetScheduledDatesAccordingToMonth      [NSString stringWithFormat:@"%@GetScheduledDatesAccordingToMonth",WSURL]
#define URLGetAllLinkedAssetList      [NSString stringWithFormat:@"%@GetAllLinkedAssetList",WSURL]
#define URLGetAllLinkedLoadList     [NSString stringWithFormat:@"%@GetAllLinkedLoadList",WSURL]
#define URLGetAllLinkedLoadForSubAssets   [NSString stringWithFormat:@"%@GetAllLinkedLoadListForSubAsset",WSURL]
#define URLGetAllLinkedLoadListForSupportAsset   [NSString stringWithFormat:@"%@GetAllLinkedLoadListForSupportAsset",WSURL]

#define URLGetDriversByCompany   [NSString stringWithFormat:@"%@GetDriversByCompany",WSURL]
#define URLGetAllLoadsSheduledByMonth   [NSString stringWithFormat:@"%@GetAllLoadsSheduledByMonth",WSURL]

#define URLGetDriverAssignedLoads     [NSString stringWithFormat:@"%@GetDriverAssignedLoads",WSURL]

#define URLGetAllLinkedLoadData     [NSString stringWithFormat:@"%@GetAllLinkedLoadData",WSURL]
#define URLGetAllDriver     [NSString stringWithFormat:@"%@GetAllDriver",WSURL]
#define URLGetAllTrailers     [NSString stringWithFormat:@"%@GetAllTrailers",WSURL]
#define URLGetAllPowerAsset     [NSString stringWithFormat:@"%@GetAllPowerAsset",WSURL]
#define URLGetAllSupportAsset     [NSString stringWithFormat:@"%@GetAllSupportAsset",WSURL]
#define URLScheduleAllAsset   [NSString stringWithFormat:@"%@ScheduleAllAsset",WSURL]

#pragma mark - Entity and Class Specifications

#define UserParsingKey @"user"
#define UserClass      @"User"
#define UserEntity  @""

#define UserAccountParsingKey @"userAccount"
#define UserAccountClass      @"UserAccount"
#define UserAccountEntity  @""

#define DOTDetailsParsingKey @"DOTDetails"
#define DOTDetailsClass      @"DOTDetails"
#define DOTDetailsEntity  @""

#define CompanyAdminParsingKey @"CompanyAdmin"
#define CompanyAdminClass      @"CompanyAdmin"
#define CompanyAdminEntity  @""

#define AlertDetailsParsingKey @"Alerts"
#define AlertDetailsClass      @"AlertDetails"
#define AlertDetailsEntity  @""

#define EquiEspecialParsingKey @"equi_especial"
#define EquiEspecialClass      @"EquiEspecial"
#define EquiEspecialEntity  @"CDEspecialEquiList"

#define SubEquiEspecialParsingKey @"sub_equi_especial"
#define SubEquiEspecialClass      @"SubEquiEspecial"
#define SubEquiEspecialEntity  @"CDSubEspecialEquiList"

#define LoadsParsingKey @"loads"
#define LoadsClass   @"Loads"
#define LoadsEntity  @"CDLoads"

#define MatchParsingKey @"matches"
#define MatchClass   @"Matches"
#define MatchEntity  @"CDAllMatches"

#define EquipmentParsingKey @"equipments"
#define EquipmentClass   @"Equipments"
#define EquipmentEntity  @"CDEquipments"

#define DriverParsingKey @"drivers"
#define DriverClass   @"Drivers"

#define OrderParsingKey @"orders"
#define OrderClass   @"Orders"

#define NetworkParsingKey @"mynetwork"
#define NetworkClass   @"MyNetwork"

#define CommentParsingKey @"comments"
#define CommentsClass   @"Comments"

#define CompanyDetailsKey @"CompanyDetails"
#define CompanyDetailsClass   @"CompanyDetails"

#define OfficeDetailsKey @"OfficeDetails"
#define OfficeDetailsClass   @"OfficeDetails"

#define CompanyRequestKey @"company_request"
#define CompanyRequestClass   @"CompanyRequest"

#endif
