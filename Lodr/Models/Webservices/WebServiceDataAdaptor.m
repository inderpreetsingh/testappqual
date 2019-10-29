#import "WebServiceDataAdaptor.h"
#import <objc/runtime.h>
#import "Function.h"

#import "Loads.h"
#import "CDLoads.h"
#import "Matches.h"
#import "CDAllMatches.h"
#import "CoreDataHelper.h"
#import "CoreDataAdaptor.h"

@implementation WebServiceDataAdaptor

@synthesize arrParsedData;

-(NSArray *) autoParse:(NSDictionary *) allValues forServiceName:(NSString *)requestURL
{
    arrParsedData = [NSArray new];
    if (isService(URLLogin))
    {
        arrParsedData = [self processJSONData:allValues forClass:UserClass forEntity:nil withJSONKey:UserParsingKey];
    }
    else if (isService(URLRegistration))
    {
        arrParsedData = [self processJSONData:allValues forClass:UserClass forEntity:nil withJSONKey:UserParsingKey];
    }
    else if (isService(URLLoginWithSocialMedia))
    {
        arrParsedData = [self processJSONData:allValues forClass:UserClass forEntity:nil withJSONKey:UserParsingKey];
    }
    else if (isService(URLCreateRoleAccount))
    {
        arrParsedData = [self processJSONData:allValues forClass:UserClass forEntity:nil withJSONKey:UserParsingKey];
    }
    else if (isService(URLUpdateRoleAccount))
    {
        arrParsedData = [self processJSONData:allValues forClass:UserClass forEntity:nil withJSONKey:UserParsingKey];
    }
    else if (isService(URLDotNumberDetail))
    {
        arrParsedData = [self processJSONData:allValues forClass:DOTDetailsClass forEntity:nil withJSONKey:DOTDetailsParsingKey];
    }
    else if (isService(URLGetEquipmentEspecial))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquiEspecialClass forEntity:EquiEspecialEntity withJSONKey:EquiEspecialParsingKey];
    }
    else if (isService(URLGetEquipmentSubEspecial))
    {
        arrParsedData = [self processJSONData:allValues forClass:SubEquiEspecialClass forEntity:SubEquiEspecialEntity withJSONKey:SubEquiEspecialParsingKey];
    }
    else if (isService(URLGetAllLoadByUserId))
    {
        arrParsedData = [self processJSONData:allValues forClass:LoadsClass forEntity:nil withJSONKey:LoadsParsingKey];
    }
    else if (isService(URLGetAllEquipmentByUserId))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquipmentClass forEntity:nil withJSONKey:EquipmentParsingKey];
    }
    else if (isService(URLFetchAllLoadByUserId))
    {
        arrParsedData = [self processJSONData:allValues forClass:LoadsClass forEntity:nil withJSONKey:LoadsParsingKey];
    }
    else if (isService(URLFetchAllEquipmentByUserId))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquipmentClass forEntity:nil withJSONKey:EquipmentParsingKey];
    }
    else if (isService(URLGetAllAlertsbyUserId))
    {
        arrParsedData = [self processJSONData:allValues forClass:AlertDetailsClass forEntity:nil withJSONKey:AlertDetailsParsingKey];
    }
    else if (isService(URLGetAllAssetsSheduledByMonth))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquipmentClass forEntity:nil withJSONKey:EquipmentParsingKey];
    }
    else if (isService(URLGetAllLinkedAssetList))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquipmentClass forEntity:nil withJSONKey:EquipmentParsingKey];
    }
    else if (isService(URLGetDriverDetail))
    {
        arrParsedData = [self processJSONData:allValues forClass:DriverClass forEntity:nil withJSONKey:DriverParsingKey];
    }
    else if (isService(URLGetScheduledDatesAccordingToYear))
    {
        arrParsedData = [self processJSONData:allValues forClass:OrderClass forEntity:nil withJSONKey:OrderParsingKey];
    }
    else if (isService(URLGetDriverAssignedLoads))
    {
        arrParsedData = [self processJSONData:allValues forClass:LoadsClass forEntity:nil withJSONKey:LoadsParsingKey];
    }
    else if (isService(URLGetDriversByCompany))
    {
        arrParsedData = [self processJSONData:allValues forClass:NetworkClass forEntity: nil withJSONKey:NetworkParsingKey];
    }
    else if (isService(URLGetAVailableDriversByCompany))
    {
        arrParsedData = [self processJSONData:allValues forClass:NetworkClass forEntity: nil withJSONKey:NetworkParsingKey];
    }
    else if (isService(URLGetAllLoadsSheduledByMonth))
    {
        arrParsedData = [self processJSONData:allValues forClass:LoadsClass forEntity: nil withJSONKey:LoadsParsingKey];
    }
    else if (isService(URLGetAllLinkedLoadList))
    {
        arrParsedData = [self processJSONData:allValues forClass:LoadsClass forEntity:nil withJSONKey:LoadsParsingKey];
    }
    else if (isService(URLGetAllLinkedLoadForSubAssets))
    {
        arrParsedData = [self processJSONData:allValues forClass:LoadsClass forEntity:nil withJSONKey:LoadsParsingKey];
    }
    else if (isService(URLGetAllLinkedLoadListForSupportAsset))
    {
        arrParsedData = [self processJSONData:allValues forClass:LoadsClass forEntity:nil withJSONKey:LoadsParsingKey];
    }
    else if (isService(URLGetAlternateEquipmentList))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquipmentClass forEntity:nil withJSONKey:EquipmentParsingKey];
    }
    else if (isService(URLGetAllEquiSubTypes))
    {
        arrParsedData = [self processJSONData:allValues forClass:SubEquiEspecialClass forEntity:nil withJSONKey:SubEquiEspecialParsingKey];
    }
    else if (isService(URLGetSupportAssetsCalender))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquipmentClass forEntity:nil withJSONKey:EquipmentParsingKey];
    }
    else if (isService(URLGetPoweredAssetsCalender))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquipmentClass forEntity:nil withJSONKey:EquipmentParsingKey];
    }
    else if (isService(URLGetAllLinkedLoadData))
    {
        arrParsedData = [self processJSONData:allValues forClass:LoadsClass forEntity:nil withJSONKey:LoadsParsingKey];
    }
    else if (isService(URLGetAllDriver))
    {
        arrParsedData = [self processJSONData:allValues forClass:MatchClass forEntity:nil withJSONKey:MatchParsingKey];
    }
    else if (isService(URLGetAllTrailers))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquipmentClass forEntity:nil withJSONKey:EquipmentParsingKey];
    }
    else if (isService(URLGetAllPowerAsset))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquipmentClass forEntity:nil withJSONKey:EquipmentParsingKey];
    }
    else if (isService(URLGetAllSupportAsset))
    {
        arrParsedData = [self processJSONData:allValues forClass:EquipmentClass forEntity:nil withJSONKey:EquipmentParsingKey];
    }
    else if (isService(URLPOSTNEWCOMMENT) || isService(URLGETMORECOMMENT)){
        
        arrParsedData = [self processJSONData:allValues forClass:CommentsClass forEntity:nil withJSONKey:CommentParsingKey];
    }
    else if (isService(URLSearchCompany))
    {
        arrParsedData = [self processJSONData:allValues forClass:CompanyDetailsClass forEntity:nil withJSONKey:CompanyDetailsKey];
    }
    else if (isService(URLSearchOffice) || isService(URLFetchAllOffice))
    {
        arrParsedData = [self processJSONData:allValues forClass:OfficeDetailsClass forEntity:nil withJSONKey:OfficeDetailsKey];
    }
    else if (isService(URLGetCompanyRequest) || isService(URLFetchCompanyAdminRequests) || isService(URLFetchOfficeAdminRequests))
    {
        arrParsedData = [self processJSONData:allValues forClass:CompanyRequestClass forEntity:nil withJSONKey:CompanyRequestKey];
    }

    else if (isService(URLFetchCompanyAdmin) || isService(URLFetchOfficeAdmin))
    {
        //arrParsedData = [self processJSONData:allValues forClass:CompanyAdminClass forEntity:nil withJSONKey:CompanyAdminParsingKey];
    }

    return arrParsedData;
}

