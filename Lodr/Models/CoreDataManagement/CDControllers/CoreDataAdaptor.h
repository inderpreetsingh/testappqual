//
//  CoreDataWrapper.h
//  NIPLiOSFramework
//
//  Created by Prerna on 5/21/15.
//  Copyright (c) 2015 Prerna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataAdaptor : NSObject

+(void)getZPK :(NSString *)entityname;
+(void)deleteDataInCoreDB:(NSString *)entityname;
+(void)SaveDataInCoreDB:(NSDictionary *)dict forEntity:(NSString *)entityname;
+(NSArray *) fetchAllDataWhere:(NSString *)condition fromEntity:(NSString *)entityname;
+(NSArray *)fetchAllDatafromEntityNamed :(NSString *)entityname where:(NSString *)condition sortingDescription:(NSSortDescriptor *)sortDescriptor;
@end
