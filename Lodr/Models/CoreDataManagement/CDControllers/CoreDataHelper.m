//
//  MMPCoreDataHelper.h
//


#import "CoreDataHelper.h"
#import "CDAllMatches.h"
NSString * const CoreDataErrorDomain = @"org.narola.coredata";
NSString * const DataAccessSaveErrorNotification = @"MMPDataAccessSaveErrorNotification";
NSString * const DataAccessDidSaveNotification = @"MMPDataAccessDidSaveNotification";

@interface CoreDataHelper () {
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContextForBackgroundWriter;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContextForMainThread;

@end

@implementation CoreDataHelper

static NSString * const MP_PERTHREADKEY_MOC = @"MPPerThreadManagedObjectContext";

@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - General

+ (instancetype)instance
{
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initSingletonInstance];
    });
    return shared;
}

- (instancetype)initSingletonInstance
{
     return [super init];
}

- (NSString *)appName
{
    return APPNAME;
}

- (NSString *)databaseName
{
    @synchronized(self)
    {
        if (!_databaseName)
            _databaseName = [[[self appName] stringByAppendingString:@".sqlite"] copy];
    }
    return _databaseName;
}

- (NSString *)modelName {
    @synchronized(self) {
        if (!_modelName)
            _modelName = [[self appName] copy];
    }
    return _modelName;
}

- (NSManagedObjectModel *)managedObjectModel
{
    @synchronized(self)
    {
        if (!_managedObjectModel)
        {
            NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self modelName] withExtension:@"momd"];
            if (!modelURL)
            {
                modelURL = [[NSBundle mainBundle] URLForResource:[self modelName] withExtension:@"mom"];
            }
            if (!modelURL)
            {
                NSLog(@"[ERROR] Unable to find model with name: %@", [self modelName]);
            }
            _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        }
    }
    return _managedObjectModel;
}

- (BOOL)isOSX {
    if (NSClassFromString(@"UIDevice")) return NO;
    return YES;
}

- (void)createApplicationSupportDirIfNeeded:(NSURL *)url {
    if ([[NSFileManager defaultManager] fileExistsAtPath:url.absoluteString]) return;
    
    [[NSFileManager defaultManager] createDirectoryAtURL:url
                             withIntermediateDirectories:YES attributes:nil error:nil];
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)applicationSupportDirectory {
    return [[[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory
                                                    inDomains:NSUserDomainMask] lastObject]
            URLByAppendingPathComponent:[self appName]];
}

- (NSString *)applicationDocumentsDirectoryAsString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (NSString *)applicationSupportDirectoryAsString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (NSURL *)sqliteStoreURL {
    NSURL *directory = [self isOSX] ? self.applicationSupportDirectory : self.applicationDocumentsDirectory;
    NSURL *databaseDir = [directory URLByAppendingPathComponent:[self databaseName]];
	NSLog(@"Database directory------------- : %@",databaseDir);
    [self createApplicationSupportDirIfNeeded:directory];
    return databaseDir;
}

