//
//  NSManagedObjectContext+SMKAdditions.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-22.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "NSManagedObjectContext+SMKAdditions.h"
#import "NSObject+AssociatedObjects.h"

static void* const SMKContentSourceKey = @"SMKContentSource";

@implementation NSManagedObjectContext (SMKAdditions)
- (BOOL)SMK_saveChanges
{
    NSError *error = nil;
    if (![self save:&error]) {
        NSLog(@"NSManagedObjectContext save error: %@ %@", error, [error userInfo]);
        return NO;
    }
    return YES;
}

- (NSArray *)SMK_fetchWithEntityName:(NSString *)entityName
                     sortDescriptors:(NSArray *)sortDescriptors
                           predicate:(NSPredicate *)predicate
                           batchSize:(NSUInteger)batchSize
                          fetchLimit:(NSUInteger)fetchLimit
                               error:(NSError **)error
{
    __block NSArray *results = nil;
    [self performBlockAndWait:^{
        NSFetchRequest *request = [self SMK_fetchRequestWithEntityName:entityName
                                                       sortDescriptors:sortDescriptors
                                                             predicate:predicate
                                                             batchSize:batchSize
                                                            fetchLimit:fetchLimit];
        results = [self executeFetchRequest:request error:error];
    }];
    return results;
}

- (NSArray *)SMK_noBlockFetchWithEntityName:(NSString *)entityName
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
    [self performBlock:^{
        NSFetchRequest *request = [self SMK_fetchRequestWithEntityName:entityName
                                                       sortDescriptors:sortDescriptors
                                                             predicate:predicate
                                                             batchSize:batchSize
                                                            fetchLimit:fetchLimit];
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

- (id)SMK_createObjectOfEntityName:(NSString *)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self];
}

#pragma mark - Accessors

- (void)setContentSource:(id<SMKContentSource>)contentSource
{
    [self weaklyAssociateValue:contentSource withKey:SMKContentSourceKey];
}

- (id<SMKContentSource>)contentSource
{
    return [self associatedValueForKey:SMKContentSourceKey];
}
@end