#pragma mark - Helper Method
//-(void)processJSONToUserDefaults:(NSDictionary *)dict withJSONKeys:(NSMutableArray *)json_Keys
//{
//    for(int i =0;i<[json_Keys count];i++)
//    {
//        [Function setStringValueToUserDefaults:[Function getStringForKey:[json_Keys objectAtIndex:i] fromDictionary:dict] ForKey:[json_Keys objectAtIndex:i]];
//    }
//}

-(NSArray *) processJSONData: (NSDictionary *)dict forClass:(NSString *)classname forEntity:(NSString *)entityname withJSONKey:(NSString *)json_Key
{
    NSMutableArray *arrProcessedData = [NSMutableArray array];
    [CoreDataAdaptor deleteDataInCoreDB:entityname];
    for(int i =0;i<[[dict objectForKey:json_Key] count];i++)
    {
        NSDictionary *allvalues = [[dict objectForKey:json_Key] objectAtIndex:i];
        id objClass = [[[NSClassFromString(classname) alloc] init] initWithDictionary:allvalues];
        [arrProcessedData addObject:objClass];   
        if(![Function stringIsEmpty:entityname])
        {
            [CoreDataAdaptor SaveDataInCoreDB:[self processObjectForCoreData:objClass] forEntity:entityname];
        }
    }
    return arrProcessedData;
}

-(NSArray *) processJSONDataWithForLoadData :(NSDictionary *)dict forClass:(NSString *)classname forEntity:(NSString *)entityname withJSONKey:(NSString *)json_Key
{
    NSMutableArray *arrProcessedData = [NSMutableArray array];
    [CoreDataAdaptor deleteDataInCoreDB:entityname];
    [CoreDataAdaptor deleteDataInCoreDB:MatchEntity];
    
    for (int i =0;i<[[dict objectForKey:json_Key] count];i++)
    {
        NSDictionary *allvalues = [[dict objectForKey:json_Key] objectAtIndex:i];
        id objClass = [[[NSClassFromString(classname) alloc] init] initWithDictionary:allvalues];
        [arrProcessedData addObject:objClass];   

        if(![Function stringIsEmpty:entityname])
        {
            Loads *objLoad = objClass;
            [CoreDataAdaptor SaveDataInCoreDB:[self processObjectForCoreData:objLoad] forEntity:entityname];
          
            if(objLoad.matches.count >0)
            {
                Matches *objMatches  = [Matches new];
                
                for (objMatches  in objLoad.matches) 
                {
                    [CoreDataAdaptor SaveDataInCoreDB:[self processObjectForCoreData:objMatches] forEntity:MatchEntity];
                }
            }
        }
    }
    return arrProcessedData;
}

- (NSDictionary *)processObjectForCoreData:(id)obj
{
    NSArray *aVoidArray =@[@"NSDate"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *key = @(property_getName(properties[i]));
        if (![aVoidArray containsObject: key] )
        {
            if ([obj valueForKey:key]!=nil)
            {
                dict[key] = [obj valueForKey:key];
            }
        }
    }
    return dict;
}

@end