- (NSString *)sqliteStorePath {
    return [[self applicationDocumentsDirectoryAsString] stringByAppendingPathComponent:[self databaseName]];
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithStoreType:(NSString *const)storeType
                                                                 storeURL:(NSURL *)storeURL {
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption: @YES,
                               NSInferMappingModelAutomaticallyOption: @YES };
    
    NSError *error = nil;
    if (![coordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:options error:&error])
        NSLog(@"ERROR WHILE CREATING PERSISTENT STORE COORDINATOR! %@, %@", error, [error userInfo]);
    
    return coordinator;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    @synchronized(self) {
        if (!_persistentStoreCoordinator)
            _persistentStoreCoordinator = [self persistentStoreCoordinatorWithStoreType:NSSQLiteStoreType storeURL:[self sqliteStoreURL]];
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContextForBackgroundWriter
{
	@try
	{
    @synchronized(self) {
        if (!_managedObjectContextForBackgroundWriter) {
            _managedObjectContextForBackgroundWriter = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            [_managedObjectContextForBackgroundWriter setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
        }
    }
    return _managedObjectContextForBackgroundWriter;
	}
	@catch (NSException *exception)
	{
		//NSLog(@"Exception found :%@",exception.description);
		//[base displayToast:@"Something wrong, Please try again."];
	}
}

- (NSManagedObjectContext *)managedObjectContextForMainThread
{
    @synchronized(self) {
        if (!_managedObjectContextForMainThread) {
            _managedObjectContextForMainThread = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            _managedObjectContextForMainThread.parentContext = [self managedObjectContextForBackgroundWriter];
        }
    }
    return _managedObjectContextForMainThread;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if ([NSThread isMainThread]) {
        return [self managedObjectContextForMainThread];
    } else {
        
        NSThread *currentThread = [NSThread currentThread];
        NSMutableDictionary *threadDictionary = [currentThread threadDictionary];
        
        NSManagedObjectContext *managedObjectContextForCurrentThread = [threadDictionary objectForKey:MP_PERTHREADKEY_MOC];
        
        if (managedObjectContextForCurrentThread == nil) {
            managedObjectContextForCurrentThread = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            managedObjectContextForCurrentThread.parentContext = [self managedObjectContextForMainThread];
            [threadDictionary setObject:managedObjectContextForCurrentThread forKey:MP_PERTHREADKEY_MOC];
        }
        
        return managedObjectContextForCurrentThread;        
    }
}

- (void)saveContextForMainThread
{
	@try
	{
		NSError *error;
		if ([[self managedObjectContextForMainThread] save:&error]) {
			// save to background writer
			[[self managedObjectContextForBackgroundWriter] performBlock:^{
				NSError *error;
				if (![[self managedObjectContextForBackgroundWriter] save:&error]) {
					[[NSNotificationCenter defaultCenter] postNotificationName:DataAccessSaveErrorNotification
																		object:nil
																	  userInfo:@{@"error" : error}];
				} else {
					[[NSNotificationCenter defaultCenter] postNotificationName:DataAccessDidSaveNotification
																		object:nil
																	  userInfo:nil];
				}
			}];
		}
		else {
			[[NSNotificationCenter defaultCenter] postNotificationName:DataAccessSaveErrorNotification
																object:nil
															  userInfo:@{@"error" : error}];
		}

   	}
	@catch (NSException *exception)
	{
		//BaseVC *base=[BaseVC new];
		NSLog(@"Exception found :%@",exception.description);
	//	[base displayToast:@"Something wrong ,Please try again."];
	}
}

- (void)_save
{
    if ([NSThread isMainThread])
	{
		[self saveContextForMainThread];
    }
	else {
        NSError *error;
        if ([[self managedObjectContext] save:&error]) {
            // save to main thread
            [[self managedObjectContextForMainThread] performBlock:^{
                [self saveContextForMainThread];
            }];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:DataAccessSaveErrorNotification
                                                                object:nil
                                                              userInfo:@{@"error" : error}];
        }
    }
}

+ (void)save
{
    [[CoreDataHelper instance] _save];
}

#pragma mark - Create, update, and delete

- (id)_createObjectOfEntity:(Class)entityClass
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(entityClass)
                                              inManagedObjectContext:managedObjectContext];
    
    NSManagedObject *managedObject = [[NSManagedObject alloc] initWithEntity:entity
                                              insertIntoManagedObjectContext:managedObjectContext];
	return managedObject;
}

+ (id)createObjectOfEntity:(Class)entityClass
{
    return [[CoreDataHelper instance] _createObjectOfEntity:entityClass];
}

- (NSEntityDescription *)_entityDescriptionOf:(Class)entityClass
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    return [NSEntityDescription entityForName:NSStringFromClass(entityClass)
                                              inManagedObjectContext:managedObjectContext];
}

+ (NSEntityDescription *)entityDescriptionOf:(Class)entityClass
{
    return [[CoreDataHelper instance] _entityDescriptionOf:entityClass];
}

- (void)_deleteObject:(NSManagedObject *)object
{
    [[self managedObjectContext] deleteObject:object];
}

+ (void)deleteObject:(NSManagedObject *)object
{
    [[CoreDataHelper instance] _deleteObject:object];
}
//pu
+ (void)deleteObjectsOfEntity:(Class)entityClass where:(NSString *)condition
{
	[[CoreDataHelper instance] _deleteObjectsOfEntity:entityClass where:condition];
}
-(void)_deleteObjectsOfEntity:(Class)entityClass where:(NSString *)condition
{
	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(entityClass)
											  inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	NSPredicate *condtn=[NSPredicate predicateWithFormat:condition];
	[fetchRequest setPredicate:condtn];
	NSError *error;
	NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
	
	
	for (NSManagedObject *managedObject in items) {
		[managedObjectContext deleteObject:managedObject];
	}
	
	if (![managedObjectContext save:&error]) {
		NSLog(@"[ERROR] Error deleting %@ - error:%@", NSStringFromClass(entityClass), error);
	}
}
//end
- (void)_deleteObjectsOfEntity:(Class)entityClass
{
	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(entityClass)
											  inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	
	NSError *error;
	NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
	
	
	for (NSManagedObject *managedObject in items) {
		[managedObjectContext deleteObject:managedObject];
	}
	
	if (![managedObjectContext save:&error]) {
		NSLog(@"[ERROR] Error deleting %@ - error:%@", NSStringFromClass(entityClass), error);
	}
}
+ (void)deleteObjectsOfEntity:(Class)entityClass
{
	[[CoreDataHelper instance] _deleteObjectsOfEntity:entityClass];
}


