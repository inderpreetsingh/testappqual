//
//  LodrAppConstants.h
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#ifndef LodrAppConstants_h
#define LodrAppConstants_h

#pragma mark - Helper Constants

#define LEFT_DRAWER_WIDTH_PERCENTAGE 1.20f

#define ROOTVIEW [[[UIApplication sharedApplication] keyWindow] rootViewController]
#define NavigationBarHidden(xxx) self.navigationController.navigationBarHidden=xxx;

#define initVCToRedirect(StroyBoardName,VCIdentifer) [[UIStoryboard storyboardWithName:StroyBoardName bundle:NULL]instantiateViewControllerWithIdentifier:VCIdentifer]

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define AppInstance ((AppDelegate*)[[UIApplication sharedApplication]delegate])

#define isService( key ) \
[requestURL isEqualToString: key ]

#define ShowNetworkIndicator(XXX) [UIApplication sharedApplication].networkActivityIndicatorVisible = XXX;


#define TRIM(string)            [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define NS_LOGString(xxx) NSLog(@"%@",xxx);
#define NS_LOGStringWithMessage(yyy,xxx) NSLog(yyy,xxx);
#define NS_LOGInt(xxx) NSLog(@"%d",xxx);

#define DATE_Formatter @"yyyy-MM-dd HH:mm:ss"
#define TIME_ZONE @"UTC"
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)

#define ISVALIDSTRING(str) (str != nil && [str isKindOfClass:[NSNull class]] == NO)
#define ToString(data) [NSString stringWithFormat:@"%@",data]

#pragma mark - Messages

#define NetworkLost @"Internet connection appears to be offline !!"
#define Msg101 @"Something went wrong !! Please try again !!"
#define RequiredFirstname @"First name is required !!"
#define RequiredLastname @"Last name is required !!" 
#define RequiredEmail @"Email is required !!"
#define InvalidEmail @"Invalid Email format !!"
#define RequiredVerifyPassword @"Confirm password is required !!"
#define RequiredPassword @"Password is required !!"
#define RequiredDotNumber @"Dot number is required !!"
#define MismatchEmail @"Password and Confirm password must be same !!"
#define RequiredShippingType @"Shipping Type is required !!" 
#define RequiredAssetType @"Asset Type is required !!" 
#define RequiredAssetDetailCapability @"Please choose asset ability !!" 
#define RequiredEquiname @"Asset name or number is required !!" 
#define RequiredTrailersType @"Asset type required !!"
#define RequiredLoadNumber @"Please enter a unique load number !!"
#define RequiredDescription @"Description is required !!"
#define RequiredEmptyWeight @"Empty Weight is required !!" 
#define RequiredLength @"Length is required !!" 
#define RequiredWidth @"Width is required !!" 
#define RequiredWeight @"Weight is required !!" 
#define RequiredHeight @"Height is required !!"
#define RequiredOfferRate @"Offer Rate is required !!" 
#define RequiredPickupCityState @"Pickup City and State are required !!"
#define RequiredPickupAddress @"Pickup Address is required !!"
#define RequiredPickupTime @"Pickup Time is required !!" 
#define RequiredDelieveryCityState @"Delivery City and State are required !!"
#define RequiredDelieveryTime @"Delivery Time required !!" 
#define RequiredDelieveryAddress @"Delivery Address is required !!" 
#define RequiredViewableTo @"Viewable value is required !!" 
#define RequiredAvailbilityValue @"Availability value is required !!" 
#define RequiredAddressData @"Please add Address !!"
#define RequiredPhoneNumberForDot @"Please add a phone number !!"
#define RequiredStreetName @"Please add street name !!"
#define RequiredCityname @"Please add city name !!"
#define RequiredStatename @"Please add state name !!"
#define RequiredZipcode @"Please add zip code !!"
#define RequiredCompanyname @"Please add company name !!"
#define MaxLimitPhoto @"Maximum 5 photos allowed !!"
#define MaxPhotoSelection @"You can select maximum 5 photos !!"
#define RequiredMapPopupAddress @"Please select the address !!"
#define NoLoadMatchesFound @"No matches found for this load !!"
#define LoadScheduledMessage @"This Load has been scheduled !!"
#define NoLoadFound @"No Load Found !!"
#define NoScheduleFound @"No Schedule Found !!"
#define NoAlertFound @"No Alert Found !!"
#define NoEquipmentsFound @"No Asset Found !!"
#define NoPhotoAvailableCollectionMessage @"Please click on \"Add Pictures\" to attach photo."
#define MailSentSuccessResponse @"Your mail has been sent !!"
#define CallFacilityNotAvailable @"Call facility not available !!"
#define RequiredChoiceAddress @"Please enter office address or choose same as company address."
#define RequiredUserChoiceAddress @"Please enter operating address or choose same as company address."
#define RequiredOfficeAddress @"Please enter operating address."
#define ZeroAlertFound @"There is no alert available !!"
#define ZeroLoadFound @"There is no load available !!"
#define ZeroEquiFound @"There is no asset available !!"
#define LoadMatchedText @"This load has a MATCH"
#define LoadScheduledText @"This load has been LINKED"
#define LoadLinkedText @"This carrier is INTERESTED"
#define RoleSelectionRequired @"Please select your role before register."
#define RoleSelectionUpdateRequired @"Please select your role."
#define PermissionForDriver @"Driver option is available for driver only."
#define PermissionForAssets @"Asset option is available for carrier only."
#define PermissionForLoad @"Load option is available for shipper only."
#define PermissionForCalender @"Calender option is not available for driver."
#define FailedToUpdateLocation @"Error while updating location."
#define PickupTimeSelectFirst @"Please choose pickup time first."
//#define InterestedText @"This carrier is INTERESTED"
#define PushMessageLoadLinkedText @"Your load has been LINKED"

#define LinkButtonText @"ARE YOU INTERESTED?"
//#define NOTINTERESTED @"NOT INTERESTED"
#define NOTINTERESTED @"ALREADY INTERESTED"
#define AlreadyLinkRequestSent @"ALREADY INTERESTED"
#define ScheduleButtonText @"LINK"
#define UnlinkButtonText @"UNLINK"
#define ReportStatusButtonText @"REPORT STATUS"

#define CancelButtonText @"CANCEL"
#define ListSavedButtonText @"SAVED"
#define ListPublishedButtonText @"PUBLISHED" 

#define MailComposerSubjectWhenContact @"Lodr App - Carrier Inquiry"
#define MailComposerBodytext @""
#endif
