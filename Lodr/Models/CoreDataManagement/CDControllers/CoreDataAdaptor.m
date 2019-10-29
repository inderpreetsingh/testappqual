//
//  CoreDataWrapper.m
//  NIPLiOSFramework
//
//  Created by Prerna on 5/21/15.
//  Copyright (c) 2015 Prerna. All rights reserved.
//

#import "CoreDataAdaptor.h"
#import "CoreDataHelper.h"
#import "NSManagedObject+CoreDataActive.h"
NSFetchedResultsController *fetchedResultController;

@implementation CoreDataAdaptor

#pragma mark - Helper Methods

+ (void)SaveDataInCoreDB:(NSDictionary *)dict forEntity:(NSString *)entityname
{
    [[[NSClassFromString(entityname) create] insert:dict]save];
}

+(void)deleteDataInCoreDB:(NSString *)entityname
{
    [NSClassFromString(entityname) clear];
}
+(void)getZPK :(NSString *)entityname
{
	[CoreDataHelper getzpk:NSClassFromString(entityname)];
}

+ (NSArray *) fetchAllDataWhere:(NSString *)condition fromEntity:(NSString *)entityname
{
	@try {
		NSArray *subcategorydata= [[NSClassFromString(entityname) query]where:condition].all;
        //NSLog(@"%@",subcategorydata.description);
		return subcategorydata;
	}
	@catch (NSException *exception) {
		//NSLog(@"Exception %@",exception.description);
	}
	
}

+(NSArray *)fetchAllDatafromEntityNamed :(NSString *)entityname where:(NSString *)condition sortingDescription:(NSSortDescriptor *)sortDescriptor
{
	fetchedResultController = [[[[[NSClassFromString(entityname) query]where:condition]order:[NSArray arrayWithObject:sortDescriptor]]sectionNameKeyPath:@""]fetchedResultsController];
    return fetchedResultController.fetchedObjects;
}


@end