#pragma mark - Utilities
// Utilities adapted from https://github.com/supermarin/ObjectiveRecord

+ (NSPredicate *)predicateFromDictionary:(NSDictionary *)dict
{
    NSMutableArray *subpredicates = [NSMutableArray array];
    for (NSString* key in dict) {
        [subpredicates addObject:[NSPredicate predicateWithFormat:@"%K = %@", key, [dict objectForKey:key]]];
    }
    
    return [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
}

+ (NSPredicate *)predicateFromObject:(id)condition {
    return [self predicateFromObject:condition arguments:NULL];
}

+ (NSPredicate *)predicateFromObject:(id)condition arguments:(va_list)arguments
{
    if ([condition isKindOfClass:[NSPredicate class]])
        return condition;
    
    if ([condition isKindOfClass:[NSString class]])
        return [NSPredicate predicateWithFormat:condition arguments:arguments];
    
    if ([condition isKindOfClass:[NSDictionary class]])
        return [self predicateFromDictionary:condition];
    
    return nil;
}

+ (NSSortDescriptor *)sortDescriptorFromDictionary:(NSDictionary *)dict
{
    BOOL isAscending = ![[[dict.allValues objectAtIndex:0] uppercaseString] isEqualToString:@"DESC"];
    return [NSSortDescriptor sortDescriptorWithKey:[dict.allKeys objectAtIndex:0]
                                         ascending:isAscending];
}

+ (NSSortDescriptor *)sortDescriptorFromString:(NSString *)order
{
    NSArray *result = [order componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray *components = [NSMutableArray array];
    for (NSString *string in result) {
        if (string.length > 0) {
            [components addObject:string];
        }
    }
    
    NSString *key = [components firstObject];
    NSString *value = [components count] > 1 ? components[1] : @"ASC";
    
    return [self sortDescriptorFromDictionary:@{key: value}];
    
}

+ (NSSortDescriptor *)sortDescriptorFromObject:(id)order
{
    if ([order isKindOfClass:[NSSortDescriptor class]])
        return order;
    
    if ([order isKindOfClass:[NSString class]])
        return [self sortDescriptorFromString:order];
    
    if ([order isKindOfClass:[NSDictionary class]])
        return [self sortDescriptorFromDictionary:order];
    
    return nil;
}

+ (NSArray *)sortDescriptorsFromObject:(id)order
{
    if (!order) {
        return nil;
    }
    
    if ([order isKindOfClass:[NSString class]])
        order = [order componentsSeparatedByString:@","];
    
    if ([order isKindOfClass:[NSArray class]]) {
        NSMutableArray *ret = [NSMutableArray array];
        for (id object in order) {
            [ret addObject:[self sortDescriptorFromObject:object]];
        }
        return ret;
    }
    
    return @[[self sortDescriptorFromObject:order]];
}

+ (id)objectWithID:(NSManagedObjectID *)objectID
{
    return [[[CoreDataHelper instance] managedObjectContext] objectWithID:objectID];
}

+(void)getzpk :(Class)entityClass
{
	NSManagedObjectContext *managedObjectContext = [[CoreDataHelper instance] managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(entityClass)
											  inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	NSError *error;
	NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
	NSLog(@"%@", [items valueForKey:@"objectID"]);
}
#pragma mark - Query producing multiple objects

+ (NSArray *)objectsOfEntity:(Class)entityClass
                       where:(id)condition
                       order:(id)order
                       limit:(NSNumber *)numberOfRecords
                      offset:(NSNumber *)fromRecordNum
                       error:(NSError **)error
{
    return [CoreDataHelper objectsOfEntity:entityClass
                                withPredicate:[CoreDataHelper predicateFromObject:condition]
                              sortDescriptors:[CoreDataHelper sortDescriptorsFromObject:order]
                                   fetchLimit:numberOfRecords
                                  fetchOffset:fromRecordNum
                                        error:error];
}

- (NSArray *)_objectsOfEntity:(Class)entityClass
                withPredicate:(NSPredicate *)predicate
              sortDescriptors:(NSArray *)sortDescriptors
                   fetchLimit:(NSNumber *)fetchLimit
                  fetchOffset:(NSNumber *)fetchOffset
                        error:(NSError **)error
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:NSStringFromClass(entityClass)
                                   inManagedObjectContext:managedObjectContext]];
    if (predicate) {
        [request setPredicate:predicate];
    }
    if (sortDescriptors) {
        [request setSortDescriptors:sortDescriptors];
    }
    if (fetchLimit) {
        [request setFetchLimit:[fetchLimit unsignedIntegerValue]];
    }
    if (fetchOffset) {
        [request setFetchOffset:[fetchOffset unsignedIntegerValue]];
    }
    
    return [managedObjectContext executeFetchRequest:request error:error];
}

