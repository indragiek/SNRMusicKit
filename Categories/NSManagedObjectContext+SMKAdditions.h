//
//  NSManagedObjectContext+SMKAdditions.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SMKContentSource.h"

@interface NSManagedObjectContext (SMKAdditions)
@property (nonatomic, weak) id<SMKContentSource> contentSource;

/**
 This method saves the managed object context and logs an error if there is one
 @return Whether the save was successful
 */
- (BOOL)SMK_saveChanges;

/**
 This method fetches the objects synchronously, wrapped in a -performBlockAndWait call
 @param entityName The name of the Core Data entity to fetch
 @param sortDescriptors Array of NSSortDescriptor's used to sort the results
 @param predicate A predicate used to filter the results
 @param batchSize The batch size to use for fetching
 @param fetchLimit The maximum number of objects to fetch
 @param error Error pointer for an NSError if something goes wrong
 @return The fetched results
 */
- (NSArray *)SMK_fetchWithEntityName:(NSString *)entityName
                     sortDescriptors:(NSArray *)sortDescriptors
                           predicate:(NSPredicate *)predicate
                           batchSize:(NSUInteger)batchSize
                          fetchLimit:(NSUInteger)fetchLimit
                               error:(NSError **)error;

/**
 This method fetches the objects synchronously, WITHOUT wrapping it in a -performBlock call
 @param entityName The name of the Core Data entity to fetch
 @param sortDescriptors Array of NSSortDescriptor's used to sort the results
 @param predicate A predicate used to filter the results
 @param batchSize The batch size to use for fetching
 @param fetchLimit The maximum number of objects to fetch
 @param error Error pointer for an NSError if something goes wrong
 @return The fetched results
 */
- (NSArray *)SMK_noBlockFetchWithEntityName:(NSString *)entityName
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
