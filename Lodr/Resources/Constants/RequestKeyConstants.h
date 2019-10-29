//
//  RequestKeyConstants.h
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#ifndef RequestKeyConstants_h
#define RequestKeyConstants_h

#pragma mark
#pragma mark - StoryBoard ID key

#define APPNAME @"Lodr"
#define SBMAIN @"Main"
#define SBDISPATCHUI @"DispatcherUI"
#define SBAFTERSIGNUP @"AfterSignUp"
#define SBCALENDERUI @"CalenderUI"
#define SBSEARCH @"Search"
#define LOGINVC @"idLoginVC"
#define REGISTERVC @"idRegistrationVC"
#define WELCOMEVC @"idWelcomeVC"
#define HOMEVC @"idHomeVC"
#define WEBCONTENTVC @"idWebContentVC"
#define MENUVC @"idMenuVC"
#define POSTEQUIPMENTVC @"idPostEquipmentVC"
#define POSTLOADVC @"idPostLoadVC"
#define MYLOADLIST @"idMyLoadListVC"
#define MYLOADDETAIL @"idLoadDetailVC"
#define MYLOADLISTDETAILVC @"idLoadListDetailsVC"
#define MYDRIVERLOADDETAILS @"idDriverLoadDetailsVC"
#define MYEQUIPMENTLIST @"idMyEquipmentList"
#define ALLSAVEDLOADLIST @"idAllSavedLoadListVC"
#define ALLSAVEDEQUIPMENTLIST @"idAllSavedEquipmentList"
#define EDITLOADVC @"idEditLoadVC"
#define DOTREGISTRATIONVC @"idDotRegistrationVC"
#define CHOOSELOADTRAILERS @"idChooseLoadTrailers"
#define EQUIPMENTDETAILVC @"idEquipmentDetailVC"
#define EDITASSETVC @"idEditAssetVC"
#define DRIVERLISTVC @"idDriverListVC"
#define DRIVERHOMELISTVC @"idDriverHomeVC"
#define DRIVERREPORTSTATUSVC @"idDriverReportsStatusVC"
#define ALERTNOTIFICATIONVC @"idAlertNotificationsVC"
#define DRIVERPROFILEVC @"idDriverProfileVC"
#define POSTDRIVERVC @"idPostDriverVC"
#define EDITDRIVERVC @"idEditDriverVC"
#define CALENDERLISTVC @"idCalenderListVC"
#define DRIVERLOADLISTVC @"idDriverLoadListVC"
#define ALERNATEQUIPMENTVC @"idAlernateEquimentListVC"
#define CHOOSEEQUITYPEVC @"idChooseEquiTypesVC"
#define ADDASSETVC @"idAddSubAssetVC"
#define SUBDETAILVC @"idSubAssetDetailsVC"
#define EDITSUBASSETVC @"idEditSubAssetVC"
#define CALENDERVC @"idCalendersVC"
#define EDITDOTACCOUNTVC @"idEditDotAccount"
#define EDITOFFICEINFOVC @"idEditOfficeInfoVC"
#define EDITUSERINFOVC @"idEditUserInfoVC"
#define EDITCOMPANYINFOVC @"idEditCompanyInfoVC"
#define SETTINGSVC @"idSettingsVC"
#define DISPATCHLISTVC @"idDispatchListVC"
#define DISPATCHDETAILVC @"idDispatchDetailVC"
#define ADDLOADPOPUPVC @"idAddLoadPopupVC"
#define SEARCHCOMPANYVC @"idSearchCompanyVC"
#define NOTIFICATIONSVC @"idNotificationsVC"
#define Company_Admin_Request_VC @"idCompanyAdminRequestVC"


#pragma mark - List of keys that will be used as request param (post parameter) in API

#pragma mark - Security Request Keys
 #define kMaxResolution 640
#define Req_secret_key @"secret_key"
#define Req_access_key @"access_key"