+ (NSArray *)objectsOfEntity:(Class)entityClass
               withPredicate:(NSPredicate *)predicate
             sortDescriptors:(NSArray *)sortDescriptors
                  fetchLimit:(NSNumber *)fetchLimit
                 fetchOffset:(NSNumber *)fetchOffset
                       error:(NSError **)error
{
    return [[CoreDataHelper instance] _objectsOfEntity:entityClass
                                            withPredicate:predicate
                                          sortDescriptors:sortDescriptors
                                               fetchLimit:fetchLimit
                                              fetchOffset:fetchOffset
                                                    error:error];
}

#pragma mark - Aggregate query

+ (NSUInteger)countObjectsOfEntity:(Class)entityClass
                             where:(id)condition
                             error:(NSError **)error
{
    return [CoreDataHelper countObjectsOfEntity:entityClass
                                     withPredicate:[CoreDataHelper predicateFromObject:condition]
                                             error:error];
}

- (NSUInteger)_countObjectsOfEntity:(Class)entityClass
                     withPredicate:(NSPredicate *)predicate
                             error:(NSError **)error
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:NSStringFromClass(entityClass)
                                   inManagedObjectContext:managedObjectContext]];
    [request setIncludesSubentities:NO]; //Omit subentities. Default is YES (i.e. include subentities)
    if (predicate) {
        [request setPredicate:predicate];
    }
    
    NSUInteger count = [managedObjectContext countForFetchRequest:request error:error];
    if (count == NSNotFound) {
        count = 0;
    }
    
    return count;
}

+ (NSUInteger)countObjectsOfEntity:(Class)entityClass
                     withPredicate:(NSPredicate *)predicate
                             error:(NSError **)error
{
    return [[CoreDataHelper instance] _countObjectsOfEntity:entityClass
                                                 withPredicate:predicate
                                                         error:error];
}

+ (id)runAggregate:(NSString *)aggregateFunction
             where:(id)condition
      forAttribute:(NSString *)attributeName
          ofEntity:(Class)entityClass
             error:(NSError **)error
{
    return [self runAggregate:aggregateFunction
                withPredicate:[CoreDataHelper predicateFromObject:condition]
                 forAttribute:attributeName
                     ofEntity:entityClass
                        error:error];
}

+ (id)runAggregate:(NSString *)aggregateFunction
     withPredicate:(NSPredicate *)predicate
      forAttribute:(NSString *)attributeName
          ofEntity:(Class)entityClass
             error:(NSError **)error
{
    return [[CoreDataHelper instance] _runAggregate:aggregateFunction
                                         withPredicate:predicate
                                          forAttribute:attributeName
                                              ofEntity:entityClass
                                                 error:error];
}

- (id)_runAggregate:(NSString *)aggregateFunction
      withPredicate:(NSPredicate *)predicate
       forAttribute:(NSString *)attributeName
           ofEntity:(Class)entityClass
              error:(NSError **)error
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass(entityClass)
                                                         inManagedObjectContext:managedObjectContext];
    NSDictionary *attributesByName = [entityDescription attributesByName];
    NSAttributeDescription *attributeDescription = [attributesByName objectForKey:attributeName];
    
    // fetch request
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setResultType:NSDictionaryResultType];
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    
    // aggregate expression
    
    NSExpression *keyExpression = [NSExpression expressionForKeyPath:attributeName];
    NSExpression *aggrExpression = [NSExpression expressionForFunction:aggregateFunction
                                                             arguments:@[keyExpression]];
    NSExpressionDescription *exprDescription = [NSExpressionDescription new];
    [exprDescription setName:attributeName];
    [exprDescription setExpression:aggrExpression];
    [exprDescription setExpressionResultType:[attributeDescription attributeType]];
    
    [fetchRequest setPropertiesToFetch:@[exprDescription]];
    
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:error];
    if (!error) {
        if ([results count] > 0) {
            return [[results objectAtIndex:0] valueForKey:attributeName];
        } else {
            NSLog(@"[WARN] Aggregate result is empty");
            return nil;
        }
    } else {
        return nil;
    }
}

