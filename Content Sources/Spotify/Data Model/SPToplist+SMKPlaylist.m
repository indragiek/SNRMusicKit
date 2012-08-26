//
//  SPToplist+SMKPlaylist.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-26.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SPToplist+SMKPlaylist.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "NSObject+AssociatedObjects.h"
#import "SMKSpotifyHelpers.h"
#import "SMKSpotifyContentSource.h"

static void* const SMKSPToplistNameKey = "SMK_SPToplistName";

@implementation SPToplist (SMKPlaylist)

#pragma mark - SMKPlaylist

- (void)fetchTracksWithCompletionHandler:(void(^)(NSArray *tracks, NSError *error))handler
{
    dispatch_queue_t queue = [(SMKSpotifyContentSource *)self.session spotifyLocalQueue];
    [SMKSpotifyHelpers loadItemsAynchronously:self.tracks
                              sortDescriptors:nil
                                    predicate:nil
                                 sortingQueue:queue
                            completionHandler:handler];
}

- (BOOL)isEditable
{
    return NO;
}

#pragma mark - SMKContentObject

- (NSString *)name
{
    return [self associatedValueForKey:SMKSPToplistNameKey];
}

- (void)setName:(NSString *)name
{
    [self associateValue:[name copy] withKey:SMKSPToplistNameKey];
}

- (NSString *)uniqueIdentifier
{
    // TODO: Figure out some sort of unique identifier since spotify URL isn't available
    return nil;
}

+ (NSSet *)supportedSortKeys
{
    return [NSSet setWithObjects:@"name", @"extendedDescription", @"tracks", @"artists", @"albums", nil];
}

- (id<SMKContentSource>)contentSource
{
    return (id<SMKContentSource>)self.session;
}

#pragma mark - SMKHierarchicalLoading

- (void)loadHierarchy:(dispatch_group_t)group array:(NSMutableArray *)array
{
    __weak SPToplist *weakSelf = self;
    dispatch_group_enter(group);
    [self SMK_spotifyWaitAsyncThen:^{
        SPToplist *strongSelf = weakSelf;
        [strongSelf.tracks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj loadHierarchy:group array:array]; 
        }];
        dispatch_group_leave(group);
    }];
}
@end
