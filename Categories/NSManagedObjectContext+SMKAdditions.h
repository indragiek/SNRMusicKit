//
//  NSManagedObjectContext+SMKAdditions.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (SMKAdditions)
/**
 This method saves the managed object context and logs an error if there is one
 @return Whether the save was successful
 */
- (BOOL)SMK_saveChanges;

/**
 This method saves the managed object context and its nested context (if it exists) and logs the error
 @return Whether the save was successful
 */
- (BOOL)SMK_saveNestedChanges;

/**
 This method fetches the objects synchronously, WITHOUT wrapping it in a -performBlock call (hence called a legacy fetch)
 @param entityName The name of the Core Data entity to fetch
 @param sortDescriptors Array of NSSortDescriptor's used to sort the results
 @param predicate A predicate used to filter the results
 @param batchSize The batch size to use for fetching
 @param fetchLimit The maximum number of objects to fetch
 @param error Error pointer for an NSError if something goes wrong
 @return The fetched results
 */
- (NSArray *)SMK_legacyFetchWithEntityName:(NSString *)entityName
                     sortDescriptors:(NSArray *)sortDescriptors
                           predicate:(NSPredicate *)predicate
                           batchSize:(NSUInteger)batchSize
                          fetchLimit:(NSUInteger)fetchLimit
                               error:(NSError **)error;

/**
 This method fetches objects asynchronously, wrapped in a -performBlock call
 @param entityName The name of the Core Data entity to fetch
 @param sortDescriptors Array of NSSortDescriptor's used to sort the results
 @param predicate A predicate used to filter the results
 @param batchSize The batch size to use for fetching
 @param fetchLimit The maximum number of objects to fetch
 @param handler Completion handler to be called upon completion of the fetch
 @return The fetched results
 */
- (void)SMK_asyncFetchWithEntityName:(NSString *)entityName
                     sortDescriptors:(NSArray *)sortDescriptors
                           predicate:(NSPredicate *)predicate
                           batchSize:(NSUInteger)batchSize
                          fetchLimit:(NSUInteger)fetchLimit
                   completionHandler:(void(^)(NSArray *results, NSError *error))handler;

/**
 @param entityName The name of the Core Data entity to fetch
 @param sortDescriptors Array of NSSortDescriptor's used to sort the results
 @param predicate A predicate used to filter the results
 @param batchSize The batch size to use for fetching
 @param fetchLimit The maximum number of objects to fetch
 @return A fetch request with the specified parameters
 */
- (NSFetchRequest *)SMK_fetchRequestWithEntityName:(NSString *)entityName
                               sortDescriptors:(NSArray *)sortDescriptors
                                     predicate:(NSPredicate *)predicate
                                     batchSize:(NSUInteger)batchSize
                                    fetchLimit:(NSUInteger)fetchLimit;

/**
 @param request The fetch request to execute
 @param handler The completion handler to call when the fetch is complete
 @discussion This method is asynchronous and will return immediately
 */
- (void)SMK_asyncFetchWithFetchRequest:(NSFetchRequest *)request
                     completionHandler:(void(^)(NSArray *results, NSError *error))handler;


/**
 This method fetches objects as NSManagedObjectID's (not the objects themselves)
 asynchronously, wrapped in a -performBlock call
 @param entityName The name of the Core Data entity to fetch
 @param sortDescriptors Array of NSSortDescriptor's used to sort the results
 @param predicate A predicate used to filter the results
 @param batchSize The batch size to use for fetching
 @param fetchLimit The maximum number of objects to fetch
 @param handler Completion handler to be called upon completion of the fetch
 @return The fetched results as NSManagedObjectIDs
 */
- (void)SMK_asyncFetchObjectIDsWithEntityName:(NSString *)entityName
                              sortDescriptors:(NSArray *)sortDescriptors
                                    predicate:(NSPredicate *)predicate
                                    batchSize:(NSUInteger)batchSize
                                   fetchLimit:(NSUInteger)fetchLimit
                            completionHandler:(void(^)(NSArray *results, NSError *error))handler;

/**
 @param objectIDs The NSManagedObjectID objects to convert into NSManagedObject's
 @return The array of NSManagedObjects
 */
- (NSArray *)SMK_objectsFromObjectIDs:(NSArray *)objectIDs;

/**
 Creates a new object of the specified entity
 @param entityName The name of the entity
 */
- (id)SMK_createObjectOfEntityName:(NSString *)entityName;
@end
