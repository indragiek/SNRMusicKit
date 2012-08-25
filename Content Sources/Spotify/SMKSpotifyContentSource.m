//
//  SMKSpotifyContentSource.m
//  SNRMusicKit
//
//  Created by Indragie Karunaratne on 2012-08-24.
//  Copyright (c) 2012 Indragie Karunaratne. All rights reserved.
//

#import "SMKSpotifyContentSource.h"
#import "NSObject+SMKSpotifyAdditions.h"
#import "NSMutableArray+SMKAdditions.h"
#import "SMKSpotifyConstants.h"

@implementation SMKSpotifyContentSource {
    dispatch_queue_t _waitingQueue;
}
#pragma mark - SMKContentSource

- (NSString *)name { return @"Spotify"; }
+ (BOOL)supportsBatching { return NO; }

- (NSArray *)playlistsWithSortDescriptors:(NSArray *)sortDescriptors
                                batchSize:(NSUInteger)batchSize
                               fetchLimit:(NSUInteger)fetchLimit
                                predicate:(NSPredicate *)predicate
                                withError:(NSError **)error
{
    [self SMK_spotifyWaitUntilLoaded];
    return [self _allPlaylistsWithSortDescriptors:sortDescriptors
                                       fetchLimit:fetchLimit
                                        predicate:predicate];
    
}

- (void)fetchPlaylistsWithSortDescriptors:(NSArray *)sortDescriptors
                                batchSize:(NSUInteger)batchSize
                               fetchLimit:(NSUInteger)fetchLimit
                                predicate:(NSPredicate *)predicate
                        completionHandler:(void(^)(NSArray *playlists, NSError *error))handler
{
    [SPAsyncLoading waitUntilLoaded:self timeout:SMKSpotifyDefaultLoadingTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        if (handler)
            handler([self _allPlaylistsWithSortDescriptors:sortDescriptors
                                            fetchLimit:fetchLimit
                                             predicate:predicate], nil);
    }];
}

- (void)dealloc
{
    if (_waitingQueue)
        dispatch_release(_waitingQueue);
}

#pragma mark - Private

- (NSArray *)_allPlaylistsWithSortDescriptors:(NSArray *)sortDescriptors fetchLimit:(NSUInteger)fetchLimit predicate:(NSPredicate *)predicate
{
    NSMutableArray *playlists = [NSMutableArray arrayWithObjects:self.inboxPlaylist, self.starredPlaylist, nil];
    [playlists addObjectsFromArray:[self.userPlaylists flattenedPlaylists]];
    [playlists SMK_processWithSortDescriptors:sortDescriptors predicate:predicate fetchLimit:fetchLimit];
    return playlists;
}

- (dispatch_queue_t)_spotifyWaitingQueue;
{
    if (!_waitingQueue) {
        _waitingQueue = dispatch_queue_create("com.indragie.SNRMusicKit.spotifyWaitingQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _waitingQueue;
}
@end