#pragma mark - Login/Registration Request Keys
#define Req_IsAsync @"is_Asyc"
#define Req_IsSync @"is_sync"
#define Req_email @"email"
#define Req_secure_password @"secure_password"
#define Req_device_token @"device_token"
#define Req_device_type @"device_type"
#define Req_userrole @"userrole"
#define Req_lastname @"lastname"
#define Req_firstname @"firstname"
#define Req_username @"username"
#define Req_phone @"phone"
#define Req_profile @"profile"
#define Req_facebookid @"facebookid"
#define Req_googleid @"googleid"
#define Req_twitterid @"twitterid"
#define Req_cstreet @"company_street"
#define Req_czip @"company_zip"
#define Req_dotstatus @"dotnum_status"
#pragma mark - Load Request Keys

#define Req_Equi_Name @"equi_name"
#define Req_Equi_Length @"equi_length"
#define Req_Equi_Weight @"equi_weight"
#define Req_Equi_Width @"equi_width"
#define Req_Equi_Height @"equi_height"
#define Req_Equi_Availability @"equi_availablity"
#define Req_Equi_Notes @"equi_notes"
#define Req_Equi_Latitude @"equi_latitude"
#define Req_Equi_EmptyWeight @"equi_empty_weight"
#define Req_Equi_Longitude @"equi_longitude"
#define Req_Equi_VideoThumb @"Equipment_VideoThumb"
#define Req_Equi_DocThumb @"Equipment_DocThumb"
#define Req_Equi_Doc @"Equipment_Doc"
#define Req_Equit_Video @"Equipment_Video"
#define Req_Equi_Photo1 @"Equipment_Photo1"
#define Req_Equi_Photo2 @"Equipment_Photo2"
#define Req_Equi_Photo3 @"Equipment_Photo3"
#define Req_Equi_Photo4 @"Equipment_Photo4"
#define Req_Equi_Photo5 @"Equipment_Photo5"
#define Req_E_Id   @"e_id"
#define Req_Load_Number  @"load_number"
#define Req_Es_Id   @"es_id"
#define Req_User_Id   @"user_id"
#define Req_Load_Status   @"load_status"
#define Req_Delay_Reason   @"delay_reason"
#define Req_Load_Description   @"load_description"
#define Req_Load_Width   @"load_width"
#define Req_Load_Height   @"load_height"
#define Req_Load_Length   @"load_length"
#define Req_Load_Weight   @"load_weight"
#define Req_Offer_Rate   @"offer_rate"
#define Req_Is_Best_Offer   @"is_bestoffer"
#define Req_Pickup_City   @"pickup_city"
#define Req_Pickup_State   @"pickup_state"
#define Req_Pickup_Country   @"pickup_country"
#define Req_Pickup_Address   @"pickup_address"
#define Req_Pickup_Latitude   @"pickup_latitude"
#define Req_Pickup_Longitude   @"pickup_longitude"
#define Req_Pickup_Time   @"pickup_time"
#define Req_Delivery_City   @"delivery_city"
#define Req_Delivery_State   @"delivery_state"
#define Req_Delivery_Country   @"delivery_country"
#define Req_Delivery_Address   @"delivery_address"
#define Req_Delivery_Latitude   @"delivery_latitude"
#define Req_Delivery_Longitude   @"delivery_longitude"
#define Req_Delivery_Time   @"delivery_time"
#define Req_Visible_To   @"visiable_to"
#define Req_Is_Allow_Comment   @"is_allow_comment"
#define Req_Notes   @"notes"
#define Req_Is_Publish   @"is_publish"
#define Req_Load_Video_Thumb   @"Load_VideoThumb"
#define Req_Load_Doc_Thumb   @"Load_DocThumb"
#define Req_Deleted_img_ids @"deleted_image_ids"
#define Req_Load_Photo1 @"Load_Photo1"
#define Req_Load_Photo2 @"Load_Photo2"
#define Req_Load_Photo3 @"Load_Photo3"
#define Req_Load_Photo4 @"Load_Photo4"
#define Req_Load_Photo5 @"Load_Photo5"
#define Req_Load_Video @"Load_Video"
#define Req_Load_Doc @"Load_Doc"
#define Req_User_role @"user_role"
#define Req_Role @"role"
#define Req_Phone_no @"phone_no"
#define Req_City @"city"
#define Req_State @"state"
#define Req_DutyType @"duty_type"
#define Req_Country @"country"
#define Req_UserLatitude @"user_latitude"
#define Req_UserLongitude @"user_longitude"
#define Req_CompanyName @"company_name"
#define Req_OfficeAddress @"office_address"
#define Req_OperatingAddress @"operating_address"
#define Req_DotNumber @"dot_number"
#define Req_McNumber @"mc_number"
#define Req_CloseTime @"closetime"
#define Req_OpenTime @"opentime"
#define Req_Pref_id @"pref_id"
#define Req_isPickup @"is_pickup"