+ (NSArray *)countWithGroupByOfFieldNamed :(NSString *)countfieldname withCondition:(NSPredicate *)predicate fromEntity:(NSString *)entityname
{
    return [[CoreDataHelper instance] _countWithGroupByOfFieldNamed:countfieldname withCondition:predicate fromEntity:entityname];
}
-(NSArray *)_countWithGroupByOfFieldNamed :(NSString *)countfieldname withCondition:(NSPredicate *)predicate fromEntity:(NSString *)entityname
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:entityname];
    NSEntityDescription* entity = [NSEntityDescription entityForName:entityname
                                              inManagedObjectContext:managedObjectContext];
    NSAttributeDescription* NotifDesc = [entity.attributesByName objectForKey:countfieldname];
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath: countfieldname];
    NSExpression *countExpression = [NSExpression expressionForFunction: @"count:"
                                                              arguments: [NSArray arrayWithObject:keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    if (predicate) {
        [fetch setPredicate:predicate];
    }
    [expressionDescription setName: @"count"];
    [expressionDescription setExpression: countExpression];
    [expressionDescription setExpressionResultType: NSInteger32AttributeType];
    [fetch setPropertiesToFetch:[NSArray arrayWithObjects:NotifDesc, expressionDescription, nil]];
    [fetch setPropertiesToGroupBy:[NSArray arrayWithObject:NotifDesc]];
    [fetch setResultType:NSDictionaryResultType];
    NSError* error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:fetch
                                                           error:&error];
    return results;
}

#if TARGET_OS_IPHONE

#pragma mark - Query producing NSFetchedResultsController

+ (NSFetchedResultsController *)fetchedResultsControllerForEntity:(Class)entityClass
                                                            where:(id)condition
                                                            order:(id)order
                                                            limit:(NSNumber *)numberOfRecords
                                                           offset:(NSNumber *)fromRecordNum
                                               sectionNameKeyPath:(NSString *)sectionNameKeyPath
                                                        cacheName:(NSString *)cacheName
{
    return [CoreDataHelper fetchedResultsControllerForEntity:entityClass
                                                  withPredicate:[CoreDataHelper predicateFromObject:condition]
                                                sortDescriptors:[CoreDataHelper sortDescriptorsFromObject:order]
                                                     fetchLimit:numberOfRecords
                                                    fetchOffset:fromRecordNum
                                             sectionNameKeyPath:sectionNameKeyPath
                                                      cacheName:cacheName];
}

- (NSFetchedResultsController *)_fetchedResultsControllerForEntity:(Class)entityClass
                                                    withPredicate:(NSPredicate *)predicate
                                                  sortDescriptors:(NSArray *)sortDescriptors
                                                       fetchLimit:(NSNumber *)fetchLimit
                                                      fetchOffset:(NSNumber *)fetchOffset
                                               sectionNameKeyPath:(NSString *)sectionNameKeyPath
                                                        cacheName:(NSString *)cacheName
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(entityClass)
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    if (sortDescriptors) {
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    if (fetchLimit) {
        [fetchRequest setFetchLimit:[fetchLimit unsignedIntegerValue]];
    }
    if (fetchOffset) {
        [fetchRequest setFetchOffset:[fetchOffset unsignedIntegerValue]];
    }
    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                               managedObjectContext:managedObjectContext
                                                 sectionNameKeyPath:sectionNameKeyPath
                                                          cacheName:cacheName];
}

+ (NSFetchedResultsController *)fetchedResultsControllerForEntity:(Class)entityClass
                                                    withPredicate:(NSPredicate *)predicate
                                                  sortDescriptors:(NSArray *)sortDescriptors
                                                       fetchLimit:(NSNumber *)fetchLimit
                                                      fetchOffset:(NSNumber *)fetchOffset
                                               sectionNameKeyPath:(NSString *)sectionNameKeyPath
                                                        cacheName:(NSString *)cacheName
{
    return [[CoreDataHelper instance] _fetchedResultsControllerForEntity:entityClass
                                                              withPredicate:predicate
                                                            sortDescriptors:sortDescriptors
                                                                 fetchLimit:fetchLimit
                                                                fetchOffset:fetchOffset
                                                         sectionNameKeyPath:sectionNameKeyPath
                                                                  cacheName:cacheName];
}

