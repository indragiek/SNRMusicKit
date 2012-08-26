//
//  SMKSpotifyHelpers.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-25.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKSpotifyHelpers.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "NSMutableArray+SMKAdditions.h"
#import "SMKHierarchicalLoading.h"

@implementation SMKSpotifyHelpers
+ (void)loadItems:(NSArray *)items group:(dispatch_group_t)group array:(NSMutableArray *)array
{
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj conformsToProtocol:@protocol(SMKHierarchicalLoading)])
            [obj loadHierarchy:group array:array];
    }];
}

+ (void)loadItemsAynchronously:(NSArray *)items
                          sortDescriptors:(NSArray *)sortDescriptors
                                predicate:(NSPredicate *)predicate
                               fetchLimit:(NSUInteger)fetchLimit
                             sortingQueue:(dispatch_queue_t)queue
                        completionHandler:(void(^)(NSArray *objects, NSError *error))handler
{
    NSMutableArray *hierarchy = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    [self loadItems:items group:group array:hierarchy];
    dispatch_group_notify(group, queue, ^{
        [hierarchy SMK_processWithSortDescriptors:sortDescriptors predicate:predicate fetchLimit:fetchLimit];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler) handler(hierarchy, nil);
        });
    });
    dispatch_release(group);
}
@end