#define Req_Ofiice_Fax @"office_fax_no"
#define Req_SecondaryEmailId @"secondary_email_id"
#define Req_CmpnyPhoneNo @"cmpny_phone_no"
#define Req_CompanyAddress @"company_address"
#define Req_Office_Phone @"office_phone"
#define Req_Office_name @"office_name"
#define Req_FromIndex @"fromIndex"
#define Req_ToIndex @"toIndex"
#define Req_GUID @"GUID"
#define Req_LoadId @"load_id"
#define Req_EquiId @"equi_id"
#define Req_New_EquiId @"New_equi_id"
#define Req_OrderFromId @"order_from_id"
#define Req_OrderToId @"order_to_id"
#define Req_OrderType @"order_type"
#define Req_matchid @"matchid"
#define Req_is_like @"is_like"
#define Req_f_from_id @"f_from_id"
#define Req_f_to_id @"f_to_id"
#define Req_is_fav @"is_fav"
#define Req_is_hide @"is_hide"
#define Req_is_contacted @"is_contacted"
#define Req_identifier @"id"
#define Req_AllMatchesId @"matchesIdList"
#define Req_isLoadLink @"isLoadLink"
#define Req_isLoadAlert @"isLoadAlert"
#define Req_DateStart @"dateStart"
#define Req_Radius @"radius_value"
#define Req_DateEnd @"dateEnd"
#define Req_OrderType @"order_type"
#define Req_MonthNum @"monthnumber"
#define Req_YearNum @"yearnumber"
#define Req_Equi_Address @"equi_address"
#define Req_driver_id @"driver_id"
#define Req_driver_user_id @"driver_user_id"
#define Req_LastEquiAddess @"last_equi_address"
#define Req_LastEquiStatecode @"last_equi_statecode"
#define Req_AssetTypeId @"asset_type_id"
#define Req_AssetAbilityId @"asset_ability_id"
#define Req_LoadName @"load_name"
#define Req_UnitMeasure @"measure_unit"
#define Req_BolPod @"bol_pod"
#define Req_Qty @"load_qty"
#define Req_SupportId @"support_id"
#define Req_PowerId @"power_id"
#define Req_DriverId @"driver_id"
#define Req_TruckArray @"arrTrucks"
#define Req_is_Load_Dispatched   @"is_Load_Dispatched"
#define Req_CommentText @"comment"
#define Req_Comment_Count @"count"
#define Req_Comment_Id @"comment_id"

#pragma mark - coredata keys

#define CdMatchStatus @"matchOrderStatus"
#define CdMatchId @"matchId"
#define CdFavourite @"isFavourite"
#define CdHide @"isHide"
#define CdLike @"isLike"
#define CdContacted @"isContacted"

#pragma mark - Useful key that will returned as response from API

#define APIResponseStatus [[sender responseDict] valueForKey:@"status"]
#define APIResponseMessage [[sender responseDict] valueForKey:@"message"]
#define APIResponseOrderId [[sender responseDict] valueForKey:@"Order_id"]
#define APIResponseToken [[sender responseDict] valueForKey:@"usertoken"]
#define APITotalMatches [[sender responseDict] valueForKey:@"TotalMatches"]
#define APITotalLoads [[sender responseDict] valueForKey:@"TotalLoads"]
#define APITotalLoad [[sender responseDict] valueForKey:@"TotalLoad"]
#define APITotalRecord [[sender responseDict] valueForKey:@"TotalRecord"]
#define APITotalEquipmentsList [[sender responseDict] valueForKey:@"TotalEquipment"]

