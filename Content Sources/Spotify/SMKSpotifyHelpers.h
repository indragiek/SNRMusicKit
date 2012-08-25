//
//  SMKSpotifyHelpers.h
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMKSpotifyHelpers : NSObject
+ (void)loadItems:(NSArray *)items group:(dispatch_group_t)group array:(NSMutableArray *)array;
+ (NSArray *)loadItemsSynchronously:(NSArray *)items
                               sortDescriptors:(NSArray *)sortDescriptors
                                     predicate:(NSPredicate *)predicate
                                    fetchLimit:(NSUInteger)fetchLimit;
+ (void)loadItemsAynchronously:(NSArray *)items
                          sortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                               fetchLimit:(NSUInteger)fetchLimit
                             sortingQueue:(dispatch_queue_t)queue
                        completionHandler:(void(^)(NSArray *objects, NSError *error))handler;
@end
