//
//  NSManagedObjectContext+SMKAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "NSManagedObjectContext+SMKAdditions.h"
#import "SMKConvenience.h"

@implementation NSManagedObjectContext (SMKAdditions)
- (BOOL)SMK_saveChanges
{
    NSError *error = nil;
    if (![self save:&error]) {
        SMKGenericErrorLog(@"NSManagedObjectContext save error", error);
        return NO;
    }
    return YES;
}

- (BOOL)SMK_saveNestedChanges
{
    BOOL success = [self SMK_saveChanges];
    if ([self parentContext]) {
        success = success && [[self parentContext] SMK_saveChanges];
    }
    return success;
}

- (NSArray *)SMK_legacyFetchWithEntityName:(NSString *)entityName
                            sortDescriptors:(NSArray *)sortDescriptors
                                  predicate:(NSPredicate *)predicate
                                  batchSize:(NSUInteger)batchSize
                                 fetchLimit:(NSUInteger)fetchLimit
                                      error:(NSError **)error
{
    NSFetchRequest *request = [self SMK_fetchRequestWithEntityName:entityName
                                                   sortDescriptors:sortDescriptors
                                                         predicate:predicate
                                                         batchSize:batchSize
                                                        fetchLimit:fetchLimit];
    return [self executeFetchRequest:request error:error];
}

- (void)SMK_asyncFetchWithEntityName:(NSString *)entityName
                     sortDescriptors:(NSArray *)sortDescriptors
                           predicate:(NSPredicate *)predicate
                           batchSize:(NSUInteger)batchSize
                          fetchLimit:(NSUInteger)fetchLimit
                   completionHandler:(void(^)(NSArray *results, NSError *error))handler
{
    NSFetchRequest *request = [self SMK_fetchRequestWithEntityName:entityName
                                                   sortDescriptors:sortDescriptors
                                                         predicate:predicate
                                                         batchSize:batchSize
                                                        fetchLimit:fetchLimit];
    [self SMK_asyncFetchWithFetchRequest:request completionHandler:handler];
}

- (void)SMK_asyncFetchWithFetchRequest:(NSFetchRequest *)request
                     completionHandler:(void(^)(NSArray *results, NSError *error))handler
{
    [self performBlock:^{
        NSError *error = nil;
        NSArray *results = [self executeFetchRequest:request error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler) handler(results, error);
        });
    }];
}

- (NSFetchRequest *)SMK_fetchRequestWithEntityName:(NSString *)entityName
                               sortDescriptors:(NSArray *)sortDescriptors
                                     predicate:(NSPredicate *)predicate
                                     batchSize:(NSUInteger)batchSize
                                    fetchLimit:(NSUInteger)fetchLimit
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    [request setSortDescriptors:sortDescriptors];
    [request setPredicate:predicate];
    [request setFetchBatchSize:batchSize];
    [request setFetchLimit:fetchLimit];
    return request;
}

- (void)SMK_asyncFetchObjectIDsWithEntityName:(NSString *)entityName
                              sortDescriptors:(NSArray *)sortDescriptors
                                    predicate:(NSPredicate *)predicate
                                    batchSize:(NSUInteger)batchSize
                                   fetchLimit:(NSUInteger)fetchLimit
                            completionHandler:(void(^)(NSArray *results, NSError *error))handler
{
    [self performBlock:^{
        NSFetchRequest *request = [self SMK_fetchRequestWithEntityName:entityName
                                                       sortDescriptors:sortDescriptors
                                                             predicate:predicate
                                                             batchSize:batchSize
                                                            fetchLimit:fetchLimit];
        [request setResultType:NSManagedObjectIDResultType];
        NSError *error = nil;
        NSArray *results = [self executeFetchRequest:request error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler) handler(results, error);
        });
    }];
}

- (NSArray *)SMK_objectsFromObjectIDs:(NSArray *)objectIDs
{
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:[objectIDs count]];
    [self performBlockAndWait:^{
        for (NSManagedObjectID *objectID in objectIDs) {
            NSError *error = nil;
            NSManagedObject *existingObject = [self existingObjectWithID:objectID error:&error];
            if (error)
                SMKGenericErrorLog([NSString stringWithFormat:@"Failed to fetch object with ID %@", objectID], error);
            if (existingObject)
                [objects addObject:existingObject];
        }
    }];
    return objects;
}

- (id)SMK_createObjectOfEntityName:(NSString *)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self];
}
@end