#endif
+ (void) updateMatchStatus :(NSDictionary *)dic
{
    @try
    {
        NSManagedObjectContext *context = [[CoreDataHelper instance]managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *sysCounters = [CoreDataHelper entityDescriptionOf:NSClassFromString(MatchEntity)];
        request.predicate = [NSPredicate predicateWithFormat:@"(matchId=%@)",[dic valueForKey:CdMatchId]];
        [request setEntity:sysCounters];
        
        NSError *error = nil;
        
        NSNumberFormatter * num = [[NSNumberFormatter alloc] init];
        [num setNumberStyle:NSNumberFormatterNoStyle];
        
        NSArray *arr= [context executeFetchRequest:request error:&error];
        NSLog(@"arr %@",arr.description);
        
        if(arr.count==0)
        {
            NSLog( @"data not found");
        }
        else
        {
            CDAllMatches *objmatch=[arr lastObject];
            [objmatch setValue: [dic valueForKey:CdMatchStatus] forKey:CdMatchStatus];
            [CoreDataHelper save];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception :%@",exception.description);
    }
}

+ (void) updateFav :(NSDictionary *)dic
{
    @try
    {
        NSManagedObjectContext *context = [[CoreDataHelper instance]managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *sysCounters = [CoreDataHelper entityDescriptionOf:NSClassFromString(MatchEntity)];
         request.predicate = [NSPredicate predicateWithFormat:@"(matchId=%@)",[dic valueForKey:CdMatchId]];
        [request setEntity:sysCounters];
        
        NSError *error = nil;
        
        NSNumberFormatter * num = [[NSNumberFormatter alloc] init];
        [num setNumberStyle:NSNumberFormatterNoStyle];
        
        NSArray *arr= [context executeFetchRequest:request error:&error];
        NSLog(@"arr %@",arr.description);
        
        if(arr.count==0)
        {
            NSLog( @"data not found");
        }
        else
        {
            CDAllMatches *objmatch=[arr lastObject];
            [objmatch setValue: [dic valueForKey:CdFavourite] forKey:CdFavourite];
            [CoreDataHelper save];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception :%@",exception.description);
    }
}

+ (void) updateHide :(NSDictionary *)dic
{
    @try
    {
        NSManagedObjectContext *context = [[CoreDataHelper instance]managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *sysCounters = [CoreDataHelper entityDescriptionOf:NSClassFromString(MatchEntity)];
      request.predicate = [NSPredicate predicateWithFormat:@"(matchId=%@)",[dic valueForKey:CdMatchId]];        [request setEntity:sysCounters];
        
        NSError *error = nil;
        
        NSNumberFormatter * num = [[NSNumberFormatter alloc] init];
        [num setNumberStyle:NSNumberFormatterNoStyle];
        
        NSArray *arr= [context executeFetchRequest:request error:&error];
        NSLog(@"arr %@",arr.description);
        
        if(arr.count==0)
        {
            NSLog( @"data not found");
        }
        else
        {
            CDAllMatches *objmatch=[arr lastObject];
            [objmatch setValue: [dic valueForKey:CdHide] forKey:CdHide];
            [CoreDataHelper save];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception :%@",exception.description);
    }
}
+ (void) updateLike :(NSDictionary *)dic
{
    @try
    {
        NSManagedObjectContext *context = [[CoreDataHelper instance]managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *sysCounters = [CoreDataHelper entityDescriptionOf:NSClassFromString(MatchEntity)];
      
         request.predicate = [NSPredicate predicateWithFormat:@"(matchId=%@)",[dic valueForKey:CdMatchId]];
        [request setEntity:sysCounters];
        
        NSError *error = nil;
        
        NSNumberFormatter * num = [[NSNumberFormatter alloc] init];
        [num setNumberStyle:NSNumberFormatterNoStyle];
        
        NSArray *arr= [context executeFetchRequest:request error:&error];
        NSLog(@"arr %@",arr.description);
        
        if(arr.count==0)
        {
            NSLog( @"data not found");
        }
        else
        {
            CDAllMatches *objmatch=[arr lastObject];
            [objmatch setValue: [dic valueForKey:CdLike] forKey:CdLike];
            [CoreDataHelper save];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception :%@",exception.description);
    }
}
@end