#define APITotalContacted [[sender responseDict] valueForKey:@"TotalContacted"]
#define APITotalAlerts [[sender responseDict] valueForKey:@"TotalAlerts"]
#define APITotalEquipments [[sender responseDict] valueForKey:@"TotalEquipments"]
#define APIIsPublished [[sender responseDict] valueForKey:@"ispublished"]
#define APITotalLoadAlerts [[sender responseDict] valueForKey:@"TotalLoadAlerts"]
#define APITotalAssetAlerts [[sender responseDict] valueForKey:@"TotalAssetAlerts"]
#define APIIsLoad [[sender responseDict] valueForKey:@"isLoad"]
#define APIDeletedId [[sender responseDict] valueForKey:@"deletedId"]
#define APIIsContacted [[sender responseDict] valueForKey:@"iscontacted"]
#define APICurrent_DOT_status [[sender responseDict] valueForKey:@"Current_DOT_status"]


#define APISuccess @"success"
#define APIFailure @"failed"

#pragma mark - User Default Keys

#define SavedSignedIn @"SIGNED_IN"
#define SavedUserId @"USER_ID"
#define SavedSecretKey @"USER_TOKEN"
#define SavedDeviceToken @"DEVICE_TOKEN"
#define SavedAccessKey @"GENERATED_ACCESS_KEY"
#define SavedUserData @"USER_DATA"
#define SavedDriverData @"DRIVER_DATA"
#define SavedDOTData @"DOT_DATA"
#define SavedUserAccountData @"USER_AC_DATA"
#define SavedUserSocialProfileURL @"USER_SOCIAL_PROFILEURL"
#define SavedUserEmail @"USER_EMAIL"
#define SavedFlagUserRoleCreation @"USER_ROLE_CREATED"
#define SavedRadiusValue @"MATCHES_RADIUS"
#define SavedRadius @"MATCHES_RADIUS_VALUE"
#define SavedAvailability @"AVAILABILITY_ASSET"
#define SavedAvailabilityValue @"AVAILABILITY_ASSET_VALUE"
#pragma mark - Custom Popup Titles

#define EquipmentListPopUpTitle @"Shipping Type"
#define UniteMeasurePopUpTitle @"Unit Of Measure"
#define EspecialEquiPopUpTitle @"Asset Type"
#define VisibilityTitle @"Viewable To"
#define AvailablilityTitle @"Availability"
#define LocationPopUpTitle @"Select Location"
#define MilesPopUpTitle @"Select Radius"

#define AssetTypePopUp @"Select Asset Type"
#define DriverPopUp @"Select Driver"
#define TrailerPopUp @"Select Trailer"
#define PoweredPopUp @"Select Powered Asset"
#define SupportPopUp @"Select Support Asset"

#pragma mark - NotificationCenter Names

#define kPushCreateORSavedLoad @"PushCreateORSavedLoad"
#define NCNamedDismissView @"dismissview"
#define NCNamedSetPickupAddress @"SetSelectedPickupAddressData"
#define NCNamedSetAddress @"SetSelectedAddressData"
#define NCNamedRefreshAssetList @"RefershAssetList"
#define NCNamedRefreshLoadList @"RefershLoadList"
#define NCNamedEditAddress @"EditSelectedAddressData"
#define NCNamedSetWelcomeScreenAddress @"SetSelectedWelcomeAddressData"
#define NCNamedSetSelectedTruckLocationData @"SetSelectedTruckLocationData"
#define NCNamedSetSelectedSubAssetLocationData @"SetSelectedSubAssetLocationData"
#define NCNamedSetDelieveryAddress @"SetSelectedDelieveryAddressData"
#define NCNamedZSYDismissPopup @"dismisspopup"
#define NCNamedSelectedImageCount @"TotalImageSelected"
#define NCNamedRefreshLoadTable @"LoadRealodData"
#define NCNamedRefreshEquiTable @"EquipmentRealodData"
#endif
